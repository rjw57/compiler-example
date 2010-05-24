[CCode (cheader_filename = "llvm-c/Core.h")]
namespace LLVM {
	[Compact]
	[CCode (cname="struct LLVMOpaqueBuilder", free_function="LLVMDisposeBuilder")]
	public class Builder {
		[CCode (cname = "LLVMCreateBuilder", cheader_filename = "llvm-c/Core.h")]
		public Builder ();
		[CCode (cname = "LLVMCreateBuilderInContext", cheader_filename = "llvm-c/Core.h")]
		public Builder.in_context (Context c);

		[CCode (cname = "LLVMPositionBuilder", cheader_filename = "llvm-c/Core.h")]
		public void position (BasicBlock block, Instruction instr);
		[CCode (cname = "LLVMPositionBuilderBefore", cheader_filename = "llvm-c/Core.h")]
		public void position_before (Instruction instr);
		[CCode (cname = "LLVMPositionBuilderAtEnd", cheader_filename = "llvm-c/Core.h")]
		public void position_at_end (BasicBlock block);

		[CCode (cname = "LLVMBuildRetVoid", cheader_filename = "llvm-c/Core.h")]
		public ReturnInst* build_ret_void ();
		[CCode (cname = "LLVMBuildRet", cheader_filename = "llvm-c/Core.h")]
		public ReturnInst* build_ret (LLVM.Value v);
		[CCode (cname = "LLVMBuildAggregateRet", cheader_filename = "llvm-c/Core.h")]
		public ReturnInst* build_aggregate_ret (LLVM.Value[] ret_vals);

		[CCode (cname = "LLVMBuildBr", cheader_filename = "llvm-c/Core.h")]
		public BranchInst* build_br (BasicBlock dest);
		[CCode (cname = "LLVMBuildCondBr", cheader_filename = "llvm-c/Core.h")]
		public BranchInst* build_cond_br (Value @if, BasicBlock then, BasicBlock @else);

		[CCode (cname = "LLVMBuildSwitch", cheader_filename = "llvm-c/Core.h")]
		public SwitchInst* build_switch (Value v, BasicBlock @else, uint num_cases = 10);

		[CCode (cname = "LLVMBuildInvoke", cheader_filename = "llvm-c/Core.h")]
		public InvokeInst* build_invoke (Value Fn, [CCode (array_length_pos = 2.9)] Value[] args, BasicBlock then, BasicBlock @catch, string name = "");

		[CCode (cname = "LLVMBuildUnwind", cheader_filename = "llvm-c/Core.h")]
		public UnwindInst* build_unwind ();

		[CCode (cname = "LLVMBuildUnreachable", cheader_filename = "llvm-c/Core.h")]
		public UnreachableInst* build_unreachable ();

