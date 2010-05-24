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

		// set this as the current scanner.
		m_current_scanner = scanner;

		// Reset the location of the current token.
		m_token_position.line = 0;
		m_token_position.column = 0;

		// Start compiling.
		m_llvm_module = new Module.with_name(scanner.input_name);

		// Add our standard types
		llvm_module.add_type_name("void", Ty.void());

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
		if((m_token_type == TokenType.SYMBOL) && (m_token_value.symbol == DEFINE_FUNCTION)) {
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

			next_token();

			// parse function block.
			var func_block = parse_block();

			// we've now moved out of the function.
			m_function = null;
		} else {
			throw new CompileError.PARSE_ERROR("Expected 'def'.");
		}
	}

	private FuncDecl parse_function_declaration() throws CompileError
	{
		FuncDecl decl = { null, null };

		// expect an identifier naming the function.
		if(m_token_type == TokenType.IDENTIFIER) {
		} else {
			throw new CompileError.PARSE_ERROR("Expected identifier which names the function.");
		}

		decl.name = m_token_value.identifier;
		decl.llvm_type = 
			Ty.function( llvm_module.get_type_by_name("void"), { }, 0 );

		return decl;
	}

	private LLVM.BasicBlock parse_block() throws CompileError
	{
		assert(m_function != null);

		if(m_token_type != TokenType.LEFT_CURLY) {
			throw new CompileError.PARSE_ERROR("Expected a '{' to start a block.");
		}

		// append the new basic block.
		var basic_block = m_function.append_basic_block("entry");
		m_builder = new Builder();
		m_builder.position_at_end(basic_block);

		// parse function block.
		next_token();
		while(m_token_type != TokenType.RIGHT_CURLY) {
			// parse statements.
			next_token();
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
			message ("result %u", exec_res.to_int (0));
		} catch (CompileError e) {
			stderr.printf("%s: %s\n", c.cur_position_string(), e.message);
		}
	}
}

// vim:sw=4:ts=4:cindent
