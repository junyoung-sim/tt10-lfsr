`ifndef LFSR_V
`define LFSR_V

`include "ShiftRegister.v"

module LFSR
#(
  parameter nbits=8
)(
  input  wire             clk,
  input  wire             rst,
  input  wire             en,
  input  wire [nbits-1:0] tap,
  input  wire [nbits-1:0] seed,
  output wire             out
);

  wire             shift_in;
  wire [nbits-1:0] shift_reg_q;

  ShiftRegister #(nbits) shift_reg
  (
    .clk      (clk),
    .rst      (rst),
    .en       (en),
    .shift_in (shift_in),
    .seed     (seed),
    .q        (shift_reg_q)
  );

  always_comb begin
    shift_in = shift_reg_q[0];
    for(int i = 1; i < nbits; i++) begin
      if(tap[i])
        shift_in = shift_in ^ shift_reg_q[i];
    end
  end

  assign out = shift_reg_q[0];

endmodule

`endif
