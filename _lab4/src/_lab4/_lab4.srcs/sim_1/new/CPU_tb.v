`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/26 19:04:26
// Design Name: 
// Module Name: CPU_tb
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


module CPU_tb(

    );
reg clk, rst;

CPU cpu1( clk, rst );
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
