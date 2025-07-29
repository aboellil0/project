module clk_divider_by_3 (
    input clk,
    input rst,
    output reg clk_out
);
    req q1,q2,q3;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            clk_out <= 0;
            q1 <= 0;
            q2 <= 0;
        end else begin
            q1 <= ~q1 & q2;
            q2 <= ~(q2 | q1);
            q3 <= q2;
            clk_out <= q2 | q3;
        end
    end
endmodule