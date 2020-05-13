`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/05/13 07:50:55
// Design Name:
// Module Name: cpu_tb
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


module cpu_tb(

       );
reg clk, rst;

cpu cpu2( clk, rst );
parameter PERIOD = 10,     	//time per cycle
          CYCLE = 20;		//total cycles
initial
  begin
    clk = 0;
    repeat ( 100 * CYCLE )
      #( PERIOD / 2 ) clk = ~clk;
    $finish;
  end
initial
  begin
    rst = 0;
    #( PERIOD / 2 );
    rst = 1;
    #( PERIOD / 2 );
    rst = 0;
  end
endmodule
