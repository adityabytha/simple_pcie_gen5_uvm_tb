//DRIVER FILE
//
//Recieves from seqr and gives to the dut with the interface
//
//

class pcie_driver extends uvm_driver#(uvm_sequence_item);
	`NEW_COMP
	`uvm_component_utils(pcie_driver)
	virtual pcie_intf vif;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db#(virtual pcie_intf)::get(this,"","pcie_intf",vif);
		`uvm_info("DRV","Build Phase",UVM_LOW)
	endfunction
	
	//virtual intf
	
	//ERROR SOMEWHERE HERE RECTIFY TMRW

	virtual task run_phase(uvm_phase phase);
		forever begin 
			//seq_item_port.get_next_item(req);
			//drive_tx(req);
			//req.print();
			//seq_item_port.item_done();
			//#`PCIE_CLK_GEN5;
			uvm_sequence_item req;
			pcie_cpl_tx req2;

			seq_item_port.get_next_item(req);
			if(!$cast(req2,req)) begin
				`uvm_fatal("DRV","FAILED TO CAST")
			end

			drive_cpl_tx(req2);
			req.print();
			seq_item_port.item_done();
		end
	endtask
	
	task drive_cpl_tx(pcie_cpl_tx tx);
		if(vif.rst_n == 1'b0) begin
			@(posedge vif.clk);
			vif.cpl_valid <= 0;
		end else begin
			@(posedge vif.clk);
			vif.cpl_valid <= 1;
			vif.tx_ready <= 1;
			vif.cpl_data <= req2.cpl_data;
			vif.cpl_requester_id <= req2.cpl_requester_id;
			vif.cpl_tag <= req2.cpl_tag;
		end	
	endtask	
/*
	task drive_tx(pcie_tx tx);
		if(vif.rst_n == 1'b0) begin
			@(posedge vif.clk);
			vif.rx_header <= 128'h0;
			vif.rx_valid <= 1'b0;
			vif.rx_data <= 256'h0;
			vif.rx_sop <= 1'b0;
			vif.rx_eop <= 1'b0;
			//for cpl signal rest 
		end else begin
		@(posedge vif.clk);
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
		end
	endtask
	*/
endclass

