//TRANSACTION FILE
//This file should contain the variables and transaction details
//It is used to add properties like copy and print to the variables
//It is also used to define the randomizable values in the transaction
//
//

class pcie_tx extends uvm_sequence_item;
	`NEW_OBJ
	`uvm_object_utils(pcie_tx)


endclass

/*module pcie_gen5_transaction_layer #(
    parameter ADDR_WIDTH = 64,
    parameter DATA_WIDTH = 256,    // Gen5 can use 256-bit payloads
    parameter TLP_HEADER_WIDTH = 128
)(
    input logic clk,
    input logic rst_n,

    // TLP Input (from Data Link Layer)
    input logic                 rx_valid,
    input logic [TLP_HEADER_WIDTH-1:0] rx_header,
    input logic [DATA_WIDTH-1:0] rx_data,
    input logic                 rx_sop, // Start of packet
    input logic                 rx_eop, // End of packet
    input logic [1:0]           rx_bar_hit,

    // TLP Output (to Data Link Layer)
    output logic                tx_valid,
    output logic [TLP_HEADER_WIDTH-1:0] tx_header,
    output logic [DATA_WIDTH-1:0] tx_data,
    output logic                tx_sop,
    output logic                tx_eop,
    input  logic                tx_ready,

    // Application Layer interface
    output logic                app_req_valid,
    output logic [7:0]          app_req_type,
    output logic [ADDR_WIDTH-1:0] app_req_addr,
    output logic [DATA_WIDTH-1:0] app_req_data,
    input  logic                app_req_ready,

    input  logic                app_cpl_valid,
    input  logic [DATA_WIDTH-1:0] app_cpl_data,
    input  logic [15:0]         app_requester_id,
    input  logic [7:0]          app_tag
);
*/
