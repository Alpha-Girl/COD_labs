`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/06 14:37:20
// Design Name: 
// Module Name: fifo_new_tb
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


module fifo_new_tb(

    );
    reg clk,rst,en_in,en_out;
reg [7:0] din;
wire [7:0] dout;
wire [4:0] count;
fifo_new fifo3(clk,rst,din,en_in,en_out,dout,count);
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
  #( PERIOD / 2 );
    rst=1;      		//ADD
    en_in=0;
    en_out=0;
    din=8'hff;
    
    #(PERIOD*2);
    rst=0;      		//ADD
    en_in=1;
    en_out=0;
    din=8'ha5;
    #(PERIOD*2);
     rst=0;      		//ADD
    en_in=0;
    din=8'hff;
    #(PERIOD*2);
     rst=0;      		//ADD
    en_in=1;
    en_out=0;
    din=8'hff;
    #(PERIOD*2);
     rst=0;      		//ADD
    en_in=0;
    en_out=1;
    din=8'h45;
    #(PERIOD*2);
     rst=0;      		//ADD
    en_in=0;
    en_out=0;
    din=8'hac;
    #(PERIOD*2);
    en_in=1;
    en_out=0;
    din=8'h78;
    #(PERIOD*2);
    en_in=1;
    en_out=0;
    din=8'hac;
    #(PERIOD*2);
    en_in=0;
    en_out=0;
    din=8'haa;
    #(PERIOD*2);
    en_out=1;
    #(PERIOD*2);
    en_out=0;
    #(PERIOD*2);
    en_out=1;
    #(PERIOD*2);
    en_out=0;
    #(PERIOD*2);
    en_out=1;
    #(PERIOD*2);
    en_out=0;
    #(PERIOD*2);
    en_out=1;
    #(PERIOD*2);
    en_out=0;
    #(PERIOD*2);
    en_out=1;
    #(PERIOD*2);
     #PERIOD;
    en_out=0;
    #(PERIOD*2);
    en_out=1;
    #PERIOD;
    #(PERIOD*2);
    en_out=0;
    #(PERIOD*2);
    en_out=1;
   #(PERIOD*2);
    $finish;
  end

endmodule
