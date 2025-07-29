`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2025 08:34:40 PM
// Design Name: 
// Module Name: comp_with_ff
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


module comp_with_ff(
        input a,b,c,
        input clk,
        output reg d,f
    );
    reg temp1,temp2;
    always @(posedge clk) begin
        temp1 <= b ^ c;
        temp2 <= ~b & c;
        d <= a ^ temp1;
        f <= temp2 | (~temp1 & a);
    end
endmodule
