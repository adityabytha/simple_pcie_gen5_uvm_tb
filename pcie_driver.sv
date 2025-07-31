//DRIVER FILE
//
//Recieves from seqr and gives to the dut with the interface
//
//

class pcie_driver extends uvm_driver#(pcie_tx);
	`NEW_COMP
	`uvm_component_utils(pcie_driver)
	virtual pcie_intf vif;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db#(virtual pcie_intf)::get(this,"","pcie_intf",vif);
		`uvm_info("DRV","Build Phase",UVM_LOW)
	endfunction
	
	//virtual intf
	
	//pcie_tx tx;

	task run_phase(uvm_phase phase);
		forever begin 
			seq_item_port.get_next_item(req);
			drive_tx(req);
		//	req.print();
			seq_item_port.item_done();
		end
	endtask

	task drive_tx(pcie_tx tx);
		vif.rx_sop    <= 1;
		vif.app_req_ready <= 0;
            	vif.rx_valid  <= 1;
            	vif.rx_header <= {req.fmt, req.type1, req.tc, req.ln, req.th, req.attr[2], req.at,
                              req.attr[1:0], req.td, req.ep, req.length, req.requester_id,
                              req.tag[9:8], req.tag[7:0], req.last_be, req.first_be, req.address};
            	vif.rx_data   <= req.data;
		vif.rx_eop    <= 0;
            	@(posedge vif.clk);
            	vif.rx_sop    <= 0;
            	vif.rx_valid  <= 0;
		vif.rx_eop    <= 1;
		@(posedge vif.clk);
		@(posedge vif.clk);
	endtask
endclass
