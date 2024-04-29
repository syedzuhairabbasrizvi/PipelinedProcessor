`timescale 1ns / 1ps
module Program_Counter(
    input clk,
    input reset,/*
    input Stall,*/
    input [63:0] PC_In,
    output reg [63:0] PC_Out
    );
//if reset, we set PC_Out to 0, otherwise it's PC_In
always @(posedge clk or posedge reset)
begin
    if (reset)
        PC_Out = 64'b0;
        /*
    else if (Stall)
        PC_Out = PC_Out;          //stay in old instruction*/
    else
        PC_Out = PC_In;
end
endmodule
