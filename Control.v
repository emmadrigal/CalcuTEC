`timescale 1ns / 1ps

module Control(
input clk,
input [3:0] cond,
input [1:0] op,
input [5:0] funct,
input [1:0] sh,

input [3:0] ALU_flags,// 0:Z, 1:N, 2:C, 3:V
output reg ALU_set,

output reg sel_PC,
output reg sel_dirA,
output reg[1:0] imm_src,
output reg reg_wr,
output reg sel_B,
output reg sel_dest,
output reg [2:0] ALU_ctrl
    );
	 
	 
reg [3:0] flags_alu;

	 
reg enable;

always @* begin
	case(cond)
		0 : begin//Z
			enable <= flags_alu[0];
		end
		1 : begin//~Z
			enable <= ~flags_alu[0];
		end
		2 : begin//C
			enable <= flags_alu[2];
		end
		3 : begin//~C
			enable <= ~flags_alu[2];
		end
		4 : begin//N
			enable <= flags_alu[1];
		end
		5 : begin//~N
			enable <= ~flags_alu[1];
		end
		6 : begin//V
			enable <= flags_alu[3];
		end
		7 : begin//~V
			enable <= ~flags_alu[3];
		end
		8 : begin//~ZC
			enable <= ~flags_alu[0] & flags_alu[2];
		end
		9 : begin// Z | ~C
			enable <= flags_alu[0] | ~flags_alu[2];
		end
		10 : begin//~(N xor V)
			enable <= ~(flags_alu[1] ^flags_alu[3]);
		end
		11 : begin//N xor V
			enable <= flags_alu[1] ^flags_alu[3];
		end
		12 : begin// ~Z ~(N xor V)
			enable <=  ~flags_alu[0] & ~(flags_alu[1] ^flags_alu[3]);
		end
		13 : begin// Z | (N xor V)
			enable <= flags_alu[0] & (flags_alu[1] ^flags_alu[3]);
		end
		default : begin //Always
			enable <= 1;
		end
	endcase
	
	if(enable) begin
		case(op)
			0:begin//Data Processing
				ALU_set <= (funct[0] == 1) ? 1: 0;//Checkea si las banderas de la ALU deben cambiar					
				reg_wr <= 1;//se debe escribir
				imm_src <= 0;//es una extensión de procesamiento de datos
				sel_PC <=  0;//No hay salto
				sel_B <= (funct[5] == 1) ? 1: 0;//Checkea si la instrucción es inmediata o no
				sel_dest <= 0;
				case(funct[4:1])
					0: begin //Funcion de AND no fue implementada, sino esto se debe cambiar
						sel_dirA <= 1;
						sel_dest <= 1;
						if(funct[3:1] == 0) begin//MUL
							ALU_ctrl <= 2;
					end
					end
					2: begin//SUB
						sel_dirA <= 0;
						ALU_ctrl <= 1;
					end
					4: begin//ADD
						sel_dirA <= 0;
						ALU_ctrl <= 0;
					end
					12:begin//OR
						sel_dirA <= 0;
						ALU_ctrl <= 3;
					end
					13:begin//Shifts
						sel_dirA <= 0;
						case(sh)
							 0:begin//LSL
								ALU_ctrl <= 4;
							 end
							 1:begin//LSR
								ALU_ctrl <= 5;
							 end
						 endcase
					end
					default:begin 
						sel_PC <=  0;//Puede hay salto
						reg_wr <= 0;//No se debe escribir en los registros
					end
				endcase

			end
			1:begin//Memory calls not implemented
				ALU_set <= 0;//Las banderas de la ALU nunca se cambian
				imm_src <= 1;//La extensión es de 0s
				sel_PC <=  0;//No hay salto
				sel_B <= (funct[5] == 1) ? 1: 0;//Checkea si la instrucción es inmediata o no
				sel_dirA <= 0;//Selecciona un registro para sumarlo en A
				sel_dest <= 1;//Selecciona la dirección de WB
				ALU_ctrl <= 0;//realice una suma en la ALU
				reg_wr <= 0;//No se debe escribir
			end
			2:begin//Branch
				sel_B <= 1; //Siempre es inmediata
				ALU_set <= 0;//Las banderas de la ALU nunca se cambian
				imm_src <= 2;//La extensión es de 0s
				sel_PC <=  1;//Puede haber salto
				reg_wr <= 0;//No se debe escribir en los registros
			end
			default: begin//El resto de ops se toman como nops
				sel_PC <=  0;//Puede hay salto
				reg_wr <= 0;//No se debe escribir en los registros
			end
		endcase
	end
end

always @(negedge clk) begin
	flags_alu <= ALU_flags;
end



endmodule
