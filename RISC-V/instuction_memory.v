
// | Address | Instruction | Assembly             | Description                           |         |
// | ------- | ----------- | -------------------- | ------------------------------------- | ------- |
// | `0x00`  | `00500113`  | `addi x2, x0, 5`     | `x2 = 5`                              |         |
// | `0x04`  | `00C00193`  | `addi x3, x0, 12`    | `x3 = 12`                             |         |
// | `0x08`  | `FF718393`  | `addi x7, x3, -9`    | `x7 = 12 - 9 = 3`                     |         |
// | `0x0C`  | `0023E233`  | `or x4, x7, x2`      | \`x4 = 3                              | 5 = 7\` |
// | `0x10`  | `0041F2B3`  | `and x5, x3, x4`     | `x5 = 12 & 7 = 4`                     |         |
// | `0x14`  | `004282B3`  | `add x5, x5, x4`     | `x5 = 4 + 7 = 11`                     |         |
// | `0x18`  | `02728863`  | `beq x5, x7, end`    | `11 ? 3`, not taken                   |         |
// | `0x1C`  | `0041A233`  | `slt x4, x3, x4`     | `x4 = (12 < 7)? 1 : 0 = 0`            |         |
// | `0x20`  | `00020463`  | `beq x4, x0, around` | `0 == 0`, taken ? jump to `around:`   |         |
// | `0x24`  | `00000293`  | `addi x5, x0, 0`     | skipped                               |         |
// | `0x28`  | `0023A233`  | `slt x4, x7, x2`     | `x4 = (3 < 5)? 1 : 0 = 1`             |         |
// | `0x2C`  | `005203B3`  | `add x7, x4, x5`     | `x7 = 1 + 11 = 12`                    |         |
// | `0x30`  | `402383B3`  | `sub x7, x7, x2`     | `x7 = 12 - 5 = 7`                     |         |
// | `0x34`  | `0471AA23`  | `sw x7, 84(x3)`      | Store `7` at `x3+84` = address `96`   |         |
// | `0x38`  | `06002103`  | `lw x2, 96(x0)`      | Load from `96` into `x2`, so `x2 = 7` |         |
// | `0x3C`  | `005104B3`  | `add x9, x2, x5`     | `x9 = 7 + 11 = 18`                    |         |
// | `0x40`  | `008001EF`  | `jal x3, end`        | Jump to `end`, `x3 = PC+4 = 0x44`     |         |
// | `0x44`  | `00100113`  | `addi x2, x0, 1`     | skipped                               |         |
// | `0x48`  | `00910133`  | `add x2, x2, x9`     | skipped                               |         |
// | `0x4C`  | `0221A023`  | `sw x2, 0x20(x3)`    | skipped                               |         |
// | `0x50`  | `00210063`  | `beq x2, x2, done`   | infinite loop                         |         |


module instruction_memory (
    input [31:0] PC,
    output [31:0] Instr
);
    reg [31:0] memory [0:63];

    initial begin
        memory[0]  = 32'h00500113; // addi x2, x0, 5
        memory[1]  = 32'h00C00193; // addi x3, x0, 12
        memory[2]  = 32'hFF718393; // addi x7, x3, -9
        memory[3]  = 32'h0023E233; // or x4, x7, x2
        memory[4]  = 32'h0041F2B3; // and x5, x3, x4
        memory[5]  = 32'h004282B3; // add x5, x5, x4
        memory[6]  = 32'h02728863; // beq x5, x7, end
        memory[7]  = 32'h0041A233; // slt x4, x3, x4
        memory[8]  = 32'h00020463; // beq x4, x0, around
        memory[9]  = 32'h00000293; // addi x5, x0, 0
        memory[10] = 32'h0023A233; // slt x4, x7, x2
        memory[11] = 32'h005203B3; // add x7, x4, x5
        memory[12] = 32'h402383B3; // sub x7, x7, x2
        memory[13] = 32'h0471AA23; // sw x7, 84(x3)
        memory[14] = 32'h06002103; // lw x2, 96(x0)
        memory[15] = 32'h005104B3; // add x9, x2, x5
        memory[16] = 32'h008001EF; // jal x3, end
        memory[17] = 32'h00100113; // addi x2, x0, 1
        memory[18] = 32'h00910133; // add x2, x2, x9
        memory[19] = 32'h0221A023; // sw x2, 0x20(x3)
        memory[20] = 32'h00210063; // beq x2, x2, done
    end

    assign Instr = memory[PC[31:2]];

endmodule
