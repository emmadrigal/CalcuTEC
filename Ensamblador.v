`timescale 1ns / 1ps

module Ensamblador(
	input clk,//Reloj para regular velocidad del procesador, ~10kHz
	input [31:0] datoA,
	input [31:0] datoB,
	input [2:0] operacion,
	
	input start,
	
	output wire [31:0] resultado,
	output reg ready,
	output reg error
    );
	 
/*Operaciones
Suma: 0
Resta: 1
Multiplicación:2
División: 3
Módulo: 4 
*/

//Entradas del procesador
reg write_ins = 0;
reg [4:0] ins_address = 0;
reg [31:0] ins = 0;
reg reset = 0;


ARMProcessor processor (
		.clk(clk), 
		.write_ins(write_ins), 
		.ins_address(ins_address), 
		.ins(ins),
		.reset(reset),
		.resultado_out(resultado)
	);
	
	
reg [8:0] lineNumber = 0;
reg startSignal = 0;
reg endSignal   = 0;
wire executing = startSignal ^ endSignal;


always @(posedge start)begin
	startSignal = ~startSignal;
end

always @(posedge clk) begin
	write_ins = 0;
	if(executing) begin
		case(lineNumber)
			//Fija el valor del primer operador
			0: begin ins_address = 0; ins = {{24'b111100111000000000000000}, datoA[7:0]}; ready = 0;end//OR $0, $0, datoA[7:0]
			1: begin ins_address = 1; ins = {{24'b111100111000000000001100}, datoA[15:8]};end//OR $0, $0, datoA[15:8]
			2: begin ins_address = 2; ins = {{24'b111100111000000000001000}, datoA[23:16]};end//OR $0, $0, datoA[23:16]
			3: begin ins_address = 3; ins = {{24'b111100111000000000000100}, datoA[31:24]};end//OR $0, $0, datoA[31:24]
			//Fija el valor del segundo
			4: begin ins_address = 4; ins = {{24'b111100111000000100010000}, datoB[7:0]};end//OR $1, $1, datoB[7:0]
			5: begin ins_address = 5; ins = {{24'b111100111000000100011100}, datoB[15:8]};end//OR $1, $1, datoB[15:8]
			6: begin ins_address = 6; ins = {{24'b111100111000000100011000}, datoB[23:16]};end//OR $1, $1, datoB[23:16]
			7: begin ins_address = 7; ins = {{24'b111100111000000100010100}, datoB[31:24]};end//OR $1, $1, datoB[31:24]
			
			default: begin
				case(operacion)
				0: begin//Suma
					case(lineNumber)
						8: begin ins_address = 8; ins = 32'b11110000100011110000000000000001; end//ADD $15, $1, $0 // Rd <- Rn + Rm 
						19: begin
							ready = 1;
							endSignal = startSignal;
							lineNumber = -1;
							reset = 0;
						end
						default: begin
							reset = 1;
							ready = 0; 
						end
					endcase
				end
				1: begin//Resta
					case(lineNumber)
						8: begin ins_address = 8; ins = 32'b11110000010011110000000000000001;;end//SUB $15, $1, $0 // Rd <- Rn - Rm
						19: begin
							ready = 1; 
							endSignal = startSignal;
							lineNumber = -1;
							reset = 0;
						end
						default: begin
							reset = 1;
							ready = 0;
						end
					endcase
				end
				2: begin//Multiplicación
					case(lineNumber)
						8: begin ins_address = 8; ins = 32'b11110000000000001111000000000001;end//MUL $15, $1, $0 // Rd <- Rn * Ra
						19: begin
							ready = 1; 
							endSignal = startSignal;
							lineNumber = -1;
							reset = 0;
						end
						default: begin
							reset = 1;
							ready = 0;
						end
					endcase
				end
				3: begin//Division
					if(datoB == 0) begin//El divisor no puede ser cero
						error = 1;
						ready = 1; 
						endSignal = startSignal;
						lineNumber = -1;
						reset = 0;
					end
					case(lineNumber)
						8:  begin ins_address =  8; ins = 32'b11110000010000100010000000000010;end//SUB   $2, $2, $2   Ra = 0
															//CONDopI_cmdS_Rn__Rd_////////_Rm_
						9:  begin ins_address =  9; ins = 32'b11110000010000110011001000000011;end//SUB   $3, $3, $3   Cont = 0
															//CONDopI_cmdS_Rn__Rd_////////_Rm_
															
						10: begin ins_address = 10; ins = 32'b11110011100001110111000000000001;end//OR    $7, $7, 1    $7 = 1
															//CONDopI_cmdS_Rn__Rd_ROT_Immediat
						11: begin ins_address = 11; ins = 32'b11110011100010001000000000011111;end//OR    $8, $8, 31   $8 = 31
															//CONDopI_cmdS_Rn__Rd_ROT_Immediat
															
						12: begin ins_address = 12; ins = 32'b11110001101000100100000000000111;end//LSL   $4, $2, $7   temp1 = Ra << 1
															//CONDopI_cmdS_Rn__Rd_/////sh/_Rm_
						13: begin ins_address = 13; ins = 32'b11110001101000000101000000101000;end//LSR   $5, $0, 31   temp2 = Rb >> 31
															//CONDopI_cmdS_Rn__Rd_/////sh/_Rm_
						14: begin ins_address = 14; ins = 32'b11110001100001000010000000000101;end//OR    $2, $4, $5   Ra = temp1 | temp2
															//CONDopI_cmdS_Rn__Rd_////////_Rm_
						15: begin ins_address = 15; ins = 32'b11110001101000000000000000000111;end//LSL   $0, $0, $7   Rb = Rb << 1
															//CONDopI_cmdS_Rn__Rd_/////sh/_Rm_
						16: begin ins_address = 16; ins = 32'b11110000010100100110000000000001;end//SUBS  $6, $2, $1   Ra - Rc < 0 ?
															//CONDopI_cmdS_Rn__Rd_////////_Rm_
						17: begin ins_address = 17; ins = 32'b01010000010000100010000000000001;end//SUBPL $2, $2, $1   Ra = Ra - Rc
															//CONDopI_cmdS_Rn__Rd_////////_Rm_
						18: begin ins_address = 18; ins = 32'b01010011100000000000000000000001;end//ORPL  $0, $0, 1    Rb = Rb | 1
															//CONDopI_cmdS_Rn__Rd_ROT_Immediat
						19: begin ins_address = 19; ins = 32'b11110010100000110011000000000001;end//ADD   $3, $3, 1    Cont = Cont + 1
															//CONDopI_cmdS_Rn__Rd_ROT_Immediat
						20: begin ins_address = 20; ins = 32'b11110010010100110110000000100000;end//SUBS  $6, $3, 32   Cont == 32
															//CONDopI_cmdS_Rn__Rd_ROT_Immediat
						21: begin ins_address = 21; ins = 32'b00011010111111111111111111110101;end//BEQ   12           Jump a 12
															//CONDop1L________Immediate_______
															
						22: begin ins_address = 22; ins = 32'b11110010100000001111000000000000;end//ADD $15, $0, 0     $15 = resultado
															//CONDopI_cmdS_Rn__Rd_ROT_Immediat
						356 : begin //El algoritmo requiere de 320 ciclos
							ready = 1; 
							endSignal = startSignal;
							lineNumber = -1;
							reset = 0;
						end
						default: begin
							reset = 1;
							ready = 0; 
						end
					endcase
				end
				4: begin//Módulo
					if(datoB == 0) begin//El divisor no puede ser cero
						error = 1;
						ready = 1; 
						endSignal = startSignal;
						lineNumber = -1;
						reset = 0;
					end
					case(lineNumber)
						8:  begin ins_address =  8; ins = 32'b11110000010000100010000000000010;end//SUB   $2, $2, $2   Ra = 0
															//CONDopI_cmdS_Rn__Rd_////////_Rm_
						9:  begin ins_address =  9; ins = 32'b11110000010000110011001000000011;end//SUB   $3, $3, $3   Cont = 0
															//CONDopI_cmdS_Rn__Rd_////////_Rm_
															
						10: begin ins_address = 10; ins = 32'b11110011100001110111000000000001;end//OR    $7, $7, 1    $7 = 1
															//CONDopI_cmdS_Rn__Rd_ROT_Immediat
						11: begin ins_address = 11; ins = 32'b11110011100010001000000000011111;end//OR    $8, $8, 31   $8 = 31
															//CONDopI_cmdS_Rn__Rd_ROT_Immediat
															
						12: begin ins_address = 12; ins = 32'b11110001101000100100000000000111;end//LSL   $4, $2, $7   temp1 = Ra << 1
															//CONDopI_cmdS_Rn__Rd_/////sh/_Rm_
						13: begin ins_address = 13; ins = 32'b11110001101000000101000000101000;end//LSR   $5, $0, 31   temp2 = Rb >> 31
															//CONDopI_cmdS_Rn__Rd_/////sh/_Rm_
						14: begin ins_address = 14; ins = 32'b11110001100001000010000000000101;end//OR    $2, $4, $5   Ra = temp1 | temp2
															//CONDopI_cmdS_Rn__Rd_////////_Rm_
						15: begin ins_address = 15; ins = 32'b11110001101000000000000000000111;end//LSL   $0, $0, $7   Rb = Rb << 1
															//CONDopI_cmdS_Rn__Rd_/////sh/_Rm_
						16: begin ins_address = 16; ins = 32'b11110000010100100110000000000001;end//SUBS  $6, $2, $1   Ra - Rc < 0 ?
															//CONDopI_cmdS_Rn__Rd_////////_Rm_
						17: begin ins_address = 17; ins = 32'b01010000010000100010000000000001;end//SUBPL $2, $2, $1   Ra = Ra - Rc
															//CONDopI_cmdS_Rn__Rd_////////_Rm_
						18: begin ins_address = 18; ins = 32'b01010011100000000000000000000001;end//ORPL  $0, $0, 1    Rb = Rb | 1
															//CONDopI_cmdS_Rn__Rd_ROT_Immediat
						19: begin ins_address = 19; ins = 32'b11110010100000110011000000000001;end//ADD   $3, $3, 1    Cont = Cont + 1
															//CONDopI_cmdS_Rn__Rd_ROT_Immediat
						20: begin ins_address = 20; ins = 32'b11110010010100110110000000100000;end//SUBS  $6, $3, 32   Cont == 32
															//CONDopI_cmdS_Rn__Rd_ROT_Immediat
						21: begin ins_address = 21; ins = 32'b00011010111111111111111111110101;end//BEQ   12           Jump a 12
															//CONDop1L________Immediate_______
															
						22: begin ins_address = 22; ins = 32'b11110010100000101111000000000000;end//ADD $15, $2, 0     $15 = resultado
															//CONDopI_cmdS_Rn__Rd_ROT_Immediat
						356 : begin //El algoritmo requiere de 320 ciclos para completarse
							ready = 1; 
							endSignal = startSignal;
							lineNumber = -1;
							reset = 0;
						end
						default: begin
							reset = 1;
							ready = 0; 
						end
					endcase
				end
				5: begin //Operacion desconocida
					ready = 1; 
					endSignal = startSignal;
					lineNumber = -1;
					reset = 0;
					error = 1;
				end
				endcase
			end
		endcase
		lineNumber = lineNumber + 1;
	end
end

always @(negedge clk) begin
	write_ins = 1;
end



endmodule
