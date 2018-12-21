module registerFile(CLK, CLR, wren, numW, depW, wdep, depID, dadoDep, dataW, numR0, depR0, dataR0, numR1, depR1, dataR1);

	/***************************************************************************
	Modulo: registerFile
	Funcao: Armazena os dados dos registradores (0-7) e o numero identificador
	das estacoes que forem escrever neles (dependencia), quando for o caso. A
	variavel |regs| representa os registradores. Ja |depRegs| armazena as
	dependencias que existirem.
	Inputs:
		- wren: habilita escrita de dado(s)
		- wdep: habilita escrita de dependencia
		- numW: numero do registrador em que se deseja escrever um dado
		- numR0: numero do primeiro registrador para leitura
		- numR1: numero do segundo registrador para leitura
		- depID: numero do registrador em que deseja escrever uma dependencia
		- depW: dependencia que se deseja escrever em depID
		- dadoDep: o mesmo que depW
		- dataW: dado que se deseja escrever em numW
	Outputs:
		- depR0: dependencia lida do primeiro registrador destinado a leitura
		- depR1: dependencia lida do segundo registrador destinado a leitura
		- dataR0: dado lido do primeiro registrador destinado a leitura
		- dataR1: dado lido do segundo registrador destinado a leitura
	***************************************************************************/

	input CLK, CLR, wren, wdep;
	input [2:0] numW, numR0, numR1, depID; 	//Indice de escrita , Indice do R0, Indice do R1 , dependencia
	input [3:0] depW, dadoDep;
	input [15:0] dataW; 	//Dado a ser escrito

	output reg [3:0] depR0, depR1;		//Dependencia 0 e 1
	output reg [15:0] dataR0, dataR1;	//Dado lido em 0 e 1

	reg [15:0] regs[7:0];	//Conjunto de registradores (guardam dados)
	reg [3:0] depRegs[7:0];	//Conjunto de registradores de dependencia
	reg [2:0] R0, R1;		//Registradores de apoio

	always @(posedge CLK, posedge CLR) begin
		if (CLR) begin	//Inicializacao
			regs[0] = 16'b01;
			regs[1] = 16'b010;
			regs[2] = 16'b011;
			regs[3] = 16'b0100;
			regs[4] = 16'b0101;
			regs[5] = 16'b0110;
			regs[6] = 16'b0111;
			regs[7] = 16'b00011000;

			depRegs[0] = 4'b0;
			depRegs[1] = 4'b0;
			depRegs[2] = 4'b0;
			depRegs[3] = 4'b0;
			depRegs[4] = 4'b0;
			depRegs[5] = 4'b0;
			depRegs[6] = 4'b0;
			depRegs[7] = 4'b0;
		end else begin
			if (wren) begin				//Escrita do dado contido no CDB
				if (depW == 4'b0000) begin
					depRegs[numW] = 4'b0000;		//Nao há dependencia nesse registrador
					regs[numW] = dataW;				//Dado escrito
				end
			end
			if (wdep) begin	//Escrita de dependencia no registrador destino de uma operacao
				depRegs[depID] = dadoDep; //Ha dependencia nesse registrador
			end
			R0 = numR0;
			// Confere se ha dependencia no registrador de leitura R0
			if (depRegs[R0] != 4'b0000) begin
				depR0 = depRegs[R0];	//Indica a dependencia
			// Nao ha depedencia
			end else begin
				depR0 = 4'b0000;
				dataR0 = regs[R0]; //Dado lido
			end

			R1 = numR1;
			// Confere se ha dependencia no registrador de leitura R1
			if (depRegs[R1] != 4'b0000) begin
				depR1 = depRegs[R1]; //Indica a dependencia
			// Nao ha depedencia
			end else begin
				depR1 = 4'b0000;
				dataR1 = regs[R1];	//Dado lido
			end
		end

	end

endmodule
