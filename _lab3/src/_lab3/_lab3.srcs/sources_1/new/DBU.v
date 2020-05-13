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
         input clk,
         input succ,
         input step,
         input rst,
         input [ 2: 0 ] sel,
         input m_rf,
         input inc,
         input dec,
         output reg [ 15: 0 ] led,
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
cpu_test_new cpu1( clk_cpu, rst, clk_cpu, m_rf_addr, m_data, rf_data, pc_in, pc_out, instr, rf_rd1, rf_rd2, alu_y, m_rd, RegDst, jump, branch, MemtoReg, Memwe, ALUSrc, Regwe, zf, alu_op );

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
        clk_cpu = clk & edg_step;
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
              outdata = pc_in;
              led[ 11: 0 ] = { jump, branch, RegDst, Regwe, 1'b1, MemtoReg, Memwe, alu_op, ALUSrc, zf };
            end
          3'b010:
            begin
              outdata = pc_out;
              led[ 11: 0 ] = { jump, branch, RegDst, Regwe, 1'b1, MemtoReg, Memwe, alu_op, ALUSrc, zf };
            end
          3'b011:
            begin
              outdata = instr;
              led[ 11: 0 ] = { jump, branch, RegDst, Regwe, 1'b1, MemtoReg, Memwe, alu_op, ALUSrc, zf };
            end
          3'b100:
            begin
              outdata = rf_rd1;
              led[ 11: 0 ] = { jump, branch, RegDst, Regwe, 1'b1, MemtoReg, Memwe, alu_op, ALUSrc, zf };
            end
          3'b101:
            begin
              outdata = rf_rd2;
              led[ 11: 0 ] = { jump, branch, RegDst, Regwe, 1'b1, MemtoReg, Memwe, alu_op, ALUSrc, zf };
            end
          3'b110:
            begin
              outdata = alu_y;
              led[ 11: 0 ] = { jump, branch, RegDst, Regwe, 1'b1, MemtoReg, Memwe, alu_op, ALUSrc, zf };
            end
          3'b111:
            begin
              outdata = m_rd;
              led[ 11: 0 ] = { jump, branch, RegDst, Regwe, 1'b1, MemtoReg, Memwe, alu_op, ALUSrc, zf };
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
        end
        default:
          next_an = an << 1;
      endcase
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
