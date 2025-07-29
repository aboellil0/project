// Implement a Verilog code for 4-bit PISO (parallel to serial), write Testbench with tasks and functions 
// to check result. 

module four_bit_piso (
    input [3:0] in,
    input clk,load
    output out
);
    reg [3:0] temp;
    always @(posedge clk) begin
        if (load) begin
            temp <= in; // Load new data on load signal
        end else begin
            temp <= {temp[2:0], 1'b0}; // Shift left
        end
        out <= temp[3]; 
    end
endmodule