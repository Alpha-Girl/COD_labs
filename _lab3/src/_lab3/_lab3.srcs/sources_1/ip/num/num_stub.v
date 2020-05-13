// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Wed May 13 16:14:38 2020
// Host        : DESKTOP-LP1A2G2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/Asus/Documents/GitHub/COD_labs/_lab3/src/_lab3/_lab3.srcs/sources_1/ip/num/num_stub.v
// Design      : num
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2019.1" *)
module num(a, spo)
/* synthesis syn_black_box black_box_pad_pin="a[3:0],spo[7:0]" */;
  input [3:0]a;
  output [7:0]spo;
endmodule
