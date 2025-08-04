//AGENT FILE
//Agent for pcie gen5 Transaction layer
//

class pcie_agent extends uvm_agent;
	`uvm_component_utils(pcie_agent)
	`NEW_COMP
	
	pcie_monitor mon;	
	pcie_driver driver;
	pcie_seqr seqr;
//	pcie_cpl_seqr cpl_seqr;
	function void build_phase(uvm_phase phase);
		mon = pcie_monitor::type_id::create("mon", this);
		driver = pcie_driver::type_id::create("driver",this);
		seqr = pcie_seqr::type_id::create("seqr",this);
	//	cpl_seqr = pcie_cpl_seqr::type_id::create("cpl_seqr",this);
		`uvm_info("AGENT","Build_Phase",UVM_LOW)
		
	endfunction

	function void connect_phase(uvm_phase phase);
		driver.seq_item_port.connect(seqr.seq_item_export);
	endfunction
endclass
