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
         input clk, rst //clock,reset

       );
wire [ 31: 0 ] alu_result, alu_a, alu_b, alu_out, rd0, rd1, wd, read0, read1, mem_out, instr, mem_data, n_pc, pc, extend, SF_extend, pc_j_b, pc_j, r_wd, _pc;

wire zf, cf, of, PCwe;
reg PCWriteCond, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, ALUSrcA, RegWrite, RegDst, r_ao, r_rf0, r_rf1, r_ins, r_data;
reg [ 1: 0 ] ALUSrcB, PCSource, ALUOp;
wire [ 8: 0 ] mem_addr, pc_addr;
wire [ 4: 0 ] wa;
reg [ 2: 0 ] alu_m;
mem MEMORY( mem_addr, alu_b, clk, MemWrite, mem_out );
alu ALU1( alu_result, zf, cf, of, alu_a, alu_b, alu_m );
register #( 32 ) REG_ALU_OUT( alu_result, clk, r_ao, rst, alu_out );
register #( 32 ) REG_FILE0( rd0, clk, r_rf0, rst, read0 );
register #( 32 ) REG_FILE1( rd1, clk, r_rf1, rst, read1 );
register #( 32 ) REG_INST( mem_out, clk, IRWrite, rst, instr );
register #( 32 ) REG_MEM_DATA( mem_out, clk, r_data, rst, mem_data );
register #( 32 ) REG_PC( n_pc, clk, PCwe, rst, pc );
reg_file #( 32 ) REG_FILE( clk, instr[ 25: 21 ], rd0, instr[ 20: 16 ], rd1, wa, RegWrite, r_wd );
assign extend = instr[ 15 ] ? { 16'hffff, instr[ 15 : 0 ] } : { 16'h0000, instr[ 15 : 0 ] };
assign SF_extend = extend << 2;
assign alu_a = ALUSrcA ? read0 : pc;
assign wa = RegDst ? instr[ 15 : 11 ] : instr[ 20 : 16 ];
assign r_wd = ( wa == 5'd0 ) ? 32'd0 : wd;
assign wd = MemtoReg ? mem_data : alu_out;
assign pc_addr = pc[ 9: 2 ] + 8'd11;
assign mem_addr = IorD ? { 1'b0, alu_out[ 9 : 2 ] } : { 1'b0, pc_addr };
assign pc_j_b = instr << 2;
assign PCwe = ( zf & PCWriteCond ) | PCWrite;
assign pc_j = { pc[ 31: 28 ], pc_j_b[ 27: 0 ] } - 32'd44;
mux4 #( 32 ) MUX1( alu_b, read1, 32'd4, extend, SF_extend, ALUSrcB );
mux4 #( 32 ) MUX2( n_pc, alu_result, alu_out, pc_j, 32'b0, PCSource );
reg [ 3: 0 ] status, next_status;
always @( posedge clk, posedge rst )
  begin
    if ( rst )
      begin
        status <= 4'd0;
      end
    else
      begin
        status <= next_status;
      end
  end
always @( * )
  begin

    if ( rst )
      begin
        next_status = 4'd0;
      end
    else
      begin
        case ( status )
          4'd0:
            next_status = 4'd1;

        4'd1:
          begin
            if ( { instr[ 31: 30 ], instr[ 28: 26 ] } == 5'b10011 )
              begin
                next_status = 4'd2;
              end
            else if ( { instr[ 31: 30 ], instr[ 28: 26 ] } == 5'b00000 )
              begin
                next_status = 4'd6;
              end
            else if ( instr[ 31: 26 ] == 6'b000100 )
              begin
                next_status = 4'd8;
              end
            else if ( instr[ 31: 26 ] == 6'b000010 )
              begin
                next_status = 4'd9;
              end
            else
              begin
                next_status = 4'd0;
              end
          end
        4'd2:
          begin
            if ( instr[ 29 ] == 1'b1 )
              begin
                next_status = 4'd5;
              end
            else
              begin
                next_status = 4'd3;
              end
          end
        4'd3:
          next_status = 4'd4;
        4'd4:
          next_status = 4'd0;
        4'd5:
          next_status = 4'd0;
        4'd6:
          next_status = 4'd7;
        4'd7:
          next_status = 4'd0;
        4'd8:
          next_status = 4'd0;
        4'd9:
          next_status = 4'd0;
        default:
          next_status = 4'd0;
      endcase
      end
  end
always @( * )
  begin
    { PCWriteCond, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst, r_ao, r_rf0, r_rf1, r_data } = 20'd0;
    if ( rst )
      begin
        { PCWriteCond, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst, r_ao, r_rf0, r_rf1, r_data } = 20'd0;
      end
    else
      begin
        case ( status )
          4'd0:
            begin
              MemRead = 1'b1;
              IRWrite = 1'b1;
              ALUSrcB = 2'b1;
              PCWrite = 1'b1;
            end
          4'd1:
            begin
              r_ao = 1'b1;
              r_rf0 = 1'b1;
              r_rf1 = 1'b1;
              ALUSrcB = 2'b11;
            end
          4'd2:
            begin
              r_ao = 1'b1;
              ALUSrcA = 1'b1;
              ALUSrcB = 2'b10;
            end
          4'd3:
            begin
              r_data = 1'b1;
              MemRead = 1'b1;
              IorD = 1'b1;
            end
          4'd4:
            begin
              RegWrite = 1'b1;
              MemtoReg = 1'b1;
            end
          4'd5:
            begin
              MemWrite = 1'b1;
              IorD = 1'b1;
            end
          4'd6:
            begin
              if ( instr[ 29 ] )
                begin
                  r_ao = 1'b1;
                  ALUSrcA = 1'b1;
                  ALUSrcB = 2'b10;
                  ALUOp = 2'b10;
                end
              else
                begin
                  r_ao = 1'b1;
                  ALUSrcA = 1'b1;
                  ALUOp = instr[1]?2'b01:2'b10;
                end
            end
          4'd7:
            begin
              if ( instr[ 29 ] )
                begin
                  RegDst = 1'b0;
                  RegWrite = 1'b1;
                end
              else
                begin
                  RegDst = 1'b1;
                  RegWrite = 1'b1;
                end
            end
          4'd8:
            begin
              r_ao = 1'b0;
              ALUSrcA = 1'b1;
              ALUOp = 2'b01;
              PCWriteCond = 1'b1;
              PCSource = 2'b01;
            end
          4'd9:
            begin
              PCWrite = 1'b1;
              PCSource = 2'b10;
            end
        endcase
      end
  end

always @ *
  begin
    case ( ALUOp )
      2'b00:
        alu_m = 3'b000;
      2'b10:
        alu_m = 3'b000;
      2'b01:
        alu_m = 3'b001;
    endcase
  end
endmodule
