`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/26/2025 09:42:15 PM
// Design Name: 
// Module Name: extend
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


module extend (
    input [31:7] imm,
    input [1:0] ImmSrc,
    output reg [31:0]  ImmExt
);
    always @(*) begin
        case (ImmSrc)
            2'b00: ImmExt = {{20{imm[31]}}, imm[31:20]}; //I
            2'b01: ImmExt = {{20{imm[31]}}, imm[31:25], imm[11:7]}; //S
            2'b10: ImmExt = {{20{imm[31]}}, imm[7], imm[30:25], imm[11:8], 1'b0}; //B
            2'b11: ImmExt = {{12{imm[31]}}, imm[19:12], imm[20], imm[30:21], 1'b0}; //J
            default: ImmExt = 32'b0; 
        endcase
    end
endmodule
