
module sequance_detector_1 (
    input clk,
    input rst,
    input in,
    output reg detected
);
    typedef enum reg [3:0] {
        s0,s1,s2,s3,s4,s5,s6,s7,s8
    } state_type;
    state_type state, next_state;
    always @(posedge clk,posedge rst) begin
        if (rst) begin
            state <= 3'b000;
        end else begin
            state <= next_state; 
        end
    end

    always @(*) begin
        case (current_state)
            S0:  next_state = in ? S1 : S0;
            S1:  next_state = in ? S1 : S2;
            S2:  next_state = in ? S3 : S0;
            S3:  next_state = in ? S1 : S4;
            S4:  next_state = in ? S5 : S0;
            S5:  next_state = in ? S1 : S6;
            S6:  next_state = in ? S7 : S0;
            S7:  next_state = in ? S1 : S8;
            S8:  next_state = in ? S1 : S0;
            default: next_state = S0;
        endcase
    end

    always @(*) begin
        detected = (current_state == S8);
    end
endmodule