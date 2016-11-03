`timescale 1ns / 1ps

module Control(
input [3:0] cond,
input [1:0] op,
input [5:0] funct,
input [1:0] sh,

input [3:0] ALU_flags,// 0:Z, 1:N, 2:C, 3:V
output ALU_set,

output sel_PC,
output sel_dirA,
output [1:0] imm_src,
output reg_wr,
output sel_B,
output mem_wr,
output sel_WB,
output sel_dest,
output ALU_ctrl
    );
	 
reg enable;

always @* begin
	case(cond)
		0 : begin//Z
			enable = ALU_flags[0];
		end
		1 : begin//~Z
			enable = ~ALU_flags[0];
		end
		2 : begin//C
			enable = ALU_flags[2];
		end
		3 : begin//~C
			enable = ~ALU_flags[2];
		end
		4 : begin//N
			enable = ALU_flags[1];
		end
		5 : begin//~N
			enable = ~ALU_flags[1];
		end
		6 : begin//V
			enable = ALU_flags[3];
		end
		7 : begin//~V
			enable = ~ALU_flags[3];
		end
		8 : begin//~ZC
			enable = ~ALU_flags[0] & ALU_flags[2];
		end
		9 : begin// Z | ~C
			enable = ALU_flags[0] | ~ALU_flags[2];
		end
		10 : begin//~(N xor V)
			enable = ~(ALU_flags[1] ^ALU_flags[3]);
		end
		11 : begin//N xor V
			enable = ALU_flags[1] ^ALU_flags[3];
		end
		12 : begin// ~Z ~(N xor V)
			enable =  ~ALU_flags[0] & ~(ALU_flags[1] ^ALU_flags[3]);
		end
		13 : begin// Z | (N xor V)
			enable = ALU_flags[0] & (ALU_flags[1] ^ALU_flags[3]);
		end
		default : begin //Always
			enable = 1;
		end
	endcase
	
	if(enable) begin
		case(op)
			0:begin//Data Processing
				if(funct[5:4] != 0) begin
					sel_B <= (funct[5] == 1) ? 1: 0;
					ALU_set <= (funct[0] == 1) ? 1: 0;
					case(funct[4:1])
						2: begin//SUB
						
						end
						4: begin//ADD
						
						end
						12:begin//OR
						
						end
						13:begin//Shifts
							case(sh)
								 0:begin//LSL
									
								 end
								 1:begin//LSR
								 
								 end
							 endcase
						end
					endcase
				end
				else begin//Multiply
					if(funct[3:1] == 0) begin//MUL
					
					end
				end
			end
			1:begin//Memory
				if(funct[2] == 1)
					if(funct[0] == 0) begin//STR
					
					end
					else begin//LDR
					
					end
			end
			2:begin//Branch
			end
		endcase
	end

end



endmodule
