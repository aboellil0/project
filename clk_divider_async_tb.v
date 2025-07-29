


module clk_divider_async_tb (
);
    reg clk;
    reg rst;
    wire clk_2, clk_4, clk_8, clk_16;

    clk_divider_async uut (
        .clk(clk),
        .rst(rst),
        .clk_2(clk_2),
        .clk_4(clk_4),
        .clk_8(clk_8),
        .clk_16(clk_16)
    );

    initial begin
        clk = 0;
        rst = 1;
        #5 rst = 0; // Release reset after 5 time units
    end

    always begin
        #5 clk = ~clk; // Toggle clock every 5 time units
    end

    initial begin
        #100; // Run the simulation for 100 time units
        $finish; // End the simulation
    end
endmodule