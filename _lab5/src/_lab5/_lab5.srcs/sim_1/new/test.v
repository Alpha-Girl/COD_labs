`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/17 20:21:44
// Design Name: 
// Module Name: test
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


module test(

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
    #( PERIOD / 2);
    rst = 1;
    #( PERIOD );
    rst = 0;
  end

endmodule
