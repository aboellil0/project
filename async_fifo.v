`timescale 1ns / 1ps

module asunc_FIFO #(parameter DEPTH = 100,WIDTH =32)(
    input w_clk,r_clk,w_rst,r_rst,
    input WR_EN,
    input [WIDTH-1:0] data_in,
    input RD_EN,
    output reg [WIDTH-1:0] data_out,
    output full,
    output empty
);
    
  
    localparam ptr_width = $clog2(DEPTH); 
    reg [WIDTH-1:0] memory_array [0:DEPTH-1];

    reg [ptr_width:0] w_ptr,r_ptr;

    assign w_ptr_gray = (w_ptr_bin >> 1) ^ w_ptr_bin;
    assign r_ptr_gray = (r_ptr_bin >> 1) ^ r_ptr_bin;

    reg [ptr_width:0] write_ptr; 
    reg [ptr_width:0] read_ptr;

    reg [ptr_width:0] sync_r_ptr_gray_wclk;

    always @(posedge w_clk) begin
    sync_r_ptr_gray_wclk   <= r_ptr_gray;
    read_ptr <= sync_r_ptr_gray_wclk;
    end

    reg [ptr_width:0] sync_w_ptr_gray_rclk;

    always @(posedge r_clk) begin
    sync_w_ptr_gray_rclk   <= w_ptr_gray;
    write_ptr <= sync_w_ptr_gray_rclk;
    end


    assign empty = (write_ptr == read_ptr);
    assign full = (write_ptr[ptr_width-1:0] == read_ptr[ptr_width-1:0]) &&(write_ptr[ptr_width] != read_ptr[ptr_width]);
           
    always @(posedge w_clk or posedge w_rst) begin
        if (w_rst) begin
            write_ptr <= 0;
            read_ptr <= 0;
//            full <= 0;
//            empty <= 0;
        end
        else if(WR_EN && !full) begin
            memory_array[write_ptr] <= data_in;
            write_ptr <= write_ptr +1;
//            empty <=0;
//            if ((write_ptr + 1 == read_ptr) ||((write_ptr == DEPTH-1)&&(read_ptr == 0)) full <=1;
        end 
    end

    always @(posedge clk_out or posedge r_rst) begin
        if (r_rst) begin
            write_ptr <= 0;
            read_ptr <= 0;
//            full <= 0;
//            empty <= 0;
        end
        else if (RD_EN && !empty) begin
            data_out <= memory_array[read_ptr];
            read_ptr <= read_ptr + 1;
//            full <= 0;
//            if (read_ptr == write_ptr) empty <= 1;
        end
    end
    
    

endmodule