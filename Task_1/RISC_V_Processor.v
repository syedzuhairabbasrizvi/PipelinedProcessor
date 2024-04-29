`timescale 1ns / 1ps

module RISC_V_Processor(
    input reset,
    input clk,
    output [63:0] Instruction_Address, //PCOut
    output  [31:0] Instruction,
    output  [4:0] rs1, rs2, rd,
    output  [63:0] Write_Data_for_Reg, ReadData1, ReadData2, Imm_Data, 
    output [63:0] a, 
    output  [63:0] b, Result, 
    output [63:0] Mem_Address, //Result
    output  [63:0] Read_Data_from_Mem
    );

wire [63:0] PC_In;
wire [63:0] PC_Out;
wire [6:0] opcode;
wire [2:0] funct3;
wire [6:0] funct7;
wire Branch;
wire MemRead;
wire MemtoReg;
wire MemWrite;
wire ALUSrc;
wire RegWrite;
wire [1:0] ALUOp;
wire [3:0] Funct;
wire [3:0] Operation;
wire Zero;
wire [63:0] Out_1;
wire [63:0] Out_2;
wire Mux_Selector;
wire BLT;
/*
wire Stall;

wire [63:0] IFID_PC_Out;
wire [31:0] IFID_Instruction;
*/
assign Mux_Selector = Branch&Zero&(Funct==4'b0000 | Funct==4'b1000) | Branch&BLT&(Funct==4'b0100 | Funct==4'b1100);

Adder add_1(PC_Out, 64'd4, Out_1);
mux_2_1 mux2(Mux_Selector, Out_1, Out_2, PC_In);
Program_Counter PC(clk, reset, /*Stall*/ PC_In, PC_Out);
Instruction_Memory IM(PC_Out, Instruction);

instruction_parser IP(Instruction, opcode, rd, funct3, rs1, rs2, funct7);
imm_gen IDE(Instruction, Imm_Data);
Control_Unit CU(opcode, /*Stall*/ ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp);
registerFile Regs(Write_Data_for_Reg, rs1, rs2, rd, RegWrite, clk, reset, ReadData1, ReadData2);
assign Funct = {Instruction[30], Instruction[14:12]};           //add complement bit to funct for ALU control

Adder add_2(PC_Out, Imm_Data*2, Out_2);
mux_2_1 mux(ALUSrc, ReadData2, Imm_Data, b);
ALU_Control AC(ALUOp, Funct, Operation);
ALU alu(ReadData1, b, Operation, Result, Zero, BLT);

Data_Memory DM(Result, ReadData2, clk, MemWrite, MemRead, Read_Data_from_Mem);

mux_2_1 mux3(MemtoReg, Result, Read_Data_from_Mem, Write_Data_for_Reg);

assign Instruction_Address = PC_Out;
assign Mem_Address = Result;
assign a = ReadData1;

endmodule
