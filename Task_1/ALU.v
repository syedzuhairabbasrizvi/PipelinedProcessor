`timescale 1ns / 1ps
module ALU(
    input [63:0] A,
    input [63:0] B,
    input [3:0] ALUOp,
    output reg [63:0] Result,
    output reg Zero,
    output reg BLT
    );
    
always @(*) begin
    case (ALUOp)
        4'b0000: Result = A & B; //AND
        4'b0001: Result = A | B; //OR
        4'b0010: Result = A + B; //ADD
        4'b0110: Result = A - B; //SUB
        4'b1100: Result = ~(A | B); //NOR
        4'b1000: Result = A * (2 ** B); // SLLI
    endcase
    Zero = (Result == 64'd0) ? 1 : 0;
    BLT = (A < B) ? 1 : 0;
    
end
endmodule