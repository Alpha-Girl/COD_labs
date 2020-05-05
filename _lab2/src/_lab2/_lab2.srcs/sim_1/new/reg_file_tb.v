`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/05 22:05:08
// Design Name: 
// Module Name: reg_file_tb
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


module reg_file_tb(

    );
reg clk,we;
reg [4:0] ra0,ra1,wa;
wire [31:0] rd0,rd1,wd;
  register_file
    #(32) ss(
    clk,
    ra0,
    rd0,
    ra1,
    rd1,//read data 1
    wa,//write address
    we,//write enable
   wd//write data
    );
reg [31:0] wd_r;
assign wd=wd_r;
    parameter PERIOD = 10,   	//time per cycle
          CYCLE = 20;		//total cycles
    initial
  begin
    clk = 0;
    repeat ( 3 * CYCLE )
      #( PERIOD / 2 ) clk = ~clk;
    $finish;
  end
initial
  begin
    ra0 = 5'b0;      		//ADD
    ra1 = 5'b0011;
    wa = 5'b1;
    we = 0;
    
    #PERIOD;
    wa=5'b0;
    wd_r=32'b1;
    we=1;
    ra1=5'd31;
    #PERIOD;
    wa=5'b1;
    wd_r=32'ha5a5;
    we=1;
    ra0=5'b1;
    ra1=5'd30;
    #PERIOD;
    $finish;
  end
endmodule
