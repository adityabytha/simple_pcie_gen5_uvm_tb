//INTERFACE FILE
//This file contains the variables that work as interconnection between DUT
//and the testbench.
//

interface pcie_intf#(
	parameter ADDR_WIDTH = 64, 
	parameter DATA_WIDTH = 256, 
	parameter TLP_HEADER_WIDTH = 128
)(input logic clk, rst_n);

    	// TLP Input (from Data Link Layer)
	logic                 rx_valid;
    	logic [TLP_HEADER_WIDTH-1:0] rx_header;
	logic [DATA_WIDTH-1:0] rx_data;
    	logic                 rx_sop; // Start of packet
    	logic                 rx_eop; // End of packet

	
	// TLP Output (to Data Link Layer)
    	logic                tx_valid;
    	logic [TLP_HEADER_WIDTH-1:0] tx_header;
    	logic [DATA_WIDTH-1:0] tx_data;
    	logic                tx_sop;
    	logic                tx_eop;
    	logic                tx_ready;

endinterface
