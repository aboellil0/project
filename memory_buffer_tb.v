`timescale 1ns / 1ps

module memory_buffer_tb (
);
    reg clk;
    reg rst;
    reg en_w;
    reg en_r;
    reg [7:0] data_in;
    wire [7:0] data_out;
    wire full_flag;
    wire empty_flag;

    // Instantiate the memory_buffer module
    memory_buffer uut (
        .clk(clk),
        .rst(rst),
        .en_w(en_w),
        .en_r(en_r),
        .data_in(data_in),
        .data_out(data_out),
        .full_flag(full_flag),
        .empty_flag(empty_flag)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    // Testbench stimulus
    initial begin
        rst = 1; en_w = 0; en_r = 0; data_in = 8'b0;
        #10 rst = 0; // Release reset

        // Write some data
        en_w = 1; data_in = 8'hA5; #10;
        en_w = 1; data_in = 8'h5A; #10;

        // Read data
        en_w = 0; en_r = 1; #10;
        $display("Data out: %h, Full: %b, Empty: %b", data_out, full_flag, empty_flag);

        // Read again
        #10;
        $display("Data out: %h, Full: %b, Empty: %b", data_out, full_flag, empty_flag);

        // Reset the buffer
        rst = 1; #10;
        rst = 0;

        // Check empty flag after reset
        $display("After reset - Full: %b, Empty: %b", full_flag, empty_flag);

        $finish;
    end
endmodule