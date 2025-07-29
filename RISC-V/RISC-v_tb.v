`timescale 1ns / 1ps
module RISC_V_tb;
    reg clk, reset;
    
    RISC_V cpu (
        .clk(clk),
        .reset(reset)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        reset = 1;
        #10 reset = 0;
        #1000 $stop;
    end
    
    // Monitor key signals
    initial begin
        $monitor("Time=%0t PC=%h Instr=%h", $time, cpu.PC, cpu.Instr);
    end
endmodule