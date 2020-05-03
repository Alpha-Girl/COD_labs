`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/03 11:24:54
// Design Name: 
// Module Name: fifo
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


module fifo(
    input clk,rst,//clock,reset
    input [7:0] din,//enqueue data
    input en_in,//enqueue enable
    input en_out,//dequeue enable
    output [7:0] dout, //dequeue data
    output [3:0] count //length of queue
    );

endmodule
