module instrRegister(CLK, CLR, IRin, instrIn, instrOut);

	/***************************************************************************
	Modulo: instrRegister
	Funcao: Guardar a instrucao para que o hardware possa utiliza-la.
	Inputs:
		- CLK: sinal de clock para sincronizacao dos módulos não-combinacionais
		- CLR: permite a limpeza assincrona e interna de todos os modulos do
		hardware, sendo recomendado para teste na placa Altera ao inves do uso
		do bloco initial.
		- IRin: sinal que, quando alto, permite que, no proximo ciclo de clock,
		a instrucao que esta em instrIn entre no registrador.
		- instrIn: instrucao de entrada
	Output:
		- instrOut: instrucao de saida
	***************************************************************************/

	input CLK, CLR, IRin;
	input [15:0] instrIn;
	output reg [15:0] instrOut;

	always @(negedge CLK, posedge CLR) begin
		if (CLR) begin
			instrOut = 16'b0;
		end else if (IRin) begin
			// Colocando a instrucao no registrador
			instrOut = instrIn;
		end
	end

endmodule
