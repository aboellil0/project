`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/26/2025 09:31:38 PM
// Design Name: 
// Module Name: three_1_mux
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


module three_1_mux(
    input [31:0] a,
    input [31:0] b,
    input [31:0] c,
    input [1:0] sel,
    output reg [31:0] out
);
    always @(*) begin
        case (sel)
            2'b00: out = a;
            2'b01: out = b; 
            2'b10: out = c; 
            default: out = 32'b0; 
        endcase
    end
endmodule
