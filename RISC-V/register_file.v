`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/27/2025 08:27:47 PM
// Design Name: 
// Module Name: register_file
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





module register_file (
    input clk,
    input rst,
    input [4:0] A1, // rs1
    input [4:0] A2, // rs2
    input [4:0] A3, // rd
    input [31:0] WD3, 
    input WE3, // RegWrite
    output reg [31:0] RD1, 
    output reg [31:0] RD2
);
    reg [31:0] registers [0:31]; // 32 registers // 32 bit 

    always @(A1,A2) begin
        if (A1 != 0) begin
            RD1 = registers[A1];
        end else begin
            RD1 = 32'b0; 
        end
        if (A2 != 0) begin
            RD2 = registers[A2];
        end else begin
            RD2 = 32'b0;
        end
    end

    integer i;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end
        else if (WE3 && A3 != 0) begin
            registers[A3] <= WD3;
        end
    end
endmodule
