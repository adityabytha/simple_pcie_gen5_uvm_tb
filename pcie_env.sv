//ENV FILE of PCIE
//

class pcie_env extends uvm_env;
	`NEW_COMP
	`uvm_component_utils(pcie_env)
	pcie_agent agent;

	function void build_phase(uvm_phase phase);
		agent = pcie_agent::type_id::create("agent",this);
		`uvm_info("ENV","Build_Phase",UVM_LOW)
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();
	endfunction

endclass
