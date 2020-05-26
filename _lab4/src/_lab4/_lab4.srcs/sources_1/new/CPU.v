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
wire zf,cf,of,we,mem_we,r_ao,r_rf0,r_rf1,r_ins,r_data,PCwe;
reg PCWriteCond,PCWrite,IorD,MemRead,MemWrite,MemtoReg,IRWrite,ALUSrcA,RegWrite,RegDst;
reg [1:0] ALUSrcB,PCSource,ALUOp;
wire [8:0] mem_addr;
wire [4:0] ra0,ra1,wa;
reg [2:0] alu_m;
wire [1:0] PCSrc;
mem MEMORY(mem_addr,mem_wd,clk,MemWrite,mem_out);
alu ALU1(alu_result,zf,cf,of,alu_a,alu_b,alu_m);
register #(32) REG_ALU_OUT(alu_result,r_ao,rst,alu_out);
register #(32) REG_FILE0(rd0,r_rf0,rst,read0);
register #(32) REG_FILE1(rd1,r_rf1,rst,read1);
register #(32) REG_INST(mem_out,IRWrite,rst,instr);
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
reg [3:0] status,next_status;
always @(posedge clk,posedge rst) begin
    if(rst)
        status<=4'd0;
    else
        status<=next_status;
end
always @(posedge clk,posedge rst) begin
    
    if(rst)
        next_status<=4'd0;
    else
        case(status)
        4'd0:next_status<=4'd1;
        4'd1:begin
            if({instr[31:30],instr[28:26]}==5'b10011)
                next_status<=4'd2;
            else if({instr[31:30],instr[28:26]}==5'b00000)
                next_status<=4'd6;
            else if(instr[31:26]==6'b000100)
                next_status<=4'd8;
            else if(instr[31:26]==6'b000010)
                next_status<=4'd9;
            else
                next_status<=4'd0;
        end
        4'd2:begin
            if(instr[29]==1'b1)
                next_status<=4'd5;
            else
                next_status<=4'd3;
        end
        4'd3:next_status<=4'd4;
        4'd4:next_status<=4'd0;
        4'd5:next_status<=4'd0;
        4'd6:next_status<=4'd7;
        4'd7:next_status<=4'd0;
        4'd8:next_status<=4'd0;
        4'd9:next_status<=4'd0;
        default:next_status<=4'd0;
        endcase
end
always @(*)begin
    {PCWriteCond,PCWrite,IorD,MemRead,MemWrite,MemtoReg,IRWrite,PCSource,ALUOp,ALUSrcB,ALUSrcA,RegWrite,RegDst}=16'd0;
    case(status)
    4'd0:begin
        MemRead=1'b1;
        IRWrite=1'b1;
        ALUSrcB=2'b1;
        PCWrite=1'b1;
    end
    4'd1:begin
        ALUSrcB=2'b11;
    end
    4'd2:begin
        ALUSrcA=1'b1;
        ALUSrcB=2'b10;
    end
    4'd3:begin
        MemRead=1'b1;
        IorD=1'b1;
    end
    4'd4:begin
        RegWrite=1'b1;
        MemtoReg=1'b1;
    end
    4'd5:begin
        MemWrite=1'b1;
        IorD=1'b1;
    end
    4'd6:begin
        ALUSrcA=1'b1;
        ALUOp=2'b10;   
    end
    4'd7:begin
        RegDst=1'b1;
        RegWrite=1'b1;
    end
    4'd8:begin
        ALUSrcA=1'b1;
        ALUOp=2'b01;
        PCWriteCond=1'b1;
        PCSource=2'b01;
    end
    4'd9:begin
        PCWrite=1'b1;
        PCSource=2'b10;
    end
    endcase
end

always @*
    begin
        case(ALUOp)
            2'b10:alu_m=3'b000;
            2'b01:alu_m=3'b001;
        endcase
    end
endmodule
