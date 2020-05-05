`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/03 11:24:54
// Design Name: 
// Module Name: fifo
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


module fifo(
    input clk,rst,//clock,reset
    input [7:0] din,//enqueue data
    input en_in,//enqueue enable
    input en_out,//dequeue enable
    output [7:0] dout, //dequeue data
    output reg [4:0] count //length of queue
    );
wire edg_in,edg_out,we,en;
reg [4:0] next_count;
reg [3:0] Q_head,Q_tail,next_Q_head,next_Q_tail,addr;
blk_mem_gen0 blcok_mem(clk,en,we,addr,din,dout);
edg edg1 (clk,rst,en_in,edg_in);
edg edg2 (clk,rst,en_out,edg_out);

assign we = edg_in;
assign en = edg_in|edg_out;
//state logic
always @(posedge clk,posedge rst)begin
    if(rst)begin
        count<=5'd0;
        Q_head<=4'b0;
        Q_tail<=4'b0;
    end
    else begin
        count<=next_count;
        Q_head<=next_Q_head;
        Q_tail<=next_Q_tail;
    end
end
//count logic
always @(posedge clk) begin
    if(rst) 
        ;
    else if (edg_in)begin
        if(count<5'd16)begin
            next_count<=count+5'd1;
            addr<=Q_tail;
            next_Q_tail<=Q_tail+4'd1;
        end
    else if(edg_out)begin
        if(count>5'd0)begin
            next_count<=count-5'd1;
            addr<=Q_head;
            next_Q_head<=Q_head+4'd1; 
        end
    end    
    end
end
endmodule
