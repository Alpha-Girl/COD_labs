`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/16 21:06:29
// Design Name: 
// Module Name: MEM_WB_REG
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


module MEM_WB_REG(
input clk,rst,stall,bubble,input [31:0] in_mdr,in_y,
output reg [31:0] out_mdr,out_y,
input in_RegWrite,in_MemtoReg,
input [4:0] in_wa,
output reg out_RegWrite,out_MemtoReg,
output reg [4:0] out_wa
    );
always @(posedge clk,posedge rst)
begin
    if(rst)
        begin
            {out_mdr,out_y}<=64'd0;
            {out_RegWrite,out_MemtoReg,out_wa}<=7'd0;
        end
    else
        begin
            {out_mdr,out_y}<={in_mdr,in_y};
            {out_RegWrite,out_MemtoReg,out_wa}<={in_RegWrite,in_MemtoReg,in_wa};
        end
end
endmodule
