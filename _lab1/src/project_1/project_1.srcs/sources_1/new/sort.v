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
wire [WIDTH-1:0] r0,r1,r2,r3,i0,i1,i2,i3,a,b;
wire zf,cf,of;
wire en0,en1,en2,en3;
wire [1:0] sel0,sel1,sel2,sel3,sela,selb;
reg [2:0] current_state,next_state;
//Data Path
register R0(clk,rst,en0,i0,r0);
register R1(clk,rst,en1,i1,r1);
register R2(clk,rst,en2,i2,r2);
register R3(clk,rst,en3,i3,r3);
alu ALU #(WIDTH) (y,zf,cf,of,a,b,3'b001);
mux4 M0(i0,x0,r1,r2,r3,sel0);
mux4 M1(i1,r0,x1,r2,r3,sel1);
mux4 M2(i2,r0,r1,x2,r3,sel2);
mux4 M3(i3,r0,r1,r2,x3,sel3);
mux4 compare_a(a,r0,r1,r2,r3,sela);
mux4 compare_b(b,r0,r1,r2,r3,selb);
//Control Unit
always @( posedge clk, posedge rst )
  
    if ( rst )
      current_state<=LOAD;
    else 
           current_state<=next_state ;
always@(*)begin

  case(current_state)
  LOAD :next_state = CX01F;
  CX01F:next_state =CX12F;
  CX12F:next_state=CX23F;
  CX23F:next_state=CX01S;
  CX01S:next_state=CX12S;
  CX12S:next_state=CX01T;
  CX01T=next_state=HLT;
  HLT:next_state=HLT;
  default:next_state=HLT;
  endcase
end  
always@(*)begin
{en0,en1,en2,en3,done}=5'b0;
case(current_state)
LOAD:begin{sel0,sel1,sel2,sel3}=8'b00011011;
{en0,en1,en2,en3}=4'b1111;
end
CX01F,CX01S,CX01T:begin
  {sela,selb}=4'b0001;
  {sel0,sel1}=4'b0100;
  en0=~cf;
  en1=~cf;
end
CX12F,CX12S:begin
  {sela,selb}=4'b0110;
  {sel1,sel2}=4'b1001;
  en1=~cf;
  en2=~cf;
end
CX23F:begin
{sela,selb}=4'b1011;
  {sel2,sel3}=4'b1110;
  en0=~cf;
  en1=~cf;
  end
HLT:done=1;
endcase
end  
endmodule


