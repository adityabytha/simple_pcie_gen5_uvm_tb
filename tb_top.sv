//TEST BENCH TOP FILE of PCIE
//
//



// Define the same parameters here
localparam int ADDR_WIDTH = 64;
localparam int DATA_WIDTH = 256;
localparam int TLP_HEADER_WIDTH = 128;


`include "uvm_pkg.sv"
import uvm_pkg::*;
`include "uvm_macros.svh"

//`include "pcie_pkg.sv"
//import pcie_pkg::*;

`include "pcie_tl_src.sv"

`include "uvm_commons.sv"

`include "pcie_intf.sv"
`include "pcie_tx.sv"

`include "pcie_env.sv"
`include "pcie_test_lib.sv"

module tb_top;
	
	logic clk, rst_n;

	pcie_intf#(
    		.ADDR_WIDTH(ADDR_WIDTH),
    		.DATA_WIDTH(DATA_WIDTH),
    		.TLP_HEADER_WIDTH(TLP_HEADER_WIDTH)
		) intf(clk,rst_n);

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

		`uvm_info("TB_TOP","THIS IS IN TOP OF TB",UVM_INFO)
		//$display("THSI\n");
		run_test();
	end

endmodule
