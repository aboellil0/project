

module state_machine (

    input clk,
    input reset,
    input taken,
    output predict
);
    reg [1:0] current_state, next_state;
    always @(posedge clk) begin
        if (reset) begin
            current_state <= 2'b00; 
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (current_state)
            2'b00: begin
                predict =1;
                if (taken) next_state = 2'b00; 
                else next_state = 2'b01; 
            end
            2'b01: begin
                predict =1;
                if (taken) next_state = 2'b00; 
                else next_state = 2'b10; 
            end
            2'b10: begin
                predict =0;
                if (taken) next_state = 2'b11; 
                else next_state = 2'b10; 
            end
            2'b11: begin
                predict =0;
                if (taken) next_state = 2'b00; 
                else next_state = 2'b10; 
            end
        endcase
    end
endmodule