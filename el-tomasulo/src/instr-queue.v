module instrQueue(CLK, CLR, cheio, vazio, adc, rtr, instrIn, instrOut);	//Fila de instrucoes

	/***************************************************************************
	Modulo: instrQueue
	Funcao: armazenar as instrucoes, em ordem, que foram recebidas da unidade de
	instrucoes e deixar elas prontas para quando o hardware requisita-las.
	Inputs:
		- CLK: sinal de clock para sincronizacao dos módulos não-combinacionais
		- CLR: permite a limpeza assincrona e interna de todos os modulos do
		hardware, sendo recomendado para teste na placa Altera ao inves do uso
		do bloco initial.
		- adc: sinal que, quando alto, avisa a fila para receber mais uma
		instrucao da unidade de instrucoes.
		- rtr: sinal que, quando alto, avisa a fila para enviar a sua 'cabeca'
		como saida.
		- instrIn: instrucao vinda da unidade de instrucoes
	Outputs:
		- cheio: avisa ao mundo externo que a fila esta cheia
		- vazio: avisa ao mundo externo que a fila esta vazia
		- instrOut: instrucao que sai da fila
	***************************************************************************/

	input CLK, CLR, adc, rtr;
	input [15:0] instrIn;
	output cheio, vazio;
	output reg [15:0] instrOut;

	reg [2:0] frente, tras;	//Para auxiliar na manipulacao da fila
	reg [7:0] iValid;			//Para mostrar que a instrucao a ser retirada e valida
	reg [15:0] instrs[7:0];	//Instrucoes armazenadas

	assign cheio = iValid[0] & iValid[1] & iValid[2] & iValid[3] & iValid[4] & iValid[5] & iValid[6] & iValid[7];
	assign vazio = ~iValid[0] & ~iValid[1] & ~iValid[2] & ~iValid[3] & ~iValid[4] & ~iValid[5] & ~iValid[6] & ~iValid[7];

	always @(posedge CLK, posedge CLR) begin
		if (CLR) begin	//Inicializacao
			iValid[7:0] = 8'b0;
			frente = 3'b0;
			tras = 3'b0;
		end else begin
			if (adc && ~cheio) begin	//So e possivel adicionar se nao estiver cheia
				instrs[tras] = instrIn;
				iValid[tras] = 1'b1;
				tras = tras + 1'b1;
			end
			if (rtr) begin
				if (~vazio) begin		//So e possivel retirar se nao estiver vazia
					instrOut = instrs[frente];
					iValid[frente] = 1'b0;
					frente = frente + 1'b1;
				end
			end
		end
	end

endmodule
