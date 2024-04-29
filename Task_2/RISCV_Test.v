`timescale 1ns / 1ps

module RISCV_Test();

reg reset;
reg clk;
wire [63:0] PC_In;
wire [63:0] PC_Out;
wire [6:0] opcode;
wire Branch;
wire MemRead;
wire MemtoReg;
wire MemWrite;
wire RegWrite;
wire [1:0] ALUOp;
wire [3:0] Operation;
wire [63:0] IFID_PC_Out;
wire [31:0] IFID_Instruction;
wire IDEX_MemRead, 
EM_MemRead;
wire [4:0] IDEX_rs1, IDEX_rs2, EM_RD, MW_RD;
wire [63:0] IDEX_ReadData1, IDEX_ReadData2, IDEX_Imm,
            EM_Adder2Out, EM_Result, EM_WriteData, MW_Read_Data_from_Mem;
wire [4:0] rs1, rs2, rd;
wire [63:0] Write_Data_for_Reg;
wire [63:0] ReadData1, ReadData2, Imm_Data, b, Result, Read_Data_from_Mem;
wire [31:0] Instruction;
wire final_branch;
wire [3:0] IDEX_Funct;
wire EM_addermuxselect;

RISC_V_Processor risc(reset, clk,
Instruction, IFID_Instruction, rs1, rs2, rd, IDEX_rs1, IDEX_rs2, EM_RD, MW_RD, Write_Data_for_Reg, ReadData1,
ReadData2, Imm_Data, b, Result, Read_Data_from_Mem, opcode, IDEX_MemRead, EM_MemRead, Branch, EM_Branch, MemRead,
MemWrite, MemtoReg, RegWrite, ALUOp, Operation, PC_In, PC_Out, IFID_PC_Out, IDEX_ReadData1, IDEX_ReadData2, IDEX_Imm, Out_2, 
EM_Adder2Out, EM_Result, EM_WriteData, MW_Read_Data_from_Mem, final_branch, IDEX_Funct, EM_addermuxselect);
initial begin
clk = 1'b0; reset = 1'b0;
#20 reset = 1'b0;
#160 reset = 1'b1;
#20 reset = 1'b0;
end
always
    #20 clk = ~clk;

endmodule