//AGENT FILE
//Agent for pcie gen5 Transaction layer
//

class pcie_agent extends uvm_agent;
	`uvm_component_utils(pcie_agent)
	`NEW_COMP
	
	pcie_driver driver;
	pcie_seqr seqr;
	function void build_phase(uvm_phase phase);
		driver = pcie_driver::type_id::create("driver",this);
		seqr = pcie_seqr::type_id::create("seqr",this);
		`uvm_info("AGENT","Build_Phase",UVM_LOW)
		
	endfunction

	function void connect_phase(uvm_phase phase);
		driver.seq_item_port.connect(seqr.seq_item_export);
	endfunction
endclass
