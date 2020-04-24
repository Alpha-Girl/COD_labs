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
wire [WIDTH-1:0] r0,r1,r2,r3,i0,i1,i2,i3,a,y;
wire zf,cf,of;
//Data Path
register R0(clk,rst,en0,i0,r0),
register R1(clk,rst,en1,i1,r1),
register R2(clk,rst,en2,i2,r2),
register R3(clk,rst,en3,i3,r3);
alu ALU #( WIDTH) (y,zf,,cf,of,a,r1,3'b001);
mux4 M4(m0,r0,r1,r2,r3,a);
mux4 M0(m0,x0,r1,r2,r3,a);
//Control Unit
always @( posedge clk, posedge rst )
  begin
    if ( rst )
      begin
      end
  end
endmodule


