// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (lin64) Build 2405991 Thu Dec  6 23:36:41 MST 2018
// Date        : Thu Oct  6 11:20:17 2022
// Host        : LittleBee running 64-bit Ubuntu 22.04.1 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/fredyvia/Downloads/cache_lab_v0.05/soc_axi_lite_loongson/rtl/xilinx_ip/clk_pll/clk_pll_stub.v
// Design      : clk_pll
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tfbg676-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_pll(cpu_clk, sys_clk, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="cpu_clk,sys_clk,clk_in1" */;
  output cpu_clk;
  output sys_clk;
  input clk_in1;
endmodule
