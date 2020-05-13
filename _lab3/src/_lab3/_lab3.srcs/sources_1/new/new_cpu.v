`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/13 17:21:25
// Design Name: 
// Module Name: new_cpu
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


module new_cpu(
    input clk,rst//clock,reset
    );
wire [31:0] n_pc,n_pc_j,n_pc_j_m,n_pc_b,n_pc_b_m;
reg [31:0] pc;
wire [4:0] wa;
wire [31:0] instruct,rs,rt,wd,ex_data,n_pc_b_b,aluout,alu_b,dataout,wd_rf,mem_r_d,alu_a;
wire zf,cf,of,b_n,zero_control; 
reg RegDst,jump,branch,MemtoReg,Memwe,ALUSrc,Regwe,mem_r_d_sel,alu_a_sel;
reg [1:0] ALUop;
reg [2:0] alu_op;
ins_a instruction(pc[9:2],instruct);
data_mem data1(mem_r_d[9:2],rt,mem_r_d[9:2],clk,Memwe,dataout);
assign alu_a=alu_a_sel?dataout:rs;
assign mem_r_d=mem_r_d_sel?rs:aluout;
assign n_pc=pc+32'd4;
assign ex_data=instruct[15]?{16'hffff,instruct[15:0]}:{16'h0000,instruct[15:0]};
assign n_pc_b_b=ex_data<<2;
assign n_pc_b=n_pc+n_pc_b_b;
assign n_pc_j={n_pc[31:28],instruct[25:0],2'd0};
assign b_n=branch&zf;
assign n_pc_b_m=b_n?n_pc_b:n_pc;
assign n_pc_j_m=jump?n_pc_j:n_pc_b_m;
assign zero_control=(wa==5'd0);
assign wd_rf=zero_control?32'd0:wd;
assign wd=MemtoReg?dataout:aluout;
assign wa=RegDst?instruct[15:11]:instruct[21:16];
reg_file reg_file1(clk,instruct[25:21],rs,instruct[20:16],rt,wa,Regwe,wd_rf);
assign alu_b=ALUSrc?ex_data:rt;
alu #(32) ALU1(aluout,zf,cf,of,rs,alu_b,alu_op);
//pc
always @(posedge clk,posedge rst)
    begin
        if(rst)
            pc<=32'd0;
        else
        pc<=n_pc_j_m;
    end
//Control Unit
always @*
    begin
        case(instruct[31:26])
        6'b000000:begin//add
                    if(instruct[5:0]==6'b100000)begin    
                    mem_r_d_sel=0;
                    alu_a_sel=0;
                    RegDst=1;
                    jump=0;
                    branch=0;
                    MemtoReg=0;
                    ALUop=2'd00;
                    Memwe=0;
                    ALUSrc=0;
                    Regwe=1;
                    end
                    else if(instruct[5:0]==6'b101000)begin
                    mem_r_d_sel=1;
                    alu_a_sel=1;
                    RegDst=1;
                    jump=0;
                    branch=0;
                    MemtoReg=0;
                    ALUop=2'd00;
                    Memwe=0;
                    ALUSrc=0;
                    Regwe=1;
                    end
                   end
        6'b001000:begin//addi
                    mem_r_d_sel=0;
                    alu_a_sel=0;
                    RegDst=0;
                    jump=0;
                    branch=0;
                    MemtoReg=0;
                    ALUop=2'd00;
                    Memwe=0;
                    ALUSrc=1;
                    Regwe=1;
                   end
        6'b100011:begin//lw
                    RegDst=0;
                    mem_r_d_sel=0;
                    alu_a_sel=0;
                    jump=0;
                    branch=0;
                    MemtoReg=1;
                    ALUop=2'd00;
                    Memwe=0;
                    ALUSrc=1;
                    Regwe=1;
                   end         
        6'b101011:begin//sw
                    RegDst=1;
                    mem_r_d_sel=0;
                    alu_a_sel=0;
                    jump=0;
                    branch=0;
                    MemtoReg=0;
                    ALUop=2'd00;
                    Memwe=1;
                    ALUSrc=1;
                    Regwe=0;
                   end     
        6'b000100:begin//beq
                    RegDst=0;
                    mem_r_d_sel=0;
                    alu_a_sel=0;
                    jump=0;
                    branch=1;
                    MemtoReg=0;
                    ALUop=2'd01;
                    Memwe=0;
                    ALUSrc=0;
                    Regwe=0;
                   end      
        6'b000010:begin//j
                    RegDst=0;
                    mem_r_d_sel=0;
                    alu_a_sel=0;
                    jump=1;
                    branch=0;
                    MemtoReg=0;
                    ALUop=2'd00;
                    Memwe=0;
                    ALUSrc=0;
                    Regwe=0;
                   end
                                                                    
        endcase
    end
//ALU Control Unit
always @*
    begin
        case(ALUop)
            2'b00:alu_op=3'b000;
            2'b01:alu_op=3'b001;
        endcase
    end
endmodule
