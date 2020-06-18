`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/16 08:47:11
// Design Name: 
// Module Name: IF_ID_REG
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


module IF_ID_REG(
input clk,rst,stall,bubble,input [31:0] in_pc,in_ir,output reg [31:0] out_pc,out_ir
    );
always @(posedge clk, posedge rst)
begin
    if(rst)
        begin
            out_pc<=32'd0;
            out_ir<=32'd0;
        end
    else if(bubble)
        begin
            out_pc<=32'd0;
            out_ir<=32'd0;
        end
    else
        begin
            out_pc<=in_pc;
            out_ir<=in_ir;
        end
end
endmodule
