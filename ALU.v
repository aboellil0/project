
// 000	ADD
// 001	SUB
// 010	AND
// 011	OR
// 100	XOR
// 101	SLT  (set if less than),
// 110	SLL (shift left logical) 
// 111	SRL  SRL(shift right logical) 

module alu (
    input [31:0] a,
    input [31:0] b,
    input [2:0] opcode,
    output reg result,
    output reg zero_flag 
);

    always @(*) begin
        case (opcode)
            3'b000: result = a + b; // ADD
            3'b001: result = a - b; // SUB
            3'b010: result = a & b; // AND
            3'b011: result = a | b; // OR
            3'b100: result = a ^ b; // XOR
            3'b101: result = (a < b) ? 1 : 0; // SLT 
            3'b110: result = a << b; // SLL 
            3'b111: result = a >> b; // SRL 
            default: result = 0;
        endcase
        zero_flag = (result == 0) ? 1 : 0;
    end
endmodule