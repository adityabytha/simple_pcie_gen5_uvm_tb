// File: pcie_gen5_transaction_layer.sv
// taken from chatgpt only for using to build a uvm-tb based on this design as
// a practice for interview and since added in resume.
module pcie_gen5_transaction_layer #(
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

    // Internal TLP fields
    typedef struct packed {
        logic [2:0]   fmt;
        logic [4:0]   type;
        logic         th;
        logic         td;
        logic         ep;
        logic [1:0]   attr;
        logic [9:0]   length;
        logic [15:0]  requester_id;
        logic [7:0]   tag;
        logic [3:0]   last_dw_be;
        logic [3:0]   first_dw_be;
        logic [ADDR_WIDTH-1:0] address;
    } tlp_header_t;

    tlp_header_t parsed_rx_header;

    // Header unpacking (rx_header[127:0])
    always_comb begin
        parsed_rx_header.fmt           = rx_header[127:125];
        parsed_rx_header.type          = rx_header[124:120];
        parsed_rx_header.th            = rx_header[119];
        parsed_rx_header.td            = rx_header[118];
        parsed_rx_header.ep            = rx_header[117];
        parsed_rx_header.attr          = rx_header[116:115];
        parsed_rx_header.length        = rx_header[109:100];
        parsed_rx_header.requester_id  = rx_header[95:80];
        parsed_rx_header.tag           = rx_header[79:72];
        parsed_rx_header.last_dw_be    = rx_header[71:68];
        parsed_rx_header.first_dw_be   = rx_header[67:64];
        parsed_rx_header.address       = rx_header[63:0]; // For 3DW header, upper bits zero
    end

    // Receive logic
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            app_req_valid <= 0;
        end else if (rx_valid && rx_sop) begin
            app_req_valid <= 1;
            app_req_type  <= {parsed_rx_header.fmt, parsed_rx_header.type};
            app_req_addr  <= parsed_rx_header.address;
            app_req_data  <= rx_data;
        end else if (app_req_ready) begin
            app_req_valid <= 0;
        end
    end

    // Completion logic
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tx_valid <= 0;
        end else if (app_cpl_valid && tx_ready) begin
            tx_valid       <= 1;
            tx_sop         <= 1;
            tx_eop         <= 1;
            tx_header      <= {
                                3'b010,             // fmt = 3DW w/ data
                                5'b01010,           // type = CplD
                                1'b0,               // th
                                1'b0,               // td
                                1'b0,               // ep
                                2'b00,              // attr
                                2'b00,              // reserved
                                10'd1,              // length
                                app_requester_id,
                                app_tag,
                                4'hF,               // last_dw_be
                                4'hF,               // first_dw_be
                                64'h0               // lower address (not used in completions)
                              };
            tx_data        <= app_cpl_data;
        end else begin
            tx_valid <= 0;
            tx_sop   <= 0;
            tx_eop   <= 0;
        end
    end

endmodule
