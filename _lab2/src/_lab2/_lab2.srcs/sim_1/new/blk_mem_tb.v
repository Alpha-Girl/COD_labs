`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/05 22:34:35
// Design Name: 
// Module Name: blk_mem_tb
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


module blk_mem_tb(

    );
reg clka,ena,wea;
reg [3:0] addra;
reg [7:0] dina;
wire [7:0] douta;
blk_mem_gen_0 aa(
    clka,
    ena,
    wea,
    addra ,
    dina ,
    douta 
  );
    parameter PERIOD = 10,   	//time per cycle
          CYCLE = 20;		//total cycles
    initial
  begin
    clka = 0;
    repeat ( 3 * CYCLE )
      #( PERIOD / 2 ) clka = ~clka;
    $finish;
  end
  initial
  begin
    ena=1;      		//ADD
    wea=0;
    addra=4'h0;
    dina=8'h11;
    
    #PERIOD;
    ena=1;      		//ADD
    wea=1;
    addra=4'h2;
    dina=8'h12;
    #PERIOD;
     ena=1;      		//ADD
    wea=1;
    addra=4'h1;
    dina=8'h14;
    #PERIOD;
     ena=1;      		//ADD
    wea=0;
    addra=4'h2;
    dina=8'h24;
    #PERIOD;
     ena=0;      		//ADD
    wea=1;
    addra=4'h0;
    dina=8'h2f;
    #PERIOD;
     ena=1;      		//ADD
    wea=0;
    addra=4'h1;
    dina=8'h24;
    $finish;
  end
endmodule
