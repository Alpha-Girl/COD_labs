`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/16 20:56:09
// Design Name: 
// Module Name: EX_MEM_REG
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


module EX_MEM_REG(
input clk,rst,stall,bubble,input [31:0] in_npc,in_y,in_b,
output reg [31:0] out_npc,out_y,out_b,
input in_MemWrite,in_MemRead,in_Branch,in_RegWrite,in_MemtoReg,in_zf,
input [4:0] in_wa,
output reg out_MemWrite,out_MemRead,out_Branch,out_RegWrite,out_MemtoReg,out_zf,
output reg [4:0] out_wa
    );
always @(posedge clk,posedge rst)
begin
    if(rst)
        begin
            {out_npc,out_y,out_b}<=96'd0;
            {out_MemWrite,out_MemRead,out_Branch,out_RegWrite,out_MemtoReg,out_wa,out_zf}<=12'd0;
        end
    else
        begin
            {out_npc,out_y,out_b}<={in_npc,in_y,in_b};
            {out_MemWrite,out_MemRead,out_Branch,out_RegWrite,out_MemtoReg,out_zf,out_wa}<={in_MemWrite,in_MemRead,in_Branch,in_RegWrite,in_MemtoReg,in_zf,in_wa};
        end
end
endmodule
