`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/10 17:57:02
// Design Name: 
// Module Name: REG_FILE
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


module REG_FILE//32 x WIDTH register file
       #( parameter WIDTH = 32 ) (  //data width
         input clk,  //clock
         input [ 4: 0 ] ra0,  //read address 0
         output [ WIDTH - 1: 0 ] rd0,  //read data 0
         input [ 4: 0 ] ra1,  //read address 1
         output [ WIDTH - 1: 0 ] rd1,  //read data 1
         input [ 4: 0 ] wa,  //write address
         input we,  //write enable
         input [ WIDTH - 1: 0 ] wd //write data
       );
wire [WIDTH-1:0] real_wd;
reg [ WIDTH - 1: 0 ] mem[ 0: WIDTH - 1 ];
initial
  $readmemh( "C:/Users/Asus/Documents/GitHub/COD_labs/_lab3/src/_lab3/_lab3.srcs/sources_1/new/rf.txt", mem );
assign real_wd=(wa==5'd0)?32'd0:wd;
assign rd0 = mem[ ra0 ];
assign rd1 = mem[ ra1 ];

always @*
  begin
    if ( we )
      begin
        mem[ wa ] = real_wd;
      end
  end
endmodule
