`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/04/24 07:49:47
// Design Name:
// Module Name: mux
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

module mux2 #( parameter WIDTH = 32 )    //数据宽度
       ( output [ WIDTH - 1: 0 ] y,    //输出数据
         input [ WIDTH - 1: 0 ] a, b,    //两路输入数据
         input s //数据选择控制
       );
assign y = s ? b : a;
endmodule


module mux4 #( parameter WIDTH = 32 )    //数据宽度
  ( output [ WIDTH - 1: 0 ] y,    //输出数据
    input [ WIDTH - 1: 0 ] a, b, c, d //两路输入数据
    input [ 1: 0 ] sel //数据选择控制
  );
wire [ WIDTH - 1: 0 ] result0, result1;
mux2 mux2_1( .y( result0 ), .a( a ), .b( b ), .s( sel[ 0 ] ) );
mux2 mux2_2( .y( result1 ), .a( c ), .b( d ), .s( sel[ 0 ] ) );
mux2 mux2_3( .y( y ), .a( result0 ), .b( result1 ), .s( sel[ 1 ] ) );
endmodule
