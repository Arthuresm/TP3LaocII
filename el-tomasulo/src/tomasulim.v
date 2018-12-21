module tomasulim(CLK, CLR);

	/***************************************************************************
	Modulo: Tomasulim
	Função: unir os demais modulos que compoem o hardware do tomasulo, promoven-
	do a devida comunicacao e sincronizacao entre eles.
	Inputs:
		- CLK: sinal de clock para sincronizacao dos módulos não-combinacionais
		- CLR: permite a limpeza assincrona e interna de todos os modulos do
		hardware, sendo recomendado para stall na placa Altera ao inves do uso
		do bloco initial.
	***************************************************************************/

	input CLK, CLR;

	reg [9:0] counter;
	reg [9:0] maisAntiga;
	reg [1:0] quemSai;
	reg [1:0] quemSai2;
	reg [3:0] stall;

	wire [4:0] addrOut;
	wire [3:0] depR0, depR1;
	wire [15:0] q, instrOut, IRout, dataR0, dataR1;
	wire cheio, vazio;

	reg [2:0]step;
	wire adiciona;
	reg adc, rtr;											//Controle da fila de instrucoes
	wire [8:0]busy;										//Controle de preenchimento das estacoes de reserva
	reg [8:0] start;										//Controle de inicio da estacao utilizada
	reg [2:0] dependencia0, dependencia1;			//Dependencias geradas
	reg [15:0] dado0,dado1;								//Possiveis dados referentes aos registradores

	reg IRin; 					//Habilita escrita do Registrador de Instrucoes
	reg [2:0] numR0,numR1;	//Indice correspondente aos registradores
	reg wren;					//Habilita escrita do banco de registradores
	wire wren_cdb;				//Manipulado pelo CDB Arbiter

	reg [3:0] depW, numW;	//Dependencia / Registrador de escrita
	wire [3:0] RD;				//Registrador destino dado pelo CDB Arbt

	// Variaveis para a estacao de addSub
	wire [9:0] clockInstr[3:0];
	wire [15:0] Valor1[3:0];
	wire [15:0] Valor2[3:0];
	wire [5:0] OP_Rd[3:0];
	wire [3:0] despacho, confirma;
	wire [3:0] ID_out[3:0];

	wire [19:0] CDB;

	// Variaveis para a estacao de loadStore
	wire [9:0] clk_instLS[3:0];
	wire [15:0] Valor3[3:0];
	wire [15:0] Valor4[3:0];
	wire [15:0] Valor5[3:0];
	wire [5:0] OP_Rd2[3:0]; //Op Code e RegDest de Load e Store
	wire [3:0] despacho2;
	wire [7:0] confirma2;
	wire [3:0] ID_out2[3:0];

	// Variaveis para a UA de add e sub
	reg strAddSub;
	reg [3:0] IDaddSub;
	reg [15:0] Dado1, Dado2;
	reg [5:0] OP_RdAddSub;
	wire [22:0] resultAddSub;
	wire confAddSub, busyAddSub;
	wire desWrAS;

	// Variaveis para a UA de load e store
	reg strLoadStore;
	reg [3:0] IDloadStore;
	reg [15:0] Dado3, Dado4, Dado5;
	reg [5:0] OP_RdLoadStore;
	wire [22:0] resultLoadStore;
	wire confAddress, busyLoadStore;
	wire desWrASLS;

	//Variaveis para a unidade de memoria
	reg confLoadStore, confLoad;
	reg [15:0]Dadolido;
	reg latencia;
	reg WMen;	//Habilita escrita da memoria

	always @(posedge CLK, posedge CLR) begin
		//Resetando as variaveis
		if(CLR)begin
			adc = 1'b0;
			rtr = 1'b0;
			step = 3'b0;
			IRin = 1'b0;
			numR0 = 3'b0;
			numR1 = 3'b0;
			start = 9'b0;
			Dadolido = 16'b0;
			wren = 1'b0;
			counter = 10'b0;
			maisAntiga = 10'b1111111111;
			strAddSub = 1'b0;
			strLoadStore = 1'b0;
			stall = 4'b0000;
			latencia = 1'b0;
			WMen = 1'b0;
		end else begin
			strAddSub = 1'b0;
			strLoadStore = 1'b0;
			maisAntiga = 10'b1111111111;
			WMen = 1'b0;

			if(~latencia) begin
				confLoadStore = 1'b0;
			end
			case(step)
				// ISSUE
				//PC incrementa e manda o endereco para a memoria
				3'b000:	begin
					step = 3'b001;
				end
				//Saida da memoria vai para a fila
				3'b001:	begin
					step = 3'b010;
					adc = 1'b1;
				end
				//Preparando para retirar da fila
				3'b010:	begin
					step = 3'b011;
					rtr = 1'b1;
				end
				//Habilitando a entrada de IR e retirando da fila
				3'b011:	begin
					wren = 1'b0;
					step = 3'b100;
					rtr = 1'b0;
					IRin = 1'b1;			//So toma efeito no proximo ciclo
				end
				//Preparando a requisicao de dados
				3'b100: begin
					IRin = 1'b0;					// Desligando sinal da etapa anterior
					counter = counter + 1'b1;
					numR0 = IRout[5:3];			//BUSCANDO NO BANCO DE REGISTRADORES, so tem efeito no proximo ciclo
					numR1 = IRout[8:6];
					step = 3'b101;
				end

				// ID
				//Buscando Estacao
				3'b101: begin
					if(IRout[2:0] == 3'b001 || IRout[2:0] == 3'b010)begin
						if(~busy[1])begin
							start[1] = 1'b1;
							depW = 4'b0001;
							numW = numR0;
							step = 3'b110;
						end else if(~busy[2]) begin
							start[2] = 1'b1;
							depW = 4'b0010;
							numW = numR0;
							step = 3'b110;
						end
						// As linhas abaixo foram comentadas para que se
						// simulasse que nao existem mais de duas estacoes de
						// add/sub
