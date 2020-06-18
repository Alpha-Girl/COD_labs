`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/17 22:38:29
// Design Name: 
// Module Name: FORWARD
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


module FORWARD(
input [4:0] ID_EX_rs,ID_EX_rt,EX_MEM_wa,MEM_WB_wa,
input EX_MEM_RegWrite,MEM_WB_RegWrite,EX_MEM_MemRead,
output reg [1:0] ALUSrcA,ALUSrcB
    );
always @*
begin
    if(ID_EX_rs==5'd0)
        ALUSrcA=2'b00;
    else if(ID_EX_rs==EX_MEM_wa&&EX_MEM_MemRead==0&&EX_MEM_RegWrite==1)
        ALUSrcA=2'b10;
    else if(ID_EX_rs==EX_MEM_wa&&EX_MEM_MemRead==1&&EX_MEM_RegWrite==1)
        ALUSrcA=2'b11;
    else if(ID_EX_rs==MEM_WB_wa&&MEM_WB_RegWrite==1)
        ALUSrcA=2'b01;
    else 
        ALUSrcA=2'b00;
end
always @*
begin
    if(ID_EX_rt==5'd0)
        ALUSrcB=2'b00;
    else if(ID_EX_rt==EX_MEM_wa&&EX_MEM_MemRead==0&&EX_MEM_RegWrite==1)
        ALUSrcB=2'b10;
    else if(ID_EX_rt==EX_MEM_wa&&EX_MEM_MemRead==1&&EX_MEM_RegWrite==1)
        ALUSrcB=2'b11;
    else if(ID_EX_rt==MEM_WB_wa&&MEM_WB_RegWrite==1)
        ALUSrcB=2'b01;
    else 
        ALUSrcB=2'b00;
end
endmodule
