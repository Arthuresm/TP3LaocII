module UA_Address(CLK, CLR, start, finalizado, ID_RS_in, Dado1, Dado2, Dado3, OP_Rd, Resultado, confirmacao, busy, desWrAS);

	/***************************************************************************
	Modulo: UA_Address (unidade aritmetica de endereco)
	Funcao: realizar o calculo de enderecos necessario para as instrucoes de
	load e store.
	Inputs:
		- start: sinal para comeco da execucao na unidade
		- finalizado:
		- ID_RS_in: identificador da estacao de reserva que mandou a operacao
		para a unidade
		- Dado1: recebe o valor do offset da estacao que mandou o dado
		- Dado2: recebe o endereco base
		- Dado3: recebe o valor a ser guardado na memoria
		- OP_Rd: opcode concatenado com o registrador destino
	Outputs:
		- Resultado: resultado da operacao concatenado com o identificador da
		estacao de reserva responsavel pela instrucao
		- confirmacao: confimacao de que a unidade ja terminou a operacao,
		para que a estacao de reserva (que mandou a instrucao) possa ser
		liberada
		- busy: aviso de que a unidade esta ocupada
		- desWrAS: quando igual a desWrASLS (UA_Address), faz com que o CDBArbt
		desabilite a escrita no banco
	***************************************************************************/

	input CLK, CLR, start, finalizado;
	input [15:0]Dado1, Dado2, Dado3;
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
			case (cont)
				2'b00: begin // 1o ciclo
					desWrAS = 1'b1;
					if (start) begin
						desWrAS = 1'b0;
						busy = 1'b1;
						cont = 2'b01;
						ID_RS = ID_RS_in;
						Rd = OP_Rd[5:3];
						Resultado[19:16] = ID_RS;
						Resultado[22:20] = Rd;
						Resultado[15:0] = Dado1 + Dado2;
						confirmacao = 1'b1;


					end
				end

				2'b01: begin
						if(finalizado) begin
							busy = 1'b0;
							cont = 2'b00;
							confirmacao = 1'b0;

						end
				end
			endcase
		end
	end
endmodule
