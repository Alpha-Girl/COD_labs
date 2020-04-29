`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/29 21:42:25
// Design Name: 
// Module Name: register_file
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module register_file//32 x WIDTH register file
    #(parameter WIDTH =32)(//data width
    input clk,//clock
    input [4:0] ra0,//read address 0
    output [WIDTH-1:0] rd0,//read datd 0
    input [4:0] ra1,//read address 1
    output [WIDTH-1:0] rd1,//read data 1
    input [4:0] wa,//write address
    input we,//write enable
    input [WIDTH-2:0] wd//write data
    );
reg [4:0] addr_reg;
reg [WIDTH-1:0] mem[0:WIDTH-1];
initial 
    $read
endmodule
