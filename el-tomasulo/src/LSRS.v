module LSRS(ID_in, CLK, CLR, start, busy, clockInstr, Valor1, Valor2, Valor3, OP_Rd, despacho, ID_out, confirma, CDB, CLK_instr, IRout, depR0, dataR0, depR1, dataR1 );

	/***************************************************************************
	Modulo: LSRS (Load/Store Reservation Station) estação de reserva load-store
	Funcao: recebe instrucoes de load/store e as faz aguardar para que qualquer
	dependencia que exista, seja eliminada. Quando essa espera termina, a
	instrucao e despachada para a unidade aritmetica (UA) correspondente
	Inputs:
		- ID_in: identificador da estacao de reserva
		- start: sinal para a ativacao do funcionamento da estacao
		- CLK_instr: linha da instrucao (que a estacao recebe) no programa
		- confirma: sinal de confirmacao da finalizacao da operacao pela unidade
		aritmetica correspondente
		- CDB: fio para visualização do que ocorre no barramento
		- IR_out: saida do registrador de instrucoes
		- dep0: dependencia (eventualmente) existente no primeiro registrador
		utilizado pela instrucao
		- dataR0: dado existente no primeiro registrador utilizado pela
		instrucao
		- dep1: dependencia (eventualmente) existente no segundo registrador
		utilizado pela instrucao
		- dataR1: dado existente no segundo registrador utilizado pela
		instrucao
	Outputs:
		- busy: sinal de quando a estacao esta ocupada com alguma instrucao
		- clockInstr: linha da instrucao no programa - dessa vez passada para
		- Valor1: recebe o valor do offset
		- Valor2: recebe o endereco base
		- Valor3: recebe o valor a ser guardado
		- OP_Rd: opcode concatenado com o registrador destinado
		- despacho: sinal de que a estacoa esta com os dados da instrucao
		prontos para serem mandados a unidade aritmetica correspondente
		- ID_out: identificador da estacao sendo mandado para os modulos poste-
		riores (UA e CDBArbt)
	***************************************************************************/

	input CLK, CLR, start;
	input confirma;
	input [3:0]ID_in;

	input [19:0] CDB;
	input [15:0]IRout;		//Offset 7 - Rs 3 - Rd 3 - OPCode 3

	input [2:0] depR0, depR1;
	input [15:0] dataR0, dataR1;

	input [9:0] CLK_instr;

	output reg [3:0]ID_out;
	output reg busy;
	output reg despacho;
	output reg [5:0]OP_Rd;
	output reg [15:0] Valor1, Valor2, Valor3;
	output reg [9:0] clockInstr;

	reg [1:0] cont;
	reg [6:0]Offset;
	reg [15:0] Vj, Vk;	//Valores contidos nos registradores
	reg [3:0] Qj, Qk;		//Indica se existe dependencia e se os valores precisam ser atualizados por meio do fowarding
	reg [5:0] OPcode;

	always @(posedge CLK, posedge CLR)begin
		if(CLR)begin
				busy = 1'b0;
				Vj = 16'b0;
				Vk = 16'b0;
				Qj = 4'b0000;
				Qk = 4'b0000;
				OPcode = 6'b0;
				cont = 2'b0;
				clockInstr = 10'b0;
				Offset = 7'b0;
				Valor3 = 16'b0;
		end else begin
			case(cont)
				2'b00: begin
						if(start)begin
							busy = 1'b1;
							Vj = dataR0;
							Vk = dataR1;
							Qj = depR0;
							Qk = depR1;
							OPcode = IRout[5:0];
							Offset = IRout[15:9];
							cont = 2'b01;
							clockInstr = CLK_instr;
						end
				end
				2'b01: begin
						if(OPcode[2:0] == 3'b011) begin //Instrucao de Load
							if(Qk != 4'b0000)begin	//Esperando o valor do registrador para somar ao OFFSET
								if(CDB[19:16] == Qk)begin
									Vk = CDB[15:0];
									Qk = 4'b0000;
								end
							end else begin
								despacho = 1'b1;	//Retirado Valor1 pois nao importa para o Load
								Valor1 = Offset;	//Offset sera somado com Valor2
								Valor2 = Vk;		//Valor2 + Offset
								OP_Rd = OPcode;	//Op code + Reg Dest
								ID_out = ID_in;	//Identificador da estacao
								cont = 2'b10;
							end
						end
						if(OPcode[2:0] == 3'b100) begin	//Instrucao de Store
							if(Qj != 3'b000 || Qk != 3'b000)begin	//Esperando o valor do registrador para somar ao OFFSET e o conteudo a ser armazenado
								if(CDB[19:16] == Qj)begin
									Vj = CDB[15:0];
									Qj = 3'b000;
								end
								if(CDB[19:16] == Qk)begin
									Vk = CDB[15:0];
									Qk = 4'b0000;
								end
							end else begin
								despacho = 1'b1;
								Valor1 = Offset;
								Valor2 = Vk;
								OP_Rd = OPcode;
								ID_out = ID_in;
								cont = 2'b10;
								Valor3 = Vj;		//Agora e necessario enviar o OFFSET

							end
						end
				end
				2'b10: begin
						if(confirma)begin		//Quando a escrita do dado final vai ser realizada enviamos a confirmacao
								busy = 1'b0;	//Esvaziando a estacao de reserva
								Vj = 16'b0;
								Vk = 16'b0;
								Qj = 4'b0000;
								Qk = 4'b0000;
								OPcode = 6'b0;
								cont = 2'b0;
								despacho = 1'b0;
								Offset = 7'b0;
						end
				end

			endcase
		end

	end


endmodule
