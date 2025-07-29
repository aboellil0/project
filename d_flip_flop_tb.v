`timescale 10ps/1ps

module d_flip_flop_tb (
);
    reg rst,clk,
    reg [31:0] d,q, qn;
    
    d_flip_flop uut (
        .D(d),
        .clk(clk),
        .q(q),
        .rst(rst),
        .qn(qn)
    );
    
    initial begin
        $monitor("Time: %0t | D: %b | CLK: %b | Q: %b | QN: %b", 
                 $time, d, clk, q, qn);
    end 
    
    initial begin
        // Initialize inputs
        d = 0; clk = 0;
        
        // Test case 1
        #10; d = 1; clk = 1; #10; clk = 0;
        
        // Test case 2
        #10; d = 0; clk = 1; #10; clk = 0;
        
        // Test case 3
        #10; d = 1; clk = 1; #10; clk = 0;
        
        // Test case 4
        #10; d = 0; clk = 1; #10; clk = 0;

        $finish;
    end

endmodule