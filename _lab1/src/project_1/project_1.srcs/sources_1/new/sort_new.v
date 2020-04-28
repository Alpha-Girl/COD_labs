`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/04/26 21:00:56
// Design Name:
// Module Name: sort_new
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


module sort_new #( parameter N = 4 )      //data width
       ( output reg [ N - 1: 0 ] s0, s1, s2, s3,    //output data
         output reg done,      //finish flag
         input [ N - 1: 0 ] x0, x1, x2, x3,      //input data
         input clk, rst,   //clock,reset
         input opr //1(descending) 0(incremental)
       );
//FSM State define
localparam LOAD = 3'd0; //load data
localparam CX01F = 3'd1; //compare 0 1 (First time)
localparam CX12F = 3'd2; //compare 1 2 (First time)
localparam CX23F = 3'd3; //compare 2 3 (First time)
localparam CX01S = 3'd4; //compare 0 1 (Second time)
localparam CX12S = 3'd5; //compare 1 2 (Second time)
localparam CX01T = 3'd6; //compare 0 1 (Third time)
localparam HLT = 3'd7; //hlt
wire [ N - 1: 0 ] r0, r1, r2, r3, i0, i1, i2, i3, a, b, y;
wire zf, cf, of;
reg flag;
reg en0, en1, en2, en3;
reg [ 1: 0 ] sel0, sel1, sel2, sel3, sela, selb;
reg [ 2: 0 ] current_state, next_state;
//Data Path
register R0( clk, rst, en0, i0, r0 );
register R1( clk, rst, en1, i1, r1 );
register R2( clk, rst, en2, i2, r2 );
register R3( clk, rst, en3, i3, r3 );
alu #( N ) ALU ( y, zf, cf, of, a, b, 3'b001 );
mux4 M0( i0, x0, r1, r2, r3, sel0 );
mux4 M1( i1, r0, x1, r2, r3, sel1 );
mux4 M2( i2, r0, r1, x2, r3, sel2 );
mux4 M3( i3, r0, r1, r2, x3, sel3 );
mux4 compare_a( a, r0, r1, r2, r3, sela );
mux4 compare_b( b, r0, r1, r2, r3, selb );
//Control Unit
always @( posedge clk, posedge rst )
  if ( rst )
    begin
      current_state <= LOAD;
    end
  else
    begin
      current_state <= next_state ;
    end
always@( * )
  begin
    case ( current_state )
      LOAD :
        next_state = CX01F;
      CX01F:
        next_state = CX12F;
      CX12F:
        next_state = CX23F;
      CX23F:
        next_state = CX01S;
      CX01S:
        next_state = CX12S;
      CX12S:
        next_state = CX01T;
      CX01T:
        next_state = HLT;
      HLT:
        next_state = HLT;
      default:
        next_state = HLT;
    endcase
  end

always@( * )
  begin
    { en0, en1, en2, en3, done } = 5'b0;
    flag = a[ N - 1 ] ^ b[ N - 1 ];
    case ( current_state )
      LOAD:
        begin
          { sel0, sel1, sel2, sel3 } = 8'b00011011;
          { en0, en1, en2, en3 } = 4'b1111;
        end
      CX01F, CX01S, CX01T:
        begin
          { sela, selb } = 4'b0001;
          { sel0, sel1 } = 4'b0100;
          en0 = opr^~cf ^ flag;
          en1 = opr^~cf ^ flag;
        end
      CX12F, CX12S:
        begin
          { sela, selb } = 4'b0110;
          { sel1, sel2 } = 4'b1001;
          en1 = opr^~cf ^ flag;
          en2 = opr^~cf ^ flag;
        end
      CX23F:
        begin
          { sela, selb } = 4'b1011;
          { sel2, sel3 } = 4'b1110;
          en2 = opr^~cf ^ flag;
          en3 = opr^~cf ^ flag;
        end
      HLT:
        done = 1;
    endcase
  end
always@( * )
  begin
    s0 = r0;
    s1 = r1;
    s2 = r2;
    s3 = r3;
  end
endmodule
