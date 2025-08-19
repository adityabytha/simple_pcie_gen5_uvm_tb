//MONITOR FILE
//gets data from dut that was driven by driver
//
//
class pcie_monitor extends uvm_monitor;
	`uvm_component_utils(pcie_monitor)
	`NEW_COMP

	//pcie_app_tx tx;
	pcie_dl_tx tx1;
	
	virtual pcie_intf vif;
	base_tx btx;
	uvm_analysis_port#(base_tx) ap_port;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ap_port = new("ap_port", this);
		if(!uvm_config_db#(virtual pcie_intf)::get(this, "", "pcie_intf", vif)) begin
			`uvm_error("MAIN_MON", "CONFIG_DB ERROR")
		end
		`uvm_info("MON","Build Phase",UVM_LOW)

	endfunction

	task run_phase(uvm_phase phase);
		`uvm_info("MON","Run Phase",UVM_LOW)
		forever begin
			@(posedge vif.clk);
			//fork
			//	app_layer_mon();
				output_tx_mon();
			//join_any
		end
	endtask
	task output_tx_mon();
		//if(!$cast(tx1, base_tx)) begin
		//	`uvm_error("CAST ERROR","pcie_dl_tx was not able to cast properly")
		//end

		`uvm_info("MON","TX MON-Running",UVM_HIGH)
		$cast(tx1, btx);
		@(posedge vif.tx_valid);
		tx1= new("cpl_layer");
		tx1.tx_sop	= vif.tx_sop;
		tx1.tx_header	= vif.tx_header;
		tx1.tx_eop	= vif.tx_eop;
		tx1.tx_data	= vif.tx_data;
		tx1.tx_ready	= vif.tx_ready;
		tx1.print();
		ap_port.write(tx1);
	endtask
/*
task app_layer_mon();
	`uvm_info("MON","APP MON-Running",UVM_HIGH)
	if(!$cast(tx, btx)) begin
		`uvm_error("CAST ERROR","pcie_app_tx was not able to cast properly")
	end
	@(posedge vif.rx_eop); //do reset handling here
	tx = new("app_layer");
	tx.app_req_valid 	= vif.app_req_valid;
	tx.app_tlp_type 	= vif.app_tlp_type;
	tx.app_address 		= vif.app_address;
	tx.app_data 		= vif.app_data;
	tx.app_tag 		= vif.app_tag;
	tx.app_requester_id 	= vif.app_requester_id;
	tx.app_first_be 	= vif.app_first_be;
	tx.app_last_be 		= vif.app_last_be;
	tx.app_tc 		= vif.app_tc;
	tx.app_attr 		= vif.app_attr;
	tx.app_th 		= vif.app_th;
	tx.app_td 		= vif.app_td;
	tx.app_ep 		= vif.app_ep;
	tx.app_at 		= vif.app_at;
	tx.app_length_dw 	= vif.app_length_dw;
	tx.app_req_ready 	= vif.app_req_ready;
	
	tx.print();
	ap_port.write(tx);
endtask*/
endclass
