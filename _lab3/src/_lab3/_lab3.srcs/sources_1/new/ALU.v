`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/05/11 22:08:01
// Design Name:
// Module Name: ALU
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


module alu #( parameter WIDTH = 32 )        //data width
       ( output reg [ WIDTH - 1: 0 ] y,         //output data
         output reg zf,                   //zero flag
         output reg cf,                   //carry flag
         output reg of,                   //overflow flag
         input [ WIDTH - 1: 0 ] a,
         b,                           //input data
         input [ 2: 0 ] m );
localparam ADD = 3'b000;
localparam SUB = 3'b001;
localparam AND = 3'b010;
localparam OR = 3'b011;
localparam XOR = 3'b100;
always @( * )
  begin
    case ( m )
      ADD:
        begin
          { cf, y } = a + b;
          of = ( ~a[ WIDTH - 1 ] & ~b[ WIDTH - 1 ] & y[ WIDTH - 1 ] ) | ( a[ WIDTH - 1 ] & b[ WIDTH - 1 ] & ~y[ WIDTH - 1 ] );
        end
      SUB:
        begin
          { cf, y } = a - b;
          of = ( ~a[ WIDTH - 1 ] & b[ WIDTH - 1 ] & y[ WIDTH - 1 ] ) | ( a[ WIDTH - 1 ] & ~b[ WIDTH - 1 ] & ~y[ WIDTH - 1 ] );
        end
      AND:
        y = a & b;
      OR:
        y = a | b;
      XOR:
        y = a ^ b;
      default:
        begin
          y = 0;
          cf = 0;
          of = 0;
        end
    endcase
    zf = ~|y;
  end
endmodule
