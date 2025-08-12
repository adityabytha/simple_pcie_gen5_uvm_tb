//TEST LIBRARY of PCIE
//
//

class pcie_base_test extends uvm_test;
	`NEW_COMP
	`uvm_component_utils(pcie_base_test)

	pcie_env env;
	function void build_phase(uvm_phase phase);
		env = pcie_env::type_id::create("env",this);
		`uvm_info("TEST_LIB","Build_Phase",UVM_LOW)
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();
	endfunction
endclass


class pcie_main_test extends pcie_base_test;
	`uvm_component_utils(pcie_main_test)
	`NEW_COMP
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		//uvm_config_db#(uvm_object_wrapper)::set(this,"env.agent.seqr.run_phase","default_sequence",pcie_seq::type_id::get());
		`uvm_info("TEST_LIB","Build_Phase - PCIE_MAIN_TEST",UVM_LOW)
	endfunction

	task run_phase(uvm_phase phase);
		pcie_seq seq;
		phase.raise_objection(this);
		//`uvm_info("TEST_LIB","Run_Phase - PCIE_MAIN_TEST",UVM_NONE)
		seq = pcie_seq::type_id::create("seq");
		phase.phase_done.set_drain_time(this,`PCIE_CLK_GEN5);
		seq.start(env.agent.seqr);
		phase.drop_objection(this);	
	endtask
	
endclass
/*
class pcie_both_test_2 extends pcie_base_test;
	`uvm_component_utils(pcie_both_test_2)
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		pcie_seq seq1;
		pcie_2_seq seq2;
		seq1 = pcie_seq::type_id::create("seq1");
		seq2 = pcie_2_seq::type_id::create("seq2");

		seq1.start(env.agent.seqr);
		seq2.start(env.agent.seqr);

		phase.phase_done.set_drain_time(this,`PCIE_CLK_GEN5);
		phase.drop_objection(this);	
	endtask

endclass
*/
class pcie_both_test extends pcie_base_test;
	`uvm_component_utils(pcie_both_test)
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

	endfunction

	task run_phase(uvm_phase phase);
		pcie_both_seq seq;
		phase.raise_objection(this);
		seq = pcie_both_seq::type_id::create("seq");
		phase.phase_done.set_drain_time(this,`PCIE_CLK_GEN5);
		seq.start(env.agent.seqr);
		phase.drop_objection(this);
	endtask

endclass
