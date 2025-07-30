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
			`uvm_do_with(req, { req.ln == 1'b1;
       				    req.tag == 10'b0101010101;
		    		    })
			#`PCIE_CLK_GEN5;
			`uvm_info("PCIE_SEQ","SEQ BODY",UVM_LOW)
		end
	endtask	
endclass

