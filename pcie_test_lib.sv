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

endclass
