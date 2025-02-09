`ifndef SHIFT_REGISTER_V
`define SHIFT_REGISTER_V

module ShiftRegister
#(
  parameter nbits=8
)(
  input  wire             clk,
  input  wire             rst,
  input  wire             en,
  input  wire             shift_in,
  input  wire [nbits-1:0] seed,
  output wire [nbits-1:0] q
);

  always_ff @(posedge clk) begin
    if(rst)
      q <= seed;
    else if(en) begin
      for(int i = 0; i < nbits-1; i++)
        q[i] <= q[i+1];
      q[nbits-1] <= shift_in;
    end
    else
      q <= q;
  end

endmodule

`endif