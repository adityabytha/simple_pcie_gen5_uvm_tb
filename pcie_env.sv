//ENV FILE of PCIE
//

class pcie_env extends uvm_env;
	`NEW_COMP
	`uvm_component_utils(pcie_env)
	pcie_agent agent;
//	pcie_scoreboard sb;
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agent = pcie_agent::type_id::create("agent",this);
//		sb = pcie_scoreboard::type_id::create("sb",this);
		`uvm_info("ENV","Build_Phase",UVM_LOW)
	endfunction

	function void connect_phase(uvm_phase phase);
//		agent.mon.ap_port.connect(sb.sb_act);
	endfunction



endclass
