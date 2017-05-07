module Dreg (input  logic Clk, Load, Reset, D,	// D flipflop inputs with load enable
				 output logic Q);							// output
		
		always_ff @ (posedge Clk or posedge Reset)
		begin	
				if (Reset)				// on reset, default to 0
					Q <= 1'b0;
				else	
					if (Load)			// on load, output equals input
						Q <= D;
					else	
						Q <= Q;			// else maintain value
		end
		
endmodule
