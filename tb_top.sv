//TEST BENCH TOP FILE of PCIE
//
//
`timescale 1ns / 1ps

`include "uvm_pkg.sv"
import uvm_pkg::*;
`include "uvm_macros.svh"

//define clock variables
`define PCIE_CLK_GEN5_HALF 0.03125
`define PCIE_CLK_GEN5 0.0625


// Define the same parameters here
localparam int ADDR_WIDTH = 64;
localparam int DATA_WIDTH = 256;
localparam int TLP_HEADER_WIDTH = 128;

`include "pcie_intf.sv"

//`include "pcie_pkg.sv"
//import pcie_pkg::*;

`include "pcie_tl_src.sv"

`include "uvm_commons.sv"
`include "pcie_tx.sv"

`include "pcie_seq_lib.sv"

`include "pcie_scoreboard.sv"
`include "pcie_monitor.sv"
`include "pcie_seqr.sv"
`include "pcie_driver.sv"
`include "pcie_agent.sv"
`include "pcie_env.sv"
`include "pcie_test_lib.sv"




module tb_top;
	
	logic clk, rst_n;

	pcie_intf#(
    		.ADDR_WIDTH(ADDR_WIDTH),
    		.DATA_WIDTH(DATA_WIDTH),
    		.TLP_HEADER_WIDTH(TLP_HEADER_WIDTH)
		) intf(clk,rst_n);

	initial uvm_config_db#(virtual pcie_intf)::set(uvm_root::get(),"*","pcie_tx",intf);
	
	pcie_gen5_transaction_layer#(
    		.ADDR_WIDTH(ADDR_WIDTH),
    		.DATA_WIDTH(DATA_WIDTH),
    		.TLP_HEADER_WIDTH(TLP_HEADER_WIDTH)
		) dut (
			.clk(clk),
			.rst_n(rst_n),
			.rx_valid(intf.rx_valid),
		       	.rx_header(intf.rx_header),
			.rx_sop(intf.rx_sop),
			.rx_eop(intf.rx_eop),
			//.rx_bar_hit(intf.rx_bar_hit),
			.tx_valid(intf.tx_valid),
			.tx_header(intf.tx_header),
			.tx_data(intf.tx_data),
			.tx_sop(intf.tx_sop),
			.tx_eop(intf.tx_eop),
			.tx_ready(intf.tx_ready),
			.app_req_valid(intf.app_req_valid),
			.app_tlp_type(intf.app_tlp_type),
			.app_address(intf.app_address),
			.app_data(intf.app_data),
			.app_tag(intf.app_tag),
			.app_requester_id(intf.app_requester_id),
			.app_first_be(intf.app_first_be),
			.app_last_be(intf.app_last_be),
			.app_tc(intf.app_tc),
			.app_attr(intf.app_attr),
			.app_th(intf.app_th),
			.app_td(intf.app_td),
			.app_ep(intf.app_ep),
			.app_at(intf.app_at),
			.app_length_dw(intf.app_length_dw),
			.app_req_ready(intf.app_req_ready),
			.cpl_data(intf.cpl_data),
			.cpl_requester_id(intf.cpl_requester_id),
			.cpl_tag(intf.cpl_tag)
			// Add all the values but put (intf.ADDR) like that
);

	initial begin
		clk = 0;
		forever #`PCIE_CLK_GEN5_HALF clk=~clk;
	end

	initial begin
		rst_n = 0;
		repeat(2) #`PCIE_CLK_GEN5;
		rst_n = 1;
	end

	initial begin

		//`uvm_info("TB_TOP","THIS IS IN TOP OF TB",UVM_NONE)
		//$display("THSI\n");
		run_test();
	end



	initial begin
		$fsdbDumpfile();
		$fsdbDumpvars(5,tb_top);
	end
endmodule
