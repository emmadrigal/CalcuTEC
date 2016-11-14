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
	
	
reg [4:0] lineNumber = 0;
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
			2: begin ins_address = 2; ins = {{24'b111100111000000000000100}, datoA[23:16]};end//OR $0, $0, datoA[23:16]
			3: begin ins_address = 3; ins = {{24'b111100111000000000000010}, datoA[31:24]};end//OR $0, $0, datoA[31:24]
			//Fija el valor del segundo
			4: begin ins_address = 4; ins = {{24'b111100111000000100010000}, datoB[7:0]};end//OR $1, $1, datoB[7:0]
			5: begin ins_address = 5; ins = {{24'b111100111000000100011100}, datoB[15:8]};end//OR $1, $1, datoB[15:8]
			6: begin ins_address = 6; ins = {{24'b111100111000000100010100}, datoB[23:16]};end//OR $1, $1, datoB[23:16]
			7: begin ins_address = 7; ins = {{24'b111100111000000100010010}, datoB[31:24]};end//OR $1, $1, datoB[31:24]
			
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
					if(datoB == 0)//El divisor no puede ser cero
						error = 1;
					case(lineNumber)
						8: begin ins_address = 8; ins = 32'b11110000100000011111001000000000;end//
						//Implementar Algoritmo de División 
						//Ejecutar el reloj del procesador ? veces
					endcase
					ready = 1;
				end
				4: begin//Módulo
					if(datoB == 0)//El divisor no puede ser cero
						error = 1;
					case(lineNumber)
						8: begin ins_address = 8; ins = 32'b11110000100000011111001000000000;end//
						//Implementar Algoritmo de División 
						//Ejecutar el reloj del procesador ? veces
					endcase
					ready = 1;
				end
				5: begin //Operacion desconocida
					ready = 1;
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
