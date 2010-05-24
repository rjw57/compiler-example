using LLVM;

// Potential errors
errordomain CompileError {
	FILE_CANNOT_BE_OPENED,	// Could not open the input file.
	EOF_ENCOUNTERED,		// An EOF was encountered unexpectedly.
	PARSE_ERROR,			// A generic parse error.
}

class Compiler {
	private struct FilePosition {
		uint line;
		uint column;
	}

	private struct FuncDecl {
		string 	name;
		Ty* 	llvm_type;
	}

	// Special reserved word symbol values.
	private const string DEFINE_FUNCTION = "DEFINE_FUNCTION";
	private const string RETURN = "RETURN";

	private LLVM.Module 		m_llvm_module = null;
	private unowned Scanner		m_current_scanner = null;

	private TokenType			m_token_type;
	private TokenValue			m_token_value;
	private FilePosition		m_token_position;

	// Current state
	private Function			m_function = null;
	private Builder				m_builder = null;

	// Property accessor for the wrapped LLVM module.
	public unowned LLVM.Module? llvm_module { get { return m_llvm_module; } }

	public void compile_source_file(string file_name) throws CompileError
	{
		// Open the file.
		var file_stream = FileStream.open(file_name, "r");
		if(file_stream == null) {
			throw new CompileError.FILE_CANNOT_BE_OPENED(
					"Could not open file %s", file_name);
		}

		// Create a scanner.
		var scanner = new Scanner(null);

		// Wire up the scanner to the file.
		scanner.input_file(file_stream.fileno());
		scanner.input_name = file_name;

		// Attempt to compile.
		compile_from_scanner(scanner);
	}

	private void compile_from_scanner(Scanner scanner) throws CompileError
	{
		// We will mostly make use of the default values for the scanner however
		// our toy language does have a few things which don't match the default
		// settings.

		// Single character identifiers are supported.
		scanner.config.scan_identifier_1char = true; 

		// There are some reserved words (aka 'symbols') in our language.
		scanner.scope_add_symbol(0, "def", DEFINE_FUNCTION);
		scanner.scope_add_symbol(0, "ret", RETURN);

		// set this as the current scanner.
		m_current_scanner = scanner;

		// Reset the location of the current token.
		m_token_position.line = 0;
		m_token_position.column = 0;

		// Start compiling.
		m_llvm_module = new Module.with_name(scanner.input_name);

		// Add our standard types
		llvm_module.add_type_name("void", Ty.void());
		llvm_module.add_type_name("float", Ty.float());

		parse_translation_unit();

		// Reset the scanner.
		m_current_scanner = null;
	}

	// UTILITY METHODS //

	// return the current scanner position as a string
	public string cur_position_string() {
		if(m_current_scanner == null)
			return "<builtin>:0:0";

		return m_current_scanner.input_name + ":" +
			m_token_position.line.to_string() + ":" + 
			m_token_position.column.to_string();
	}

	private void next_token(bool expecting_eof = false)
		throws CompileError
	{
		assert(m_current_scanner != null);

		// Get the next token.
		m_token_type = m_current_scanner.get_next_token();
		m_token_value = m_current_scanner.cur_value();

		if(!expecting_eof && (m_token_type == TokenType.EOF))
			throw new CompileError.EOF_ENCOUNTERED("Unexpected EOF.");
		
		// Record the end of this token.
		m_token_position.line = m_current_scanner.cur_line();
		m_token_position.column = m_current_scanner.cur_position();
	}

	private bool check_token(TokenType expected_type, void* expected_symbol = null)
	{
		assert(m_current_scanner != null);
		assert((expected_symbol == null) || (expected_type == TokenType.SYMBOL));

		if((m_token_type != expected_type) ||
				((expected_symbol != null) && 
				 	(m_token_value.symbol != expected_symbol))) {
			m_current_scanner.unexp_token(expected_type,
					"identifier", "reserved word",
					m_token_value.identifier,
					null, true);
			return false;
		}
		return true;
	}

	// PARSING METHODS //

	// parse an entire translation unit (aka an entire file)
	private void parse_translation_unit() throws CompileError
	{
		assert(llvm_module != null);
		assert(m_current_scanner != null);

		next_token(true);
		while(m_token_type != TokenType.EOF) {
			parse_top_level_declaration();
			next_token(true);
		}

		llvm_module.dump();
	}

	// parse a top-level function declaration
	private void parse_top_level_declaration() throws CompileError
	{
		if(check_token(TokenType.SYMBOL, DEFINE_FUNCTION)) {
			// starting to define a function.
			next_token();

			// expect the name of the function and then a block.
			var func_decl = parse_function_declaration();

			// check for an existing function with that name.
			var f = llvm_module.get_named_function(func_decl.name);
			if(f != null) {
				throw new CompileError.PARSE_ERROR(
						"A function named '%s' already exists.", func_decl);
			}

			// no existing function, create it.
			m_function = new Function(llvm_module, func_decl.name, func_decl.llvm_type); 
			m_function.call_conv = CallConv.C;

			// parse function block.
			parse_block();

			// we've now moved out of the function.
			m_function = null;
		} else {
			throw new CompileError.PARSE_ERROR("Expected 'def'.");
		}
	}

