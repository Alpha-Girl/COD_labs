`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/16 20:37:08
// Design Name: 
// Module Name: ID_EX_REG
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


module ID_EX_REG(
input clk,rst,stall,bubble,input [31:0] in_npc,in_a,in_b,in_imm,in_ir,
output reg [31:0] out_npc,out_a,out_b,out_imm,out_ir,
input in_ALUSrc,in_RegDst,in_MemWrite,in_MemRead,in_Branch,in_RegWrite,in_MemtoReg,
input [1:0] in_ALUOp,
output reg out_ALUSrc,out_RegDst,out_MemWrite,out_MemRead,out_Branch,out_RegWrite,out_MemtoReg,
output reg [1:0] out_ALUOp
    );
always @(posedge clk,posedge rst)
begin
    if(rst)
        begin
            {out_npc,out_a,out_b,out_imm,out_ir}<=160'd0;
            {out_ALUSrc,out_RegDst,out_MemWrite,out_MemRead,out_Branch,out_RegWrite,out_MemtoReg,out_ALUOp}<=9'd0;
        end
    else
        begin
            {out_npc,out_a,out_b,out_imm,out_ir}<={in_npc,in_a,in_b,in_imm,in_ir};
            {out_ALUSrc,out_RegDst,out_MemWrite,out_MemRead,out_Branch,out_RegWrite,out_MemtoReg,out_ALUOp}<={in_ALUSrc,in_RegDst,in_MemWrite,in_MemRead,in_Branch,in_RegWrite,in_MemtoReg,in_ALUOp};
        end
end
endmodule
