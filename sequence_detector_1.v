

module sequance_detector_1 (
    input clk,
    input rst,
    input in,
    output reg detected
);
    reg [2:0] state, next_state;
    always @(posedge clk,posedge rst) begin
        if (rst) begin
            state <= 3'b000;
        end else begin
            state <= next_state; 
        end
    end
    always @(posedge clk or posedge rst) begin
        case (state)
            3'b000: next_state =in? 3'b001 : 3'b000; 
            3'b001: next_state =in? 3'b010 : 3'b001; 
            3'b010: next_state =in? 3'b011 : 3'b000; 
            3'b011: next_state =in? 3'b100 : 3'b100; 
            3'b100: next_state =in? 3'b101 : 3'b000; 
            3'b101: next_state =in? 3'b110 : 3'b110;
            3'b110: next_state =in? 3'b111 : 3'b000;
            3'b111: begin
                if (in) begin
                    next_state = 3'b001; 
                    detected = 1; 
                end else begin
                    next_state = 3'b000;
                end
            end
            default: next_state =3'b000;
        endcase
    end
endmodule