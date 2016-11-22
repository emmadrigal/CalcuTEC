`timescale 1ns / 1ps
// Importante solo use if que verifiquen que se apreta ya que si uso una maquina de estados
// tendria que hace las mimas comparaciones muchas veces.

module calculogic(
 //Inputs
	input clk,
	input [9:0] mousex,
	input [9:0] mousey,
	input mouseclick,
	
	
	//Ouputs
	output wire [6:0] que_dibujar,
	output wire [6:0] que_simbolo
	);
/*
Los valores que puede tomar el  signo son:
97: %
98: /
99: +
100: -
101: x
*/



localparam SymbolSize = 64 ;
localparam Numerounor = 90;
localparam Numerounot = 150;
localparam cleanr = 560;
localparam cleant = 150;
localparam signor = 30;
localparam signot = 70;

// turno dice que primeros se deben escribir 1 o 2 numeros luego el signo y luego 2 o 1 numero
reg[2:0] turno = 1; //se utiliza para saber si se debe escribir un numero o una funcion es para impedir errores 
reg cambio = 1; // se utiliza para no escribir el mismo numero dos veces error de que escribe 11 al apretar 1 por ejemplo

reg [6:0] primervalor =7'bzzzzzzz;//sirve para guardar el valor del primer numero
reg [6:0] segundovalor =7'bzzzzzzz;//sirve para guardar el valor del segundo numero
reg [6:0] resultado = 0;
reg [6:0] signoaux = 103; //sirve para guardar el valor del signo
reg [6:0] que_dibujaraux = 0; // salida de que va a dibujar
reg [6:0] que_simboloaux = 103; // salida del simbolo que va a dibujar diferente ya que al ser un numero puede generar errores 



always@ (posedge clk) begin
	if (mouseclick) begin // ve si ya se apreto un numero no escribe otro hasta que suelte el click
	// aqui dependiendo de donde se de click se cambia el que se va a dibujar
			if ((mousex >= Numerounor) && (mousex <= (Numerounor + 1*SymbolSize)) && (mousey >= Numerounot) && (mousey <= (Numerounot + SymbolSize)))begin
				if (turno == 1)begin
				primervalor = 1;
				que_dibujaraux = primervalor;
				turno = turno+1;
				end
				else if(turno == 3)begin
				segundovalor = 1;
				que_dibujaraux = segundovalor;
				turno = turno+1;
				end
			end
			else if ((mousex >= (Numerounor + 2*SymbolSize)) && (mousex <= (Numerounor + 3*SymbolSize)) && (mousey >= Numerounot) && (mousey <= (Numerounot + SymbolSize)))begin
				if (turno == 1)begin
				primervalor = 2;
				que_dibujaraux = primervalor;
				turno = turno+1;
				end
				else if(turno == 3)begin
				segundovalor = 2;
				que_dibujaraux = segundovalor;
				turno = turno+1;
				end
			end
		   else  if ((mousex >= (Numerounor + 4*SymbolSize)) && (mousex <= (Numerounor + 5*SymbolSize)) && (mousey >= Numerounot) && (mousey <= (Numerounot + SymbolSize)))begin
				if (turno == 1)begin
				primervalor = 3;
				que_dibujaraux = primervalor;
				turno = turno+1;
				end
				else if(turno == 3)begin
				segundovalor = 3;
				que_dibujaraux = segundovalor;
				turno = turno+1;
				end
			end
			else if ((mousex >= Numerounor) && (mousex <= (Numerounor + 1*SymbolSize)) && (mousey >= Numerounot + SymbolSize+25) && (mousey <= (Numerounot + 2*SymbolSize+25)))begin
				if (turno == 1)begin
				primervalor = 4;
				que_dibujaraux = primervalor;
				turno = turno+1;
				end
				else if(turno == 3)begin
				segundovalor = 4;
				que_dibujaraux = segundovalor;
				turno = turno+1;
				end
			end
			else if ((mousex >= (Numerounor + 2*SymbolSize)) && (mousex <= (Numerounor + 3*SymbolSize)) && (mousey >= Numerounot + SymbolSize+25) && (mousey <= (Numerounot + 2*SymbolSize+25)))begin
				if (turno == 1)begin
				primervalor = 5;
				que_dibujaraux = primervalor;
				turno = turno+1;
				end
				else if(turno == 3)begin
				segundovalor = 5;
				que_dibujaraux = segundovalor;
				turno = turno+1;
				end
			end
			else if ((mousex >= (Numerounor + 4*SymbolSize)) && (mousex <= (Numerounor + 5*SymbolSize)) && (mousey >= Numerounot + SymbolSize+25) && (mousey <= (Numerounot + 2*SymbolSize+25)))begin
				if (turno == 1)begin
				primervalor = 6;
				que_dibujaraux = primervalor;
				turno = turno+1;
				end
				else if(turno == 3)begin
				segundovalor = 6;
				que_dibujaraux = segundovalor;
				turno = turno+1;
				end
			end 
			else if ((mousex >= Numerounor) && (mousex <= (Numerounor + 1*SymbolSize)) && (mousey >= Numerounot + 2*SymbolSize+50) && (mousey <= (Numerounot + 3*SymbolSize+50)))begin
				if (turno == 1)begin
				primervalor = 7;
				que_dibujaraux = primervalor;
				turno = turno+1;
				end
				else if(turno == 3)begin
				segundovalor = 7;
				que_dibujaraux = segundovalor;
				turno = turno+1;
				end
			end  
			else if ((mousex >= (Numerounor + 2*SymbolSize)) && (mousex <= (Numerounor + 3*SymbolSize)) && (mousey >= Numerounot + 2*SymbolSize+50) && (mousey <= (Numerounot + 3*SymbolSize+50)))begin
				if (turno == 1)begin
				primervalor = 8;
				que_dibujaraux = primervalor;
				turno = turno+1;
				end
				else if(turno == 3)begin
				segundovalor = 8;
				que_dibujaraux = segundovalor;
				turno = turno+1;
				end
			end  
			else if ((mousex >= (Numerounor + 4*SymbolSize)) && (mousex <= (Numerounor + 5*SymbolSize)) && (mousey >= Numerounot + 2*SymbolSize+50) && (mousey <= (Numerounot + 3*SymbolSize+50)))begin
				if (turno == 1)begin
				primervalor = 9;
				que_dibujaraux = primervalor;
				turno = turno+1;
				end
				else if(turno == 3)begin
				segundovalor = 9;
				que_dibujaraux = segundovalor;
				turno = turno+1;
				end
			end  
			else if ((mousex >= Numerounor) && (mousex <= (Numerounor + 1*SymbolSize)) && (mousey >= Numerounot + 3*SymbolSize+75) && (mousey <= (Numerounot + 4*SymbolSize+75)))begin
				if (turno == 1)begin
				primervalor = 0;
				que_dibujaraux = primervalor;
				turno = turno+1;
				end
				else if(turno == 3)begin
				segundovalor = 0;
				que_dibujaraux = segundovalor;
				turno = turno+1;
				end
			end
			// Aqui comienza la funcionalidad de los signos se ve si apreta un signo y si ya eligio un numero primero	
			else if ((mousex >= (Numerounor + 6*SymbolSize)) && (mousex <= (Numerounor + 7*SymbolSize)) && (mousey >= Numerounot + SymbolSize+25) && (mousey <= (Numerounot + 2*SymbolSize+25)))begin
				if (turno == 2)begin
				signoaux = 97;
				que_simboloaux = signoaux;
				turno = turno+1;
				end
			end
			else if ((mousex >= (Numerounor + 6*SymbolSize)) && (mousex <= (Numerounor + 7*SymbolSize)) && (mousey >= Numerounot + 2*SymbolSize+50) && (mousey <= (Numerounot + 3*SymbolSize+50)))begin
				if (turno == 2)begin
				signoaux = 98;
				que_simboloaux = signoaux;
				turno = turno+1;
				end
			end
			else if ((mousex >= (Numerounor + 2*SymbolSize)) && (mousex <= (Numerounor + 3*SymbolSize)) && (mousey >= Numerounot + 3*SymbolSize+75) && (mousey <= (Numerounot + 4*SymbolSize+75)))begin
				if (turno == 2)begin
				signoaux = 99;
				que_simboloaux = signoaux;
				turno = turno+1;
				end
			end
			else if ((mousex >= (Numerounor + 4*SymbolSize)) && (mousex <= (Numerounor + 5*SymbolSize)) && (mousey >= Numerounot + 3*SymbolSize+75) && (mousey <= (Numerounot + 4*SymbolSize+75)))begin
				if (turno == 2)begin
				signoaux = 100;
				que_simboloaux = signoaux;
				turno = turno+1;
				end
			end
			else if ((mousex >= (Numerounor + 6*SymbolSize)) && (mousex <= (Numerounor + 7*SymbolSize)) && (mousey >= Numerounot + 3*SymbolSize+75) && (mousey <= (Numerounot + 4*SymbolSize+75)))begin
				if (turno == 2)begin
				signoaux = 101;
				que_simboloaux = signoaux;
				turno = turno+1;
				end
			end
			//funcionalidad del = 
			// en esta parte emma debes poner lo del arms con el primer valor y el segundo valor 
			// y el signoaux es la funcion segun su numero solo debes quitar esos if y guardar en resultado
			// lo que de el arms
			else if ((mousex >= (Numerounor + 6*SymbolSize)) && (mousex <= (Numerounor + 7*SymbolSize)) && (mousey >= Numerounot) && (mousey <= (Numerounot + SymbolSize)))begin
				if (segundovalor != 7'bzzzzzzz)begin
					if (signoaux == 97)begin
						resultado = primervalor%segundovalor;
						que_dibujaraux = resultado;
					end
					else if (signoaux == 98)begin
						resultado = primervalor/segundovalor;
						que_dibujaraux = resultado;
					end
					else if (signoaux == 99)begin
						resultado = primervalor+segundovalor;
						que_dibujaraux = resultado;
					end
					else if (signoaux == 100)begin
						resultado = primervalor-segundovalor;
						que_dibujaraux = resultado;
					end
					else if (signoaux == 101)begin
						resultado = primervalor*segundovalor;
						que_dibujaraux = resultado;
					end
				end
			end
		// aqui verifico si le da click a la c de clean
		if ((mousex >= cleanr) && (mousex <= (cleanr + 1*SymbolSize)) && (mousey >= cleant) && (mousey <= (cleant + SymbolSize))&& mouseclick==1) begin
				primervalor = 0; // vuelvo a sus valores originales los valore guardados de los numeros y el signo
				signoaux = 103;
				segundovalor = 0; 
				que_dibujaraux = primervalor; // dibujo los nuevos valores
				que_simboloaux = signoaux; // dibujo el nuevo signo
				turno = 1;
		end
		
	end
end

assign que_dibujar = que_dibujaraux; 
assign que_simbolo = que_simboloaux;

endmodule
