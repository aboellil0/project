`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/27/2025 09:16:05 PM
// Design Name: 
// Module Name: RISC_V
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



module RISC_V (
    input clk,
    input reset
);
    wire [31:0] PCNext, PC;
    wire [31:0] Instr;
    
    // PC Logic
    pc_pcnext pc_next_inst (
        .clk(clk),
        .rst(reset),
        .pc_next(PCNext),
        .pc(PC)
    );
    
    // Instruction Memory
    instruction_memory instruction_memory_inst (
        .PC(PC),
        .Instr(Instr)
    );
    
    // Instruction Decode
    wire [6:0] op = Instr[6:0];
    wire [2:0] funct3 = Instr[14:12];
    wire funct7 = Instr[30];  
    wire [4:0] rs1 = Instr[19:15];
    wire [4:0] rs2 = Instr[24:20];
    wire [4:0] rd = Instr[11:7];
    
    // Control Signals
    wire RegWrite, ALUSrc, MemWrite, PCSrc;
    wire [1:0] ResultSrc, ImmSrc;
    wire [2:0] ALUControl;
    
    // Register File
    wire [31:0] result, src1, src2;
    register_file register_file_inst (
        .clk(clk),
        .rst(reset),
        .A1(rs1),
        .A2(rs2),
        .A3(rd),
        .WD3(result), 
        .WE3(RegWrite),
        .RD1(src1), 
        .RD2(src2)
    );
    
    // Immediate Extension
    wire [31:0] ImmExt;
    extend extend_inst (
        .imm(Instr[31:7]),
        .ImmSrc(ImmSrc),
        .ImmExt(ImmExt)
    );
    
    // ALU Input Mux
    wire [31:0] SrcB;
    two_1_mux alu_mux (
        .a(src2),
        .b(ImmExt),
        .sel(ALUSrc),
        .out(SrcB)
    );
    
    // ALU
    wire [31:0] ALUResult;
    wire Zero;
    alu alu_inst (
        .SrcA(src1),
        .SrcB(SrcB),
        .ALUControl(ALUControl),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );
    
    // Data Memory
    wire [31:0] ReadData;
    data_memory data_memory_inst (
        .clk(clk),
        .WriteData(src2),
        .A(ALUResult),
        .WE(MemWrite),
        .ReadData(ReadData)
    );
    
    // PC Calculation
    wire [31:0] PCTarget, pc_plus4;
    
    PCTarget pc_target_inst (
        .PC(PC),
        .ImmExt(ImmExt),
        .PCTarget(PCTarget)
    );
    
    PCPlus4 pc_plus4_inst (
        .pc(PC),
        .pc_plus4(pc_plus4)
    );
    
    // PC Next Mux
    two_1_mux pc_mux (
        .a(pc_plus4),
        .b(PCTarget),
        .sel(PCSrc),
        .out(PCNext)
    );
    
    // Result Mux (3-to-1)
    three_1_mux result_mux (
        .a(ALUResult),
        .b(ReadData),
        .c(pc_plus4),
        .sel(ResultSrc),
        .out(result)
    );
    
    // Control Unit
    control_unit control_unit_inst (
        .op(op),
        .funct3(funct3),
        .funct7(funct7),
        .Zero(Zero),
        .PCSrc(PCSrc),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .ALUControl(ALUControl),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite)
    );
endmodule