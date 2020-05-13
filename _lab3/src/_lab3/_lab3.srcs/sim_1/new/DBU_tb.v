`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/05/13 15:26:32
// Design Name:
// Module Name: DBU_tb
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


module DBU_tb(

       );

reg succ, step, rst, m_rf, inc, dec, clk;
reg [ 2: 0 ] sel;
wire [ 15: 0 ] led;
wire [ 7: 0 ] an, seg;
DBU DBU1( clk, succ, step, rst, sel, m_rf, inc, dec, led, an, seg );
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
    step = 0;
    #( PERIOD / 2 );
    repeat ( 100 * CYCLE )
      #( PERIOD * 2 ) step = ~step;
    $finish;
  end
initial
  begin
    succ = 0;
    inc = 0;
    dec = 0;
    rst = 1;
    sel = 3'd0;
    m_rf = 0;
    #PERIOD;

    rst = 1;
    #PERIOD;
    inc = 1;
    rst = 0;

    #PERIOD;

    #PERIOD;
    sel = 3'd1;

    #PERIOD;

    #PERIOD;
    sel = 3'd2;

    #PERIOD;
    sel = 3'd3;

    m_rf = 1;
    #PERIOD;
    sel = 3'd4;

    #PERIOD;
    sel = 3'd5;

    #PERIOD;
    sel = 3'd6;

    #PERIOD;
    sel = 3'd7;

  end
endmodule
