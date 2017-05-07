module Buffer_FF (input Clk,
						input start,
						output logic change);
			
			logic [20:0] counter;
			
			always_ff @ (posedge Clk)
			begin
				if(start)
					counter <= 11'b0;
				else
					counter <= counter + 1'b1;
			end
			
			always_comb
			begin
				change = 1'b0;
				if(counter[10])
					change = 1'b1;
			end
endmodule
			