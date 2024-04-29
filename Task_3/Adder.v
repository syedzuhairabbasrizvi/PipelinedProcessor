`timescale 1ns / 1ps
module Adder(
    input [63:0] A,
    input [63:0] B,
    output reg [63:0] out
    );
always @(A or B) 
    begin 
    out= A + B;
    end
endmodule
