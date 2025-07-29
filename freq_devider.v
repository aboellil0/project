// make frequancy devider from 50Mhz 
`timescale 1ns / 1ps
module moduleName (
    input clk, 
    input rst, 
    output reg clk_out 
);
    reg [25:0] counter; // 

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            clk_out <= 0;
        end else begin
            if (counter == 25000000) begin 
                clk_out <= ~clk_out; // toggle 
                counter <= 0; // reset the counter
            end else begin
                counter <= counter + 1; // increment the counter
            end
        end
    end
endmodule