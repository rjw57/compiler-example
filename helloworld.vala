using LLVM;
using Gee;

// Potential errors
errordomain CompileError {
	FILE_CANNOT_BE_OPENED,	// Could not open the input file.
	EOF_ENCOUNTERED,		// An EOF was encountered unexpectedly.
	PARSE_ERROR,			// A generic parse error.
}

class SymbolTable {
	private LinkedList<HashMap<string,LLVM.Value*>> m_table = 
		new LinkedList<HashMap<string,LLVM.Value*>>();

	public SymbolTable() 
	{
		push_scope();
	}

	~SymbolTable()
	{
		pop_scope();
	}

	public void add_symbol(string name, LLVM.Value* value)
	{
		m_table.first().set(name, value);
	}

	public bool has_symbol_named(string name)
	{
		foreach(var map in m_table) 
		{
			if(map.has_key(name))
				return true;
		}

		return false;
	}

	public LLVM.Value* get_symbol_named(string name)
	{
		foreach(var map in m_table) 
		{
			if(map.has_key(name)) {
				return map.get(name);
			}
		}

		return null;
	}

	public void push_scope()
	{
		m_table.insert(0, new HashMap<string,LLVM.Value*>());
	}

	public void pop_scope()
	{
		m_table.poll_head();
	}
}

class Compiler {
	private struct FilePosition {
		uint line;
		uint column;
	}

	[Compact]
	private class FuncDecl {
		public string 				name = null;
		public Ty* 					llvm_type = null;
		public HashMap<string, Ty*>	arguments = new HashMap<string, Ty*>();
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

	private SymbolTable			m_symbol_table = null;

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
		llvm_module.add_type_name("int", Ty.int32());

		// Create the symbol table
		m_symbol_table = new SymbolTable();

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
	}

	private void new_variable(string name, LLVM.Ty* type, LLVM.Value* initial_value = null)
	{
		LLVM.Value* alloca = m_builder.build_alloca(type, name);
		m_symbol_table.add_symbol(name, alloca);

		if(initial_value != null) 
		{
			m_builder.build_store(initial_value, alloca);
		}
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
						"A function named '%s' already exists.", func_decl.name);
			}

			// no existing function, create it.
			m_function = new Function(llvm_module, func_decl.name, func_decl.llvm_type); 
			m_function.call_conv = CallConv.C;

			m_builder = new Builder();
			var basic_block = m_function.append_basic_block("entry");
			m_builder.position_at_end(basic_block);

			// push a new scope
			m_symbol_table.push_scope();

			// add any arguments
			if(func_decl.arguments.size > 0) 
			{
				// add function arguments as variables
				uint arg_idx = 0;
				foreach(var arg in func_decl.arguments)
				{
					new_variable(arg.key, arg.value, m_function.get_param(arg_idx));
					arg_idx++;
				}
			}

			// parse function block.
			parse_block();

			// terminate the function's basic block if appropriate
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
					throw new CompileError.PARSE_ERROR(
							"Function ends without a return statement.");
				}
			}

			m_builder = null;

			// remove the scope
			m_symbol_table.pop_scope();

			// we've now moved out of the function.
			m_function = null;
		} else {
			throw new CompileError.PARSE_ERROR("Expected 'def'.");
		}
	}

	// parse a function declaration
	private FuncDecl parse_function_declaration() throws CompileError
	{
		FuncDecl decl = new FuncDecl(); 

		// expect an identifier naming the function.
		if(!check_token(TokenType.IDENTIFIER)) {
			throw new CompileError.PARSE_ERROR("Expected identifier which names the function.");
		}

		decl.name = m_token_value.identifier;
		
		next_token();

		// Any arguments?
		if(m_token_type == TokenType.IDENTIFIER) {
			parse_function_arguments(decl);
		}

		// Do we have a return type specified?
		Ty* return_type = llvm_module.get_type_by_name("void");
		if(m_token_type == ':') {
			next_token();

			// get the type name
			return_type = parse_type_name();
		}

		decl.llvm_type = Ty.function( return_type, decl.arguments.values.to_array(), 0 );

		return decl;
	}

	private void parse_function_arguments(FuncDecl decl) throws CompileError
	{
		// function arguments are a comma separated list of type and argument name
		bool keep_parsing = true;
		while(keep_parsing) {
			LLVM.Ty* type = parse_type_name();

			if(!check_token(TokenType.IDENTIFIER)) {
				throw new CompileError.PARSE_ERROR("Expecting identifier to name argument.");
			}

			if(decl.arguments.has_key( m_token_value.identifier )) {
				throw new CompileError.PARSE_ERROR("Function alreay has argument named '%s'.",
						m_token_value.identifier);
			}

			decl.arguments.set( m_token_value.identifier, type );

			next_token();

			if(m_token_type == TokenType.COMMA) {
				keep_parsing = true;
				next_token(); // chomp comma
			} else {
				keep_parsing = false;
			}
		}
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

	private void parse_block() throws CompileError
	{
		assert(m_function != null);

		if(!check_token(TokenType.LEFT_CURLY)) {
			throw new CompileError.PARSE_ERROR("Expected a '{' to start a block.");
		}
		next_token();

		m_symbol_table.push_scope();

		// parse function block.
		while(m_token_type != TokenType.RIGHT_CURLY) {
			// parse statements.
			parse_statement();
		}

		m_symbol_table.pop_scope();
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
				// attempt to parse expression
				parse_expression();

				if(!check_token((TokenType)';')) {
					throw new CompileError.PARSE_ERROR(
							"Expect expression statement to have terminating semi-colon.");
				}
				next_token();
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
			expression = Constant.const_int( Ty.int32(), (uint) m_token_value.int, 1 );
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
		} else if(m_token_type == TokenType.IDENTIFIER) {
			string name = m_token_value.identifier;
			next_token();

			if(m_token_type != TokenType.LEFT_PAREN) {
				/* a variable */
				if(!m_symbol_table.has_symbol_named(name)) {
					throw new CompileError.PARSE_ERROR("Unknown variable: '%s'.", name);
				}

				expression = m_builder.build_load(m_symbol_table.get_symbol_named(name));
			} else {
				/* a function call: do we have a function named this? */
				LLVM.Function* f = llvm_module.get_named_function(name);

				if(f == null) {
					throw new CompileError.PARSE_ERROR("No such function '%s' defined.",
							name);
				}

				/* parse arguments */
				next_token();
				var arguments = new ArrayList<LLVM.Value*>();
				while(m_token_type != TokenType.RIGHT_PAREN) {
					/* parse expression */
					arguments.add( parse_expression() );

					if(m_token_type != TokenType.RIGHT_PAREN) {
						/* we should be separated by commas */
						if(!check_token(TokenType.COMMA)) {
							throw new CompileError.PARSE_ERROR(
									"Function arguments should be separated by commas.");
						}

						next_token(); // chomp comma
					}
				}

				/* do call */
				expression = m_builder.build_call(f, arguments.to_array());

				next_token();
			}
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
			c.llvm_module.dump();

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
