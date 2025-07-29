`timescale 1ns/1ps

module randamizer_tb;
    // Test signals
    reg [3:0] in;
    reg clk;
    reg rst;
    reg load;
    reg en;
    reg [14:0] seed_in;
    wire [3:0] out;
    

    randamizer DUT (
        .in(in),
        .clk(clk),
        .rst(rst),
        .load(load),
        .en(en),
        .seed_in(seed_in),
        .out(out)
    );

    always begin
        #20 clk = ~clk;
    end

    initial begin
        clk = 0;
        rst = 0;
        load = 0;
        en = 1;
        in = 4'b0000;
        seed_in = 15'b011011100010101;

        // Test sequence of hex inputs
        in = 4'hA; #20;  // First digit of AC
        in = 4'hC; #20;  // Second digit of AC
        in = 4'hB; #20;  // First digit of BC
        in = 4'hC; #20;  // Second digit of BC
        in = 4'hD; #20;  // First digit of D2
        in = 4'h2; #20;  // Second digit of D2
        in = 4'h1; #20;  // First digit of 11
        in = 4'h1; #20;  // Second digit of 11
        in = 4'h4; #20;  // First digit of 4D
        in = 4'hD; #20;  // Second digit of 4D
        in = 4'hA; #20;  // First digit of AE
        in = 4'hE; #20;  // Second digit of AE
        in = 4'h1; #20;  // First digit of 15
        in = 4'h5; #20;  // Second digit of 15
        in = 4'h7; #20;  // First digit of 77
        in = 4'h7; #20;  // Second digit of 77
        in = 4'hC; #20;  // First digit of C6
        in = 4'h6; #20;  // Second digit of C6
        in = 4'hD; #20;  // First digit of DB
        in = 4'hB; #20;  // Second digit of DB
        in = 4'hF; #20;  // First digit of F4
        in = 4'h4; #20;  // Second digit of F4
        in = 4'hC; #20;  // First digit of C9
        in = 4'h9; #20;  // Second digit of C9
        // End simulation
        #10 $finish;
    end
    
    // Monitor changes
    initial begin
        $monitor("Time=%0t rst=%b load=%b en=%b in=%b seed_in=%b out=%b",
                 $time, rst, load, en, in, seed_in, out);
    end
    
endmodule