	// parse a function declaration
	private FuncDecl parse_function_declaration() throws CompileError
	{
		FuncDecl decl = { null, null };

		// expect an identifier naming the function.
		if(!check_token(TokenType.IDENTIFIER)) {
			throw new CompileError.PARSE_ERROR("Expected identifier which names the function.");
		}

		decl.name = m_token_value.identifier;
		
		next_token();

		// Do we have a return type specified?
		Ty* return_type = llvm_module.get_type_by_name("void");
		if(m_token_type == ':') {
			next_token();

			// get the type name
			return_type = parse_type_name();
		}

		decl.llvm_type = Ty.function( return_type, { }, 0 );

		return decl;
	}

	private LLVM.Ty* parse_type_name() throws CompileError
	{
		if(!check_token(TokenType.IDENTIFIER)) {
				throw new CompileError.PARSE_ERROR("Expecting identifier to name type.");
		}

		Ty* type = llvm_module.get_type_by_name(m_token_value.identifier);

		if(type == null) {
			throw new CompileError.PARSE_ERROR("Unknown type name '%s'.", 
					m_token_value.identifier);
		}
		
		next_token();

		return type;
	}

	private LLVM.BasicBlock parse_block() throws CompileError
	{
		assert(m_function != null);

		if(!check_token(TokenType.LEFT_CURLY)) {
			throw new CompileError.PARSE_ERROR("Expected a '{' to start a block.");
		}
		next_token();

		// append the new basic block.
		var basic_block = m_function.append_basic_block("entry");
		m_builder = new Builder();
		m_builder.position_at_end(basic_block);

		// parse function block.
		while(m_token_type != TokenType.RIGHT_CURLY) {
			// parse statements.
			parse_statement();
		}

		// terminate the basic block if appropriate
		var bb = m_builder.get_insert_block();
		var last_inst = bb->get_last_instruction();

		if((last_inst == null) || !last_inst->is_a_terminator_inst()) 
		{
			// if we get here, there is no return statement.
			var func_type = m_function.type_of();
			assert(func_type->get_type_kind() == TypeKind.Pointer);

			func_type = func_type->get_element_type();
			assert(func_type->get_type_kind() == TypeKind.Function);

			// if the function returns void, just append a ret void statement
			var ret_type = func_type->get_return_type();
			if(ret_type->get_type_kind() == TypeKind.Void) {
				m_builder.build_ret_void();
			} else {
				throw new CompileError.PARSE_ERROR("Function ends without a return statement.");
			}
		}

		m_builder = null;

		return basic_block;
	}
	
	private void parse_statement() throws CompileError
	{
		assert(m_builder != null);

		// is the block we're inserting into already terminated?
		var insert_bb = m_builder.get_insert_block();
		assert(insert_bb != null);
		var last_inst = insert_bb->get_last_instruction();

		if((last_inst != null) && (last_inst->is_a_terminator_inst())) {
			// the previous basic block has been terminated, add a new one.
			var basic_block = m_function.append_basic_block("block");
			m_builder.position_at_end(basic_block);
		}

		// statements are terminated by semi-colon.
		while(m_token_type != ';') {
			if((m_token_type == TokenType.SYMBOL) && (m_token_value.symbol == RETURN)) {
				// return statement
				parse_return_statement();
			} else {
				throw new CompileError.PARSE_ERROR("Error parsing statement.");
			}
		}

		// chomp semi-colon
		next_token();
	}
	
	private void parse_return_statement() throws CompileError
	{
		assert(m_builder != null);

		// begin with 'ret'
		if(!check_token(TokenType.SYMBOL, RETURN)) {
			throw new CompileError.PARSE_ERROR("Error parsing return statement.");
		}
		next_token();

		// find the return type of the current function.
		var func_type = m_function.type_of();
		assert(func_type->get_type_kind() == TypeKind.Pointer);

		func_type = func_type->get_element_type();
		assert(func_type->get_type_kind() == TypeKind.Function);

		var ret_type = func_type->get_return_type();

		// if no expression, then check we're ok to return void.
		if(m_token_type == ';') {
			if(ret_type->get_type_kind() != TypeKind.Void) {
				throw new CompileError.PARSE_ERROR(
						"Attempt to return void from non-void function.");
			}
			m_builder.build_ret_void();
			return;
		}

		// we expect some expression
		var expr = parse_expression();

		// check types match
		if(ret_type->get_type_kind() != expr->type_of()->get_type_kind()) {
			throw new CompileError.PARSE_ERROR(
					"Invalid expression in return statement. " +
					"Type must match return type of function.");
		}

		m_builder.build_ret(expr);
	}

	private void check_compatible_types(LLVM.Value a, LLVM.Value b)  throws CompileError
	{
		if(a.type_of() != b.type_of()) {
			throw new CompileError.PARSE_ERROR("Expressions are of incompatible types.");
		}
	}

