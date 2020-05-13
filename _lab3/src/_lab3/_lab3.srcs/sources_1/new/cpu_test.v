`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/05/12 21:36:37
// Design Name:
// Module Name: cpu_test
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


module cpu_test(
         input clk, rst, //clock,reset
         input run,
         input [ 7: 0 ] m_rf_addr,
         output [ 31: 0 ] m_data, rf_data, pc_in, pc_out, instr, rf_rd1, rf_rd2, alu_y, m_rd,
         output reg RegDst, jump, branch, MemtoReg, Memwe, ALUSrc, Regwe,
         output zf,
         output reg [ 2: 0 ] alu_op
       );


wire [ 31: 0 ] n_pc, n_pc_j, n_pc_j_m, n_pc_b, n_pc_b_m;
reg [ 31: 0 ] pc;
wire [ 7: 0 ] data_addr;
wire [ 4: 0 ] wa, rs_addr;
wire [ 31: 0 ] instruct, rs, rd, rt, wd, ex_data, n_pc_b_b, aluout, alu_b, dataout;
wire sel_pc_b, cf, of;

reg [ 1: 0 ] ALUop;
ins instruction( n_pc_j_m[ 9: 2 ], instruct );
assign data_addr = run ? aluout[ 7 : 0 ] : m_rf_addr;
data data1( data_addr, rt, aluout[ 7: 0 ], clk, Memwe, dataout );
assign m_data = dataout;
assign rf_data = rf_rd1;
assign pc_in = n_pc_j_m;
assign pc_out = pc;
assign instr = instruct;
assign rf_rd1 = rs;
assign rf_rd2 = rt;
assign alu_y = aluout;
assign m_rd = dataout;
assign n_pc = pc + 32'd4;
assign ex_data = instruct[ 15 ] ? { 16'hffff, instruct[ 15 : 0 ] } : { 16'h0000, instruct[ 15 : 0 ] };
assign n_pc_b_b = ex_data << 2;
assign n_pc_b = n_pc + n_pc_b_b;
assign n_pc_j = { n_pc[ 31: 28 ], instruct[ 25: 0 ], 2'd0 };
assign n_pc_b_m = branch & zf ? n_pc_b_b : n_pc;
assign n_pc_j_m = jump ? n_pc_b_m : n_pc_j_m;
mux2 #( 32 ) mux2_1 ( n_pc_b_m, n_pc, n_pc_b, sel_pc_b );
assign wd = MemtoReg ? dataout : aluout;
assign wa = RegDst ? instruct[ 15 : 11 ] : instruct[ 21 : 16 ];
assign rs_addr = run ? instruct[ 25 : 21 ] : m_rf_addr[ 4 : 0 ];
reg_file reg_file1( clk, rs_addr, rs, instruct[ 20: 16 ], rt, wa, Regwe, wd );
assign alu_b = ALUSrc ? ex_data : rt;
alu #( 32 ) ALU1( aluout, zf, cf, of, rs, alu_b, alu_op );
//pc
always @( posedge clk )
  begin
    pc <= n_pc_j_m;
  end
//Control Unit
always @ *
  begin
    case ( instruct[ 31: 26 ] )
      6'b000000:
        begin
          RegDst = 1;
          jump = 0;
          branch = 0;
          MemtoReg = 0;
          ALUop = 2'd00;
          Memwe = 0;
          ALUSrc = 0;
          Regwe = 1;
        end
      6'b001000:
        begin
          RegDst = 1;
          jump = 0;
          branch = 0;
          MemtoReg = 0;
          ALUop = 2'd00;
          Memwe = 0;
          ALUSrc = 1;
          Regwe = 1;
        end
      6'b100011:
        begin
          RegDst = 0;
          jump = 0;
          branch = 0;
          MemtoReg = 1;
          ALUop = 2'd00;
          Memwe = 0;
          ALUSrc = 1;
          Regwe = 1;
        end
      6'b101011:
        begin
          RegDst = 1;
          jump = 0;
          branch = 0;
          MemtoReg = 0;
          ALUop = 2'd00;
          Memwe = 1;
          ALUSrc = 1;
          Regwe = 0;
        end
      6'b000100:
        begin
          RegDst = 0;
          jump = 0;
          branch = 1;
          MemtoReg = 0;
          ALUop = 2'd01;
          Memwe = 0;
          ALUSrc = 0;
          Regwe = 0;
        end
      6'b000010:
        begin
          RegDst = 0;
          jump = 1;
          branch = 0;
          MemtoReg = 0;
          ALUop = 2'd00;
          Memwe = 0;
          ALUSrc = 0;
          Regwe = 0;
        end
    endcase
  end
//ALU Control Unit
always @ *
  begin
    case ( ALUop )
      2'b00:
        alu_op = 3'b000;
      2'b01:
        alu_op = 3'b001;
    endcase
  end
endmodule
