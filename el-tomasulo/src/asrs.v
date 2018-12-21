module ASRS(ID_in, CLK, CLR, start, busy, clockInstr, Valor1, Valor2, OP_Rd, despacho, ID_out, confirma, CDB, CLK_instr, IRout, depR0, dataR0, depR1, dataR1 );

	/***************************************************************************
	Modulo: ASRS (Add/Sub Reservation Station)
	Funcao: Armazena os dados requeridos pelas instrucoes e dependencias
	eventualmente relacionados a eles, resolvendo hazards de dados dos tipos
	RAW, WAR e WAW. Libera a instrucao para a unidade aritmetica quando todos os
	dados estao disponiveis. Permanece ocupada enquanto a unidade nao informar
	que terminou a operacao correspondente a instrucao que esta dentro da
	estacao.
	Inputs:
		- ID_in: identificador da estacao (unico para cada instancia)
		- start: qual o sinal fica alto durante uma borda positiva do clock, a
		estacao comeca a operar
		- confirma: sinal vindo da Unidade Aritmetica correspondente
		- CDB: fio para monitoramento do CDB
		- CLK_instr: linha em que a instrucao se encontra no programa
		- IRout: saida do registrador de instrucoes
		- depR0: dependencia encontrada para o R0 pedido
		- dataR0: dado recebido para R0
		- depR1: dependencia encontrada para o R0 pedido
		- dataR1: dado recebido para R1
	Outputs:
		- busy: indicacao que a estacoa esta ocupada com alguma instrucao
		- clockInstr: linha em que a instrucao se encontra no programa
		- Valor1: valor 1 precisado pela instrucao
		- Valor2: valor 2 precisado pela instrucao
		- OP_Rd: opcode concatenado com o registrador destino
		- despacho: indica que os dados da instrucao estao prontos para serem
		passados para uma unidade aritmetica
	***************************************************************************/

	input CLK, CLR, start;
	input confirma;
	input [3:0]ID_in;

	input [19:0] CDB;
	input [15:0]IRout;		//Offset 7 - Rs 3 - Rd 3 - OPCode 3

	input	 [2:0] depR0, depR1;
	input [15:0] dataR0, dataR1;

	input [9:0] CLK_instr;

	output reg [3:0]ID_out;
	output reg busy;
	output reg despacho;
	output reg [5:0]OP_Rd;
	output reg [15:0] Valor1,Valor2;
	output reg [9:0] clockInstr;

	reg [1:0] cont;

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
		end else begin
			case(cont)
				2'b00: begin
						if(start)begin	//Iniciando a estacao e fazendo as atribuicoes referentes aos dados requisitados
							busy = 1'b1;
							Vj = dataR0;
							Vk = dataR1;
							Qj = depR0;
							Qk = depR1;
							OPcode = IRout[5:0];
							cont = 2'b01;
							clockInstr = CLK_instr;
						end
				end
				2'b01: begin
						if(Qj != 3'b000 || Qk != 3'b000)begin	//Enquanto existe dependencia nao podemos prosseguir
							if(CDB[19:16] == Qj)begin
								Vj = CDB[15:0];
								Qj = 3'b000;
							end
							if(CDB[19:16] == Qk)begin
								Vk = CDB[15:0];
								Qk = 4'b0000;
							end
						end else begin		//Dependencia foi atulizada e entao podemos prosseguir
							despacho = 1'b1;
							Valor1 = Vj;
							Valor2 = Vk;
							OP_Rd = OPcode;
							ID_out = ID_in;
							cont = 2'b10;
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
						end
				end

			endcase
		end

	end


endmodule
