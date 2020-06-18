`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/18 19:36:39
// Design Name: 
// Module Name: CPU_1
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


module CPU_1(

input clk,rst//clock,reset
    );
wire [31:0] npc,pc,ins_mem_out,pc_add_4,write_data,real_alu_b;
wire [31:0] IF_ID_npc,IF_ID_ir,real_npc,alu_a,alu_b;
wire [31:0] ID_EX_npc_i,ID_EX_a_i,ID_EX_b_i,ID_EX_imm_i,ID_EX_ir_i,
ID_EX_npc_o,ID_EX_a_o,ID_EX_b_o,ID_EX_imm_o,ID_EX_ir_o;
wire [31:0] EX_MEM_npc_i,EX_MEM_y_i,EX_MEM_b_i,
EX_MEM_npc_o,EX_MEM_y_o,EX_MEM_b_o;
wire [31:0] MEM_WB_mdr_i,MEM_WB_y_i,
MEM_WB_mdr_o,MEM_WB_y_o;
wire [4:0] EX_MEM_wa_i,EX_MEM_wa_o,MEM_WB_wa_i,MEM_WB_wa_o;
reg [2:0] alu_m;
wire [1:0] ALUSrcA,ALUSrcB;
wire cf,of,PCSrc;
reg IF_ID_stall,IF_ID_bubble,ID_EX_stall,ID_EX_bubble,EX_MEM_stall,EX_MEM_bubble,MEM_WB_stall,MEM_WB_bubble;
reg ID_EX_ALUSrc_i,ID_EX_RegDst_i,ID_EX_MemWrite_i,ID_EX_MemRead_i,ID_EX_Branch_i,ID_EX_RegWrite_i,ID_EX_MemtoReg_i;
wire ID_EX_ALUSrc_o,ID_EX_RegDst_o,ID_EX_MemWrite_o,ID_EX_MemRead_o,ID_EX_Branch_o,ID_EX_RegWrite_o,ID_EX_MemtoReg_o;
wire EX_MEM_MemWrite_i,EX_MEM_MemRead_i,EX_MEM_Branch_i,EX_MEM_RegWrite_i,EX_MEM_MemtoReg_i,EX_MEM_zf_i;
wire EX_MEM_MemWrite_o,EX_MEM_MemRead_o,EX_MEM_Branch_o,EX_MEM_RegWrite_o,EX_MEM_MemtoReg_o,EX_MEM_zf_o;
wire MEM_WB_RegWrite_i,MEM_WB_MemtoReg_i,MEM_WB_RegWrite_o,MEM_WB_MemtoReg_o;
wire [1:0] ID_EX_ALUOp_o;
reg [1:0] ID_EX_ALUOp_i;
assign real_alu_b=ID_EX_ALUSrc_o?ID_EX_imm_o:alu_b;
INS_MEM_1 INS_MEM_1_0(pc[9:2],32'd0,clk,0,ins_mem_out);
DATA_MEM_1 DATA_MEM_1_0(EX_MEM_y_o[9:2],EX_MEM_b_o,clk,EX_MEM_MemWrite_o,MEM_WB_mdr_i);
ALU ALU0(EX_MEM_y_i,EX_MEM_zf_i,cf,of,alu_a,real_alu_b,alu_m);
assign pc_add_4=pc+32'd4;
assign EX_MEM_npc_i = (ID_EX_imm_o<<2)+ID_EX_npc_o;
REG_FILE REG_FILE0(clk,IF_ID_ir[25:21],ID_EX_a_i,IF_ID_ir[20:16],ID_EX_b_i,MEM_WB_wa_o,MEM_WB_RegWrite_o,write_data);
IF_ID_REG IF_ID_REG0(clk,rst,0,IF_ID_bubble,pc_add_4,ins_mem_out,IF_ID_npc,IF_ID_ir);
ID_EX_REG ID_EX_REG0(clk,rst,0,ID_EX_bubble,ID_EX_npc_i,ID_EX_a_i,ID_EX_b_i,ID_EX_imm_i,ID_EX_ir_i,
ID_EX_npc_o,ID_EX_a_o,ID_EX_b_o,ID_EX_imm_o,ID_EX_ir_o,
ID_EX_ALUSrc_i,ID_EX_RegDst_i,ID_EX_MemWrite_i,ID_EX_MemRead_i,ID_EX_Branch_i,ID_EX_RegWrite_i,ID_EX_MemtoReg_i,ID_EX_ALUOp_i,
ID_EX_ALUSrc_o,ID_EX_RegDst_o,ID_EX_MemWrite_o,ID_EX_MemRead_o,ID_EX_Branch_o,ID_EX_RegWrite_o,ID_EX_MemtoReg_o,ID_EX_ALUOp_o);
EX_MEM_REG EX_MEM_REG0(clk,rst,0,EX_MEM_bubble,EX_MEM_npc_i,EX_MEM_y_i,EX_MEM_b_i,
EX_MEM_npc_o,EX_MEM_y_o,EX_MEM_b_o,
EX_MEM_MemWrite_i,EX_MEM_MemRead_i,EX_MEM_Branch_i,EX_MEM_RegWrite_i,EX_MEM_MemtoReg_i,EX_MEM_zf_i,EX_MEM_wa_i,
EX_MEM_MemWrite_o,EX_MEM_MemRead_o,EX_MEM_Branch_o,EX_MEM_RegWrite_o,EX_MEM_MemtoReg_o,EX_MEM_zf_o,EX_MEM_wa_o);
MEM_WB_REG MEM_WB_REG(clk,rst,0,0,MEM_WB_mdr_i,MEM_WB_y_i,
MEM_WB_mdr_o,MEM_WB_y_o,
MEM_WB_RegWrite_i,MEM_WB_MemtoReg_i,MEM_WB_wa_i,
MEM_WB_RegWrite_o,MEM_WB_MemtoReg_o,MEM_WB_wa_o);
assign write_data=MEM_WB_MemtoReg_o?MEM_WB_mdr_o:MEM_WB_y_o;
assign ID_EX_imm_i=IF_ID_ir[15]?{16'hffff,IF_ID_ir[15:0]}:{16'h0000,IF_ID_ir[15:0]};
assign ID_EX_ir_i=IF_ID_ir;
assign PCSrc=EX_MEM_Branch_o&EX_MEM_zf_o;
assign npc=PCSrc?EX_MEM_npc_o:real_npc;
assign real_npc=(ins_mem_out[31:26]==6'b000010)?{pc_add_4[31:28],ins_mem_out[25:0],2'b00}:pc_add_4;
register register0(npc,clk,1,rst,pc);
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
    if(rst)
        {ID_EX_ALUSrc_i,ID_EX_RegDst_i,ID_EX_MemWrite_i,ID_EX_MemRead_i,ID_EX_Branch_i,ID_EX_RegWrite_i,ID_EX_MemtoReg_i,ID_EX_ALUOp_i}=9'b000000000;
    else
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
        default:{ID_EX_ALUSrc_i,ID_EX_RegDst_i,ID_EX_MemWrite_i,ID_EX_MemRead_i,ID_EX_Branch_i,ID_EX_RegWrite_i,ID_EX_MemtoReg_i,ID_EX_ALUOp_i}=9'b000000000;
    endcase
end
assign ID_EX_npc_i=IF_ID_npc;
assign EX_MEM_b_i=alu_b;
assign EX_MEM_Branch_i=ID_EX_Branch_o;
assign EX_MEM_MemWrite_i=ID_EX_MemWrite_o;
assign EX_MEM_MemRead_i=ID_EX_MemRead_o;
assign EX_MEM_RegWrite_i=ID_EX_RegWrite_o;
assign EX_MEM_MemtoReg_i=ID_EX_MemtoReg_o;
assign MEM_WB_MemtoReg_i=EX_MEM_MemtoReg_o;
assign MEM_WB_RegWrite_i=EX_MEM_RegWrite_o;
assign MEM_WB_wa_i=EX_MEM_wa_o;
assign MEM_WB_y_i=EX_MEM_y_o;
//forwarding unit
FORWARD FORWARD0(ID_EX_ir_o[25:21],ID_EX_ir_o[20:16],EX_MEM_wa_o,MEM_WB_wa_o,EX_MEM_RegWrite_o,MEM_WB_RegWrite_o,EX_MEM_MemRead_o,ALUSrcA,ALUSrcB);
mux4 muxa(alu_a,ID_EX_a_o,write_data,EX_MEM_y_o,MEM_WB_mdr_i,ALUSrcA);
mux4 muxb(alu_b,ID_EX_b_o,write_data,EX_MEM_y_o,MEM_WB_mdr_i,ALUSrcB);
//hazard
always @*
begin
    if(PCSrc)
        {IF_ID_bubble,ID_EX_bubble,EX_MEM_bubble}<=3'b111;
    else
        {IF_ID_bubble,ID_EX_bubble,EX_MEM_bubble}<=3'b000;
end
endmodule
