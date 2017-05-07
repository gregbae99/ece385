module reg_8 (input  logic Clk, Reset, Shift_In, Load, Shift_En,	// shift register inputs
			  input  logic [7:0]  D,	// extended 4-bit register to 8-bit
			  output logic Shift_Out,
			  output logic [7:0]  D_Out);

		always_ff @ (posedge Clk)
		begin
			if (Reset)				// in reset, register output is cleared
				D_Out <= 8'h0;
			else if (Load)
				D_Out <= D;			// in load, register parallel loads
			else if (Shift_En)	// in shift mode, shifts right one bit
			begin
				D_Out <= {Shift_In, D_Out[7:1]};
			end
		end

		assign Shift_Out = D_Out[0];
		
endmodule
