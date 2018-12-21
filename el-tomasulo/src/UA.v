module UA(CLK, CLR, start, ID_RS_in, Dado1, Dado2, OP_Rd, Resultado, confirmacao, busy, desWrAS);

	/***************************************************************************
	Modulo: UA (unidade aritmetica)
	Funcao: Realizar, em tres ciclos, a operacao escolhida (entre add/sub) para
	os dados de entrada.
	Inputs:
		- start: sinal para que a unidade comece a realizar a operacao
		- ID_RS_in: identificador da estacao de reserva que mandou os dados para
		execucao
		- Dado1: dado 1 para execucao
		- Dado2: dado 2 para execucao
		- OP_Rd: opcode (que delimita a operacao a ser realizada) concatenado
		com o registrador de destino
	Outputs:
		- Resultado: resultado da operacao, concatenado com o ID da estacao de
		reserva que requisitou a execucao e o registrador destino da instrucao
		- confirmacao: confirmacao de que a operacao terminou - enviada para a
		estacao de reserva que requereu a execucao
		- busy: sinal de que a unidade esta ocupada
		- desWrAS: quando igual a desWrASLS (UA_Address), faz com que o CDBArbt
		desabilite a escrita no banco
	***************************************************************************/

	input CLK, CLR, start;
	input [15:0]Dado1, Dado2;
	input [5:0]OP_Rd;
	input [3:0]ID_RS_in;

	output reg desWrAS;		//Confirmacao da reinicializacao
	output reg confirmacao;	//Confirmacao geral
	output reg busy;			//Representa se a unidade esta em atividade
	output reg [22:0] Resultado;		//22-20 Reg Dest  --  19-16 ID Estacao de Reserva  --  15-0 Resultado

	//Registradores auxiliares
	reg [2:0]Rd;
	reg [3:0]ID_RS;
	reg [1:0]cont;

	always @(posedge CLK, posedge CLR)begin
		if(CLR)begin
			cont = 2'b00;
			Resultado = 23'b0;
			confirmacao = 1'b0;
			busy = 1'b0;
			ID_RS = 4'b0000;
		end else begin
			confirmacao = 1'b0;
			case (cont)
				2'b00: begin // 1o ciclo
					desWrAS = 1'b1;
					if (start) begin
						desWrAS = 1'b0;
						busy = 1'b1;
						cont = 2'b01;
						ID_RS = ID_RS_in;
						Rd = OP_Rd[5:3];
					end
				end
				2'b01: begin // 2o ciclo
					cont = 2'b10;
					Resultado[19:16] = ID_RS;
					confirmacao = 1'b1;
				end
				2'b10: begin // 3o ciclo
					case(OP_Rd[2:0])
						// Caso add/sub
						3'b001 :	Resultado[15:0] = Dado1 + Dado2;		//Soma
						3'b010 :	Resultado[15:0] = Dado1 - Dado2;		//Subtracao
						// Caso load/store
						3'b011 : Resultado[15:0] = Dado1 + Dado2;		//Calculo de endereco para L e S
						3'b100 : Resultado[15:0] = Dado1 + Dado2;
						default: ;
					endcase

					busy = 1'b0;
					cont = 2'b00;

					Resultado[22:20] = Rd;
				end
			endcase
		end
	end
endmodule
