`timescale 1ps / 1ps

module binary_to_graycode (
    input [7:0] binary_in,
    output reg [7:0] gray_out
);
    always @(*) begin
        gray_out[7] = binary_in[7]; // MSB remains the same
        gray_out[6] = binary_in[7] ^ binary_in[6];
        gray_out[5] = binary_in[6] ^ binary_in[5];
        gray_out[4] = binary_in[5] ^ binary_in[4];
        gray_out[3] = binary_in[4] ^ binary_in[3];
        gray_out[2] = binary_in[3] ^ binary_in[2];
        gray_out[1] = binary_in[2] ^ binary_in[1];
        gray_out[0] = binary_in[1] ^ binary_in[0]; // LSB
    end
endmodule


module binary_to_graycode #(parameter  N= 8) (
    input [N-1:0] binary_in,
    output reg [N-1:0] gray_out
);
    always @(*) begin
        gray_out[N-1] = binary_in[N-1];

        for (integer i = N-2; i >= 0; i = i - 1) begin
            gray_out[i] = binary_in[i+1] ^ binary_in[i];
        end 
    end
endmodule