//						else if(~busy[3]) begin
//							start[3] = 1'b1;
//							depW = 4'b0011;
//							numW = numR0;
//							step = 3'b110;
//						end else if(~busy[4]) begin
//							start[4] = 1'b1;
//							depW = 4'b0100;
//							numW = numR0;
//							step = 3'b110;
//						end
						else begin
							stall = 4'b0001;
							//Logica de stall, ja que nao existe nenhuma estacao disponivel
							// Nao e necessario fazer nada
						end
					end

					if(IRout[2:0] == 3'b011 || IRout[2:0] == 3'b100 )begin	//Load Store
							if(~busy[5])begin
								start[5] = 1'b1;
								depW = 4'b0101;
								numW = numR0;
								step = 3'b110;
							end else if(~busy[6]) begin
								start[6] = 1'b1;
								depW = 4'b0110;
								numW = numR0;
								step = 3'b110;
							end
							// As linhas abaixo foram comentadas para que se
							// simulasse que nao existem mais de duas estacoes de
							// load/store
//							else if(~busy[7]) begin
//								start[7] = 1'b1;
//								depW = 4'b0111;
//								numW = numR0;
//								step = 3'b110;
//							end else if(~busy[8]) begin
//								start[8] = 1'b1;
//								depW = 4'b1000;
//								numW = numR0;
//								step = 3'b110;
//							end
							else begin
								stall = 4'b0001;
								//Logica de stall, ja que nao existe nenhuma estacao disponivel
								// Nao e necessario fazer nada
							end
					end
				end
				// Uma estacao foi achada
				3'b110 : begin
					if(~confAddSub & ~confLoadStore)begin
						if(IRout[2:0] != 3'b100)
							wren = 1'b1; //Escrevendo dependencia
						step = 3'b010; // Reiniciando processo de ISSUE
						start = 9'b000000000;
					end
				end
			endcase

			// EXEC
			// Conferindo se alguma estacao quer despachar
			if ((despacho[0] || despacho[1] || despacho[2] || despacho[3]) && ~busyAddSub) begin
				if (despacho[0] && clockInstr[0] < maisAntiga) begin
					
					maisAntiga = clockInstr[0];
					quemSai = 2'b00;
				end
				if (despacho[1] && clockInstr[1] < maisAntiga) begin
					maisAntiga = clockInstr[1];
					quemSai = 2'b01;
				end
				if (despacho[2] && clockInstr[2] < maisAntiga) begin
					maisAntiga = clockInstr[2];
					quemSai = 2'b10;
				end
				if (despacho[3] && clockInstr[3] < maisAntiga) begin
					maisAntiga = clockInstr[3];
					quemSai = 2'b11;
				end
				// Iniciando a UA correspondente;
				strAddSub = 1'b1;
				Dado1 = Valor1[quemSai];
				Dado2 = Valor2[quemSai];
				IDaddSub = ID_out[quemSai];
				OP_RdAddSub = OP_Rd[quemSai];

			end
			//Despacho de Load Store
			if(~confAddress) begin
				if ((despacho2[0] || despacho2[1] || despacho2[2] || despacho2[3]) && ~busyLoadStore) begin
					if (despacho2[0] && clk_instLS[0] < maisAntiga) begin
						
						maisAntiga = clk_instLS[0];
						quemSai2 = 2'b00;
					end
					if (despacho2[1] && clk_instLS[1] < maisAntiga) begin
						maisAntiga = clk_instLS[1];
						quemSai2 = 2'b01;
					end
					if (despacho2[2] && clk_instLS[2] < maisAntiga) begin
						maisAntiga = clk_instLS[2];
						quemSai2 = 2'b10;
					end
					if (despacho2[3] && clk_instLS[3] < maisAntiga) begin
						maisAntiga = clk_instLS[3];
						quemSai2 = 2'b11;
					end
					// Iniciando a UA correspondente;
					strLoadStore = 1'b1;
					Dado3 = Valor3[quemSai2];
					Dado4 = Valor4[quemSai2];
					Dado5 = Valor5[quemSai2];
					IDloadStore = ID_out2[quemSai2];
					OP_RdLoadStore = OP_Rd2[quemSai2];

				end
			end
			//Verificacao se uma UA de Load Store terminou
			if(confAddress) begin
				if(OP_RdLoadStore[2:0] == 3'b011) begin//Instrucao de Load
					if(latencia == 1'b0)begin
						latencia = 1'b1;
						confLoad = 1'b1;
					end	else begin
							confLoadStore = 1'b1;
							Dadolido = q;
							latencia = 1'b0;
							confLoad = 1'b0;
					end
				end

				if(OP_RdLoadStore[2:0] == 3'b100) begin//Instrucao de Store
					WMen = 1'b1;
				end

			end
		end
	end

	assign adiciona = (adc & (~WMen));
	ram1pm instrUnit(confAddress ? resultLoadStore[4:0] : addrOut, CLK, Valor5[quemSai2], WMen, q);						//Memoria de instrucoes
	programCounter pc(CLK, CLR, ~cheio & ~confAddress, addrOut);						//PC
	instrQueue iq(CLK, CLR, cheio, vazio, adiciona, rtr, q, instrOut);	//Fila de instrucoes
	instrRegister IR(CLK, CLR, IRin, instrOut, IRout);					//Registrador de instrucoes

	//Banco de registradores
	registerFile RF(CLK, CLR, wren_cdb,  RD , wren_cdb ? 4'b0000 :	depW , wren, numW, depW, CDB[15:0], numR0, depR0, dataR0, numR1, depR1, dataR1);

	//Estacoes de reserva
	ASRS Est1(4'b0001, CLK, CLR, start[1], busy[1], clockInstr[0], Valor1[0], Valor2[0], OP_Rd[0], despacho[0], ID_out[0], confirma[0], CDB[19:0], counter, IRout, depR0, dataR0, depR1, dataR1 );
	ASRS Est2(4'b0010, CLK, CLR, start[2], busy[2], clockInstr[1], Valor1[1], Valor2[1], OP_Rd[1], despacho[1], ID_out[1], confirma[1], CDB[19:0], counter, IRout, depR0, dataR0, depR1, dataR1 );
	ASRS Est3(4'b0011, CLK, CLR, start[3], busy[3], clockInstr[2], Valor1[2], Valor2[2], OP_Rd[2], despacho[2], ID_out[2], confirma[2], CDB[19:0], counter, IRout, depR0, dataR0, depR1, dataR1 );
	ASRS Est4(4'b0100, CLK, CLR, start[4], busy[4], clockInstr[3], Valor1[3], Valor2[3], OP_Rd[3], despacho[3], ID_out[3], confirma[3], CDB[19:0], counter, IRout, depR0, dataR0, depR1, dataR1 );

	// Unidade aritmetica
	UA addSub(CLK, CLR, strAddSub, IDaddSub, Dado1, Dado2, OP_RdAddSub, resultAddSub, confAddSub, busyAddSub, desWrAS);

	// Decoder
	decoder decConfAddSub(confAddSub, CLR, resultAddSub[19:16], confirma);

	//Estacoes de reserva LOAD - STORE
	LSRS Est5(4'b0101, CLK, CLR, start[5], busy[5], clk_instLS[0], Valor3[0], Valor4[0], Valor5[0], OP_Rd2[0], despacho2[0], ID_out2[0], confirma2[4], CDB[19:0], counter, IRout, depR0, dataR0, depR1, dataR1 );
	LSRS Est6(4'b0110, CLK, CLR, start[6], busy[6], clk_instLS[1], Valor3[1], Valor4[1], Valor5[1], OP_Rd2[1], despacho2[1], ID_out2[1], confirma2[5], CDB[19:0], counter, IRout, depR0, dataR0, depR1, dataR1 );
	LSRS Est7(4'b0111, CLK, CLR, start[7], busy[7], clk_instLS[2], Valor3[2], Valor4[2], Valor5[2], OP_Rd2[2], despacho2[2], ID_out2[2], confirma2[6], CDB[19:0], counter, IRout, depR0, dataR0, depR1, dataR1 );
	LSRS Est8(4'b1000, CLK, CLR, start[8], busy[8], clk_instLS[3], Valor3[3], Valor4[3], Valor5[3], OP_Rd2[3], despacho2[3], ID_out2[3], confirma2[7], CDB[19:0], counter, IRout, depR0, dataR0, depR1, dataR1 );

	// Unidade Aritmetica de Load Store
	UA_Address loadStore(CLK, CLR | confLoadStore, strLoadStore, confLoadStore|WMen , IDloadStore, Dado3, Dado4, Dado5, OP_RdLoadStore, resultLoadStore, confAddress, busyLoadStore, desWrASLS);

	// Decoder Load Store
	decoder decConfLoadStore(confAddress, CLR, resultLoadStore[19:16], confirma2);

	//CDB Arbiter
	CDBArbt Arb(confAddSub | confLoad, confAddSub, confLoad, CLR | (desWrAS~^desWrASLS), confAddress, resultAddSub, {resultLoadStore[22:16], Dadolido}, clockInstr[resultAddSub[19:16]-1], clk_instLS[resultLoadStore[19:16]-1], CDB, wren_cdb, RD);
																		//XNOR
endmodule
