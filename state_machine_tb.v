`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/20/2025 10:58:20 AM
// Design Name: 
// Module Name: state_machine_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module state_machine_tb (
);
    reg clk;
    reg reset;
    reg taken;
    wire predict;
    localparam T = 10;
    state_machine uut (
        .clk(clk),
        .reset(reset),
        .taken(taken),
        .predict(predict)
    );
    initial begin
           forever #5 clk = ~clk;
        end
    initial begin 
        clk = 1;
        reset = 1;
        taken = 0;
        
        #T reset = 0; taken =0;
        #T taken =1;
        #T taken =0;
        #T taken =1;
        #T taken =1;
        #T taken =1;
        
        $finish;
    end
    
endmodule
