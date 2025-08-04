//MONITOR FILE
//gets data from dut that was driven by driver
//
//
class pcie_monitor extends uvm_monitor;
	`uvm_component_utils(pcie_monitor)
	`NEW_COMP

	pcie_app_tx tx;
	//instantiate virtual interface
	virtual pcie_intf vif;

	uvm_analysis_port#(pcie_app_tx) ap_port;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ap_port = new("ap_port", this);
		if(!uvm_config_db#(virtual pcie_intf)::get(this, "", "pcie_intf", vif)) begin
			`uvm_error("MAIN_MON", "CONFIG_DB ERROR")
		end
		`uvm_info("MON","Build Phase",UVM_LOW)

	endfunction

	task run_phase(uvm_phase phase);
		forever begin
		/*	if (vif.rst_n == 1'b0) begin
				tx = new("app_layer");
				tx.app_req_valid = 0;
			end else begin*/
			@(posedge vif.rx_sop); //do reset handling here
			tx = new("app_layer");
			tx.app_req_valid = vif.app_req_valid;
			tx.app_tlp_type = vif.app_tlp_type;
			tx.app_address = vif.app_address;
			tx.app_data = vif.app_data;
			tx.app_tag = vif.app_tag;
			tx.app_requester_id = vif.app_requester_id;
			tx.app_first_be = vif.app_first_be;
			tx.app_last_be = vif.app_last_be;
			tx.app_tc = vif.app_tc;
			tx.app_attr = vif.app_attr;
			tx.app_th = vif.app_th;
			tx.app_td = vif.app_td;
			tx.app_ep = vif.app_ep;
			tx.app_at = vif.app_at;
			tx.app_length_dw = vif.app_length_dw;
			tx.app_req_ready = vif.app_req_ready;
			tx.print();
			ap_port.write(tx);
			//collect values into physical interface
		//	end
		end
	endtask

endclass
