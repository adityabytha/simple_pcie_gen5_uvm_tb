//MONITOR FILE
//gets data from dut that was driven by driver
//
//
class pcie_monitor extends uvm_monitor;
	`uvm_component_utils(pcie_monitor)
	`NEW_COMP

	pcie_tx tx;
	//instantiate virtual interface
	virtual pcie_intf vif;

	uvm_analysis_port#(pcie_tx) ap_port;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ap_port = new("ap_port", this);
		if(!uvm_config_db#(virtual pcie_intf)::get(this, "", "pcie_intf", vif)) begin
			`uvm_error("MAIN_MON", "CONFIG_DB ERROR")
		end
		`uvm_info("MON","Build Phase",UVM_LOW)

	endfunction

	task run_phase(uvm_phase phase);
		//physical interface
		forever begin
			@(vif.tx_valid);
			tx = new("MON");
			tx.tag <= vif.app_tag;
			tx.print();
			ap_port.write(tx);
			//collect values into physical interface
		end
	endtask

endclass
