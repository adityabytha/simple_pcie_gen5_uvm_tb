//ENV FILE of PCIE
//

class pcie_env extends uvm_env;
	`NEW_COMP
	`uvm_component_utils(pcie_env)

	function void build_phase(uvm_phase phase);
		`uvm_info("ENV","Build_Phase",UVM_LOW)
	endfunction
endclass
