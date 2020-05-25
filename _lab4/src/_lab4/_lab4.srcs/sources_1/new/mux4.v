`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/25 19:05:40
// Design Name: 
// Module Name: mux4
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


  module mux4 #( parameter WIDTH = 32 )      //data width
  ( output [ WIDTH - 1: 0 ] y,      //output data
    input [ WIDTH - 1: 0 ] a, b, c, d ,  //input data
    input [ 1: 0 ] sel //select
  );
wire [ WIDTH - 1: 0 ] result0, result1;
mux2 mux2_1( .y( result0 ), .a( a ), .b( b ), .s( sel[ 0 ] ) );
mux2 mux2_2( .y( result1 ), .a( c ), .b( d ), .s( sel[ 0 ] ) );
mux2 mux2_3( .y( y ), .a( result0 ), .b( result1 ), .s( sel[ 1 ] ) );
endmodule
