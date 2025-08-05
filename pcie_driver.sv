//DRIVER FILE
//
//Recieves from seqr and gives to the dut with the interface
//
//

class pcie_driver extends uvm_driver#(base_tx);
	`NEW_COMP
	`uvm_component_utils(pcie_driver)
	virtual pcie_intf vif;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db#(virtual pcie_intf)::get(this,"","pcie_intf",vif);
		`uvm_info("DRV","Build Phase",UVM_LOW)
	endfunction
	
	task run_phase(uvm_phase phase);
		forever begin 
			base_tx req;
			pcie_tx tx1;
			pcie_cpl_tx tx2;
			seq_item_port.get_next_item(req);
			if ($cast(tx1, req)) begin
			        // handle A item
				drive_tx(tx1);
			end else if ($cast(tx2,req)) begin
				// handle B item
				drive_cpl_tx(tx2);	
			end
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
			vif.cpl_data <= tx.cpl_data;
			vif.cpl_requester_id <= tx.cpl_requester_id;
			vif.cpl_tag <= tx.cpl_tag;
		end	
	endtask	

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
            	vif.rx_header <= {tx.fmt, tx.type1, tx.tc, tx.ln, tx.th, tx.attr[2], tx.at,
		       			tx.attr[1:0], tx.td, tx.ep, tx.length, tx.requester_id,
					tx.tag[9:8], tx.tag[7:0], tx.last_be, tx.first_be, tx.address};
            	vif.rx_data   <= tx.data;
		vif.rx_eop    <= 0;

            	@(posedge vif.clk);
            	vif.rx_sop    <= 0;
            	vif.rx_valid  <= 0;
		vif.rx_eop    <= 1;
		end
	endtask

endclass

