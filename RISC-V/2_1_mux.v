

module two_1_mux (
    input [31:0] a,
    input [31:0] b,
    input sel,
    output reg [31:0] out
);
    always @(*) begin
        if (sel == 1'b0) begin
            out = a;
        end else begin
            out = b;
        end
    end
endmodule