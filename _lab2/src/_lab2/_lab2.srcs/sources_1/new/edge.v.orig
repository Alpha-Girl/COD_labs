`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/03 11:31:38
// Design Name: 
// Module Name: edge
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


module edg(
    input clk,rst,
    input y,
    output p
    );
localparam S0= 2'd0;
localparam S1= 2'd1;
localparam S2= 2'd2;
reg [1:0] state,next_state;
//output logic
assign p = (state ==S1);

//state logic
always @(posedge rst, posedge clk) 
    if(rst)
        state<=S0;
    else
        state<=next_state;

//next state logic
always @* begin
    next_state=state;
    case(state)
        S0: if(y)next_state=S1;
        S1:if(y)next_state=S2;
        else next_state=S0;
        S2:if (!y) 
          next_state=S0;
          default:next_state=S0;
    endcase
end

endmodule
