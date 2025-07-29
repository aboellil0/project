
// module up_down_counter #(parameter N = 4) (
//         input clk,rst,
//         input up_down,
//         output reg [N-1:0] count
//     );
    
//     always @(posedge clk or posedge rst) begin
//         if(rst) begin
//             count <= 0;
//         end
//         case (up_down)
//             1'b0:
//                 count <= count - 1; // counting down
//             1'b1:
//                 count <= count + 1; // counting up
//             default:
//                 count <= count;
//         endcase
//     end
// endmodule


module up_down_counter_tb;

    reg clk;
    reg up_down;
    wire [3:0] count;

    up_down_counter #(4) uut (
        .clk(clk),
        .up_down(up_down),
        .count(count)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end

    initial begin
        // Test counting up
        up_down = 1; // Set to count up
        #10; // Wait for some time
        $display("Count after counting up: %b", count);

        // Test counting down
        up_down = 0; // Set to count down
        #10; // Wait for some time
        $display("Count after counting down: %b", count);

        // Finish simulation
        $finish;
    end
endmodule