`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/10 15:27:21
// Design Name: 
// Module Name: cpu
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


module cpu(
    input clk,rst//clock,reset
    );
wire [31:0] pc,n_pc,n_pc_j,n_pc_j_m,n_pc_b,n_pc_b_m;
wire [4:0] wa;
wire [31:0] instruct,rs,rd,rt,wd,ex_data,n_pc_b_b;
wire we,sel_pc_b; 
ins instruction(pc,instruct);
assign n_pc=pc+32'd4;
assign ex_data=instruct[15]?{16'hffff,instruct[15:0]}:{16'h0000,instruct[15:0]};
assign n_pc_b_b=ex_data<<2;
assign n_pc_b=n_pc+n_pc_b_b[7:0];
assign n_pc_j={n_pc};
mux2 #(32) mux2_1 (n_pc_b_m,n_pc,n_pc_b,sel_pc_b);
reg_file reg_file1(clk,instruct[25:21],rs,instruct[20:16],rt,wa,we,wd);
endmodule