		[CCode (cname = "LLVMBuildAdd", cheader_filename = "llvm-c/Core.h")]
		public Value* build_add (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildNSWAdd", cheader_filename = "llvm-c/Core.h")]
		public Value* build_nswadd (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildFAdd", cheader_filename = "llvm-c/Core.h")]
		public Value* build_fadd (Value lhs, Value rhs, string name = "");

		[CCode (cname = "LLVMBuildSub", cheader_filename = "llvm-c/Core.h")]
		public Value* build_sub (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildFSub", cheader_filename = "llvm-c/Core.h")]
		public Value* build_fsub (Value lhs, Value rhs, string name = "");

		[CCode (cname = "LLVMBuildMul", cheader_filename = "llvm-c/Core.h")]
		public Value* build_mul (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildFMul", cheader_filename = "llvm-c/Core.h")]
		public Value* build_fmul (Value lhs, Value rhs, string name = "");

		[CCode (cname = "LLVMBuildUDiv", cheader_filename = "llvm-c/Core.h")]
		public Value* build_udiv (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildFDiv", cheader_filename = "llvm-c/Core.h")]
		public Value* build_fdiv (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildSDiv", cheader_filename = "llvm-c/Core.h")]
		public Value* build_sdiv (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildExactSDiv", cheader_filename = "llvm-c/Core.h")]
		public Value* build_exact_sdiv (Value lhs, Value rhs, string name = "");

		[CCode (cname = "LLVMBuildURem", cheader_filename = "llvm-c/Core.h")]
		public Value* build_urem (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildSRem", cheader_filename = "llvm-c/Core.h")]
		public Value* build_srem (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildFRem", cheader_filename = "llvm-c/Core.h")]
		public Value* build_frem (Value lhs, Value rhs, string name = "");

		[CCode (cname = "LLVMBuildShl", cheader_filename = "llvm-c/Core.h")]
		public Value* build_shl (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildLShr", cheader_filename = "llvm-c/Core.h")]
		public Value* build_lshr (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildAShr", cheader_filename = "llvm-c/Core.h")]
		public Value* build_ashr (Value lhs, Value rhs, string name = "");

		[CCode (cname = "LLVMBuildAnd", cheader_filename = "llvm-c/Core.h")]
		public Value* build_and (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildOr", cheader_filename = "llvm-c/Core.h")]
		public Value* build_or (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildXor", cheader_filename = "llvm-c/Core.h")]
		public Value* build_xor (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildNeg", cheader_filename = "llvm-c/Core.h")]
		public Value* build_neg (Value v, string name = "");
		[CCode (cname = "LLVMBuildFNeg", cheader_filename = "llvm-c/Core.h")]
		public Value* build_fneg (Value v, string name = "");
		[CCode (cname = "LLVMBuildNot", cheader_filename = "llvm-c/Core.h")]
		public Value* build_not (Value v, string name = "");

		[CCode (cname = "LLVMBuildMalloc", cheader_filename = "llvm-c/Core.h")]
		public CallInst* build_malloc (Ty ty, string name = "");
		[CCode (cname = "LLVMBuildArrayMalloc", cheader_filename = "llvm-c/Core.h")]
		public CallInst* build_array_malloc (Ty ty, Value val, string name = "");
		[CCode (cname = "LLVMBuildAlloca", cheader_filename = "llvm-c/Core.h")]
		public AllocaInst* build_alloca (Ty ty, string name = "");
		[CCode (cname = "LLVMBuildArrayAlloca", cheader_filename = "llvm-c/Core.h")]
		public AllocaInst* build_array_alloca (Ty ty, Value val, string name = "");
		[CCode (cname = "LLVMBuildFree", cheader_filename = "llvm-c/Core.h")]
		public CallInst* build_free (Value pointer_val);

		[CCode (cname = "LLVMBuildLoad", cheader_filename = "llvm-c/Core.h")]
		public LoadInst* build_load (Value pointer_val, string name = "");
		[CCode (cname = "LLVMBuildStore", cheader_filename = "llvm-c/Core.h")]
		public StoreInst* build_store (Value val, Value ptr);

		[CCode (cname = "LLVMBuildGEP", cheader_filename = "llvm-c/Core.h")]
		public GEPInst* build_gep (Value pointer, [CCode (array_length_pos = 2.9)] Value[] indices, string name = "");
		[CCode (cname = "LLVMBuildInBoundsGEP", cheader_filename = "llvm-c/Core.h")]
		public GEPInst* build_in_bounds_gep (Value pointer, [CCode (array_length_pos = 2.9)] Value[] indices, string name = "");
		[CCode (cname = "LLVMBuildStructGEP", cheader_filename = "llvm-c/Core.h")]
		public GEPInst* build_struct_gep (Value pointer, uint idx, string name = "");
		[CCode (cname = "LLVMBuildGlobalString", cheader_filename = "llvm-c/Core.h")]
		public GlobalValue* build_global_string (string str, string name = "");
		[CCode (cname = "LLVMBuildGlobalStringPtr", cheader_filename = "llvm-c/Core.h")]
		public GEPInst* build_global_string_ptr (string str, string name = "");

		[CCode (cname = "LLVMBuildTrunc", cheader_filename = "llvm-c/Core.h")]
		public CastInst* build_trunc (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildZExt", cheader_filename = "llvm-c/Core.h")]
		public CastInst* build_zext (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildSExt", cheader_filename = "llvm-c/Core.h")]
		public CastInst* build_sext (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildFPToSI", cheader_filename = "llvm-c/Core.h")]
		public CastInst* build_fp_to_si (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildFPToUI", cheader_filename = "llvm-c/Core.h")]
		public CastInst* build_fp_to_ui (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildUIToFP", cheader_filename = "llvm-c/Core.h")]
		public CastInst* build_ui_to_fp (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildSIToFP", cheader_filename = "llvm-c/Core.h")]
		public CastInst* build_si_to_fp (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildFPTrunc", cheader_filename = "llvm-c/Core.h")]
		public CastInst* build_fp_trunc (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildFPExt", cheader_filename = "llvm-c/Core.h")]
		public CastInst* build_fp_ext (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildPtrToInt", cheader_filename = "llvm-c/Core.h")]
		public CastInst* build_ptr_to_int (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildIntToPtr", cheader_filename = "llvm-c/Core.h")]
		public CastInst* build_int_to_ptr (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildBitCast", cheader_filename = "llvm-c/Core.h")]
		public CastInst* build_bit_cast (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildZExtOrBitCast", cheader_filename = "llvm-c/Core.h")]
		public CastInst* build_zext_or_bit_cast (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildSExtOrBitCast", cheader_filename = "llvm-c/Core.h")]
		public CastInst* build_sext_or_bit_cast (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildTruncOrBitCast", cheader_filename = "llvm-c/Core.h")]
		public CastInst* build_trunc_or_bit_cast (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildPointerCast", cheader_filename = "llvm-c/Core.h")]
		public CastInst* build_pointer_cast (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildIntCast", cheader_filename = "llvm-c/Core.h")]
		public CastInst* build_int_cast (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildFPCast", cheader_filename = "llvm-c/Core.h")]
		public CastInst* build_fp_cast (Value val, Ty destty, string name = "");

		[CCode (cname = "LLVMBuildICmp", cheader_filename = "llvm-c/Core.h")]
		public ICmpInst* build_icmp (IntPredicate op, Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildFCmp", cheader_filename = "llvm-c/Core.h")]
		public FCmpInst* build_fcmp (RealPredicate op, Value lhs, Value rhs, string name = "");

		[CCode (cname = "LLVMBuildPhi", cheader_filename = "llvm-c/Core.h")]
		public PHINode* build_phi (Ty ty, string name = "");
		[CCode (cname = "LLVMBuildCall", cheader_filename = "llvm-c/Core.h")]
		public CallInst* build_call (Function fn, [CCode (array_length_pos = 2.9)] LLVM.Value*[] args, string name = "");
		[CCode (cname = "LLVMBuildSelect", cheader_filename = "llvm-c/Core.h")]
		public SelectInst* build_select (Value @if, Value then, Value @else, string name = "");
		[CCode (cname = "LLVMBuildVAArg", cheader_filename = "llvm-c/Core.h")]
		public VAArgInst* build_vaarg (Value list, Ty ty, string name = "");
		[CCode (cname = "LLVMBuildExtractElement", cheader_filename = "llvm-c/Core.h")]
		public ExtractElementInst* build_extract_element (Value vec_val, Value index, string name = "");
		[CCode (cname = "LLVMBuildInsertElement", cheader_filename = "llvm-c/Core.h")]
		public InsertElementInst* build_insert_element (Value vec_val, Value elt_val, Value index, string name = "");
		[CCode (cname = "LLVMBuildShuffleVector", cheader_filename = "llvm-c/Core.h")]
		public ShuffleVectorInst* build_shuffle_vector (Value v1, Value v2, Value mask, string name = "");
		[CCode (cname = "LLVMBuildExtractValue", cheader_filename = "llvm-c/Core.h")]
		public ExtractValueInst* build_extract_value (Value agg_val, uint index, string name = "");
		[CCode (cname = "LLVMBuildInsertValue", cheader_filename = "llvm-c/Core.h")]
		public InsertValueInst* build_insert_value (Value agg_val, Value elt_val, uint index, string name = "");

		[CCode (cname = "LLVMBuildIsNotNull", cheader_filename = "llvm-c/Core.h")]
		public ICmpInst* build_is_not_null (Value val, string name = "");
		[CCode (cname = "LLVMBuildIsNull", cheader_filename = "llvm-c/Core.h")]
		public ICmpInst* build_is_null (Value val, string name = "");
		[CCode (cname = "LLVMBuildPtrDiff", cheader_filename = "llvm-c/Core.h")]
		public Value* build_ptr_diff (Value lhs, Value rhs, string name = "");

		[CCode (cname = "LLVMGetInsertBlock", cheader_filename = "llvm-c/Core.h")]
		public BasicBlock* get_insert_block ();
		[CCode (cname = "LLVMClearInsertionPosition", cheader_filename = "llvm-c/Core.h")]
		public void clear_insertion_position ();
		[CCode (cname = "LLVMInsertIntoBuilder", cheader_filename = "llvm-c/Core.h")]
		public void insert (Instruction instr);
		[CCode (cname = "LLVMInsertIntoBuilderWithName", cheader_filename = "llvm-c/Core.h")]
		public void insert_with_name (Instruction instr, string name = "");
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueContext", free_function="")]
	// free_function="LLVMContextDispose
	public class Context {
		[CCode (cname = "LLVMContextCreate")]
		public Context();

		[CCode (cname = "LLVMAppendBasicBlockInContext")]
		BasicBlock append_basic_block (Value fn, string name = "");
		[CCode (cname = "LLVMInsertBasicBlockInContext")]
		BasicBlock insert_basic_block (BasicBlock bb, string name = "");

		[CCode (cname = "LLVMGetGlobalContext")]
		public static Context get_global ();

	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueExecutionEngine", free_function="LLVMDisposeExecutionEngine")]
	public class ExecutionEngine {
		[CCode (cname = "LLVMCreateExecutionEngine")]
		public static bool create_execution_engine (out ExecutionEngine ee, owned ModuleProvider m, out Message error);
		[CCode (cname = "LLVMCreateJITCompiler")]
		public static bool create_jit_compiler (out ExecutionEngine jit, owned ModuleProvider m, uint opt_level, out Message error);
		[CCode (cname = "LLVMCreateInterpreter")]
		public static bool create_interpreter (out ExecutionEngine interp, owned ModuleProvider m, out Message error);

		[CCode (cname = "LLVMGetExecutionEngineTargetData", cheader_filename = "llvm-c/ExecutionEngine.h")]
		public TargetData* get_target_data ();

		[CCode (cname = "LLVMAddGlobalMapping", cheader_filename = "llvm-c/ExecutionEngine.h")]
		public void add_global_mapping (Value global, void* addr);
		[CCode (cname = "LLVMAddModuleProvider", cheader_filename = "llvm-c/ExecutionEngine.h")]
		public void add_module_provider (ModuleProvider mp);
		[CCode (cname = "LLVMRemoveModuleProvider", cheader_filename = "llvm-c/ExecutionEngine.h")]
		public int remove_module_provider (ModuleProvider mp, out Module mod, out Message error);

		[CCode (cname = "LLVMRunFunction", cheader_filename = "llvm-c/ExecutionEngine.h")]
		public GenericValue run_function (Function f, [CCode (array_length_pos = 1.9)] GenericValue[] args);
		[CCode (cname = "LLVMRunStaticConstructors", cheader_filename = "llvm-c/ExecutionEngine.h")]
		public void run_static_constructors ();
		[CCode (cname = "LLVMRunStaticDestructors", cheader_filename = "llvm-c/ExecutionEngine.h")]
		public void run_static_destructors ();
		[CCode (cname = "LLVMRunFunctionAsMain", cheader_filename = "llvm-c/ExecutionEngine.h")]
		public int run_function_as_main (Function f, [CCode (array_length_pos = 1.9)] string[] argv, [CCode (array_length = false)] string[] EnvP);
		[CCode (cname = "LLVMFreeMachineCodeForFunction", cheader_filename = "llvm-c/ExecutionEngine.h")]
		public void free_machine_code_for_function (Function f);
		[CCode (cname = "LLVMFindFunction", cheader_filename = "llvm-c/ExecutionEngine.h")]
		public int find_function (string name, out Function* f);
		[CCode (cname = "LLVMGetPointerToGlobal", cheader_filename = "llvm-c/ExecutionEngine.h")]
		public void* get_pointer_to_global (GlobalValue global);
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueGenericValue", free_function="LLVMDisposeGenericValue", cheader_filename = "llvm-c/ExecutionEngine.h")]
	public class GenericValue {
		[CCode (cname = "LLVMCreateGenericValueOfFloat", cheader_filename = "llvm-c/ExecutionEngine.h")]
		public GenericValue.of_float (Ty ty, double n);
		[CCode (cname = "LLVMCreateGenericValueOfInt", cheader_filename = "llvm-c/ExecutionEngine.h")]
		public GenericValue.of_int (Ty ty, uint n, int is_signed);
		[CCode (cname = "LLVMCreateGenericValueOfPointer", cheader_filename = "llvm-c/ExecutionEngine.h")]
		public GenericValue.of_pointer (void* p);

		[CCode (cname = "LLVMGenericValueIntWidth", cheader_filename = "llvm-c/ExecutionEngine.h")]
		public uint int_witdh ();

		[CCode (cname = "LLVMGenericValueToFloat", instance_pos = 1.9, cheader_filename = "llvm-c/ExecutionEngine.h")]
		public double to_float (Ty ty);
		[CCode (cname = "LLVMGenericValueToInt", cheader_filename = "llvm-c/ExecutionEngine.h")]
		public uint to_int (int is_signed);
		[CCode (cname = "LLVMGenericValueToPointer", cheader_filename = "llvm-c/ExecutionEngine.h")]
		public void* to_pointer ();
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueMemoryBuffer", free_function="LLVMDisposeMemoryBuffer")]
	public class MemoryBuffer {
		[CCode (cname = "LLVMCreateMemoryBufferWithSTDIN")]
		public static int create_with_stdin (out MemoryBuffer membuf, out Message message);
		[CCode (cname = "LLVMCreateMemoryBufferWithContentsOfFile")]
		public static int create_with_contents_of_file (string path, out MemoryBuffer membuf, out Message message);

		[CCode (cname = "LLVMGetBitcodeModuleProvider", cheader_filename = "llvm-c/BitReader.h")]
		public int get_module_provider (out ModuleProvider mp, out Message message);
		[CCode (cname = "LLVMGetBitcodeModuleProviderInContext", instance_pos = 1.9, cheader_filename = "llvm-c/BitReader.h")]
		public int get_module_provider_in_context (Context context, out ModuleProvider mp, out Message message);
		[CCode (cname = "LLVMParseBitcode", cheader_filename = "llvm-c/BitReader.h")]
		public int parse_bitcode (out Module module, out Message message);
		[CCode (cname = "LLVMParseBitcodeInContext", instance_pos = 1.9, cheader_filename = "llvm-c/BitReader.h")]
		public int parse_bitcode_in_context (Context Context, out Module module, out Message message);
	}

	[CCode (cname="char", free_function="LLVMDisposeMessage")]
	public class Message: string {
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueModuleProvider", free_function="")]
	/* LLVMDisposeModuleProvider */
	public class ModuleProvider {
		[CCode (cname = "LLVMCreateModuleProviderForExistingModule", cheader_filename = "llvm-c/Core.h")]
		public ModuleProvider (/* owned */ Module m);
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueModule", free_function="")]
	/* LLVMDisposeModule */
	public class Module {
		[CCode (cname = "LLVMModuleCreateWithName")]
		public Module.with_name (string name);
		[CCode (cname = "LLVMModuleCreateWithNameInContext")]
		public Module.with_name_in_context (string name, Context c);

		[CCode (cname = "LLVMGetDataLayout")]
		public string* get_data_layout ();
		[CCode (cname = "LLVMSetDataLayout")]
		public void set_data_layout (string triple);

		[CCode (cname = "LLVMGetTarget")]
		public string* get_target ();
		[CCode (cname = "LLVMSetTarget")]
		public void set_target (string Triple);

		[CCode (cname = "LLVMAddTypeName")]
		public int add_type_name (string name, Ty ty);
		[CCode (cname = "LLVMDeleteTypeName")]
		public void delete_type_name (string name);
		[CCode (cname = "LLVMGetTypeByName")]
		public Ty? get_type_by_name (string name);

		[CCode (cname = "LLVMAddAlias", cheader_filename = "llvm-c/Core.h")]
		public GlobalAlias add_alias (LLVM.Ty ty, LLVM.Value aliasee, string name);

		[CCode (cname = "LLVMDumpModule")]
		public void dump ();

		[CCode (cname = "LLVMGetNamedGlobal", cheader_filename = "llvm-c/Core.h")]
		public GlobalVariable* get_named_global (string name);
		[CCode (cname = "LLVMGetFirstGlobal", cheader_filename = "llvm-c/Core.h")]
		public GlobalVariable* get_first_global ();
		[CCode (cname = "LLVMGetLastGlobal", cheader_filename = "llvm-c/Core.h")]
		public GlobalVariable* get_last_global ();

		[CCode (cname = "LLVMGetNamedFunction", cheader_filename = "llvm-c/Core.h")]
		public Function* get_named_function (string name);
		[CCode (cname = "LLVMGetFirstFunction", cheader_filename = "llvm-c/Core.h")]
		public Function* get_first_function ();
		[CCode (cname = "LLVMGetLastFunction", cheader_filename = "llvm-c/Core.h")]
		public Function* get_last_function ();

		[CCode (cname = "LLVMVerifyModule", cheader_filename = "llvm-c/Analysis.h")]
		public int verify (VerifierFailureAction action, out Message message);
		[CCode (cname = "LLVMWriteBitcodeToFile", cheader_filename = "llvm-c/BitWriter.h")]
		public int write_bitcode_to_file (string path);
		[CCode (cname = "LLVMWriteBitcodeToFileHandle", cheader_filename = "llvm-c/BitWriter.h")]
		public int write_bitcode_to_file_handle (int handle);
	}

	[Compact]
	[CCode (cname="struct LLVMOpaquePassManager", free_function="LLVMDisposePassManager")]
	public class PassManagerBase {
		[CCode (cname = "LLVMAddTargetData", instance_pos = -1, cheader_filename = "llvm-c/Target.h")]
		public void add_target_data (TargetData target);
		[CCode (cname = "LLVMAddAggressiveDCEPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_aggressive_dce ();
		[CCode (cname = "LLVMAddArgumentPromotionPass", cheader_filename = "llvm-c/Transforms/IPO.h")]
		public void add_argument_promotion ();
		[CCode (cname = "LLVMAddCFGSimplificationPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_cfg_simplification ();
		[CCode (cname = "LLVMAddConstantMergePass", cheader_filename = "llvm-c/Transforms/IPO.h")]
		public void add_constant_merge ();
		[CCode (cname = "LLVMAddConstantPropagationPass", cheader_filename = "llvm-c/Transforms/IPO.h")]
		public void add_constant_propagation ();
		[CCode (cname = "LLVMAddDeadArgEliminationPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_dead_arg_elimination ();
		[CCode (cname = "LLVMAddDeadStoreEliminationPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_dead_store_elimination ();
		[CCode (cname = "LLVMAddDeadTypeEliminationPass", cheader_filename = "llvm-c/Transforms/IPO.h")]
		public void add_dead_type_elimination ();
		[CCode (cname = "LLVMAddDemoteMemoryToRegisterPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_demote_memory_to_register ();
		[CCode (cname = "LLVMAddFunctionAttrsPass", cheader_filename = "llvm-c/Transforms/IPO.h")]
		public void add_function_attrs ();
		[CCode (cname = "LLVMAddFunctionInliningPass", cheader_filename = "llvm-c/Transforms/IPO.h")]
		public void add_function_inlining ();
		[CCode (cname = "LLVMAddGVNPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_gvn ();
		[CCode (cname = "LLVMAddGlobalDCEPass", cheader_filename = "llvm-c/Transforms/IPO.h")]
		public void add_global_dce ();
		[CCode (cname = "LLVMAddGlobalOptimizerPass", cheader_filename = "llvm-c/Transforms/IPO.h")]
		public void add_global_optimizer_pass ();
		[CCode (cname = "LLVMAddIPConstantPropagationPass", cheader_filename = "llvm-c/Transforms/IPO.h")]
		public void add_ipconstant_propagation ();
		[CCode (cname = "LLVMAddIndVarSimplifyPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_ind_var_simplify ();
		[CCode (cname = "LLVMAddInstructionCombiningPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_instruction_combining ();
		[CCode (cname = "LLVMAddJumpThreadingPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_jump_threading ();
		[CCode (cname = "LLVMAddLICMPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_licm ();
		[CCode (cname = "LLVMAddLoopDeletionPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_loop_deletion ();
		[CCode (cname = "LLVMAddLoopIndexSplitPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_loop_index_split ();
		[CCode (cname = "LLVMAddLoopRotatePass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_loop_rotate ();
		[CCode (cname = "LLVMAddLoopUnrollPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_loop_unroll ();
		[CCode (cname = "LLVMAddLoopUnswitchPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_loop_unswitch ();
		[CCode (cname = "LLVMAddLowerSetJmpPass", cheader_filename = "llvm-c/Transforms/IPO.h")]
		public void add_lower_setjmp ();
		[CCode (cname = "LLVMAddMemCpyOptPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_memcpy_opt ();
		[CCode (cname = "LLVMAddPromoteMemoryToRegisterPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_promote_memory_to_register ();
		[CCode (cname = "LLVMAddPruneEHPass", cheader_filename = "llvm-c/Transforms/IPO.h")]
		public void add_prune_eh ();
		[CCode (cname = "LLVMAddRaiseAllocationsPass", cheader_filename = "llvm-c/Transforms/IPO.h")]
		public void add_raise_allocations ();
		[CCode (cname = "LLVMAddReassociatePass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_reassociate ();
		[CCode (cname = "LLVMAddSCCPPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_sccp ();
		[CCode (cname = "LLVMAddScalarReplAggregatesPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_scalar_repl_aggregates ();
		[CCode (cname = "LLVMAddSimplifyLibCallsPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_simplify_lib_calls ();
		[CCode (cname = "LLVMAddStripDeadPrototypesPass", cheader_filename = "llvm-c/Transforms/IPO.h")]
		public void add_strip_dead_prototypes ();
		[CCode (cname = "LLVMAddStripSymbolsPass", cheader_filename = "llvm-c/Transforms/IPO.h")]
		public void add_strip_symbols ();
		[CCode (cname = "LLVMAddTailCallEliminationPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_tailcall_elimination ();
	}

	[Compact]
	[CCode (cname="struct LLVMOpaquePassManager", free_function="LLVMDisposePassManager")]
	public class PassManager: PassManagerBase {
		[CCode (cname = "LLVMCreatePassManager", cheader_filename = "llvm-c/Core.h")]
		public PassManager ();

		[CCode (cname = "LLVMRunPassManager", cheader_filename = "llvm-c/Core.h")]
		public int run (Module m);
	}

	[Compact]
	[CCode (cname="struct LLVMOpaquePassManager", free_function="LLVMDisposePassManager")]
	public class FunctionPassManager: PassManagerBase {
		[CCode (cname = "LLVMCreateFunctionPassManager", cheader_filename = "llvm-c/Core.h")]
		public FunctionPassManager (ModuleProvider mp);

		[CCode (cname = "LLVMFinalizeFunctionPassManager", cheader_filename = "llvm-c/Core.h")]
		public int finalize ();
		[CCode (cname = "LLVMInitializeFunctionPassManager", cheader_filename = "llvm-c/Core.h")]
		public int initialize ();
		[CCode (cname = "LLVMRunFunctionPassManager", cheader_filename = "llvm-c/Core.h")]
		public int run (Function f);
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueStructLayout")]
	public class StructLayout {
	}

	[CCode (cprefix = "", has_type_id = "0", cheader_filename = "llvm-c/Target.h")]
	public enum ByteOrdering {
		[CCode (cname = "LLVMBigEndian")]
		BigEndian,
		[CCode (cname = "LLVMLittleEndian")]
		LittleEndian
	}

	[Compact]
	[CCode (cheader_filename = "llvm-c/Target.h", cname="struct LLVMOpaqueTargetData", free_function="LLVMDisposeTargetData")]
	public class TargetData {
		[CCode (cname = "LLVMCreateTargetData", cheader_filename = "llvm-c/Target.h")]
		public TargetData (string string_rep);

		[CCode (cname = "LLVMOffsetOfElement", cheader_filename = "llvm-c/Target.h")]
		public uint offset_of_element (Ty struct_ty, uint element);
		[CCode (cname = "LLVMPointerSize", cheader_filename = "llvm-c/Target.h")]
		public uint pointer_size ();
		[CCode (cname = "LLVMCopyStringRepOfTargetData", cheader_filename = "llvm-c/Target.h")]
		public string string_rep ();
		[CCode (cname = "LLVMByteOrder", cheader_filename = "llvm-c/Target.h")]
		public ByteOrdering byte_order ();
		[CCode (cname = "LLVMSizeOfTypeInBits", cheader_filename = "llvm-c/Target.h")]
		public uint size_of_type_in_bits (Ty ty);
		[CCode (cname = "LLVMStoreSizeOfType", cheader_filename = "llvm-c/Target.h")]
		public uint store_size_of_type (Ty ty);
		[CCode (cname = "LLVMABISizeOfType", cheader_filename = "llvm-c/Target.h")]
		public uint abi_size_of_type (Ty ty);
		[CCode (cname = "LLVMABIAlignmentOfType", cheader_filename = "llvm-c/Target.h")]
		public uint abi_alignment_of_type (Ty ty);
		[CCode (cname = "LLVMCallFrameAlignmentOfType", cheader_filename = "llvm-c/Target.h")]
		public uint call_frame_alignment_of_type (Ty ty);
		[CCode (cname = "LLVMElementAtOffset", cheader_filename = "llvm-c/Target.h")]
		public uint element_at_offset (Ty struct_ty, uint offset);
		[CCode (cname = "LLVMInvalidateStructLayout", cheader_filename = "llvm-c/Target.h")]
		public void invalidate_struct_layout (Ty struct_ty);
		[CCode (cname = "LLVMPreferredAlignmentOfGlobal", cheader_filename = "llvm-c/Target.h")]
		public uint preferred_alignment_of_global (GlobalVariable global_var);
		[CCode (cname = "LLVMPreferredAlignmentOfType", cheader_filename = "llvm-c/Target.h")]
		public uint preferred_alignment_of_type (Ty ty);
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueTypeHandle", free_function="LLVMDisposeTypeHandle")]
	public class TyHandle {
		[CCode (cname = "LLVMCreateTypeHandle")]
		public TyHandle (Ty potentially_abstract_ty);

		[CCode (cname = "LLVMResolveTyHandle")]
		public Ty* resolve ();
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueType", free_function="")]
	public class Ty {
		/* array */
		[CCode (cname = "LLVMArrayType")]
		public static Ty* array (Ty element_type, uint element_count);
		[CCode (cname = "LLVMGetArrayLength")]
		public uint get_array_length ();
		/* double */
		[CCode (cname = "LLVMDoubleType")]
		public static Ty* double ();
		[CCode (cname = "LLVMDoubleTypeInContext")]
		public static Ty* double_in_context (Context c);
		/* fp128 */
		[CCode (cname = "LLVMFP128Type")]
		public static Ty* fp128 ();
		[CCode (cname = "LLVMFP128TypeInContext")]
		public static Ty* fp128_in_context (Context c);
		/* float */
		[CCode (cname = "LLVMFloatType")]
		public static Ty* float ();
		[CCode (cname = "LLVMFloatTypeInContext")]
		public static Ty* float_in_context (Context c);
		/* function */
		[CCode (cname = "LLVMFunctionType")]
		public static Ty* function (Ty return_type, [CCode (array_length_pos = 2.9)] Ty*[] param_types, int is_var_arg = false);
		[CCode (cname = "LLVMIsFunctionVarArg")]
		public int is_function_var_arg (); /* function_ty */
		[CCode (cname = "LLVMGetReturnType")]
		public Ty* get_return_type (); /* function_ty */
		[CCode (cname = "LLVMCountParamTypes")]
		public uint count_param_types (); /* function_ty */
		[CCode (cname = "LLVMGetParamTypes")]
		public void get_param_types (ref Ty[] dest);
		/* int */
		[CCode (cname = "LLVMInt16Type")]
		public static Ty* int16 ();
		[CCode (cname = "LLVMInt16TypeInContext")]
		public static Ty* int16_in_context (Context c);
		[CCode (cname = "LLVMInt1Type")]
		public static Ty* int1 ();
		[CCode (cname = "LLVMInt1TypeInContext")]
		public static Ty* int1_in_context (Context c);
		[CCode (cname = "LLVMInt32Type")]
		public static Ty* int32 ();
		[CCode (cname = "LLVMInt32TypeInContext")]
		public static Ty* int32_in_context (Context c);
		[CCode (cname = "LLVMInt64Type")]
		public static Ty* int64 ();
		[CCode (cname = "LLVMInt64TypeInContext")]
		public static Ty* int64_in_context (Context c);
		[CCode (cname = "LLVMInt8Type")]
		public static Ty* int8 ();
		[CCode (cname = "LLVMInt8TypeInContext")]
		public static Ty* int8_in_context (Context c);
		[CCode (cname = "LLVMIntPtrType", cheader_filename="llvm-c/Target.h")]
		public static Ty* int_ptr (TargetData p1);
		[CCode (cname = "LLVMIntType")]
		public static Ty* int (uint num_bits);
		[CCode (cname = "LLVMIntTypeInContext")]
		public static Ty* int_in_context (Context c, uint num_bits);
		[CCode (cname = "LLVMGetIntTypeWidth")]
		public uint get_int_type_width (); /* integer_ty */
		/* label */
		[CCode (cname = "LLVMLabelType")]
		public static Ty* label ();
		[CCode (cname = "LLVMLabelTypeInContext")]
		public static Ty* label_in_context (Context c);
		/* opaque */
		[CCode (cname = "LLVMOpaqueType")]
		public static Ty* opaque ();
		[CCode (cname = "LLVMOpaqueTypeInContext")]
		public static Ty* opaque_in_context (Context c);
		/* PPCFP128 */
		[CCode (cname = "LLVMPPCFP128Type")]
		public static Ty* ppcfp128 ();
		[CCode (cname = "LLVMPPCFP128TypeInContext")]
		public static Ty* ppcfp128_in_context (Context c);
		/* pointer */
		[CCode (cname = "LLVMPointerType")]
		public static Ty* pointer (Ty element_type, uint address_space);
		[CCode (cname = "LLVMGetPointerAddressSpace")]
		public uint get_pointer_address_space ();
		/* struct */
		[CCode (cname = "LLVMStructType")]
		public static Ty* struct (Ty element_types, uint element_count, int packed);
		[CCode (cname = "LLVMStructTypeInContext")]
		public static Ty* struct_in_context (Context c, Ty element_types, uint element_count, int packed);
		[CCode (cname = "LLVMCountStructElementTypes")]
		public uint count_struct_element_types ();
		[CCode (cname = "LLVMGetStructElementTypes")]
		public void get_struct_element_types (ref Ty[] Dest);
		[CCode (cname = "LLVMIsPackedStruct")]
		public int is_packed_struct (); /* struct_ty */
		/* vector */
		[CCode (cname = "LLVMVectorType")]
		public static Ty* vector (Ty element_type, uint element_count);
		[CCode (cname = "LLVMGetVectorSize")]
		public uint get_vector_size (); /* vector_ty */
		/* void */
		[CCode (cname = "LLVMVoidType")]
		public static Ty* void ();
		[CCode (cname = "LLVMVoidTypeInContext")]
		public static Ty* void_in_context (Context c);
		/* X86FP80 */
		[CCode (cname = "LLVMX86FP80Type")]
		public static Ty* x86fp80 ();
		[CCode (cname = "LLVMX86FP80TypeInContext")]
		public static Ty* x86fp80_in_context (Context c);


		[CCode (cname = "LLVMGetElementType")]
		public Ty* get_element_type ();
		[CCode (cname = "LLVMGetTypeKind")]
		public TypeKind get_type_kind ();
		[CCode (cname = "LLVMGetTypeContext")]
		public Context* get_context ();

		[CCode (cname = "LLVMSizeOf")]
		public Value size_of (Ty ty);

		[CCode (cname = "LLVMRefineType")]
		public void refine (Ty concrete_ty);
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueUseIterator")]
	public class UseIterator {
		[CCode (cname = "LLVMGetNextUse")]
		public LLVM.UseIterator* get_next ();

		[CCode (cname = "LLVMGetUsedValue")]
		public LLVM.Value get_used_value ();
		[CCode (cname = "LLVMGetUser")]
		public LLVM.Value get_user ();
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function="")]
	public class Value {
		[CCode (cname = "LLVMTypeOf")]
		public Ty* type_of ();
		[CCode (cname = "LLVMGetValueName")]
		public string* get_name ();
		[CCode (cname = "LLVMSetValueName")]
		public void set_name (string name);
		[CCode (cname = "LLVMDumpValue")]
		public void dump ();
		[CCode (cname = "LLVMReplaceAllUsesWith")]
		public void replace_all_use_with (Value new_val);
		[CCode (cname = "LLVMGetFirstUse")]
		public UseIterator* get_first_use ();

		[CCode (cname = "LLVMIsAAllocaInst")]
		public bool is_a_alloca_inst ();
		[CCode (cname = "LLVMIsAArgument")]
		public bool is_a_argument ();
		[CCode (cname = "LLVMIsABasicBlock")]
		public bool is_a_basic_block ();
		[CCode (cname = "LLVMIsABinaryOperator")]
		public bool is_a_binary_operator ();
		[CCode (cname = "LLVMIsABitCastInst")]
		public bool is_a_bit_cast_inst ();
		[CCode (cname = "LLVMIsABranchInst")]
		public bool is_a_branch_inst ();
		[CCode (cname = "LLVMIsACallInst")]
		public bool is_a_call_inst ();
		[CCode (cname = "LLVMIsACastInst")]
		public bool is_a_cast_inst ();
		[CCode (cname = "LLVMIsACmpInst")]
		public bool is_a_cmp_inst ();
		[CCode (cname = "LLVMIsAConstant")]
		public bool is_a_constant ();
		[CCode (cname = "LLVMIsAConstantAggregateZero")]
		public bool is_a_constant_aggregate_zero ();
		[CCode (cname = "LLVMIsAConstantArray")]
		public bool is_a_constant_array ();
		[CCode (cname = "LLVMIsAConstantExpr")]
		public bool is_a_constant_expr ();
		[CCode (cname = "LLVMIsAConstantFP")]
		public bool is_a_constant_fp ();
		[CCode (cname = "LLVMIsAConstantInt")]
		public bool is_a_constant_int ();
		[CCode (cname = "LLVMIsAConstantPointerNull")]
		public bool is_a_constant_pointer_null ();
		[CCode (cname = "LLVMIsAConstantStruct")]
		public bool is_a_constant_struct ();
		[CCode (cname = "LLVMIsAConstantVector")]
		public bool is_a_constant_vector ();
		[CCode (cname = "LLVMIsADbgDeclareInst")]
		public bool is_a_dbg_declare_inst ();
		[CCode (cname = "LLVMIsADbgFuncStartInst")]
		public bool is_a_dbg_func_start_inst ();
		[CCode (cname = "LLVMIsADbgInfoIntrinsic")]
		public bool is_a_dbg_info_intrinsic ();
		[CCode (cname = "LLVMIsADbgRegionEndInst")]
		public bool is_a_dbg_region_end_inst ();
		[CCode (cname = "LLVMIsADbgRegionStartInst")]
		public bool is_a_dbg_region_start_inst ();
		[CCode (cname = "LLVMIsADbgStopPointInst")]
		public bool is_a_dbg_stop_point_inst ();
		[CCode (cname = "LLVMIsAEHSelectorInst")]
		public bool is_a_eh_selector_inst ();
		[CCode (cname = "LLVMIsAExtractElementInst")]
		public bool is_a_extract_element_inst ();
		[CCode (cname = "LLVMIsAExtractValueInst")]
		public bool is_a_extract_value_inst ();
		[CCode (cname = "LLVMIsAFCmpInst")]
		public bool is_a_fcmp_inst ();
		[CCode (cname = "LLVMIsAFPExtInst")]
		public bool is_a_fp_ext_inst ();
		[CCode (cname = "LLVMIsAFPToSIInst")]
		public bool is_a_fp_to_si_inst ();
		[CCode (cname = "LLVMIsAFPToUIInst")]
		public bool is_a_fp_to_ui_inst ();
		[CCode (cname = "LLVMIsAFPTruncInst")]
		public bool is_a_fp_trunc_inst ();
		[CCode (cname = "LLVMIsAFunction")]
		public bool is_a_function ();
		[CCode (cname = "LLVMIsAGetElementPtrInst")]
		public bool is_a_get_element_ptr_inst ();
		[CCode (cname = "LLVMIsAGlobalAlias")]
		public bool is_a_global_alias ();
		[CCode (cname = "LLVMIsAGlobalValue")]
		public bool is_a_global_value ();
		[CCode (cname = "LLVMIsAGlobalVariable")]
		public bool is_a_global_variable ();
		[CCode (cname = "LLVMIsAICmpInst")]
		public bool is_a_icmp_inst ();
		[CCode (cname = "LLVMIsAInlineAsm")]
		public bool is_a_inline_asm ();
		[CCode (cname = "LLVMIsAInsertElementInst")]
		public bool is_a_insert_element_inst ();
		[CCode (cname = "LLVMIsAInsertValueInst")]
		public bool is_a_insert_value_inst ();
		[CCode (cname = "LLVMIsAInstruction")]
		public bool is_a_instruction ();
		[CCode (cname = "LLVMIsAIntToPtrInst")]
		public bool is_a_int_to_ptr_inst ();
		[CCode (cname = "LLVMIsAIntrinsicInst")]
		public bool is_a_intrinsic_inst ();
		[CCode (cname = "LLVMIsAInvokeInst")]
		public bool is_a_invoke_inst ();
		[CCode (cname = "LLVMIsALoadInst")]
		public bool is_a_load_inst ();
		[CCode (cname = "LLVMIsAMemCpyInst")]
		public bool is_a_mem_cpy_inst ();
		[CCode (cname = "LLVMIsAMemIntrinsic")]
		public bool is_a_mem_intrinsic ();
		[CCode (cname = "LLVMIsAMemMoveInst")]
		public bool is_a_mem_move_inst ();
		[CCode (cname = "LLVMIsAMemSetInst")]
		public bool is_a_mem_set_inst ();
		[CCode (cname = "LLVMIsAPHINode")]
		public bool is_a_phi_node ();
		[CCode (cname = "LLVMIsAPtrToIntInst")]
		public bool is_a_ptr_to_int_inst ();
		[CCode (cname = "LLVMIsAReturnInst")]
		public bool is_a_return_inst ();
		[CCode (cname = "LLVMIsASExtInst")]
		public bool is_a_sext_inst ();
		[CCode (cname = "LLVMIsASIToFPInst")]
		public bool is_a_si_to_fp_inst ();
		[CCode (cname = "LLVMIsASelectInst")]
		public bool is_a_select_inst ();
		[CCode (cname = "LLVMIsAShuffleVectorInst")]
		public bool is_a_shuffle_vector_inst ();
		[CCode (cname = "LLVMIsAStoreInst")]
		public bool is_a_store_inst ();
		[CCode (cname = "LLVMIsASwitchInst")]
		public bool is_a_switch_inst ();
		[CCode (cname = "LLVMIsATerminatorInst")]
		public bool is_a_terminator_inst ();
		[CCode (cname = "LLVMIsATruncInst")]
		public bool is_a_trunc_inst ();
		[CCode (cname = "LLVMIsAUIToFPInst")]
		public bool is_a_ui_to_fp_inst ();
		[CCode (cname = "LLVMIsAUnaryInstruction")]
		public bool is_a_unary_instruction ();
		[CCode (cname = "LLVMIsAUndefValue")]
		public bool is_a_undef_value ();
		[CCode (cname = "LLVMIsAUnreachableInst")]
		public bool is_a_unreachable_inst ();
		[CCode (cname = "LLVMIsAUnwindInst")]
		public bool is_a_unwind_inst ();
		[CCode (cname = "LLVMIsAUser")]
		public bool is_a_user ();
		[CCode (cname = "LLVMIsAVAArgInst")]
		public bool is_a_va_arg_inst ();
		[CCode (cname = "LLVMIsAZExtInst")]
		public bool is_a_zext_inst ();

		[CCode (cname = "LLVMIsConstant")]
		public int is_constant ();
		[CCode (cname = "LLVMIsDeclaration")]
		public int is_declaration (); /* global */
		[CCode (cname = "LLVMIsGlobalConstant")]
		public int is_global_constant (); /* global_var */
		[CCode (cname = "LLVMIsNull")]
		public int is_null ();
		[CCode (cname = "LLVMIsTailCall")]
		public int is_tail_call ();
		[CCode (cname = "LLVMIsThreadLocal")]
		public int is_thread_local ();
		[CCode (cname = "LLVMIsUndef")]
		public int is_undef ();

		[CCode (cname = "LLVMValueAsBasicBlock", cheader_filename = "llvm-c/Core.h")]
		public LLVM.BasicBlock as_basic_block ();
		[CCode (cname = "LLVMValueIsBasicBlock", cheader_filename = "llvm-c/Core.h")]
		public int is_basic_block ();
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueBasicBlock", free_function="")]
	public class BasicBlock: Value {
		// FIXME: LLVMDeleteBasicBlock
		[CCode (cname = "LLVMAppendBasicBlock", cheader_filename = "llvm-c/Core.h")]
		public BasicBlock (Function f, string name);

		[CCode (cname = "LLVMInsertBasicBlock")]
		public BasicBlock.before (string name);

		[CCode (cname = "LLVMBasicBlockAsValue", cheader_filename = "llvm-c/Core.h")]
		public Value as_value ();

		[CCode (cname = "LLVMGetBasicBlockParent", cheader_filename = "llvm-c/Core.h")]
		public Value* get_parent ();

		[CCode (cname = "LLVMGetNextBasicBlock", cheader_filename = "llvm-c/Core.h")]
		public BasicBlock* get_next ();
		[CCode (cname = "LLVMGetPreviousBasicBlock", cheader_filename = "llvm-c/Core.h")]
		public BasicBlock* get_previous ();

		[CCode (cname = "LLVMGetFirstInstruction", cheader_filename = "llvm-c/Core.h")]
		public Instruction* get_first_instruction ();
		[CCode (cname = "LLVMGetLastInstruction", cheader_filename = "llvm-c/Core.h")]
		public Instruction* get_last_instruction ();
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class User: Value {
		[CCode (cname = "LLVMGetOperand")]
		public LLVM.Value get_operand (uint index);
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class Instruction: User {
		[CCode (cname = "LLVMGetInstructionParent")]
		public Instruction* get_parent ();
		[CCode (cname = "LLVMGetNextInstruction", cheader_filename = "llvm-c/Core.h")]
		public Instruction* get_next ();
		[CCode (cname = "LLVMGetPreviousInstruction", cheader_filename = "llvm-c/Core.h")]
		public Instruction* get_previous ();
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class CmpInst: Instruction {
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class ICmpInst: CmpInst {
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class FCmpInst: CmpInst {
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class ReturnInst: Instruction {
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class BranchInst: Instruction {
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class SwitchInst: Instruction {
		[CCode (cname = "LLVMAddCase", cheader_filename = "llvm-c/Core.h")]
		public void add_case (Value on_val, BasicBlock dest);
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class InvokeInst: Instruction {
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class UnwindInst: Instruction {
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class UnreachableInst: Instruction {
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class UnaryInst: Instruction {
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class AllocaInst: UnaryInst {
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class LoadInst: UnaryInst {
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class CastInst: UnaryInst {
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class StoreInst: Instruction {
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class GEPInst: Instruction {
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class SelectInst: Instruction {
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class VAArgInst: Instruction {
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class ExtractElementInst: Instruction {
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class InsertElementInst: Instruction {
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class ShuffleVectorInst: Instruction {
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class ExtractValueInst: Instruction {
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class InsertValueInst: Instruction {
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class CallInst: Instruction {
		[CCode (cname = "LLVMSetInstructionCallConv", cheader_filename = "llvm-c/Core.h")]
		public void set_call_conv (uint cc);
		[CCode (cname = "LLVMGetInstructionCallConv", cheader_filename = "llvm-c/Core.h")]
		public uint get_call_conv ();

		[CCode (cname = "LLVMAddInstrAttribute", cheader_filename = "llvm-c/Core.h")]
		public void add_attribute (uint index, Attribute attr);
		[CCode (cname = "LLVMRemoveInstrAttribute", cheader_filename = "llvm-c/Core.h")]
		public void remove_attribute (uint index, Attribute attr);
		[CCode (cname = "LLVMSetInstrParamAlignment", cheader_filename = "llvm-c/Core.h")]
		public void set_alignment (uint index, uint align);

		[CCode (cname = "LLVMIsTailCall", cheader_filename = "llvm-c/Core.h")]
		public bool is_tail_call ();
		[CCode (cname = "LLVMSetTailCall", cheader_filename = "llvm-c/Core.h")]
		public void set_tail_call (bool is_tc = true);
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class PHINode: Instruction {
		[CCode (cname = "LLVMAddIncoming", cheader_filename = "llvm-c/Core.h")]
		public void add_incoming ([CCode (array_length_pos = 3.9)] LLVM.Value*[] incoming_values, [CCode (array_length = false)] BasicBlock*[] incoming_blocks);
		[CCode (cname = "LLVMCountIncoming", cheader_filename = "llvm-c/Core.h")]
		public uint count_incoming ();
		[CCode (cname = "LLVMGetIncomingValue", cheader_filename = "llvm-c/Core.h")]
		public LLVM.Value* get_incoming_value (uint index);
		[CCode (cname = "LLVMGetIncomingBlock", cheader_filename = "llvm-c/Core.h")]
		public LLVM.BasicBlock* get_incoming_block (uint index);
	}

	// FIXME: Argument or Parameter - there is a mix in the bindings
	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class Argument: Value {
		[CCode (cname = "LLVMGetParamParent", cheader_filename = "llvm-c/Core.h")]
		public Function* get_parent ();

		[CCode (cname = "LLVMAddAttribute", cheader_filename = "llvm-c/Core.h")]
		public void add_attribute (Attribute pa);
		[CCode (cname = "LLVMRemoveAttribute", cheader_filename = "llvm-c/Core.h")]
		public void remove_attribute (Attribute pa);
		[CCode (cname = "LLVMGetAttribute", cheader_filename = "llvm-c/Core.h")]
		public Attribute get_attribute ();
		[CCode (cname = "LLVMSetParamAlignment", cheader_filename = "llvm-c/Core.h")]
		public void set_alignment (uint align);

		[CCode (cname = "LLVMGetNextParam", cheader_filename = "llvm-c/Core.h")]
		public Argument* get_next ();
		[CCode (cname = "LLVMGetPreviousParam", cheader_filename = "llvm-c/Core.h")]
		public Argument* get_previous ();
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class Constant: User {
		[CCode (cname = "LLVMConstInt", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_int (LLVM.Ty ty, uint n, int sign_extend);
		[CCode (cname = "LLVMConstIntCast", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_int_cast (LLVM.Value constant_val, LLVM.Ty to_type, uint is_signed);
		[CCode (cname = "LLVMConstIntGetSExtValue", cheader_filename = "llvm-c/Core.h")]
		public long const_int_get_sext_value (LLVM.Value constant_val);
		[CCode (cname = "LLVMConstIntGetZExtValue", cheader_filename = "llvm-c/Core.h")]
		public uint const_int_get_zext_value (LLVM.Value constant_val);
		[CCode (cname = "LLVMConstIntOfString", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_int_of_string (LLVM.Ty int_ty, string text, uchar radix);
		[CCode (cname = "LLVMConstIntOfStringAndSize", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_int_of_string_and_size (LLVM.Ty int_ty, string text, uint slen, uchar radix);
		[ccode (cname = "LLVMConstIntToPtr", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_int_to_ptr (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstReal", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_real (LLVM.Ty real_ty, double n);
		[CCode (cname = "LLVMConstRealOfString", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_real_of_string (LLVM.Ty real_ty, string text);
		[CCode (cname = "LLVMConstRealOfStringAndSize", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_real_of_string_and_size (LLVM.Ty real_ty, string text, uint slen);

		[CCode (cname = "LLVMConstNull", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_null (LLVM.Ty ty);
		[CCode (cname = "LLVMConstAllOnes", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_all_ones (LLVM.Ty Ty);
		[CCode (cname = "LLVMGetUndef", cheader_filename = "llvm-c/Core.h")]
		public static Constant* get_undef (LLVM.Ty ty);
		[CCode (cname = "LLVMConstPointerNull", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_pointer_null (LLVM.Ty ty);

		[CCode (cname = "LLVMConstString", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_string (string str, uint length, int dont_null_terminate);
		[CCode (cname = "LLVMConstStringInContext", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_string_in_context (LLVM.Context c, string str, uint length, int dont_null_terminate);

		[CCode (cname = "LLVMConstStruct", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_struct (LLVM.Value constant_vals, uint count, int packed);
		[CCode (cname = "LLVMConstStructInContext", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_struct_in_context (LLVM.Context c, LLVM.Value constant_vals, uint count, int packed);

		[CCode (cname = "LLVMConstArray", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_array (LLVM.Ty element_ty, LLVM.Value constant_vals, uint length);
		[CCode (cname = "LLVMConstVector", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_vector (LLVM.Value scalar_constant_vals, uint size);

		[CCode (cname = "LLVMGetConstOpcode", cheader_filename = "llvm-c/Core.h")]
		public LLVM.Opcode get_const_opcode ();
		[CCode (cname = "LLVMAlignOf", cheader_filename = "llvm-c/Core.h")]
		public static Constant* align_of (LLVM.Ty ty);
		[CCode (cname = "LLVMSizeOf")]
		public static Constant* size_of (LLVM.Ty ty);
		[CCode (cname = "LLVMConstNeg", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_neg (LLVM.Value constant_val);
		[CCode (cname = "LLVMConstFNeg", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_fneg (LLVM.Value constant_val);
		[ccode (cname = "LLVMConstNot", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_not (LLVM.Value constant_val);
		[ccode (cname = "LLVMConstAdd", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_add (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstNSWAdd", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_nswadd (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstFAdd", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_fadd (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstSub", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_sub (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstFSub", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_fsub (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstMul", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_mul (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstFMul", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_fmul (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstUDiv", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_udiv (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstSDiv", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_sdiv (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstExactSDiv", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_exact_sdiv (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstFDiv", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_fdiv (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstURem", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_urem (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstSRem", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_srem (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstFRem", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_frem (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstAnd", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_and (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstOr", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_or (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstXor", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_xor (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[CCode (cname = "LLVMConstICmp", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_icmp (LLVM.IntPredicate predicate, LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[CCode (cname = "LLVMConstFCmp", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_fcmp (LLVM.IntPredicate predicate, LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[CCode (cname = "LLVMConstShl", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_shl (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[CCode (cname = "LLVMConstLShr", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_lshr (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[CCode (cname = "LLVMConstAShr", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_ashr (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[CCode (cname = "LLVMConstGEP", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_gep (LLVM.Value constant_val, LLVM.Value constant_indices, uint num_indices);
		[CCode (cname = "LLVMConstInBoundsGEP", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_in_bounds_gep (LLVM.Value constant_val, LLVM.Value constant_indices, uint num_indices);
		[CCode (cname = "LLVMConstTrunc", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_trunc (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstSExt", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_sext (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstZExt", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_zext (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstFPTrunc", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_fptrunc (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstFPExt", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_fpext (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstUIToFP", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_ui_to_fp (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstSIToFP", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_si_to_fp (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstFPToUI", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_fp_to_ui (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstFPToSI", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_fp_to_si (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstPtrToInt", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_ptr_to_int (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstBitCast", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_bit_cast (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstZExtOrBitCast", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_zext_or_bit_cast (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstSExtOrBitCast", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_sext_or_bit_cast (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstTruncOrBitCast", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_trunc_or_bit_cast (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstPointerCast", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_pointer_cast (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstFPCast", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_fp_cast (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstSelect", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_select (Value constant_condition, LLVM.Value constant_if_true, LLVM.Value constant_if_false);
		[CCode (cname = "LLVMConstExtractElement", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_extract_element (LLVM.Value vector_constant, LLVM.Value index_constant);
		[CCode (cname = "LLVMConstInsertElement", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_insert_element (LLVM.Value vector_constant, LLVM.Value element_value_constant, LLVM.Value index_constant);
		[CCode (cname = "LLVMConstShuffleVector", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_shuffle_vector (LLVM.Value vector_constant, LLVM.Value vector_b_constant, LLVM.Value mask_constant);
		[CCode (cname = "LLVMConstExtractValue", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_extract_value (LLVM.Value agg_constant, uint idx_list, uint num_idx);
		[CCode (cname = "LLVMConstInsertValue", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_insert_value (LLVM.Value agg_constant, LLVM.Value element_value_constant, uint idx_list, uint num_idx);
		[CCode (cname = "LLVMConstInlineAsm", cheader_filename = "llvm-c/Core.h")]
		public static Constant* const_inline_asm (LLVM.Ty ty, string asm_string, string constraints, int has_side_effects);
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class GlobalValue: Constant {
		[CCode (cname = "LLVMGetGlobalParent", cheader_filename = "llvm-c/Core.h")]
		public Module get_global_parent ();
		[CCode (cname = "LLVMGetLinkage", cheader_filename = "llvm-c/Core.h")]
		public Linkage get_linkage ();
		[CCode (cname = "LLVMSetLinkage", cheader_filename = "llvm-c/Core.h")]
		public void set_linkage ( LLVM.Linkage linkage);
		[CCode (cname = "LLVMGetSection", cheader_filename = "llvm-c/Core.h")]
		public string get_section ();
		[CCode (cname = "LLVMSetSection", cheader_filename = "llvm-c/Core.h")]
		public void set_section (string Section);
		[CCode (cname = "LLVMGetVisibility", cheader_filename = "llvm-c/Core.h")]
		public Visibility get_visibility ();
		[CCode (cname = "LLVMSetVisibility", cheader_filename = "llvm-c/Core.h")]
		public void set_visibility (LLVM.Visibility viz);
		[CCode (cname = "LLVMGetAlignment", cheader_filename = "llvm-c/Core.h")]
		public uint get_alignment ();
		[CCode (cname = "LLVMSetAlignment", cheader_filename = "llvm-c/Core.h")]
		public void set_alignment (uint bytes);
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class GlobalVariable: GlobalValue {
		[CCode (cname = "LLVMAddGlobal", cheader_filename = "llvm-c/Core.h")]
		public GlobalVariable (LLVM.Module m, LLVM.Ty ty, string name);

		[CCode (cname = "LLVMGetNextGlobal", cheader_filename = "llvm-c/Core.h")]
		public GlobalVariable* get_next ();
		[CCode (cname = "LLVMGetPreviousGlobal", cheader_filename = "llvm-c/Core.h")]
		public GlobalVariable* get_previous ();
		[CCode (cname = "LLVMDeleteGlobal", cheader_filename = "llvm-c/Core.h")]
		public void delete ();

		[CCode (cname = "LLVMGetInitializer", cheader_filename = "llvm-c/Core.h")]
		public Constant get_initializer ();
		[CCode (cname = "LLVMSetInitializer", cheader_filename = "llvm-c/Core.h")]
		public void set_initializer (Constant constant_val);

		[CCode (cname = "LLVMSetThreadLocal", cheader_filename = "llvm-c/Core.h")]
		public void set_thread_local (bool is_thread_local);
		[CCode (cname = "LLVMSetGlobalConstant", cheader_filename = "llvm-c/Core.h")]
		public void set_global_constant (bool is_constant);
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class GlobalAlias: GlobalValue {
		[CCode (cname = "LLVMAddAlias", cheader_filename = "llvm-c/Core.h")]
		public GlobalAlias (LLVM.Module m, LLVM.Ty ty, LLVM.Value aliasee, string name);
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueValue", free_function = "")]
	public class Function: GlobalValue {
		// it's not getOrInsert, it's the ctor, check the code if you don't believe it
		[CCode (cname = "LLVMAddFunction", cheader_filename = "llvm-c/Core.h")]
		public Function (LLVM.Module m, string name, LLVM.Ty function_ty);

		[CCode (cname = "LLVMAppendBasicBlock", cheader_filename = "llvm-c/Core.h")]
		public LLVM.BasicBlock append_basic_block (string name);

		[CCode (cname = "LLVMGetNextFunction", cheader_filename = "llvm-c/Core.h")]
		public Function* get_next ();
		[CCode (cname = "LLVMGetPreviousFunction", cheader_filename = "llvm-c/Core.h")]
		public Function* get_previous ();

		[CCode (cname = "LLVMDeleteFunction", cheader_filename = "llvm-c/Core.h")]
		public void delete ();

		[CCode (cname = "LLVMGetIntrinsicID", cheader_filename = "llvm-c/Core.h")]
		public uint get_intrinsic_id ();

		[CCode (cname = "LLVMSetFunctionCallConv", cheader_filename = "llvm-c/Core.h")]
		public void set_call_conv (uint cc);
		[CCode (cname = "LLVMGetFunctionCallConv", cheader_filename = "llvm-c/Core.h")]
		public uint get_call_conv ();

		[CCode (cname = "LLVMGetGC", cheader_filename = "llvm-c/Core.h")]
		public string* get_gc ();
		[CCode (cname = "LLVMSetGC", cheader_filename = "llvm-c/Core.h")]
		public void set_gc (string name);

		[CCode (cname = "LLVMAddFunctionAttr", cheader_filename = "llvm-c/Core.h")]
		public void add_attribute (LLVM.Attribute pa);
		[CCode (cname = "LLVMRemoveFunctionAttr", cheader_filename = "llvm-c/Core.h")]
		public void remove_attribute (LLVM.Attribute pa);
		[CCode (cname = "LLVMGetFunctionAttr", cheader_filename = "llvm-c/Core.h")]
		public Attribute get_attribute ();

		[CCode (cname = "LLVMCountParams", cheader_filename = "llvm-c/Core.h")]
		public uint count_params ();
		[CCode (cname = "LLVMGetParams", cheader_filename = "llvm-c/Core.h")]
		public void get_params (ref Value[] Params);
		[CCode (cname = "LLVMGetParam", cheader_filename = "llvm-c/Core.h")]
		public Value* get_param (uint index);

		[CCode (cname = "LLVMGetFirstParam", cheader_filename = "llvm-c/Core.h")]
		public Argument* get_first_param ();
		[CCode (cname = "LLVMGetLastParam", cheader_filename = "llvm-c/Core.h")]
		public Argument* get_last_param ();

		[CCode (cname = "LLVMCountBasicBlocks", cheader_filename = "llvm-c/Core.h")]
		public uint count_basic_blocks ();
		[CCode (cname = "LLVMGetBasicBlocks", cheader_filename = "llvm-c/Core.h")]
		public void get_basic_blocks (ref BasicBlock[] basic_blocks);
		[CCode (cname = "LLVMGetFirstBasicBlock", cheader_filename = "llvm-c/Core.h")]
		public BasicBlock* get_first_basic_block ();
		[CCode (cname = "LLVMGetLastBasicBlock", cheader_filename = "llvm-c/Core.h")]
		public BasicBlock* get_last_basic_block ();
		[CCode (cname = "LLVMGetEntryBasicBlock", cheader_filename = "llvm-c/Core.h")]
		public BasicBlock* get_entry_basic_block ();

		[CCode (cname = "LLVMVerifyFunction", cheader_filename = "llvm-c/Analysis.h")]
		public int verify (VerifierFailureAction action);

		[CCode (cname = "LLVMViewFunctionCFG", cheader_filename = "llvm-c/Analysis.h")]
		public void view_cfg ();
		[CCode (cname = "LLVMViewFunctionCFGOnly", cheader_filename = "llvm-c/Analysis.h")]
		public void view_cfg_only ();

		public uint call_conv { [CCode (cname = "LLVMSetFunctionCallConv", cheader_filename = "llvm-c/Core.h")] set; }
	}




	[Flags]
	[CCode (cprefix = "", has_type_id = "0")]
	public enum Attribute {
		[CCode (cname="LLVMZExtAttribute")]
		ZExt,
		[CCode (cname="LLVMSExtAttribute")]
		Ext,
		[CCode (cname="LLVMNoReturnAttribute")]
		NoReturn,
		[CCode (cname="LLVMInRegAttribute")]
		InReg,
		[CCode (cname="LLVMStructRetAttribute")]
		StructRet,
		[CCode (cname="LLVMNoUnwindAttribute")]
		NoUnwind,
		[CCode (cname="LLVMNoAliasAttribute")]
		NoAlias,
		[CCode (cname="LLVMByValAttribute")]
		ByVal,
		[CCode (cname="LLVMNestAttribute")]
		Nest,
		[CCode (cname="LLVMReadNoneAttribute")]
		ReadNone,
		[CCode (cname="LLVMReadOnlyAttribute")]
		ReadOnly,
		[CCode (cname="LLVMNoInlineAttribute")]
		NoInline,
		[CCode (cname="LLVMAlwaysInlineAttribute")]
		AlwaysInline,
		[CCode (cname="LLVMOptimizeForSizeAttribute")]
		OptimizeForSize,
		[CCode (cname="LLVMStackProtectAttribute")]
		StackProtect,
		[CCode (cname="LLVMStackProtectReqAttribute")]
		ProtectReq,
		[CCode (cname="LLVMNoCaptureAttribute")]
		NoCaptureAttribute,
		[CCode (cname="LLVMNoRedZoneAttribute")]
		NoRedZone,
		[CCode (cname="LLVMNoImplicitFloatAttribute")]
		NoImplicitFloat,
		[CCode (cname="LLVMNakedAttribute")]
		Naked,
		[CCode (cname="LLVMInlineHintAttribute")]
		InlineHint
	}

	[CCode (cprefix = "", has_type_id = "0")]
	public enum CallConv {
		[CCode (cname="LLVMCCallConv")]
		C,
		[CCode (cname="LLVMFastCallConv")]
		Fast,
		[CCode (cname="LLVMColdCallConv")]
		Cold,
		[CCode (cname="LLVMX86StdcallCallConv")]
		Std,
		[CCode (cname="LLVMX86FastcallCallConv")]
		X86Fast
	}

	[CCode (cprefix = "LLVMInt", has_type_id = "0")]
	public enum IntPredicate {
		EQ,
		NE,
		UGT,
		UGE,
		ULT,
		ULE,
		SGT,
		SGE,
		SLT,
		SL
	}

	[CCode (cprefix = "", has_type_id = "0")]
	public enum Linkage {
		[CCode (cname="LLVMExternalLinkage")]
		External,
		[CCode (cname="LLVMAvailableExternallyLinkage")]
		AvailableExternally,
		[CCode (cname="LLVMLinkOnceAnyLinkage")]
		LinkOnceAny,
		[CCode (cname="LLVMLinkOnceODRLinkage")]
		LinkOnceODR,
		[CCode (cname="LLVMWeakAnyLinkage")]
		WeakAny,
		[CCode (cname="LLVMWeakODRLinkage")]
		WeakODR,
		[CCode (cname="LLVMAppendingLinkage")]
		Appending,
		[CCode (cname="LLVMInternalLinkage")]
		Internal,
		[CCode (cname="LLVMPrivateLinkage")]
		Private,
		[CCode (cname="LLVMDLLImportLinkage")]
		DLLImport,
		[CCode (cname="LLVMDLLExportLinkage")]
		DLLExport,
		[CCode (cname="LLVMExternalWeakLinkage")]
		ExternalWeak,
		[CCode (cname="LLVMGhostLinkage")]
		Ghost,
		[CCode (cname="LLVMCommonLinkage")]
		Common,
		[CCode (cname="LLVMLinkerPrivateLinkage")]
		LinkerPrivate
	}

	[CCode (cprefix = "LLVM", has_type_id = "0")]
	public enum Opcode {
		Ret,
		Br,
		Switch,
		Invoke,
		Unwind,
		Unreachable,
		Add,
		FAdd,
		Sub,
		FSub,
		Mul,
		FMul,
		UDiv,
		SDiv,
		FDiv,
		URem,
		SRem,
		FRem,
		Shl,
		LShr,
		AShr,
		And,
		Or,
		Xor,
		Malloc,
		Free,
		Alloca,
		Load,
		Store,
		GetElementPtr,
		Trunk,
		ZExt,
		SExt,
		FPToUI,
		FPToSI,
		UIToFP,
		SIToFP,
		FPTrunc,
		FPExt,
		PtrToInt,
		IntToPtr,
		BitCast,
		ICmp,
		FCmp,
		PHI,
		Call,
		Select,
		VAArg,
		ExtractElement,
		InsertElement,
		ShuffleVector,
		ExtractValue,
		InsertValue
	}

	[CCode (cprefix = "LLVMReal", has_type_id = "0")]
	public enum RealPredicate {
		[CCode (cname="LLVMRealPredicateFalse")]
		False,
		OEQ,
		OGT,
		OGE,
		OLT,
		OLE,
		ONE,
		ORD,
		UNO,
		UEQ,
		UGT,
		UGE,
		ULT,
		ULE,
		UNE,
		[CCode (cname="LLVMRealPredicateTrue")]
		True
	}

	[CCode (cprefix = "", has_type_id = "0")]
	public enum TypeKind {
		[CCode (cname="LLVMVoidTypeKind")]
		Void,
		[CCode (cname="LLVMFloatTypeKind")]
		Float,
		[CCode (cname="LLVMDoubleTypeKind")]
		Double,
		[CCode (cname="LLVMX86_FP80TypeKind")]
		X86_FP80,
		[CCode (cname="LLVMFP128TypeKind")]
		FP128,
		[CCode (cname="LLVMPPC_FP128TypeKind")]
		PPC_FP128,
		[CCode (cname="LLVMLabelTypeKind")]
		Label,
		[CCode (cname="LLVMIntegerTypeKind")]
		Integer,
		[CCode (cname="LLVMFunctionTypeKind")]
		Function,
		[CCode (cname="LLVMStructTypeKind")]
		Struct,
		[CCode (cname="LLVMArrayTypeKind")]
		Array,
		[CCode (cname="LLVMPointerTypeKind")]
		Pointer,
		[CCode (cname="LLVMOpaqueTypeKind")]
		Opaque,
		[CCode (cname="LLVMVectorTypeKind")]
		Vector,
		[CCode (cname="LLVMMetadataTypeKind")]
		Metadata
	}

	[CCode (cheader_filename = "llvm-c/Analysis.h", cprefix = "", has_type_id = "0")]
	public enum VerifierFailureAction {
		[CCode (cname="LLVMAbortProcessAction")]
		AbortProcess,
		[CCode (cname="LLVMPrintMessageAction")]
		PrintMessage,
		[CCode (cname="LLVMReturnStatusAction")]
		ReturnStatus
	}

	[CCode (cprefix = "", has_type_id = "0")]
	public enum Visibility {
		[CCode (cname="LLVMDefaultVisibility")]
		Default,
		[CCode (cname="LLVMHiddenVisibility")]
		Hidden,
		[CCode (cname="LLVMProtectedVisibility")]
		Protected
	}

	[CCode (cprefix = "LLVM_LTO_", has_type_id = "0")]
	public enum LTOStatus {
		UNKNOWN,
		OPT_SUCCESS,
		READ_SUCCESS,
		READ_FAILURE,
		WRITE_FAILURE,
		NO_TARGET,
		NO_WORK,
		MODULE_MERGE_FAILURE,
		ASM_FAILURE,
		NULL_OBJECT
	}

	[Compact]
	[CCode (cname="llvm_lto_t", free_function="llvm_destroy_optimizer", cheader_filename = "llvm-c/LinkTimeOptimizer.h")]
	public class LTO {
		[CCode (cname="llvm_create_optimizer")]
		public LTO ();
		[CCode (cname="llvm_optimize_modules")]
		public LTOStatus optimize_modules (string output_filename);
		[CCode (cname="llvm_read_object_file")]
		public LTOStatus read_object_file (string input_filename);
	}

	[CCode (cname = "LLVMLinkInInterpreter", cheader_filename = "llvm-c/Core.h")]
	public static void link_in_interpreter ();
	[CCode (cname = "LLVMLinkInJIT", cheader_filename = "llvm-c/Core.h")]
	public static void link_in_jit ();

	[CCode (cname = "LLVMInitializeCppBackendTargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_cpp_backend_target_info ();
	[CCode (cname = "LLVMInitializeCppBackendTarget", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_cpp_backend_target ();
	[CCode (cname = "LLVMInitializeMSILTargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_msil_target_info ();
	[CCode (cname = "LLVMInitializeMSILTarget", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_msil_target ();
	[CCode (cname = "LLVMInitializeCBackendTargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_c_backend_target_info ();
	[CCode (cname = "LLVMInitializeCBackendTarget", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_c_backend_target ();
	[CCode (cname = "LLVMInitializeBlackfinTargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_blackfin_target_info ();
	[CCode (cname = "LLVMInitializeBlackfinTarget", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_blackfin_target ();
	[CCode (cname = "LLVMInitializeSystemZTargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_systemz_target_info ();
	[CCode (cname = "LLVMInitializeSystemZTarget", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_systemz_target ();
	[CCode (cname = "LLVMInitializeMSP430TargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_msp430_target_info ();
	[CCode (cname = "LLVMInitializeMSP430Target", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_msp430_target ();
	[CCode (cname = "LLVMInitializeXCoreTargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_xcore_target_info ();
	[CCode (cname = "LLVMInitializeXCoreTarget", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_xcore_target ();
	[CCode (cname = "LLVMInitializePIC16TargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_pic16_target_info ();
	[CCode (cname = "LLVMInitializePIC16Target", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_pic16_target ();
	[CCode (cname = "LLVMInitializeCellSPUTargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_cell_spu_target_info ();
	[CCode (cname = "LLVMInitializeCellSPUTarget", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_cell_spu_target ();
	[CCode (cname = "LLVMInitializeMipsTargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_mips_target_info ();
	[CCode (cname = "LLVMInitializeMipsTarget", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_mips_target ();
	[CCode (cname = "LLVMInitializeARMTargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_arm_target_info ();
	[CCode (cname = "LLVMInitializeARMTarget", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_arm_target ();
	[CCode (cname = "LLVMInitializeAlphaTargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_alpha_target_info ();
	[CCode (cname = "LLVMInitializeAlphaTarget", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_alpha_target ();
	[CCode (cname = "LLVMInitializePowerPCTargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_powerpc_target_info ();
	[CCode (cname = "LLVMInitializePowerPCTarget", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_powerpc_target ();
	[CCode (cname = "LLVMInitializeSparcTargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_sparc_target_info ();
	[CCode (cname = "LLVMInitializeSparcTarget", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_sparc_target ();
	[CCode (cname = "LLVMInitializeX86TargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_x86_target_info ();
	[CCode (cname = "LLVMInitializeX86Target", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_x86_target ();

	[CCode (cname = "LLVMInitializeAllTargetInfos", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_all_target_infos ();
	[CCode (cname = "LLVMInitializeAllTargets", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_all_targets ();
	[CCode (cname = "LLVMInitializeNativeTarget", cheader_filename = "llvm-c/Target.h")]
	public static int initialize_native_target ();

	[Compact]
	[CCode (cname = "lto_code_gen_t", cheader_filename = "llvm-c/lto.h", free_function = "lto_codegen_dispose")]
	public class LTOCodeGen {
		[CCode (cname = "lto_codegen_create", cheader_filename = "llvm-c/lto.h")]
		public LTOCodeGen ();

		[CCode (cname = "lto_codegen_add_module", cheader_filename = "llvm-c/lto.h")]
		public bool add_module (LTOModule mod);
		[CCode (cname = "lto_codegen_add_must_preserve_symbol", cheader_filename = "llvm-c/lto.h")]
		public void add_must_preserve_symbol (string symbol);
		[CCode (cname = "lto_codegen_compile", cheader_filename = "llvm-c/lto.h")]
		public void* compile (size_t length);
		[CCode (cname = "lto_codegen_debug_options", cheader_filename = "llvm-c/lto.h")]
		public void debug_options (string p2);
		[CCode (cname = "lto_codegen_set_assembler_path", cheader_filename = "llvm-c/lto.h")]
		public void set_assembler_path (string path);
		[CCode (cname = "lto_codegen_set_debug_model", cheader_filename = "llvm-c/lto.h")]
		public bool set_debug_model (LTODebugModel p2);
		[CCode (cname = "lto_codegen_set_gcc_path", cheader_filename = "llvm-c/lto.h")]
		public void set_gcc_path (string path);
		[CCode (cname = "lto_codegen_set_pic_model", cheader_filename = "llvm-c/lto.h")]
		public bool set_pic_model (LTOCodeGenModel p2);
		[CCode (cname = "lto_codegen_write_merged_modules", cheader_filename = "llvm-c/lto.h")]
		public bool write_merged_modules (string path);
	}

	[Compact]
	[CCode (cname = "lto_module_t", cheader_filename = "llvm-c/lto.h", free_function="lto_module_dispose")]
	public class LTOModule {
		[CCode (cname = "lto_module_create", cheader_filename = "llvm-c/lto.h")]
		public LTOModule (string path);
		[CCode (cname = "lto_module_create_from_memory", cheader_filename = "llvm-c/lto.h")]
		public LTOModule.from_memory (void* mem, size_t length);

		[CCode (cname = "lto_module_get_num_symbols", cheader_filename = "llvm-c/lto.h")]
		public uint get_num_symbols ();
		[CCode (cname = "lto_module_get_symbol_attribute", cheader_filename = "llvm-c/lto.h")]
		public LTOSymbolAttributes get_symbol_attribute (uint index);
		[CCode (cname = "lto_module_get_symbol_name", cheader_filename = "llvm-c/lto.h")]
		public string* get_symbol_name (uint index);
		[CCode (cname = "lto_module_get_target_triple", cheader_filename = "llvm-c/lto.h")]
		public string* get_target_triple ();

		[CCode (cname = "lto_module_is_object_file", cheader_filename = "llvm-c/lto.h")]
		public static bool is_object_file (string path);
		[CCode (cname = "lto_module_is_object_file_for_target", cheader_filename = "llvm-c/lto.h")]
		public static bool is_object_file_for_target (string path, string target_triple_prefix);
		[CCode (cname = "lto_module_is_object_file_in_memory", cheader_filename = "llvm-c/lto.h")]
		public static bool is_object_file_in_memory (void* mem, size_t length);
		[CCode (cname = "lto_module_is_object_file_in_memory_for_target", cheader_filename = "llvm-c/lto.h")]
		public static bool is_object_file_in_memory_for_target (void* mem, size_t length, string target_triple_prefix);
	}

	[CCode (cname = "lto_get_error_message", cheader_filename = "llvm-c/lto.h")]
	public static string* lto_get_error_message ();
	[CCode (cname = "lto_get_version", cheader_filename = "llvm-c/lto.h")]
	public static string* lto_get_version ();

	[CCode (cprefix = "LTO_CODEGEN_PIC_MODEL_", has_type_id = "0", cheader_filename = "llvm-c/Core.h")]
	public enum LTOCodeGenModel {
		STATIC,
		DYNAMIC,
		DYNAMIC_NO_PIC
	}
	[CCode (cprefix = "LTO_DEBUG_MODEL_", has_type_id = "0", cheader_filename = "llvm-c/Core.h")]
	public enum LTODebugModel {
		NONE,
		DWARF
	}
	[CCode (cprefix = "LTO_SYMBOL_", has_type_id = "0", cheader_filename = "llvm-c/Core.h")]
	public enum LTOSymbolAttributes {
		ALIGNMENT_MASK,
		PERMISSIONS_MASK,
		PERMISSIONS_CODE,
		PERMISSIONS_DATA,
		PERMISSIONS_RODATA,
		DEFINITION_MASK,
		DEFINITION_REGULAR,
		DEFINITION_TENTATIVE,
		DEFINITION_WEAK,
		DEFINITION_UNDEFINED,
		DEFINITION_WEAKUNDEF,
		SCOPE_MASK,
		SCOPE_INTERNAL,
		SCOPE_HIDDEN,
		SCOPE_PROTECTED,
		SCOPE_DEFAULT
	}
	[CCode (cheader_filename = "llvm-c/lto.h")]
	public const int LTO_API_VERSION;

}
