`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/19 11:53:23
// Design Name: 
// Module Name: register
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


module register#(parameter WIDTH=32)(input [WIDTH-1:0] in_data,
input clk,rst,
output reg [WIDTH-1:0] out_data

    );
    always @(posedge clk,posedge rst)
    begin
        if(rst)
            out_data<=32'b0;
        else
            out_data<=in_data;
    end
endmodule
