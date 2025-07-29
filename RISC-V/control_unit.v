

module control_unit (
    input [6:0] op,
    input [2:0] funct3,
    input funct7,
    input Zero,
    output PCSrc,
    output [1:0] ResultSrc,
    output MemWrite,
    output [2:0] ALUControl,
    output ALUSrc,
    output [1:0] ImmSrc,
    output RegWrite
);
    wire Branch, ALUOp, Jump;
    wire [1:0] ALUOpCode;

    main_decoder md (
        .op(op),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite),
        .ALUOp(ALUOpCode),
        .Branch(Branch),
        .Jump(Jump)
    );

    assign PCSrc = (Branch & Zero) | Jump; 

    ALU_Decoder ad (
        .funct3(funct3),
        .funct7(funct7),
        .ALUOp(ALUOpCode),
        .op(op[5]),
        .ALUControl(ALUControl)
    );
endmodule


module main_decoder (
    input [6:0] op,
    output reg [1:0] ResultSrc,
    output reg MemWrite,
    output reg ALUSrc,
    output reg [1:0] ImmSrc,
    output reg RegWrite,
    output reg [1:0] ALUOp,
    output reg Branch,
    output reg Jump
);
    always @(*) begin
        case (op)
            7'b0000011: begin //lw
                MemWrite = 0;
                ALUSrc = 1;
                ImmSrc = 2'b00;
                RegWrite = 1;
                Branch = 0;
                ALUOp = 2'b00; 
                ResultSrc = 2'b01;
                Jump = 0;
            end
            7'b0100011: begin // sw
                ResultSrc = 2'bxx;
                MemWrite = 1;
                ALUSrc = 1;
                ImmSrc = 2'b01;
                RegWrite = 0;
                Branch = 0;
                ALUOp = 2'b00;
                Jump = 0;
            end
            7'b0110011: begin // R-type
                ResultSrc = 2'b00;
                MemWrite = 0;
                ALUSrc = 0;
                ImmSrc = 2'bxx;
                RegWrite = 1;
                Branch = 0;
                ALUOp = 2'b10; 
                Jump = 0;
            end
            7'b1100011: begin // beq
                ResultSrc = 2'bxx;
                MemWrite = 0;
                ALUSrc = 0;
                ImmSrc = 2'b10;
                RegWrite = 0;
                Branch = 1;
                ALUOp = 2'b01;
                Jump = 0;
            end
            7'b0010011: begin // I-type ALU
                RegWrite = 1;
                ImmSrc = 2'b00;
                ALUSrc = 1;
                MemWrite = 0;
                ResultSrc = 2'b00;
                Branch = 0;
                ALUOp = 2'b10; 
                Jump = 0;
            end
            7'b1101111: begin // JAL
                RegWrite = 1;
                ImmSrc = 2'b11;
                ALUSrc = 1'bx;
                MemWrite = 0;
                ResultSrc = 2'b10;
                Branch = 0;
                ALUOp = 2'bxx; 
                Jump = 1; 
            end
            default: begin //default 
                ResultSrc = 2'bxx;
                MemWrite = 0;
                ALUSrc = 0;
                ImmSrc = 2'b00;
                RegWrite = 0;
                Branch = 0;
                ALUOp = 2'bxx;
            end
        endcase
    end
endmodule


module ALU_Decoder (
    input [2:0] funct3,
    input funct7, // 7th 
    input [1:0] ALUOp,
    input op, // 5th 
    output reg [2:0] ALUControl
);
    always @(*) begin
        case (ALUOp)
            2'b00: ALUControl = 3'b000; // (add) Load/Store
            2'b01: ALUControl = 3'b001; // (subtract) beq
            2'b10: begin // R-type
                case (funct3)
                    3'b000: ALUControl = (funct7 == 1'b1 && op == 1'b1) ? 3'b001 : 3'b000; // sub or add
                    3'b010: ALUControl = 3'b101; // slt
                    3'b110: ALUControl = 3'b011; // or
                    3'b111: ALUControl = 3'b010; // and
                    default: ALUControl = 3'bxxx; // Undefined operation
                endcase
            end
            default: ALUControl = 3'bxxx; // Undefined operation for other cases
        endcase
    end
endmodule