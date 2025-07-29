

module register_file_tb ();
    reg clk;
    reg rst;
    reg [4:0] A1, A2, A3;
    reg [31:0] WD3;
    reg WE3;
    wire [31:0] RD1, RD2;

    register_file uut (
        .clk(clk),
        .rst(rst),
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .WD3(WD3),
        .WE3(WE3),
        .RD1(RD1),
        .RD2(RD2)
    );

    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk; 
        end
    end

    initial begin
        rst = 1;
        A1 = 5'b00000;
        A2 = 5'b00001; 
        A3 = 5'b00010; 
        WD3 = 32'h12345678; 
        WE3 = 0;

        #10 rst = 0;

        #10 WE3 = 1; A3 = 5'b00010; WD3 = 32'h12345678;
        
        #10 WE3 = 0; A1 = 5'b00001; A2 = 5'b00010;
    end
endmodule
