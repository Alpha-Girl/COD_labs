`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/12 20:36:29
// Design Name: 
// Module Name: DBU
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


module DBU(
    input succ,
    input step,
    input rst,
    input [2:0] sel,
    input m_rf,
    input inc,
    input dec,
    output reg [15:0] led,
    output [7:0] an,
    output seg
    );
wire clk,edg_step,edg_inc,edg_dec;
reg [7:0] m_rf_addr,n_m_rf_addr;
reg [31:0] outdata;
reg clk_cpu;
wire [31:0] m_data,rf_data,pc_in,pc_out,instr,rf_rd1,rf_rd2,alu_y,m_rd;
wire RegDst,jump,branch,MemtoReg,Memwe,ALUSrc,Regwe,zf;
wire [2:0] alu_op;
cpu_test cpu1(clk_cpu,rst,clk_cpu,m_rf_addr,m_data,rf_data,pc_in,pc_out,instr,rf_rd1,rf_rd2,alu_y,m_rd,RegDst,jump,branch,MemtoReg,Memwe,ALUSrc,Regwe,zf,alu_op);

edg edg_st(clk,rst,step,edg_step);
edg edg_incc(clk,rst,inc,edg_inc);
edg edg_decc(clk,rst,dec,edg_dec);
always @(posedge clk)
    begin
        if(edg_inc)
            n_m_rf_addr=m_rf_addr+8'd1;
        else if(edg_dec)
            n_m_rf_addr=m_rf_addr-8'd1;
        else
            n_m_rf_addr=m_rf_addr;
    end

always @(posedge clk)
    begin
        if(rst)
            m_rf_addr<=8'd0;
        else 
            m_rf_addr<=n_m_rf_addr;
    end
always @*
    begin
        if(succ)
            clk_cpu=clk;
        else
            clk_cpu=clk&edg_step;
    end
always @*
begin
    case(sel)
        3'b000:begin
                if(m_rf)
                    outdata=m_data;
                else
                    outdata=rf_data;
                led[7:0]=m_rf_addr;
                end
        3'b001:begin
        outdata=pc_in;
        led[11:0]={jump,branch,RegDst,Regwe,1'b1,MemtoReg,Memwe,alu_op,ALUSrc,zf};
        end
        3'b010:begin outdata=pc_out;led[11:0]={jump,branch,RegDst,Regwe,1'b1,MemtoReg,Memwe,alu_op,ALUSrc,zf};end
        3'b011:begin outdata=instr;led[11:0]={jump,branch,RegDst,Regwe,1'b1,MemtoReg,Memwe,alu_op,ALUSrc,zf};end
        3'b100:begin outdata=rf_rd1;led[11:0]={jump,branch,RegDst,Regwe,1'b1,MemtoReg,Memwe,alu_op,ALUSrc,zf};end
        3'b101:begin outdata=rf_rd2;led[11:0]={jump,branch,RegDst,Regwe,1'b1,MemtoReg,Memwe,alu_op,ALUSrc,zf};end
        3'b110:begin outdata=alu_y;led[11:0]={jump,branch,RegDst,Regwe,1'b1,MemtoReg,Memwe,alu_op,ALUSrc,zf};end
        3'b111:begin outdata=m_rd;led[11:0]={jump,branch,RegDst,Regwe,1'b1,MemtoReg,Memwe,alu_op,ALUSrc,zf};end
    endcase
end
endmodule
