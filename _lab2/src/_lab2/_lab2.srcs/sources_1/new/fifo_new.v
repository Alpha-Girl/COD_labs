`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/05/06 11:13:59
// Design Name:
// Module Name: fifo_new
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


module fifo_new(
         input clk, rst, //clock,reset
         input [ 7: 0 ] din, //enqueue data
         input en_in, //enqueue enable
         input en_out, //dequeue enable
         output [ 7: 0 ] dout,  //dequeue data
         output reg [ 4: 0 ] count //length of queue
       );
wire edg_in, edg_out, we;

reg [ 5: 0 ] next_count;
reg [ 3: 0 ] Q_head, Q_tail, next_Q_head, next_Q_tail;
reg [ 1: 0 ] state, next_state;
wire [ 3: 0 ] addr;
dist_mem_gen_0 dis_mem1( addr, din, clk, we, dout );
edg edg1 ( clk, rst, en_in, edg_in );
edg edg2 ( clk, rst, en_out, edg_out );

assign we = edg_in;
localparam S0 = 2'b00;
localparam S1 = 2'b01;
localparam S2 = 2'b10;


//state logic
always @( posedge clk, posedge rst )
  begin
    if ( rst )
      begin
        state <= S0;
      end
    else
      begin
        state <= next_state;
      end
  end
always @( posedge clk, posedge rst )
  begin
    if ( rst )
      begin
        next_state = 2'b0;
      end
    else
      begin
        case ( { edg_in, edg_out, state } )
          4'b1000:
            next_state <= S1;
        end
        4'b1001:
          begin
            if ( count == 5'd15 )
              begin
                next_state <= S2;
              end
          end
        4'b0110:
          next_state <= S1;
        4'b0101:
          begin
            if ( count == 5'd1 )
              begin
                next_state <= S0;
              end
          end
        default:
          next_state <= next_state;
      endcase
  end
//count logic
always @( posedge clk, posedge rst )
  begin
    if ( rst )
      begin
        count = 5'd0;
      end
    else
      begin
        count <= next_count;
      end
  end

always @( posedge clk, posedge rst )
  begin
    if ( rst )
      begin
        next_count = 5'd0;
      end
    else if ( edg_in )
      begin
        case ( state )
          S0, S1:
            next_count <= count + 5'd1;
        end
        S2:
          next_count <= count;
      endcase
    else if ( edg_out )
      begin
        case ( state )
          S1, S2:
            next_count <= count - 5'd1;
        end
        S0:
          next_count <= count;
      endcase
  end
//head
always @( posedge clk, posedge rst )
  begin
    if ( rst )
      begin
        Q_head = 4'd0;
      end
    else
      begin
        Q_head <= next_Q_head;
      end
  end
always @( posedge clk, posedge rst )
  begin
    if ( rst )
      begin
        next_Q_head = 4'd0;
      end
    else if ( edg_out )
      begin
        case ( state )
          S1, S2:
            next_Q_head <= Q_head + 4'd1;
        end
        S0:
          next_Q_head <= Q_head;
      endcase
  end
//tail
always @( posedge clk, posedge rst )
  begin
    if ( rst )
      begin
        Q_tail = 4'd0;
      end
    else
      begin
        Q_tail <= next_Q_tail;
      end
  end
always @( posedge clk, posedge rst )
  begin
    if ( rst )
      begin
        next_Q_tail = 4'd0;
      end
    else if ( edg_in )
      begin
        case ( state )
          S0, S1:
            next_Q_tail <= Q_tail + 4'd1;
        end
        S2:
          next_Q_tail <= Q_tail;
      endcase
  end
assign addr = we ? Q_tail : Q_head;
endmodule
