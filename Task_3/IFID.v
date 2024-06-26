`timescale 1ns / 1ps
module IFID(
    input clk,
    input reset,
    input [31:0] Instruction,
    input [63:0] PC_Out,
    output reg [31:0] IFID_Instruction,
    output reg [63:0] IFID_PC_Out
);
always @(posedge clk or posedge reset) begin
    if (reset == 1'b1) begin
        IFID_Instruction = 0; IFID_PC_Out = 0;
    end
    else begin
        IFID_Instruction = Instruction; IFID_PC_Out = PC_Out;
    end
end
endmodule