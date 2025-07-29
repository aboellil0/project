`timescale 1ns / 1ps

module sunc_FIFO #(parameter DEPTH = 128,WIDTH = 32)(
    input clk,rst,
    input WR_EN,
    input [WIDTH-1:0] data_in,
    input RD_EN,
    output reg [WIDTH-1:0] data_out,
    output reg full,
    output reg empty
);

    localparam ptr_width = $clog2(DEPTH); 
    reg [WIDTH-1:0] memory_array [0:DEPTH-1];
    reg [ptr_width-1:0] write_ptr; 
    reg [ptr_width-1:0] read_ptr;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            write_ptr <= 0;
            read_ptr <= 0;
            full <= 0;
            empty <= 0;
        end
        else if(WR_EN && !full) begin
            memory_array[write_ptr] <= data_in;
            write_ptr <= write_ptr +1;
            empty <=0;
            if (write_ptr == DEPTH-1) full <=1;
        end 
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            write_ptr <= 0;
            read_ptr <= 0;
            full <= 0;
            empty <= 0;
        end
        else if (RD_EN && !empty) begin
            data_out <= memory_array[read_ptr];
            read_ptr <= read_ptr + 1;
            full <= 0;
            if (read_ptr == write_ptr) empty <= 1;
        end
    end

endmodule