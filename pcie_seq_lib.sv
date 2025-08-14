//PCIE SEQUENCE LIBRARY FILE
//
//Should house different sequences or TLP headers for write/read transactions.


/*class base_seq extends uvm_sequence#(pcie_tx);
	`uvm_object_utils(pcie_tx)
	`NEW_OBJ
	uvm_phase phase;

	task pre_body();
		phase=get_starting_phase();
		if(phase != null) begin
			phase.raise_objection(this);
			phase.phase_done.set_drain_time(this,100);
		end
	endtask

	task post_body();
		if(phase != null) begin
			phase.drop_objection(this);
		end
	endtask
endclass
*/

class pcie_seq extends uvm_sequence#(pcie_tx);
	`uvm_object_utils(pcie_seq)
	`NEW_OBJ
	int runs;
	task body();
		if (!uvm_resource_db#(int)::read_by_name("*", "runs", runs, this)) begin
            		runs = 1; // fallback if not set
        	end
		`uvm_info("PCIE_SEQ","SEQ BODY",UVM_LOW)
		repeat(runs) begin
			#`PCIE_CLK_GEN5;
			`uvm_do_with(req, { 	//Memory write TLPs
						req.fmt[2] == 1'b0;		//fmt[2] = 0 - no TLP prefix is present, as we have not coded to handle them in src code.
						req.fmt[1] == 1'b1;		//fmt[1] = 1 - Payload present
						req.fmt[0] == 1'b0;		//fmt[0] = 0 - 3DW header - 32bit addressing
						req.type1 == 5'b00000;		//TLP type = mem wr tlp
						req.tc == 3'b000;		//Traffic class 0 because no support for TC/VC mapping						
						req.ln == 1'b0; 		//link in bytes not used normally. hardcoded to 0.
						req.th == 1'b0;			//No TLP processing hints present (no support)
					      	req.attr == 3'b111;		//attributes values defined in README
						req.at == 2'b0; 		//all are physical addresses
						req.td == 1'b0;			//ECRC not present
						req.ep == 1'b0;			//TLP is not errenous
						req.length == 10'b00_0000_1000;	//length fixed in 256bits = 8DWs
						req.requester_id == 16'b0;	//only present in cpls, hardcoded to 0 in memwr	
						//req.tag; randomized
						req.first_be == 4'hf;		//aligned
						req.last_be == 4'hf;		//aligned
						req.address[63:32] == 32'b0;
						req.address[31:0]  == 32'b0;	//addr is 32bit so uppers are hardcoded to 0s. 
				    		//req.data; all data is random
		    		    })
			#`PCIE_CLK_GEN5;
			`uvm_do_with(req, { 	//Memory read TLPs
						req.fmt[2] == 1'b0;		//fmt[2] = 0 - no TLP prefix is present, as we have not coded to handle them in src code.
						req.fmt[1] == 1'b0;		//fmt[1] = 1 - Payload present
						req.fmt[0] == 1'b0;		//fmt[0] = 0 - 3DW header - 32bit addressing
						req.type1 == 5'b00000;		//TLP type = mem wr tlp
						req.tc == 3'b000;		//Traffic class 0 because no support for TC/VC mapping						
						req.ln == 1'b0; 		//link in bytes not used normally. hardcoded to 0.
						req.th == 1'b0;			//No TLP processing hints present (no support)
					      	req.attr == 3'b111;		//attributes values defined in README
						req.at == 2'b0; 		//all are physical addresses
						req.td == 1'b0;			//ECRC not present
						req.ep == 1'b0;			//TLP is not errenous
						req.length == 10'b00_0000_1000;	//length fixed in 256bits = 8DWs
						req.requester_id == 16'b0;	//only present in cpls, hardcoded to 0 in memwr	
						//req.tag; randomized
						req.first_be == 4'hf;		//aligned
						req.last_be == 4'hf;		//aligned
						req.address[63:32] == 32'b0;	//addr is 32bit so uppers are hardcoded to 0s. 
						req.address[31:0]  == 32'b0;	//addr is 32bit so uppers are hardcoded to 0s. 
				    		//req.data; all data is random
		    		    })
		end
	endtask	
endclass

class pcie_2_seq extends uvm_sequence#(pcie_cpl_tx);
	`uvm_object_utils(pcie_2_seq)
	`NEW_OBJ
	int runs;
	task body();
		if (!uvm_resource_db#(int)::read_by_name("*", "runs", runs, this)) begin
            		runs = 1; // fallback if not set
        	end
		`uvm_info("PCIE_2_SEQ","SEQ BODY",UVM_LOW)
		repeat(runs) begin
			`uvm_do_with(req, { req.cpl_tag >= 10'b0110_0100_00;
				    req.cpl_requester_id >= 16'hfff0;
		    		    })
			#`PCIE_CLK_GEN5;
		end
	endtask	
endclass

class pcie_both_seq extends uvm_sequence#(base_tx);
	`uvm_object_utils(pcie_both_seq)
	`NEW_OBJ
	int runs;
	pcie_seq seq1;
	//pcie_2_seq seq2;
	task body();
			`uvm_do(seq1)
			//`uvm_do(seq2)
		`uvm_info("PCIE_BOTH_SEQ","SEQ BODY",UVM_LOW)
	endtask	
endclass

