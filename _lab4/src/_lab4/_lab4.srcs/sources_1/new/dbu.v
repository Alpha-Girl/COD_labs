`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/05/27 16:50:16
// Design Name:
// Module Name: dbu
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


module dbu(

         input clk, //clock
         input succ, //successive
         input step, //step
         input rst, //reset
         input [ 2: 0 ] sel, //select
         input m_rf, //memory_regfile
         input inc, //increase
         input dec, //decrease
         output reg [ 15: 0 ] led, //show part
         output reg [ 7: 0 ] an,
         output [ 7: 0 ] seg
       );
wire edg_step, edg_inc, edg_dec, clk_10, locked;
reg [ 3: 0 ] num_seg;
wire [ 3: 0 ] nums;
reg [ 7: 0 ] m_rf_addr, n_m_rf_addr, next_an;
reg [ 31: 0 ] outdata;
reg clk_cpu;
wire [ 31: 0 ] m_data, rf_data, pc_in, pc_out, instr, rf_rd1, rf_rd2, alu_y, m_rd;
wire RegDst, jump, branch, MemtoReg, Memwe, ALUSrc, Regwe, zf;
wire [ 2: 0 ] alu_op;

wire [ 31: 0 ] o_pc, o_ir, o_md, o_a, o_b, o_aluout;
wire [ 1: 0 ] o_PCSrc;
wire o_PCwe, o_IorD, o_MemWrite, o_IRWrite, o_RegDst, o_MemtoReg, o_RegWrite;
wire [ 2: 0 ] o_ALUm;
wire o_ALUSrcA;
wire [ 1: 0 ] o_ALUSrcB;
wire o_ALUZero;
CPU_dbu cpu1(
          clk_cpu, rst,
          o_pc, o_ir, o_md, o_a, o_b, o_aluout,
          o_PCSrc,
          o_PCwe, o_IorD, o_MemWrite, o_IRWrite, o_RegDst, o_MemtoReg, o_RegWrite,
          o_ALUm,
          o_ALUSrcA,
          o_ALUSrcB,
          o_ALUZero,
          m_rf_addr,
          m_data,
          rf_data,
          succ );
edg edg_st( clk, rst, step, edg_step );
edg edg_incc( clk, rst, inc, edg_inc );
edg edg_decc( clk, rst, dec, edg_dec );
always @( posedge clk )
  begin
    if ( edg_inc )
      begin
        n_m_rf_addr = m_rf_addr + 8'd1;
      end
    else if ( edg_dec )
      begin
        n_m_rf_addr = m_rf_addr - 8'd1;
      end
    else
      begin
        n_m_rf_addr = m_rf_addr;
      end
  end

always @( posedge clk )
  begin
    if ( rst )
      begin
        m_rf_addr <= 8'd0;
      end
    else
      begin
        m_rf_addr <= n_m_rf_addr;
      end
  end
always @ *
  begin
    if ( succ )
      begin
        clk_cpu = clk;
      end
    else
      begin
        clk_cpu = edg_step;
      end
  end
always @ *
  begin
    if ( rst )
      begin
        led = 16'd0;
      end
    else
      begin
        led = { o_PCSrc,
                o_PCwe, o_IorD, o_MemWrite, o_IRWrite, o_RegDst, o_MemtoReg, o_RegWrite,
                o_ALUm,
                o_ALUSrcA,
                o_ALUSrcB,
                o_ALUZero };
        case ( sel )
          3'b000:
            begin
              if ( m_rf )
                begin
                  outdata = m_data;
                end
              else
                begin
                  outdata = rf_data;
                end
              led[ 7: 0 ] = m_rf_addr;
            end
          3'b001:
            begin
              outdata = o_pc;

            end
          3'b010:
            begin
              outdata = o_ir;

            end
          3'b011:
            begin
              outdata = o_md;


            end
          3'b100:
            begin
              outdata = o_a;


            end
          3'b101:
            begin
              outdata = o_b;

            end
          3'b110:
            begin
              outdata = o_aluout;

            end

        endcase
      end
  end
clk_wiz_0 clock( clk_10, rst, locked, clk );
always @( posedge clk, posedge rst )
  begin
    if ( rst )
      begin
        an = 8'b00000001;
      end
    else
      begin
        an = next_an;
      end
  end
always @( posedge clk, posedge rst )
  begin
    if ( rst )
      begin
        next_an = 8'h01;
      end
    else
      begin
        case ( an )
          8'h80:
            next_an = 8'h01;

          default:
            next_an = an << 1;
        endcase
      end
  end
num num1( nums, seg );
assign nums = num_seg;
always @ *
  begin
    case ( an )
      8'h01:
        num_seg = outdata[ 3: 0 ];
      8'h02:
        num_seg = outdata[ 7: 4 ];
      8'h04:
        num_seg = outdata[ 11: 8 ];
      8'h08:
        num_seg = outdata[ 15: 12 ];
      8'h10:
        num_seg = outdata[ 19: 16 ];
      8'h20:
        num_seg = outdata[ 23: 20 ];
      8'h40:
        num_seg = outdata[ 27: 24 ];
      8'h80:
        num_seg = outdata[ 31: 28 ];
    endcase

  end
endmodule

