`timescale 1ns / 1ps

// 000	ADD
// 001	SUB
// 010	AND
// 011	OR
// 100	XOR
// 101	SLT  (set if less than),
// 110	SLL (shift left logical) 
// 111	SRL  SRL(shift right logical) 

module alu (
    input [31:0] SrcA,
    input [31:0] SrcB,  
    input [2:0] ALUControl,
    output reg [31:0] ALUResult,
    output reg Zero 
);
    always @(*) begin
        case (ALUControl)
            3'b000: ALUResult = SrcA + SrcB; // ADD
            3'b001: ALUResult = SrcA - SrcB; // SUB
            3'b010: ALUResult = SrcA & SrcB; // AND
            3'b011: ALUResult = SrcA | SrcB; // OR
            3'b100: ALUResult = SrcA ^ SrcB; // XOR
            3'b101: ALUResult = (SrcA < SrcB) ? 1 : 0; // SLT 
            3'b110: ALUResult = SrcA << SrcB; // SLL 
            3'b111: ALUResult = SrcA >> SrcB; // SRL 
            default: ALUResult = 0;
        endcase
        Zero = (ALUResult == 0);
    end
endmodule