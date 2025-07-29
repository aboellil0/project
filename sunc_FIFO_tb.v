`timescale 1ns / 1ps

module sunc_FIFO_tb ();
    
    
    localparam w=32;
    localparam d=8;
    reg clk;
    reg rst;
    reg WR_EN;
    reg [w-1:0] data_in;
    reg RD_EN;
    wire [w-1:0] data_out;
    wire full;
    wire empty;

    // Instantiate the FIFO module
    sunc_FIFO #(d, w) uut (
        .clk(clk),
        .rst(rst),
        .WR_EN(WR_EN),
        .data_in(data_in),
        .RD_EN(RD_EN),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $monitor("Time: %0t | WR_EN: %b | RD_EN: %b | Data In: %h  Full: %b | Empty: %b",
                 $time, WR_EN, RD_EN, data_in, full, empty);
    end

    initial begin
        rst = 1;
        WR_EN = 0;
        RD_EN = 0;
        data_in = 32'b0;

        #10 rst = 0;

        WR_EN = 1;
        data_in = 32'b10101010101010101010101010101010; 
        #10;
        data_in = 32'b10101010101010101010101010101010; 
        #10;
        data_in = 32'b10101010101010101010101010101010; 
        #10;
        data_in = 32'b10101010101010101010101010101010; 
        #10;
        data_in = 32'b10101010101010101010101010101010; 
        #10;
        data_in = 32'b10101010101010101010101010101010; 
        #10;
        data_in = 32'b10101010101010101010101010101010; 
        #10;
        data_in = 32'b10101010101010101010101010101010; 
        #10;
        data_in = 32'b10101010101010101010101010101010; 
        #10;
        data_in = 32'b10101010101010101010101010101010; 
        #10;

        WR_EN = 0; // Stop writing
        RD_EN = 1; // Start reading
        $display("Data Out: %h", data_out);
        #10;
        $display("Data Out: %h", data_out);
        #10;
        $display("Data Out: %h", data_out);
        #10;
        $display("Data Out: %h", data_out);
        #10;
        $display("Data Out: %h", data_out);
        #10;
        $display("Data Out: %h", data_out);
        #10;
        $display("Data Out: %h", data_out);
        #10;
        $display("Data Out: %h", data_out);
        #10;
        $display("Data Out: %h", data_out);


        #10;
        $finish;
    end

endmodule