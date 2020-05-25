`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/17 09:34:33
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
wire [31:0] alu_result,alu_a,alu_b,alu_out,rd0,rd1,wd,read0,read1,mem_wd,mem_out,instr,mem_data,n_pc,pc,extend,SF_extend,pc_j_b,pc_j;
wire zf,cf,of,we,mem_we,r_ao,r_rf0,r_rf1,r_ins,r_data,PCwe,ALUSrcA,RegDst,MemtoReg,IorD,PCWrite,PCWriteCond;
wire [8:0] mem_addr;
wire [4:0] ra0,ra1,wa;
wire [2:0] alu_m;
wire [1:0] ALUSrcB,PCSrc;
mem MEMORY(mem_addr,mem_wd,clk,mem_we,mem_out);
alu ALU1(alu_result,zf,cf,of,alu_a,alu_b,alu_m);
register #(32) REG_ALU_OUT(alu_result,r_ao,rst,alu_out);
register #(32) REG_FILE0(rd0,r_rf0,rst,read0);
register #(32) REG_FILE1(rd1,r_rf1,rst,read1);
register #(32) REG_INST(mem_out,r_ins,rst,instr);
register #(32) REG_MEM_DATA(mem_out,r_data,rst,mem_data);
register #(32) REG_PC(n_pc,PCwe,rst,pc);
reg_file #(32) REG_FILE(clk,instr[25:21],rd0,instr[20:16],rd1,wa,we,wd);
assign extend=instr[15]?{16'hffff,instr[15:0]}:{16'h0000,instr[15:0]};
assign SF_extend=extend<<2;
assign alu_a=ALUSrcA?read0:pc;
assign wa=RegDst?instr[15:11]:instr[20:16];
assign wd=MemtoReg?mem_data:alu_out;
assign mem_addr=IorD?{1'b1,alu_out[9:2]}:{1'b0,pc[9:2]};
assign pc_j_b=instr<<2;
assign PCwe=(zf&PCWriteCond)|PCWrite;
assign pc_j={pc[31:28],pc_j_b[27:0]};
mux4 #(32) MUX1(alu_b,read0,32'd4,extend,SF_extend,ALUSrcB);
mux4 #(32) MUX2(n_pc,alu_result,alu_out,pc_j,32'b0,PCSrc);

endmodule
