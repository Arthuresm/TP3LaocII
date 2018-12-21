module CDBArbt(CLK, CLK1, CLK2, CLR, controle, resultadoAddSub, resultadoLoadStore, clk_instAS, clk_instLS, CDB, wren_banco, RD);

	/***************************************************************************
	Modulo: CDBArbt (Arbitro de CDB)
	Funcao: decidir qual dado. advindo ou da unidade aritmetica add/sub ou da
	unidade de memoria, sera escrito no CDB.
	escrevera no no banco de registradores atraves do CDB.
	Inputs:
		- CLK1: confirmacao advinda da unidade aritmetica add/sub
		- CLK2: confirmacao advinda da unidade aritmetica load/store
		- controle: identificador da estacao de reserva load/store de onde
		vieram os dados
		- resultadoAddSub: resultado vindo da unidade aritmetica de add/sub
		- resultadoLoadStore: dado lido da memoria concatenado com o
		identificador da estacoa de reserva que mandou os dados e o numero do
		registrador destino
		- clk_instAS: linha da instrucao de add/sub
		- clk_instLS: linha da instrucao de load/store
	Outputs:
		- CDB: para escrita no fio do CDB
		- wren_banco: habilita a escrita no banco
		- RD: registrador destino da escrita
	***************************************************************************/

	input CLK;
	input CLK1;	//Confirmacao da UA
	input CLK2;     //Confirmacao da UA_LS
	input CLR, controle;
	input [22:0]  resultadoAddSub;
	input [22:0]  resultadoLoadStore;


	input [9:0]clk_instAS;
	input [9:0]clk_instLS;


	output reg [19:0]CDB;
	output reg wren_banco;
	output reg [2:0] RD;

	reg [3:0]estacaoAS;
	reg [3:0]estacaoLS;

		always @(negedge CLK, posedge CLR)begin
				if(CLR)begin	//precisamos levar em conta o clk_inst
					wren_banco = 1'b0;
				end else begin
					wren_banco = 1'b0;
					if(CLK1 && CLK2)begin	//Se uma unidade funcional de LS e de AS geram resultados ao mesmo tempo
						if(clk_instAS < clk_instLS) begin	//-1 pois o identificador da estacao e o indice da estacao
							CDB = resultadoAddSub[15:0];
							wren_banco = 1'b1;
							RD = resultadoAddSub[22:20];
						end else begin
							//Logica de escrita na memoria ou escrita no banco em caso de Load
								CDB = resultadoLoadStore[19:0];
								wren_banco = 1'b1;
								RD = resultadoLoadStore[22:20];
						end
					end else begin
						if(~controle) begin
								if(~CLK1)begin
									CDB = resultadoAddSub[19:0];
									wren_banco = 1'b1;
									RD = resultadoAddSub[22:20];
								end
						end	else	begin
								//Logica de escrita na memoria ou escrita no banco em caso de Load
								CDB = resultadoLoadStore[19:0];
								wren_banco = 1'b1;
								RD = resultadoLoadStore[22:20];

						end
					end
				end
		end

endmodule
