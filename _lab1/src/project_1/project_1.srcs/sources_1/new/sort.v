`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/04/23 22:09:47
// Design Name:
// Module Name: sort
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


module sort #( parameter N = 4 )   //数据宽度
       ( output [ N - 1: 0 ] s0, s1, s2, s3 //排序后的四个数据(递增)
         output done,   //排序结束的标志
         input [ N - 1: 0 ] x0, x1, x2, x3,   //原始输入数据
         input clk, rst //时钟（上升沿有效）、复位（高电平有效）

       );
//FSM State define
parameter LOAD = 3'd0; //装入
parameter CX01F = 3'd1; //0，1寄存器比较（First time）
parameter CX12F = 3'd2; //1，2寄存器比较（First time）
parameter CX23F = 3'd3; //0，1寄存器比较（First time）
parameter CX01S = 3'd4; //0，1寄存器比较（Second time）
parameter CX12S = 3'd5; //1，2寄存器比较（Second time）
parameter CX01T = 3'd6; //0，1寄存器比较（Third time）
parameter HLT = 3'd7; //结束

//Data Path

//Control Unit
always @( posedge clk, posedge rst )
  begin
    if ( rst )
      begin
      end

    endmodule


      module mux2 #( parameter WIDTH = 32 )   //数据宽度
      ( output [ WIDTH - 1: 0 ] y,   //输出数据
        input [ WIDTH - 1: 0 ] a, b,   //两路输入数据
        input s //数据选择控制
      );
  end
assign y = s ? b : a;
endmodule


  module mux4 #( parameter WIDTH = 32 )   //数据宽度
  ( output [ WIDTH - 1: 0 ] y,   //输出数据
    input [ WIDTH - 1: 0 ] a, b, c, d //两路输入数据
    input [ 1: 0 ] sel //数据选择控制
  );
wire [ WIDTH - 1: 0 ] result0, result1;
mux2 mux2_1( .y( result0 ), .a( a ), .b( b ), .s( sel[ 0 ] ) );
mux2 mux2_2( .y( result1 ), .a( c ), .b( d ), .s( sel[ 0 ] ) );
mux2 mux2_3( .y( y ), .a( result0 ), .b( result1 ), .s( sel[ 1 ] ) );
endmodule
