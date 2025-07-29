//MONITOR FILE
//gets data from dut that was driven by driver
//
//
class pcie_monitor extends uvm_monitor;
	`uvm_component_utils(pcie_monitor)
	`NEW_COMP

	pcie_tx tx;
	//instantiate virtual interface

	uvm_analysis_port#(pcie_tx) ap_port;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ap_port = new("ap_port", this);
	endfunction

	task run_phase(uvm_phase phase);
		//physical interface
		forever begin
			//collect values into physical interface
		end
	endtask

endclass
