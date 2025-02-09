/*
 * Copyright (c) 2024 Junyoung Sim
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none
`timescale 1ns / 1ps

module tt_um_lfsr_jsim (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  wire       rst;
  wire       en;
  wire [3:0] tap;
  wire [3:0] seed;
  wire       out;

  assign rst  = ~rst_n;
  assign en   = uio_in[0];
  assign tap  = ui_in[7:4];
  assign seed = ui_in[3:0];

  LFSR #(4) lfsr4b
  (
    .clk  (clk),
    .rst  (rst),
    .en   (en),
    .tap  (tap),
    .seed (seed),
    .out  (out)
  );

  assign uo_out[0] = out;

  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out[7:1] = 0;
  assign uio_out     = 0;
  assign uio_oe      = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ uio_in[7:1], ena };

endmodule
