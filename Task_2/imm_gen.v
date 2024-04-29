`timescale 1ns / 1ps
module imm_gen(
    input [31:0] ins,
    output reg [63:0] imm_data
);
reg [11:0] imm;
always @(ins or imm)
begin
    if (ins[6] == 1'b1)
        imm <= {ins[31], ins[7], ins[30:25], ins[11:8]}; //SB format
    else begin
        if (ins[5] == 1'b1)
            imm <= {ins[31:25],ins[11:7]}; //S format
        else
            imm <= {ins[31:20]}; //I format
    end
    if (imm[11] == 0)
        imm_data <= {52'd0, imm};
    else
        imm_data <= {52'hFFFFFFFFFFFFF, imm}; //00000010100001010011010010000011
    end
endmodule
