using LLVM;
using Posix;

void main(string[] argv)
{
	link_in_interpreter ();
	link_in_jit ();
	initialize_all_targets ();
	initialize_all_target_infos ();

	var m = new Module.with_name ("fac_module");

	var a = Ty.function (Ty.int32 (), { Ty.int32 () }, 0);
	var fac = new Function (m, "fac", a);
	//fac.call_conv = CallConv.C;

	var entry = fac.append_basic_block("entry");
	var iftrue = fac.append_basic_block("iftrue");
	var iffalse = fac.append_basic_block("iffalse");
	var end = fac.append_basic_block("end");

	var b = new Builder ();

	b.position_at_end (entry);
	var n = fac.get_param (0);
	var @if = b.build_icmp (IntPredicate.EQ, n, Constant.const_int (Ty.int32 (), 0, 0), "n == 0");
	b.build_cond_br (@if, iftrue, iffalse);

	b.position_at_end (iftrue);
	var res_iftrue = Constant.const_int (Ty.int32 (), 1, 0);
	b.build_br (end);

	b.position_at_end (iffalse);
	var n_minus = b.build_sub (n, Constant.const_int (Ty.int32 (), 1, 0), "n - 1");
	var call_fac = b.build_call (fac, { n_minus }, "fac(n - 1)");
	var res_iffalse = b.build_mul (n, call_fac, "n * fac (n - 1)");
	b.build_br (end);

	b.position_at_end (end);
	var res = b.build_phi (Ty.int32 (), "result");
	res->add_incoming ({ res_iftrue, res_iffalse }, { iftrue, iffalse });
	b.build_ret (res);

	Message error;
	m.verify (VerifierFailureAction.AbortProcess, out error);

	ExecutionEngine ee;
	var provider = new ModuleProvider (m);
	ExecutionEngine.create_jit_compiler (out ee, (owned)provider, 3, out error);
	//ExecutionEngine.create_interpreter (out ee, (owned)provider, out error);
	if (error != null) {
		warning (error);
		exit (1);
	}

	var pass = new PassManager ();
	pass.add_target_data (ee.get_target_data ());
	pass.add_constant_propagation ();
	pass.add_instruction_combining ();
	pass.add_promote_memory_to_register ();
	pass.add_gvn ();
	pass.add_cfg_simplification ();
	pass.run (m);
	m.dump ();

	GenericValue exec_res = ee.run_function (fac, { new GenericValue.of_int (Ty.int32 (), 10, 0) });

	message ("result %u", exec_res.to_int (0));
}
