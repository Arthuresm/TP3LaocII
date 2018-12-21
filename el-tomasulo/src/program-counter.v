module programCounter(CLK, CLR, incr, addrOut);

	/***************************************************************************
	Modulo: programCounter
	Funcao: fornecer um endereco para a unidade de instrucoes e incrementa-lo
	enquanto a fila nao e preenchida.
	Inputs:
		- CLK: sinal de clock para sincronizacao dos módulos não-combinacionais
		- CLR: permite a limpeza assincrona e interna de todos os modulos do
		hardware, sendo recomendado para teste na placa Altera ao inves do uso
		do bloco initial.
		- incr: quando ativo, o endereco fornecido e incrementado na proxima
		subida do clock. Fica ativo enquanto a fila de instrucoes nao esta cheia
	Output:
		- addrOut: endereco fornecido para a memoria de instrucoes
	***************************************************************************/

	input CLK, CLR, incr;
	output reg [4:0] addrOut;

	//Incrementa = incr e depende diretamente do estado atual da fila
	//ou seja se ela pode receber mais dados ou nao.
	always @(negedge CLK, posedge CLR) begin
		if (CLR) begin
			addrOut = 5'b0;
		end else if (incr) begin
			addrOut = addrOut + 1'b1;
		end
	end

endmodule
