`timescale 1ns / 1ps

module alu_tb;

    // Testbench signals
    reg [31:0] a, b;
    reg [2:0] opcode;
    wire [31:0] result;
    wire zero_flag;

    // Instantiate the ALU
    alu uut (
        .a(a),
        .b(b),
        .opcode(opcode),
        .result(result),
        .zero_flag(zero_flag)
    );

    initial begin
        $display("Time(ns)\tOpcode\tA\t\tB\t\tResult\t\tZero");
        $monitor("%0t\t%b\t%h\t%h\t%h\t%b", $time, opcode, a, b, result, zero_flag);

        // ADD
        #5  a = 32'd10; b = 32'd5; opcode = 3'b000;
        #10;

        // SUB
        #5  a = 32'd10; b = 32'd5; opcode = 3'b001;
        #10;

        // AND
        #5  a = 32'hF0F0F0F0; b = 32'h0F0F0F0F; opcode = 3'b010;
        #10;

        // OR
        #5  a = 32'hF0F0F0F0; b = 32'h0F0F0F0F; opcode = 3'b011;
        #10;

        // XOR
        #5  a = 32'hFFFF0000; b = 32'h00FFFF00; opcode = 3'b100;
        #10;

        // SLT (a < b)
        #5  a = 32'd3; b = 32'd7; opcode = 3'b101;
        #10;

        // SLT (a > b)
        #5  a = 32'd10; b = 32'd2; opcode = 3'b101;
        #10;

        // SLL (shift left logical)
        #5  a = 32'b00000000000000000000000000000001; b = 32'd4; opcode = 3'b110;
        #10;

        // SRL (shift right logical)
        #5  a = 32'b00010000000000000000000000000000; b = 32'd4; opcode = 3'b111;
        #10;

        // Zero Flag (Result should be 0)
        #5  a = 32'd5; b = 32'd5; opcode = 3'b001; // SUB: 5 - 5 = 0
        #10;

        $finish;
    end

endmodule
