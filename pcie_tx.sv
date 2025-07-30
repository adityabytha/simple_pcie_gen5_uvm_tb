//TRANSACTION FILE
//This file should contain the variables and transaction details
//It is used to add properties like copy and print to the variables
//It is also used to define the randomizable values in the transaction
//
//

class pcie_tx extends uvm_sequence_item;
	`NEW_OBJ
    rand bit [2:0] fmt;
    rand bit [4:0] type1;
    rand bit [2:0] tc;
    rand bit       ln;
    rand bit       th;
    rand bit [2:0] attr;
    rand bit [1:0] at;
    rand bit       td;
    rand bit       ep;
    rand bit [9:0] length;
    rand bit [15:0] requester_id;
    rand bit [9:0] tag;
    rand bit [3:0] first_be;
    rand bit [3:0] last_be;
    rand bit [63:0] address;
    rand bit [255:0] data; // Assume 256-bit payload

    `uvm_object_utils_begin(pcie_tx)
        `uvm_field_int(fmt, UVM_ALL_ON)
        `uvm_field_int(type1, UVM_ALL_ON)
        `uvm_field_int(tc, UVM_ALL_ON)
        `uvm_field_int(ln, UVM_ALL_ON)
        `uvm_field_int(th, UVM_ALL_ON)
        `uvm_field_int(attr, UVM_ALL_ON)
        `uvm_field_int(at, UVM_ALL_ON)
        `uvm_field_int(td, UVM_ALL_ON)
        `uvm_field_int(ep, UVM_ALL_ON)
        `uvm_field_int(length, UVM_ALL_ON)
        `uvm_field_int(requester_id, UVM_ALL_ON)
        `uvm_field_int(tag, UVM_ALL_ON)
        `uvm_field_int(first_be, UVM_ALL_ON)
        `uvm_field_int(last_be, UVM_ALL_ON)
        `uvm_field_int(address, UVM_ALL_ON)
        `uvm_field_int(data, UVM_ALL_ON)
    `uvm_object_utils_end

endclass
/* pcie_tlp_item.sv
class pcie_tlp_item extends uvm_sequence_item;

    rand bit [2:0] fmt;
    rand bit [4:0] type;
    rand bit [2:0] tc;
    rand bit       ln;
    rand bit       th;
    rand bit [2:0] attr;
    rand bit [1:0] at;
    rand bit       td;
    rand bit       ep;
    rand bit [9:0] length;
    rand bit [15:0] requester_id;
    rand bit [9:0] tag;
    rand bit [3:0] first_be;
    rand bit [3:0] last_be;
    rand bit [63:0] address;
    rand bit [255:0] data; // Assume 256-bit payload

    `uvm_object_utils_begin(pcie_tlp_item)
        `uvm_field_int(fmt, UVM_ALL_ON)
        `uvm_field_int(type, UVM_ALL_ON)
        `uvm_field_int(tc, UVM_ALL_ON)
        `uvm_field_int(ln, UVM_ALL_ON)
        `uvm_field_int(th, UVM_ALL_ON)
        `uvm_field_int(attr, UVM_ALL_ON)
        `uvm_field_int(at, UVM_ALL_ON)
        `uvm_field_int(td, UVM_ALL_ON)
        `uvm_field_int(ep, UVM_ALL_ON)
        `uvm_field_int(length, UVM_ALL_ON)
        `uvm_field_int(requester_id, UVM_ALL_ON)
        `uvm_field_int(tag, UVM_ALL_ON)
        `uvm_field_int(first_be, UVM_ALL_ON)
        `uvm_field_int(last_be, UVM_ALL_ON)
        `uvm_field_int(address, UVM_ALL_ON)
        `uvm_field_int(data, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "pcie_tlp_item");
        super.new(name);
    endfunction
endclass


module pcie_gen5_transaction_layer #(
    parameter ADDR_WIDTH = 64,
    parameter DATA_WIDTH = 256,
    parameter TLP_HEADER_WIDTH = 128
)(
    input logic clk,
    input logic rst_n,

    // RX from DL
    input logic rx_valid,
    input logic [TLP_HEADER_WIDTH-1:0] rx_header,
    input logic [DATA_WIDTH-1:0] rx_data,
    input logic rx_sop,
    input logic rx_eop,

    // TX to DL
    output logic tx_valid,
    output logic [TLP_HEADER_WIDTH-1:0] tx_header,
    output logic [DATA_WIDTH-1:0] tx_data,
    output logic tx_sop,
    output logic tx_eop,
    input logic tx_ready,

    // Interface to Application Layer
    output logic app_req_valid,
    output logic [7:0] app_tlp_type, // Combined fmt + type
    output logic [ADDR_WIDTH-1:0] app_address,
    output logic [DATA_WIDTH-1:0] app_data,
    output logic [9:0] app_tag,
    output logic [15:0] app_requester_id,
    output logic [3:0] app_first_be,
    output logic [3:0] app_last_be,
    output logic [2:0] app_tc,
    output logic [2:0] app_attr,
    output logic app_th,
    output logic app_td,
    output logic app_ep,
    output logic [1:0] app_at,
    output logic [9:0] app_length_dw,
    input  logic app_req_ready,

    // Completion Input
    input logic cpl_valid,
    input logic [DATA_WIDTH-1:0] cpl_data,
    input logic [15:0] cpl_requester_id,
    input logic [9:0] cpl_tag
);
*/

