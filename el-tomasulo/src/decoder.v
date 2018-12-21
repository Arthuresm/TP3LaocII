module decoder(CLK, CLR, ID, confirma);

	/***************************************************************************
	Modulo: decoder
	Funcao: recebe o numero de uma estacao de reserva e o decodifica para uma
	string para confirmacao para a estacao em questao.
	Inputs:
		- ID: identificador da estacoo de reserva
	Outputs:
		- confirma: string de confirmacao correspondente com o identificador
	***************************************************************************/

	input CLK, CLR;
	input [3:0] ID;
	output reg [7:0] confirma;

	always @(posedge CLK, posedge CLR) begin
		if (CLR) begin
			confirma = 8'b00000000;
		end else begin
			case (ID)
				4'b0001: confirma = 8'b00000001;
				4'b0010: confirma = 8'b00000010;
				4'b0011: confirma = 8'b00000100;
				4'b0100: confirma = 8'b00001000;
				4'b0101: confirma = 8'b00010000;
				4'b0110: confirma = 8'b00100000;
				4'b0001: confirma = 8'b01000000;
				4'b1000: confirma = 8'b10000000;
			endcase
		end
	end

endmodule
