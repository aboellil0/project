

module three_1_mux_tb (
);
    reg [31:0] a, b, c;
    reg [1:0] sel;
    wire [31:0] out;

    three_1_mux uut (
        .a(a),
        .b(b),
        .c(c),
        .sel(sel),
        .out(out)
    );

    initial begin
        a = 32'h00000001; b = 32'h00000002; c = 32'h00000003; 
        sel = 2'b00;
        #10;
        sel = 2'b01;
        #10;
        sel = 2'b10;
        #10;
        sel = 2'b11; 
        #10;
        $finish;
    end
endmodule