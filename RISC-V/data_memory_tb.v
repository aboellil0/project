

module data_memory_tb ();
    reg clk;
    reg [31:0] WriteData;
    reg [31:0] A; 
    reg WE;
    wire [31:0] ReadData;

    data_memory uut (
        .clk(clk),
        .WriteData(WriteData),
        .A(A),
        .WE(WE),
        .ReadData(ReadData)
    );

    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk; 
        end
    end

    initial begin
        A = 32'h00000000; 
        WriteData = 32'hDEADBEEF; 
        WE = 0;

        #10 WE = 1; 
        #10 WE = 0; 

        #10 A = 32'h00000000; 
    end
endmodule