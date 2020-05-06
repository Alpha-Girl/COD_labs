`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/06 08:04:17
// Design Name: 
// Module Name: edge_tb
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


module edge_tb(

    );
reg clk,rst,y;
wire p;
edg edg_(clk,rst,y,p);
    parameter PERIOD = 10,   	//time per cycle
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
    rst=1;
    y=0;
    
    #PERIOD;
    rst=0;
    y=1;
    #PERIOD;
    
    #PERIOD;
    #PERIOD;
    y=0;
    #PERIOD;
    y=1;
    #PERIOD;
    y=0;
    #PERIOD;
    rst=1;
    #PERIOD;
    rst=0;
    y=0;
    #PERIOD;
    y=1;
    #PERIOD;
    #PERIOD;#PERIOD;
    $finish;
  end
endmodule
