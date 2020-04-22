`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/04/22 22:17:57
// Design Name:
// Module Name: ALU
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


module alu #(parameter WIDTH = 32) //数据宽度
            (output [WIDTH-1:0]y,  //运算结果
             output zf,            //零标志
             output cf,            //进位/错位标志
             output of,            //溢出标志
             input [WIDTH-1:0] a,
             b,                    //两操作数
             input [2:0]m);
endmodule
