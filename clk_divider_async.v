

module clk_divider_async (
    input clk,
    input rst,
    output reg clk_2,clk_4, clk_8,clk_16
);

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            clk_2 <= 0;
            clk_4 <= 0;
            clk_8 <= 0;
            clk_16 <= 0;
        end else begin
            clk_2 <= ~clk_2;
        end
    end

    always @(posedge clk_2, posedge rst) begin
        if (rst) begin
            clk_2 <= 0;
            clk_4 <= 0;
            clk_8 <= 0;
            clk_16 <= 0;
        end else begin
            clk_4 <= ~clk_4;
        end
    end

    always @(posedge clk_4, posedge rst) begin
        if (rst) begin
            clk_2 <= 0;
            clk_4 <= 0;
            clk_8 <= 0;
            clk_16 <= 0;
        end else begin
            clk_8 <= ~clk_8;
        end
    end

    always @(posedge clk_8, posedge rst) begin
        if (rst) begin
            clk_2 <= 0;
            clk_4 <= 0;
            clk_8 <= 0;
            clk_16 <= 0;
        end else begin
            clk_16 <= ~clk_16;
        end
    end
endmodule
