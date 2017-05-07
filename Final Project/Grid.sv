module Grid1 (output logic [9:0]          X_Pos, X_Size, Y_Pos, Y_Size,
				  output logic [291:0][123:0] pixel_map);
		
		logic [9:0]			 X_Pos_in;
		logic [291:0][123:0] pixel_map_in;
			
		parameter [9:0]	 X_Size_in = 124;
		parameter [9:0]	 Y_Size_in = 292;
		parameter [9:0]	 Y_Pos_in = 112;
			
		assign pixel_map = pixel_map_in;
		assign X_Size = X_Size_in;
		assign Y_Size = Y_Size_in;
		assign X_Pos = X_Pos_in;
		assign Y_Pos = Y_Pos_in;
		
		always_comb
		begin
			pixel_map_in[291:290] = {248{1'b1}};
			pixel_map_in[289:2] = {288{2'b11,{120{1'b0}}, 2'b11}};
			pixel_map_in[1:0] = {248{1'b1}};
			
			X_Pos_in = 10'd99;
				
		end
endmodule		

module Grid2 (output logic [9:0]          X_Pos, X_Size, Y_Pos, Y_Size,
				  output logic [291:0][123:0] pixel_map);
		
		logic [9:0]			 X_Pos_in;
		logic [291:0][123:0] pixel_map_in;
			
		parameter [9:0]	 X_Size_in = 124;
		parameter [9:0]	 Y_Size_in = 292;
		parameter [9:0]	 Y_Pos_in = 112;
			
		assign pixel_map = pixel_map_in;
		assign X_Size = X_Size_in;
		assign Y_Size = Y_Size_in;
		assign X_Pos = X_Pos_in;
		assign Y_Pos = Y_Pos_in;
		
		always_comb
		begin
			pixel_map_in[291:290] = {248{1'b1}};
			pixel_map_in[289:2] = {288{2'b11,{120{1'b0}}, 2'b11}};
			pixel_map_in[1:0] = {248{1'b1}};
			
			X_Pos_in = 10'd419;
			
		end
endmodule	