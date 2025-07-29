module up_down_counter #(parameter N = 4) (
        input clk,
        input up_down,
        output reg [N-1:0] count
    );
    
    always @(posedge clk) begin
        case (up_down)
            1'b0:
                count <= count - 1; // counting down
            1'b1:
                count <= count + 1; // counting up
            default:
                count <= count;
        endcase
    end
endmodule
