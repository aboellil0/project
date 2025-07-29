`timescale 1ns / 1ps

module data_memory (
    input clk,
    input [31:0] WriteData,
    input [31:0] A, // ALUResult
    input WE, // MemWrite
    output reg [31:0] ReadData
);
    reg [31:0] memory [0:127]; 

    always @(posedge clk) begin
        if (WE) begin
            memory[A] <= WriteData; // Write data 
        end
        ReadData <= memory[A]; // Read data 
    end
    integer i;
    initial begin
        for (i = 0; i < 128; i = i + 1) begin
            memory[i] = 32'b10101010101010101010101010101010; 
        end
    end
endmodule