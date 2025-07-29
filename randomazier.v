
            // for (integer i = 0; i < 4; i = i + 1) begin
            //     xor1[i] = seed[13] ^ seed[14];
            //     seed = {seed[14:1], xor1[i]};
            //     out[i] = in[i] ^ xor1[i];
            // end

module randamizer (
    input [3:0] in,
    input clk,
    input rst, // async reset
    input load, // load new seed other wise is keeping the current seed
    input en, // clock enable (en) inputs 
    input [14:0] seed_in,
    output reg [3:0] out
);
    reg temp;
    reg [14:0] seed;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            out <= 0;
            seed <= 15'b011011100010101; // Initial seed value
        end
        else if (load) begin
            seed <= seed_in; // Load new seed
        end 
        else if (en) begin
            for (integer i = 0; i < 4; i = i + 1) begin
                temp = seed[13] ^ seed[14];
                seed = {seed[14:1], temp};
                out[i] <= in[i] ^ temp;
            end 
        end 
        else begin
            out <= out; // keep current output if not loading or enabling
        end
    end
endmodule