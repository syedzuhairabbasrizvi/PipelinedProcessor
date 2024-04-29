`timescale 1ns / 1ps

module ALU_Control(input[1:0]ALUOP,input[3:0]Funct,output reg[3:0]operation);
    always @(ALUOP or Funct)
    begin
    case(ALUOP)
    2'b00:      //L/S instruction
        begin
        if (Funct==4'b0001) operation<=4'b1000;
        else operation<=4'b0010;
        end
    2'b01:      //branch
        operation<=4'b0110;  
    2'b10:      //R instruction
        begin
        if (Funct==4'b0000) operation<=4'b0010;
        else if(Funct==4'b1000) operation<=4'b0110;
        else if(Funct==4'b0111) operation<=4'b0000;
        else if(Funct==4'b0110) operation<=4'b0001;
        end
        default: operation<=4'bxxxx;
     endcase
     end
endmodule