// .   Write Verilog code to model and verify a simple ROM with the following specifications: 
// • Input signals: Address (32-bit width) 
// • Output signals: Data_out (32-bit width) 
// • Memory characteristics: 
// • 256 memory locations 
// • 32-bit data width per location 
// • Read-only operation 
// Additional requirements: 
// • Ignore lowest 2 address bits (Address [1:0]) 


module rom_module (
    input [31:0] address,
    output reg [31:0] data_out
);
    reg [31:0] memory [0:255]; 
    reg [31:0] memory_location; 
    always @(*) begin
        memory_location = address[31:2]; 
        data_out = memory[memory_location];
    end
    initial begin
        // some values for testing
        memory[0] = 32'b00000000000000000000000000000001;
        memory[1] = 32'b00000000000000000000000000000010;
        memory[2] = 32'b00000000000000000000000000000011;
        memory[3] = 32'b00000000000000000000000000000100; 
        memory[4] = 32'b00000000000000000000000000000101;
    end
endmodule