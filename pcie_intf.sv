//INTERFACE FILE
//This file contains the variables that work as interconnection between DUT
//and the testbench.
//

interface pcie_intf#(
	parameter ADDR_WIDTH = 64, 
	parameter DATA_WIDTH = 256, 
	parameter TLP_HEADER_WIDTH = 128
)(input logic clk, rst_n);

	//INPUTS
    // TLP Input (from Data Link Layer)
	logic                 rx_valid;
    	logic [TLP_HEADER_WIDTH-1:0] rx_header;
	logic [DATA_WIDTH-1:0] rx_data;
    	logic                 rx_sop; // Start of packet
    	logic                 rx_eop; // End of packet
    //	logic [1:0]           rx_bar_hit;

	//output to DLL but is input to dut
    	logic                tx_ready;
	
	//OUTPUTS
	// TLP Output (to Data Link Layer)
    	logic                tx_valid;
    	logic [TLP_HEADER_WIDTH-1:0] tx_header;
    	logic [DATA_WIDTH-1:0] tx_data;
    	logic                tx_sop;
    	logic                tx_eop;

    // Interface to Application Layer
    logic app_req_valid;
    logic [7:0] app_tlp_type; // Combined fmt + type
    logic [ADDR_WIDTH-1:0] app_address;
    logic [DATA_WIDTH-1:0] app_data;
    logic [9:0] app_tag;
    logic [15:0] app_requester_id;
    logic [3:0] app_first_be;
    logic [3:0] app_last_be;
    logic [2:0] app_tc;
    logic [2:0] app_attr;
    logic app_th;
    logic app_td;
    logic app_ep;
    logic [1:0] app_at;
    logic [9:0] app_length_dw;
    logic app_req_ready;

    // Completion Input
    logic cpl_valid;
    logic [DATA_WIDTH-1:0] cpl_data;
    logic [15:0] cpl_requester_id;
    logic [9:0] cpl_tag;
endinterface	
	

