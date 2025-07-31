//SCOREBOARD FILE
//checks the correct transmission of the headers
//
//
class pcie_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(pcie_scoreboard)
	uvm_analysis_port#(pcie_app_tx) sb_act; //actual
	//uvm_analysis_port#(pcie_tx) sb_exp; //expected

	function new(string name="",uvm_component parent=null);
		super.new(name,parent);
		sb_act = new("sb_act",this);
		//sb_exp = new();
	endfunction

	task run_phase(uvm_phase phase);
		
		//check for outputs if they are correct
		`uvm_info("SCO","Run Phase",UVM_LOW)

	endtask
endclass	
