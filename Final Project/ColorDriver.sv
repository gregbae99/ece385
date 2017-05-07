module ColorDriver (input        [2:0]  In0,
						  output logic [23:0] Color);
		
		always_comb
		begin
			unique case (In0)
				3'b000: Color = 24'hb3ffb3; //Bright Green
				3'b001: Color = 24'h0000ff; //Blue
				3'b010: Color = 24'hffffff; //White
				3'b011: Color = 24'haaaaaa; //Gray
				3'b100: Color = 24'h555555; //Dark Gray
				default: Color = 24'h000000; //Black	
			endcase
		end
endmodule