	private bool next_token_is_operator() {
		return ((m_token_type == '+') || (m_token_type == '-') || 
				(m_token_type == '*') || (m_token_type == '/'));
	}

	private int token_precedence(TokenType token) {
		if((token == '+') || (token == '-'))
			return 10;

		if((token == '*') || (token == '/'))
			return 20;

		return 0;
	}

	// This expression parsing with precedence mechanism is an example of an
	// operator precedence parser (see
	// http://en.wikipedia.org/wiki/Operator-precedence_parser ).

	private LLVM.Value* parse_expression() throws CompileError
	{
		return parse_expression_1( parse_primary(), 0 );
	}

	private LLVM.Value* parse_expression_1(LLVM.Value* lhs, int min_precedence) 
		throws CompileError
	{
		while(next_token_is_operator() &&
				(token_precedence(m_token_type) >= min_precedence))
		{
			TokenType op = m_token_type;
			next_token(); // chomp the operator
			int op_precedence = token_precedence(op);

			LLVM.Value* rhs = parse_primary();

			while(next_token_is_operator() &&
				(token_precedence(m_token_type) > op_precedence) )
			{
				TokenType lookahead = m_token_type;
				rhs = parse_expression_1( rhs, token_precedence(lookahead) );
			}

			if(op == '+') {
				check_compatible_types(lhs, rhs);
				lhs = m_builder.build_add(lhs, rhs);
			} else if(op == '-') {
				check_compatible_types(lhs, rhs);
				lhs = m_builder.build_sub(lhs, rhs);
			} else if(op == '*') {
				check_compatible_types(lhs, rhs);
				lhs = m_builder.build_mul(lhs, rhs);
			} else if(op == '/') {
				check_compatible_types(lhs, rhs);
				lhs = m_builder.build_fdiv(lhs, rhs);
			} else {
				// should be unreachable.
				assert(false);
			}
		}

		return lhs;
	}
	
	private LLVM.Value* parse_primary() throws CompileError
	{
		LLVM.Value* expression = null;

		if(m_token_type == '(') {
			next_token(); // chomp bracket

			// parse the sub-expression
			expression = parse_expression();
			if(!check_token((TokenType)')')) {
				throw new CompileError.PARSE_ERROR("Error parsing sub-expression.");
			}

			next_token(); // chomp bracket
		} else if(m_token_type == TokenType.INT) {
			expression = Constant.const_real( Ty.int32(), m_token_value.int );
			next_token();
		} else if(m_token_type == TokenType.FLOAT) {
			expression = Constant.const_real( Ty.float(), m_token_value.float );
			next_token();
		} else if(m_token_type == '+') {
			/* nop */
			next_token();
			expression = parse_primary();
		} else if(m_token_type == '-') {
			/* negate */
			next_token();

			LLVM.Value* lhs = Constant.const_real( Ty.float(), -1.0 );
			LLVM.Value* rhs = parse_primary();

			check_compatible_types(lhs, rhs);
			expression = m_builder.build_mul(lhs, rhs); 
		} else {
			throw new CompileError.PARSE_ERROR("Error parsing expression.");
		}

		assert(expression != null);

		return expression;
	}
}

void main(string[] argv)
{
	link_in_interpreter ();
	link_in_jit ();
	initialize_native_target ();

	for(int i=1; i<argv.length; ++i) {
		var file_name = argv[i];
		stdout.printf("Compiling %s.\n", file_name);

		var c = new Compiler();
		try {
			c.compile_source_file(file_name);

			stdout.printf("Verifying %s.\n", file_name);
			Message error;
			c.llvm_module.verify (VerifierFailureAction.AbortProcess, out error);

			stdout.printf("Running %s.\n", file_name);
		
			ExecutionEngine ee;
			var provider = new ModuleProvider (c.llvm_module);
			ExecutionEngine.create_jit_compiler (out ee, (owned)provider, 3, out error);
			//ExecutionEngine.create_interpreter (out ee, (owned)provider, out error);
			if (error != null) {
				warning (error);
				Posix.exit (1);
			}

			var pass = new PassManager ();
			pass.add_target_data (ee.get_target_data ());
			pass.add_constant_propagation ();
			pass.add_instruction_combining ();
			pass.add_promote_memory_to_register ();
			pass.add_gvn ();
			pass.add_cfg_simplification ();
			pass.run (c.llvm_module);
			c.llvm_module.dump ();

			var main = c.llvm_module.get_named_function("main");
			if(main == null) {
				stderr.printf("No function named main.");
			}
			
			GenericValue exec_res = ee.run_function (main, { });
			message ("result %lf", exec_res.to_float (Ty.float()));
		} catch (CompileError e) {
			stderr.printf("%s: %s\n", c.cur_position_string(), e.message);
			if(c.llvm_module != null)
				c.llvm_module.dump();
		}
	}
}

// vim:sw=4:ts=4:cindent
