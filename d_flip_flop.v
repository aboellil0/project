module d_flip_flop (
    input [31:0] D,
    input clk,rst,
    output reg [31:0] q,qn
  );
  always @(posedge clk or posedge rst)
  begin
    if (!rst)
      q <= 0;
    qn <= 0;
    else
      q <= D;
    qn <= ~D;
  end
endmodule
