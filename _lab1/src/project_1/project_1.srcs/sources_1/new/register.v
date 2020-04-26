`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/04/24 07:49:47
// Design Name:
// Module Name: register
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

module register #( parameter WIDTH = 32, RST_VALUE = 0 )
       (
         input clk, rst, en,  //clock,reset,enable
         input [ WIDTH - 1: 0 ] d,  //input data
         output reg [ WIDTH - 1: 0 ] q //output data
       );
always @( posedge clk, posedge rst )
  begin
    if ( rst )
      begin
        q <= RST_VALUE;
      end
    else if ( en )
      begin
        q <= d;
      end
  end
endmodule
