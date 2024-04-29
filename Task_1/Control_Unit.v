`timescale 1ns / 1ps

module Control_Unit(
    input [6:0] Opcode,
    /*input Stall,*/
    output reg [1:0] ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp
    );
always @(*) begin
    case (Opcode)
        7'b0110011 : begin                                       //R-type
            ALUSrc <= 0;
            MemtoReg <= 0;
            RegWrite <= 1;
            MemRead <= 0;
            MemWrite <= 0;
            Branch <= 0;
            ALUOp <= 2'b10;
        end
        7'b0000011 : begin                                       //I-type (ld)
            ALUSrc <= 1;
            MemtoReg <= 1;
            RegWrite <= 1;
            MemRead <= 1;
            MemWrite <= 0;
            Branch <= 0;
            ALUOp <= 2'b00;
        end
        7'b0010011 : begin                                       //addi
            ALUSrc <= 1;
            MemtoReg <= 0;
            RegWrite <= 1;
            MemRead <= 0;
            MemWrite <= 0;
            Branch <= 0;
            ALUOp <= 2'b00;
        end
        7'b0100011 : begin                                       //S-type
            ALUSrc <= 1;
            MemtoReg <= 1'bX;
            RegWrite <= 0;
            MemRead <= 0;
            MemWrite <= 1;
            Branch <= 0;
            ALUOp <= 2'b00;
        end
        7'b1100011 : begin                                       //SB-type
            ALUSrc <= 0;
            MemtoReg <= 1'bX;
            RegWrite <= 0;
            MemRead <= 0;
            MemWrite <= 0;
            Branch <= 1;
            ALUOp <= 2'b01;
        end
        default : begin                                       //default
            ALUSrc <= 0;
            MemtoReg <= 0;
            RegWrite <= 0;
            MemRead <= 0;
            MemWrite <= 0;
            Branch <= 0;
            ALUOp <= 2'b00;
        end
    endcase
    /*
    if (Stall) begin                                    //don't repeat the instruction!!!
        ALUSrc <= 0;
        MemtoReg <= 0;
        RegWrite <= 0;
        MemRead <= 0;
        MemWrite <= 0;
        Branch <= 0;
        ALUOp <= 2'b00;
    end*/
end
endmodule
