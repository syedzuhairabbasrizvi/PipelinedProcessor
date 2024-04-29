`timescale 1ns / 1ps
module mux_2_1(
    input S, //the selector
    input [63:0] A, //two inputs of size 1 bit each.
    input [63:0] B,
    output [63:0] O //the output as a 1-bit number
);
//choose output depending on which one is chosen.
assign O = (S ? B : A);
endmodule