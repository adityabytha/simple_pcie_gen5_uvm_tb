//PCIE SEQUENCE LIBRARY FILE
//
//Should house different sequences or TLP headers for write/read transactions.


class base_seq extends uvm_sequence#(pcie_tx);
	`uvm_object_utils(pcie_tx)
	`NEW_OBJ
	//uvm_phase phase;

	/*task pre_body();
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
	endtask*/
endclass

class pcie_seq extends base_seq;
	`uvm_object_utils(pcie_seq)
	`NEW_OBJ

	task body();
		`uvm_do(req)
		`uvm_info("PCIE_SEQ","SEQ BODY",UVM_LOW)
	endtask	
endclass

