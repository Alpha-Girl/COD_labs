`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/15 21:57:41
// Design Name: 
// Module Name: CPU
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


module CPU(
input clk,rst//clock,reset
    );
wire [31:0] npc,pc,ins_mem_out,pc_add_4,read_data0,read_data1,write_data,EX_MEM_b,EX_MEM_y,data_mem_out,alu_out,ID_EX_a,alu_b,j_npc,ID_EX_imm,ID_EX_npc;
wire [31:0] IF_ID_npc,IF_ID_ir,real_npc;
wire [31:0] ID_EX_npc_i,ID_EX_a_i,ID_EX_b_i,ID_EX_imm_i,ID_EX_ir_i,
ID_EX_npc_o,ID_EX_a_o,ID_EX_b_o,ID_EX_imm_o,ID_EX_ir_o;
wire [31:0] EX_MEM_npc_i,EX_MEM_y_i,EX_MEM_b_i,wd,
EX_MEM_npc_o,EX_MEM_y_o,EX_MEM_b_o;
wire [31:0] MEM_WB_mdr_i,MEM_WB_y_i,
MEM_WB_mdr_o,MEM_WB_y_o;
wire [4:0] read_add0,read_add1,write_add,EX_MEM_wa_i,EX_MEM_wa_o,MEM_WB_wa_i,MEM_WB_wa_o;
reg [2:0] alu_m;
wire RegWrite,MemWrite,zf,cf,of,PCSrc;
reg ID_EX_ALUSrc_i,ID_EX_RegDst_i,ID_EX_MemWrite_i,ID_EX_MemRead_i,ID_EX_Branch_i,ID_EX_RegWrite_i,ID_EX_MemtoReg_i;
wire ID_EX_ALUSrc_o,ID_EX_RegDst_o,ID_EX_MemWrite_o,ID_EX_MemRead_o,ID_EX_Branch_o,ID_EX_RegWrite_o,ID_EX_MemtoReg_o;
wire EX_MEM_MemWrite_i,EX_MEM_MemRead_i,EX_MEM_Branch_i,EX_MEM_RegWrite_i,EX_MEM_MemtoReg_i,EX_MEM_zf_i;
wire EX_MEM_MemWrite_o,EX_MEM_MemRead_o,EX_MEM_Branch_o,EX_MEM_RegWrite_o,EX_MEM_MemtoReg_o,EX_MEM_zf_o;
wire MEM_WB_RegWrite_i,MEM_WB_MemtoReg_i,MEM_WB_RegWrite_o,MEM_WB_MemtoReg_o;
wire [1:0] ID_EX_ALUOp_o;
reg [1:0] ID_EX_ALUOp_i;
INS_MEM INS_MEM0(pc[9:2],32'd0,clk,0,ins_mem_out);
DATA_MEM DATA_MEM0(EX_MEM_y_o[9:2],EX_MEM_b_o,clk,EX_MEM_MemWrite_o,MEM_WB_mdr_i);
ALU ALU0(alu_out,EX_MEM_zf_i,cf,of,ID_EX_a,alu_b,alu_m);
assign pc_add_4=pc+32'd4;
assign EX_MEM_npc_i = (ID_EX_imm<<2)+ID_EX_npc_o;
REG_FILE REG_FILE0(clk,IF_ID_ir[25:21],ID_EX_a_i,IF_ID_ir[20:16],ID_EX_a_i,MEM_WB_wa_o,MEM_WB_RegWrite_o,write_data);
IF_ID_REG IF_ID_REG0(clk,rst,0,0,pc_add_4,ins_mem_out,IF_ID_npc,IF_ID_ir);
ID_EX_REG ID_EX_REG0(clk,rst,0,0,ID_EX_npc_i,ID_EX_a_i,ID_EX_b_i,ID_EX_imm_i,ID_EX_ir_i,
ID_EX_npc_o,ID_EX_a_o,ID_EX_b_o,ID_EX_imm_o,ID_EX_ir_o,
ID_EX_ALUSrc_i,ID_EX_RegDst_i,ID_EX_MemWrite_i,ID_EX_MemRead_i,ID_EX_Branch_i,ID_EX_RegWrite_i,ID_EX_MemtoReg_i,ID_EX_ALUOp_i,
ID_EX_ALUSrc_o,ID_EX_RegDst_o,ID_EX_MemWrite_o,ID_EX_MemRead_o,ID_EX_Branch_o,ID_EX_RegWrite_o,ID_EX_MemtoReg_o,ID_EX_ALUOp_o);
EX_MEM_REG EX_MEM_REG0(clk,rst,0,0,EX_MEM_npc_i,EX_MEM_y_i,EX_MEM_b_i,
EX_MEM_npc_o,EX_MEM_y_o,EX_MEM_b_o,
EX_MEM_MemWrite_i,EX_MEM_MemRead_i,EX_MEM_Branch_i,EX_MEM_RegWrite_i,EX_MEM_MemtoReg_i,EX_MEM_zf_i,EX_MEM_wa_i,
EX_MEM_MemWrite_o,EX_MEM_MemRead_o,EX_MEM_Branch_o,EX_MEM_RegWrite_o,EX_MEM_MemtoReg_o,EX_MEM_zf_o,EX_MEM_wa_o);
MEM_WB_REG MEM_WB_REG(clk,rst,0,0,MEM_WB_mdr_i,MEM_WB_y_i,
MEM_WB_mdr_o,MEM_WB_y_o,
MEM_WB_RegWrite_i,MEM_WB_MemtoReg_i,MEM_WB_wa_i,
MEM_WB_RegWrite_o,MEM_WB_MemtoReg_o,MEM_WB_wa_o);
assign write_data=MEM_WB_MemtoReg_o?MEM_WB_mdr_o:MEM_WB_y_o;
assign ID_EX_imm=IF_ID_ir[15]?{16'hffff,IF_ID_ir[15:0]}:{16'h0000,IF_ID_ir[15:0]};
assign ID_EX_ir_i=IF_ID_ir;
assign PCSrc=EX_MEM_Branch_o&EX_MEM_zf_o;
assign npc=PCSrc?EX_MEM_npc_o:pc_add_4;
assign real_npc=(pc[31:26]==6'b000010)?{pc_add_4[31:28],pc[25:0],2'b00}:npc;
register register0(real_npc,clk,1,rst,pc);
assign EX_MEM_wa_i=ID_EX_RegDst_o?ID_EX_ir_o[15:11]:ID_EX_ir_o[20:16];
//alu control
always @*
begin
    case(ID_EX_ALUOp_o)
        2'b00:alu_m=3'b0;
        2'b01:alu_m=3'b1;
        2'b10:if(ID_EX_ir_o[5:0]==6'b100000)
                alu_m=3'b0;
        default:alu_m=3'b0;
    endcase
end
//control
always @*
begin
    case(IF_ID_ir[31:26])
    //add
        6'b0:{ID_EX_ALUSrc_i,ID_EX_RegDst_i,ID_EX_MemWrite_i,ID_EX_MemRead_i,ID_EX_Branch_i,ID_EX_RegWrite_i,ID_EX_MemtoReg_i,ID_EX_ALUOp_i}=9'b010001010;
        //addi
        6'b001000:{ID_EX_ALUSrc_i,ID_EX_RegDst_i,ID_EX_MemWrite_i,ID_EX_MemRead_i,ID_EX_Branch_i,ID_EX_RegWrite_i,ID_EX_MemtoReg_i,ID_EX_ALUOp_i}=9'b100001000;
        //lw
        6'b100011:{ID_EX_ALUSrc_i,ID_EX_RegDst_i,ID_EX_MemWrite_i,ID_EX_MemRead_i,ID_EX_Branch_i,ID_EX_RegWrite_i,ID_EX_MemtoReg_i,ID_EX_ALUOp_i}=9'b100101100;
        //sw
        6'b101011:{ID_EX_ALUSrc_i,ID_EX_RegDst_i,ID_EX_MemWrite_i,ID_EX_MemRead_i,ID_EX_Branch_i,ID_EX_RegWrite_i,ID_EX_MemtoReg_i,ID_EX_ALUOp_i}=9'b101000000;
        //beq
        6'b000100:{ID_EX_ALUSrc_i,ID_EX_RegDst_i,ID_EX_MemWrite_i,ID_EX_MemRead_i,ID_EX_Branch_i,ID_EX_RegWrite_i,ID_EX_MemtoReg_i,ID_EX_ALUOp_i}=9'b000010001;
        //j
        6'b000010:{ID_EX_ALUSrc_i,ID_EX_RegDst_i,ID_EX_MemWrite_i,ID_EX_MemRead_i,ID_EX_Branch_i,ID_EX_RegWrite_i,ID_EX_MemtoReg_i,ID_EX_ALUOp_i}=9'b000000000;
    endcase
end
endmodule
