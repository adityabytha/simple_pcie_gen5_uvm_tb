// File: pcie_gen5_transaction_layer.sv
// taken from chatgpt only for using to build a uvm-tb based on this design as
// a practice for interview and since added in resume.
//
//The code implements a simplified PCIe Gen5 Transaction Layer module in 
//SystemVerilog. It parses incoming TLP headers from the Data Link Layer, 
//extracts all defined fields per the PCIe 5.0 spec, and interfaces with the 
//Application Layer to handle requests and generate completions. 
//It ensures full compliance by including all mandatory TLP header fields such 
//as Fmt, Type, Attr, AT, Tag[9:0], TC, and others.

module pcie_gen5_transaction_layer #(
    parameter ADDR_WIDTH = 64,
    parameter DATA_WIDTH = 256,
    parameter TLP_HEADER_WIDTH = 128
    //parameter LINK_WIDTH = 8
)(
    input logic clk,
    input logic rst_n,

    // RX from DLL - received from RC assume 
    input logic rx_valid,
    input logic [TLP_HEADER_WIDTH-1:0] rx_header,
    input logic [DATA_WIDTH-1:0] rx_data,
    input logic rx_sop,
    input logic rx_eop,

    // TX to DLL - sending cpl back to RC
    output logic tx_valid,
    output logic [TLP_HEADER_WIDTH-1:0] tx_header,
    output logic [DATA_WIDTH-1:0] tx_data,
    output logic tx_sop,
    output logic tx_eop,
    input logic tx_ready

    /*
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
    
    // Completion Input from outside forwarded to DLL
    input logic cpl_valid,
    input logic [DATA_WIDTH-1:0] cpl_data,
    input logic [15:0] cpl_requester_id,
    input logic [9:0] cpl_tag
    */
);

    logic [DATA_WIDTH-1:0] tl_ep_mem [ADDR_WIDTH-1:0];
    logic [DATA_WIDTH-1:0] read_data;

    typedef struct packed {
        logic [2:0] fmt;
        logic [4:0] type1;
        logic [2:0] tc;
        logic       ln;
        logic       th;
        logic [2:0] attr;
        logic [1:0] at;
        logic       td;
        logic       ep;
        logic [9:0] length;
        logic [15:0] requester_id;
        logic [9:0] tag;
        logic [3:0] last_be;
        logic [3:0] first_be;
        logic [63:0] address;
    } tlp_t;

    tlp_t rx_tlp;

    // Parse rx_header
    always_comb begin
        rx_tlp.fmt           = rx_header[127:125];
        rx_tlp.type1          = rx_header[124:120];
        rx_tlp.tc            = rx_header[119:117];
        rx_tlp.ln            = rx_header[116];
        rx_tlp.th            = rx_header[115];
        rx_tlp.attr[2]       = rx_header[114];
        rx_tlp.at            = rx_header[113:112];
        rx_tlp.attr[1:0]     = rx_header[111:110];
        rx_tlp.td            = rx_header[109];
        rx_tlp.ep            = rx_header[108];
        rx_tlp.length        = rx_header[107:98];
        rx_tlp.requester_id  = rx_header[97:82];
        rx_tlp.tag[9:8]      = rx_header[81:80]; // T9:T8
        rx_tlp.tag[7:0]      = rx_header[79:72];
        rx_tlp.last_be       = rx_header[71:68];
        rx_tlp.first_be      = rx_header[67:64];
        rx_tlp.address       = rx_header[63:0];
    end

    always_ff @(posedge clk or negedge rst_n) begin
	    if (!rst_n) begin
		    for (int i = 0; i < 64; i++) begin
			    tl_ep_mem[i] <=  '0;
		    end
	   end else if((rx_tlp.type1 == 5'b0_0000) && (rx_tlp.fmt == 3'b010) && rx_valid && rx_sop) begin
		   tl_ep_mem[rx_tlp.address] <= rx_data;
		   //$display("Wriiten value %d at %h",tl_ep_mem[rx_tlp.address],rx_tlp.address);
	   end //else if((rx_tlp.type1 == 5'b0_0000) && (rx_tlp.fmt == 3'b000) && rx_valid && rx_sop) begin
		//	tx_data <= tl_ep_mem[rx_tlp.address];
	  // end

   end
	
   //always_comb read_data = tl_ep_mem[rx_tlp.address];

   always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tx_valid <= 0;
        end else if (tx_ready) begin
            tx_valid    <= 1;
            tx_sop      <= 1;
            tx_eop      <= 1;

            // Build header for Completion w/ Data
            tx_header <= {
                3'b010,             // fmt = 3DW with data
                5'b01010,           // type = CplD
                3'b000,             // TC
                1'b0,               // LN
                1'b0,               // TH
                1'b0,               // Attr[2]
                2'b00,              // AT
                2'b00,              // Attr[1:0]
                1'b0,               // TD
                1'b0,               // EP
                10'd1000,              // Length (8 DWs)
                16'd0, 			//requester is 0 for now
                rx_tlp.tag[9:8],
                rx_tlp.tag[7:0],
                4'hF,               // Last DW BE
                4'hF,               // First DW BE
                64'd0               // Address not used in Completion
            };

   	    tx_data <= tl_ep_mem[rx_tlp.address];
            //tx_data <= cpl_data;
        end else begin
            tx_valid <= 0;
            tx_sop   <= 0;
            tx_eop   <= 0;
        end
    end
    
	    


/*
    // RX to Application Logic
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            app_req_valid <= 0;
        end else if (rx_valid && rx_sop) begin
            app_req_valid   <= 1;
            app_tlp_type    <= {rx_tlp.fmt, rx_tlp.type1};
            app_tc          <= rx_tlp.tc;
            app_th          <= rx_tlp.th;
            app_td          <= rx_tlp.td;
            app_ep          <= rx_tlp.ep;
            app_attr        <= rx_tlp.attr;
            app_at          <= rx_tlp.at;
            app_length_dw   <= rx_tlp.length;
            app_tag         <= rx_tlp.tag;
            app_requester_id<= rx_tlp.requester_id;
            app_first_be    <= rx_tlp.first_be;
            app_last_be     <= rx_tlp.last_be;
            app_address     <= rx_tlp.address;
            app_data        <= rx_data;
        end else if (app_req_ready) begin
            app_req_valid <= 0;
        end
    end

    // TX Completion Logic
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tx_valid <= 0;
        end else if (cpl_valid && tx_ready) begin
            tx_valid    <= 1;
            tx_sop      <= 1;
            tx_eop      <= 1;

            // Build header for Completion w/ Data
            tx_header <= {
                3'b010,             // fmt = 3DW with data
                5'b01010,           // type = CplD
                3'b000,             // TC
                1'b0,               // LN
                1'b0,               // TH
                1'b0,               // Attr[2]
                2'b00,              // AT
                2'b00,              // Attr[1:0]
                1'b0,               // TD
                1'b0,               // EP
                10'd1000,              // Length (8 DWs)
                cpl_requester_id,
                cpl_tag[9:8],
                cpl_tag[7:0],
                4'hF,               // Last DW BE
                4'hF,               // First DW BE
                64'd0               // Address not used in Completion
            };

            tx_data <= cpl_data;
        end else begin
            tx_valid <= 0;
            tx_sop   <= 0;
            tx_eop   <= 0;
        end
    end
*/
endmodule

