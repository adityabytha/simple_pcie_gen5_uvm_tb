//DRIVER FILE
//
//Recieves from seqr and gives to the dut with the interface
//
//

class pcie_driver extends uvm_driver#(pcie_tx);
	`NEW_COMP
	`uvm_component_utils(pcie_driver)

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("DRV","Build Phase",UVM_LOW)
	endfunction

endclass
