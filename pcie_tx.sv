//TRANSACTION FILE
//This file should contain the variables and transaction details
//It is used to add properties like copy and print to the variables
//It is also used to define the randomizable values in the transaction
//
//

class base_tx extends uvm_sequence_item;
	`NEW_OBJ
    	`uvm_object_utils(base_tx)

endclass


class pcie_tx extends base_tx;
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
        `uvm_field_int(tc, UVM_NOPRINT)
        `uvm_field_int(ln, UVM_NOPRINT)
        `uvm_field_int(th, UVM_NOPRINT)
        `uvm_field_int(attr, UVM_NOPRINT)
        `uvm_field_int(at, UVM_NOPRINT)
        `uvm_field_int(td, UVM_NOPRINT)
        `uvm_field_int(ep, UVM_NOPRINT)
        `uvm_field_int(length, UVM_NOPRINT)
        `uvm_field_int(requester_id, UVM_ALL_ON)
        `uvm_field_int(tag, UVM_ALL_ON)
        `uvm_field_int(first_be, UVM_NOPRINT)
        `uvm_field_int(last_be, UVM_NOPRINT)
        `uvm_field_int(address, UVM_ALL_ON)
        `uvm_field_int(data, UVM_ALL_ON)
    `uvm_object_utils_end

endclass

class pcie_dl_tx extends base_tx;
	`NEW_OBJ
	// TX to DL
    bit tx_valid;
    bit [TLP_HEADER_WIDTH-1:0] tx_header;
    bit [DATA_WIDTH-1:0] tx_data;
    bit tx_sop;
    bit tx_eop;
    bit tx_ready;
	
    `uvm_object_utils_begin(pcie_dl_tx)
    	`uvm_field_int(tx_valid, UVM_ALL_ON)
    	`uvm_field_int(tx_header, UVM_ALL_ON)
    	`uvm_field_int(tx_data, UVM_ALL_ON)
    	`uvm_field_int(tx_sop, UVM_ALL_ON)
    	`uvm_field_int(tx_eop, UVM_ALL_ON)
    	`uvm_field_int(tx_ready, UVM_ALL_ON)
    `uvm_object_utils_end
    
endclass

class pcie_app_tx extends base_tx;
	`NEW_OBJ
	
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
	
	`uvm_object_utils_begin(pcie_app_tx)
		`uvm_field_int(app_req_valid, UVM_ALL_ON)
		`uvm_field_int(app_tlp_type, UVM_ALL_ON)
		`uvm_field_int(app_address, UVM_ALL_ON)
		`uvm_field_int(app_data, UVM_ALL_ON)
		`uvm_field_int(app_tag, UVM_ALL_ON)
		`uvm_field_int(app_requester_id, UVM_ALL_ON)
		`uvm_field_int(app_first_be, UVM_ALL_ON)
		`uvm_field_int(app_last_be, UVM_ALL_ON)
		`uvm_field_int(app_tc, UVM_ALL_ON)
		`uvm_field_int(app_attr, UVM_ALL_ON)
		`uvm_field_int(app_th, UVM_ALL_ON)
		`uvm_field_int(app_td, UVM_ALL_ON)
		`uvm_field_int(app_ep, UVM_ALL_ON)
		`uvm_field_int(app_at, UVM_ALL_ON)
		`uvm_field_int(app_length_dw, UVM_ALL_ON)
		`uvm_field_int(app_req_ready, UVM_ALL_ON)
	`uvm_object_utils_end
endclass

class pcie_cpl_tx extends base_tx;
	`NEW_OBJ
	rand bit [DATA_WIDTH-1:0] cpl_data;
       	rand bit [15:0] cpl_requester_id;
	rand bit [9:0] cpl_tag;

	`uvm_object_utils_begin(pcie_cpl_tx)
		`uvm_field_int(cpl_data, UVM_ALL_ON)
		`uvm_field_int(cpl_requester_id, UVM_ALL_ON)
		`uvm_field_int(cpl_tag, UVM_ALL_ON)
	`uvm_object_utils_end
endclass
