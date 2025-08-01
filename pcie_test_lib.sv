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
/*	
	task run_phase(uvm_phase phase);
		base_seq seq;
		seq = base_seq::type_id::create("seq");

	endtask
	*/
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
