module Next_Block1 (input         [2:0]    Next,
						 output  logic [9:0]    X_Pos, Y_Pos, Size,
						 output  logic [3135:0] pixel_map, background_map);
		
			logic [9:0]			 X_Pos_in;
			logic [3135:0]		 pixel_map_in, background_map_in;
			
			parameter [9:0]	 Size_in = 56;
			parameter [9:0]	 Y_Pos_in = 112;
			
			assign pixel_map = pixel_map_in;
			assign background_map = background_map_in;
			assign Size = Size_in;
			assign X_Pos = X_Pos_in;
			assign Y_Pos = Y_Pos_in;
			
			always_comb
			begin
				background_map_in[3135:3024] = 112'b0;
				background_map_in[3023:112] = {52{2'b0,{52{1'b1}}, 2'b0}};
				background_map_in[111:0] = 112'b0;
				
				case (Next)
					3'b001:
					begin
						pixel_map_in[3135:1904] = 1232'b0;
						pixel_map_in[1903:1232] = {12{4'h0, {48{1'b1}}, 4'h0}};
						pixel_map_in[1231:0] = 1232'b0;
					end
					3'b010:
					begin
						pixel_map_in[3135:2240] = 896'b0;
						pixel_map_in[2239:1568] = {12{10'b0, {36{1'b1}}, 10'h0}};
						pixel_map_in[1567:896] = {12{22'b0, {12{1'b1}}, 22'b0}};
						pixel_map_in[895:0] = 896'b0;
					end
					3'b011:
					begin
						pixel_map_in[3135:2240] = 896'b0;
						pixel_map_in[2239:896] = {24{16'h0, {24{1'b1}}, 16'h0}};
						pixel_map_in[895:0] = 896'b0;
					end
					3'b100:
					begin
						pixel_map_in[3135:2240] = 896'b0;
						pixel_map_in[2239:1568] = {12{10'b0, {36{1'b1}}, 10'h0}};
						pixel_map_in[1567:896] = {12{10'b0, {12{1'b1}}, 34'b0}};
						pixel_map_in[895:0] = 896'b0;
					end
					3'b101:
					begin
						pixel_map_in[3135:2240] = 896'b0;
						pixel_map_in[2239:1568] = {12{10'b0, {36{1'b1}}, 10'h0}};
						pixel_map_in[1567:896] = {12{34'b0, {12{1'b1}}, 10'b0}};
						pixel_map_in[895:0] = 896'b0;
					end
					3'b110:
					begin
						pixel_map_in[3135:2240] = 896'b0;
						pixel_map_in[2239:1568] = {12{22'b0, {24{1'b1}}, 10'h0}};
						pixel_map_in[1567:896] = {12{10'b0, {24{1'b1}}, 22'b0}};
						pixel_map_in[895:0] = 896'b0;
					end
					3'b111:
					begin
						pixel_map_in[3135:2240] = 896'b0;
						pixel_map_in[2239:1568] = {12{10'b0, {24{1'b1}}, 22'b0}};
						pixel_map_in[1567:896] = {12{22'b0, {24{1'b1}}, 10'h0}};
						pixel_map_in[895:0] = 896'b0;
					end
					default:
					begin
						pixel_map_in = 3136'b0;
					end
				endcase
				
				X_Pos_in = 10'd40;
				
			end
endmodule

module Next_Block2 (input         [2:0]    Next,
						 output  logic [9:0]    X_Pos, Y_Pos, Size,
						 output  logic [3135:0] pixel_map, background_map);
		
			logic [9:0]			 X_Pos_in;
			logic [3135:0]		 pixel_map_in, background_map_in;
			
			parameter [9:0]	 Size_in = 56;
			parameter [9:0]	 Y_Pos_in = 112;
			
			assign pixel_map = pixel_map_in;
			assign background_map = background_map_in;
			assign Size = Size_in;
			assign X_Pos = X_Pos_in;
			assign Y_Pos = Y_Pos_in;
			
			always_comb
			begin
				background_map_in[3135:3024] = 112'b0;
				background_map_in[3023:112] = {52{2'b0,{52{1'b1}}, 2'b0}};
				background_map_in[111:0] = 112'b0;
				
				case (Next)
					3'b001:
					begin
						pixel_map_in[3135:1904] = 1232'b0;
						pixel_map_in[1903:1232] = {12{4'h0, {48{1'b1}}, 4'h0}};
						pixel_map_in[1231:0] = 1232'b0;
					end
					3'b010:
					begin
						pixel_map_in[3135:2240] = 896'b0;
						pixel_map_in[2239:1568] = {12{10'b0, {36{1'b1}}, 10'h0}};
						pixel_map_in[1567:896] = {12{22'b0, {12{1'b1}}, 22'b0}};
						pixel_map_in[895:0] = 896'b0;
					end
					3'b011:
					begin
						pixel_map_in[3135:2240] = 896'b0;
						pixel_map_in[2239:896] = {24{16'h0, {24{1'b1}}, 16'h0}};
						pixel_map_in[895:0] = 896'b0;
					end
					3'b100:
					begin
						pixel_map_in[3135:2240] = 896'b0;
						pixel_map_in[2239:1568] = {12{10'b0, {36{1'b1}}, 10'h0}};
						pixel_map_in[1567:896] = {12{10'b0, {12{1'b1}}, 34'b0}};
						pixel_map_in[895:0] = 896'b0;
					end
					3'b101:
					begin
						pixel_map_in[3135:2240] = 896'b0;
						pixel_map_in[2239:1568] = {12{10'b0, {36{1'b1}}, 10'h0}};
						pixel_map_in[1567:896] = {12{34'b0, {12{1'b1}}, 10'b0}};
						pixel_map_in[895:0] = 896'b0;
					end
					3'b110:
					begin
						pixel_map_in[3135:2240] = 896'b0;
						pixel_map_in[2239:1568] = {12{22'b0, {24{1'b1}}, 10'h0}};
						pixel_map_in[1567:896] = {12{10'b0, {24{1'b1}}, 22'b0}};
						pixel_map_in[895:0] = 896'b0;
					end
					3'b111:
					begin
						pixel_map_in[3135:2240] = 896'b0;
						pixel_map_in[2239:1568] = {12{10'b0, {24{1'b1}}, 22'b0}};
						pixel_map_in[1567:896] = {12{22'b0, {24{1'b1}}, 10'h0}};
						pixel_map_in[895:0] = 896'b0;
					end
					default:
					begin
						pixel_map_in = 3136'b0;
					end
				endcase
				
				X_Pos_in = 10'd360;
				
			end
endmodule