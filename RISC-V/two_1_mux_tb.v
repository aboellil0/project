`timescale 1ns / 1ps


module two_1_mux_tb (
);
    reg [31:0] a, b;
    reg sel;
    wire [31:0] out;

    two_1_mux uut (
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
    );

    initial begin
        a = 32'h00000001; b = 32'h00000002; 
        sel = 1'b0;
        #10;
        sel = 1'b1;
        #10;
        $finish;
    end
endmodule