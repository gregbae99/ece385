module Score (input               Clk, Reset,
				  input        [2:0]  Rows_Cleared,
				  output logic [23:0] Score);
		
		logic [23:0] Score_in;
		
		assign Score = Score_in;
		
//		always_ff @ (posedge Clk)
//		begin
//			Score_in = Score + 24'b10;
//		end
		
		always_comb
		begin
			Score_in = 24'h0;
			
			case (Rows_Cleared)
				3'b001 : Score_in = Score + 24'h10;
				3'b010: Score_in = Score + 24'h20;
				3'b011: Score_in = Score + 24'h30;
				3'b100: Score_in = Score + 24'h80;
				default:
				if (~Reset)
					Score_in = Score;
			endcase
			
			if(Score_in[7:4] >= 4'ha)
				Score_in = Score_in + 24'h60;
			if(Score_in[11:8] == 4'ha)
				Score_in = Score_in + 24'h600;
			if(Score_in[15:12] == 4'ha)
				Score_in = Score_in + 24'h6000;
			if(Score_in[19:16] == 4'ha)
				Score_in = Score_in + 24'h60000;
			if(Score_in[23:20] == 4'ha)
				Score_in = 24'h999990;
		end
endmodule

module Score_Header1 (input        [23:0]   Score,
							input         [1:0]    player,
 							output logic [9:0]    X_Pos, X_Size, Y_Pos, Y_Size,
							output logic [1439:0] pixel_map);
		
		logic [9:0][4:0]   font;
		logic [9:0][143:0] pixel_font;
		logic [9:0]			 X_Pos_in;
		logic [1439:0]		 pixel_map_in;
			
		parameter [9:0]	 X_Size_in = 120;
		parameter [9:0]	 Y_Size_in = 12;
		parameter [9:0]	 Y_Pos_in = 88;
	
		FontDriver fonts0 (font[0], pixel_font[0]);
		FontDriver fonts1 (font[1], pixel_font[1]);
		FontDriver fonts2 (font[2], pixel_font[2]);
		FontDriver fonts3 (font[3], pixel_font[3]);
		FontDriver fonts4 (font[4], pixel_font[4]);
		FontDriver fonts5 (font[5], pixel_font[5]);
		FontDriver fonts6 (font[6], pixel_font[6]);
		FontDriver fonts7 (font[7], pixel_font[7]);
		FontDriver fonts8 (font[8], pixel_font[8]);
		FontDriver fonts9 (font[9], pixel_font[9]);
		
		assign pixel_map = pixel_map_in;
		assign X_Size = X_Size_in;
		assign Y_Size = Y_Size_in;
		assign X_Pos = X_Pos_in;
		assign Y_Pos = Y_Pos_in;
			
		always_comb
		begin
			font[0] = 5'b11111; //default empty
			font[1] = 5'b11111; //
			if(player == 2'b01)
			begin
				font[2] = {1'b0, Score[23:20]};
				font[3] = {1'b0, Score[19:16]};
				font[4] = {1'b0, Score[15:12]};
				font[5] = {1'b0, Score[11:8]};
				font[6] = {1'b0, Score[7:4]};
				font[7] = {1'b0, Score[3:0]};
			end
			else
			begin
				font[2] = 5'b11111; //
				font[3] = 5'b11111;
				font[4] = 5'b11111;
				font[5] = 5'b11111;
				font[6] = 5'b11111;
				font[7] = 5'b11111;
			end
			font[8] = 5'b11111; //
			font[9] = 5'b11111;
			
			pixel_map_in[1439:1320] = {pixel_font[0][143:132], pixel_font[1][143:132], pixel_font[2][143:132], pixel_font[3][143:132], pixel_font[4][143:132], pixel_font[5][143:132], pixel_font[6][143:132], pixel_font[7][143:132], pixel_font[8][143:132], pixel_font[9][143:132]};
			pixel_map_in[1319:1200] = {pixel_font[0][131:120], pixel_font[1][131:120], pixel_font[2][131:120], pixel_font[3][131:120], pixel_font[4][131:120], pixel_font[5][131:120], pixel_font[6][131:120], pixel_font[7][131:120], pixel_font[8][131:120], pixel_font[9][131:120]};
			pixel_map_in[1199:1080] = {pixel_font[0][119:108], pixel_font[1][119:108], pixel_font[2][119:108], pixel_font[3][119:108], pixel_font[4][119:108], pixel_font[5][119:108], pixel_font[6][119:108], pixel_font[7][119:108], pixel_font[8][119:108], pixel_font[9][119:108]};
			pixel_map_in[1079:960] = {pixel_font[0][107:96], pixel_font[1][107:96], pixel_font[2][107:96], pixel_font[3][107:96], pixel_font[4][107:96], pixel_font[5][107:96], pixel_font[6][107:96], pixel_font[7][107:96], pixel_font[8][107:96], pixel_font[9][107:96]};
			pixel_map_in[959:840] = {pixel_font[0][95:84], pixel_font[1][95:84], pixel_font[2][95:84], pixel_font[3][95:84], pixel_font[4][95:84], pixel_font[5][95:84], pixel_font[6][95:84], pixel_font[7][95:84], pixel_font[8][95:84], pixel_font[9][95:84]};
			pixel_map_in[839:720] = {pixel_font[0][83:72], pixel_font[1][83:72], pixel_font[2][83:72], pixel_font[3][83:72], pixel_font[4][83:72], pixel_font[5][83:72], pixel_font[6][83:72], pixel_font[7][83:72], pixel_font[8][83:72], pixel_font[9][83:72]};
			pixel_map_in[719:600] = {pixel_font[0][71:60], pixel_font[1][71:60], pixel_font[2][71:60], pixel_font[3][71:60], pixel_font[4][71:60], pixel_font[5][71:60], pixel_font[6][71:60], pixel_font[7][71:60], pixel_font[8][71:60], pixel_font[9][71:60]};
			pixel_map_in[599:480] = {pixel_font[0][59:48], pixel_font[1][59:48], pixel_font[2][59:48], pixel_font[3][59:48], pixel_font[4][59:48], pixel_font[5][59:48], pixel_font[6][59:48], pixel_font[7][59:48], pixel_font[8][59:48], pixel_font[9][59:48]};
			pixel_map_in[479:360] = {pixel_font[0][47:36], pixel_font[1][47:36], pixel_font[2][47:36], pixel_font[3][47:36], pixel_font[4][47:36], pixel_font[5][47:36], pixel_font[6][47:36], pixel_font[7][47:36], pixel_font[8][47:36], pixel_font[9][47:36]};
			pixel_map_in[359:240] = {pixel_font[0][35:24], pixel_font[1][35:24], pixel_font[2][35:24], pixel_font[3][35:24], pixel_font[4][35:24], pixel_font[5][35:24], pixel_font[6][35:24], pixel_font[7][35:24], pixel_font[8][35:24], pixel_font[9][35:24]};
			pixel_map_in[239:120] = {pixel_font[0][23:12], pixel_font[1][23:12], pixel_font[2][23:12], pixel_font[3][23:12], pixel_font[4][23:12], pixel_font[5][23:12], pixel_font[6][23:12], pixel_font[7][23:12], pixel_font[8][23:12], pixel_font[9][23:12]};
			pixel_map_in[119:0] = {pixel_font[0][11:0], pixel_font[1][11:0], pixel_font[2][11:0], pixel_font[3][11:0], pixel_font[4][11:0], pixel_font[5][11:0], pixel_font[6][11:0], pixel_font[7][11:0], pixel_font[8][11:0], pixel_font[9][11:0]};
			
			X_Pos_in = 10'd98;
				
		end
endmodule


module Score_Header2 (input        [23:0]   Score,
							input 			[1:0]   player,
							output logic [9:0]    X_Pos, X_Size, Y_Pos, Y_Size,
							output logic [1439:0] pixel_map);
		
		logic [9:0][4:0]   font;
		logic [9:0][143:0] pixel_font;
		logic [9:0]			 X_Pos_in;
		logic [1439:0]		 pixel_map_in;
			
		parameter [9:0]	 X_Size_in = 120;
		parameter [9:0]	 Y_Size_in = 12;
		parameter [9:0]	 Y_Pos_in = 88;
	
		FontDriver fonts0 (font[0], pixel_font[0]);
		FontDriver fonts1 (font[1], pixel_font[1]);
		FontDriver fonts2 (font[2], pixel_font[2]);
		FontDriver fonts3 (font[3], pixel_font[3]);
		FontDriver fonts4 (font[4], pixel_font[4]);
		FontDriver fonts5 (font[5], pixel_font[5]);
		FontDriver fonts6 (font[6], pixel_font[6]);
		FontDriver fonts7 (font[7], pixel_font[7]);
		FontDriver fonts8 (font[8], pixel_font[8]);
		FontDriver fonts9 (font[9], pixel_font[9]);
		
		assign pixel_map = pixel_map_in;
		assign X_Size = X_Size_in;
		assign Y_Size = Y_Size_in;
		assign X_Pos = X_Pos_in;
		assign Y_Pos = Y_Pos_in;
			
		always_comb
		begin
			font[0] = 5'b11111; //default empty
			font[1] = 5'b11111; //
			if(player == 2'b10)
			begin
				font[2] = {1'b0, Score[23:20]};
				font[3] = {1'b0, Score[19:16]};
				font[4] = {1'b0, Score[15:12]};
				font[5] = {1'b0, Score[11:8]};
				font[6] = {1'b0, Score[7:4]};
				font[7] = {1'b0, Score[3:0]};
			end
			else
			begin
				font[2] = 5'b11111; //
				font[3] = 5'b11111;
				font[4] = 5'b11111;
				font[5] = 5'b11111;
				font[6] = 5'b11111;
				font[7] = 5'b11111;
			end
			font[8] = 5'b11111; //
			font[9] = 5'b11111;
			
			pixel_map_in[1439:1320] = {pixel_font[0][143:132], pixel_font[1][143:132], pixel_font[2][143:132], pixel_font[3][143:132], pixel_font[4][143:132], pixel_font[5][143:132], pixel_font[6][143:132], pixel_font[7][143:132], pixel_font[8][143:132], pixel_font[9][143:132]};
			pixel_map_in[1319:1200] = {pixel_font[0][131:120], pixel_font[1][131:120], pixel_font[2][131:120], pixel_font[3][131:120], pixel_font[4][131:120], pixel_font[5][131:120], pixel_font[6][131:120], pixel_font[7][131:120], pixel_font[8][131:120], pixel_font[9][131:120]};
			pixel_map_in[1199:1080] = {pixel_font[0][119:108], pixel_font[1][119:108], pixel_font[2][119:108], pixel_font[3][119:108], pixel_font[4][119:108], pixel_font[5][119:108], pixel_font[6][119:108], pixel_font[7][119:108], pixel_font[8][119:108], pixel_font[9][119:108]};
			pixel_map_in[1079:960] = {pixel_font[0][107:96], pixel_font[1][107:96], pixel_font[2][107:96], pixel_font[3][107:96], pixel_font[4][107:96], pixel_font[5][107:96], pixel_font[6][107:96], pixel_font[7][107:96], pixel_font[8][107:96], pixel_font[9][107:96]};
			pixel_map_in[959:840] = {pixel_font[0][95:84], pixel_font[1][95:84], pixel_font[2][95:84], pixel_font[3][95:84], pixel_font[4][95:84], pixel_font[5][95:84], pixel_font[6][95:84], pixel_font[7][95:84], pixel_font[8][95:84], pixel_font[9][95:84]};
			pixel_map_in[839:720] = {pixel_font[0][83:72], pixel_font[1][83:72], pixel_font[2][83:72], pixel_font[3][83:72], pixel_font[4][83:72], pixel_font[5][83:72], pixel_font[6][83:72], pixel_font[7][83:72], pixel_font[8][83:72], pixel_font[9][83:72]};
			pixel_map_in[719:600] = {pixel_font[0][71:60], pixel_font[1][71:60], pixel_font[2][71:60], pixel_font[3][71:60], pixel_font[4][71:60], pixel_font[5][71:60], pixel_font[6][71:60], pixel_font[7][71:60], pixel_font[8][71:60], pixel_font[9][71:60]};
			pixel_map_in[599:480] = {pixel_font[0][59:48], pixel_font[1][59:48], pixel_font[2][59:48], pixel_font[3][59:48], pixel_font[4][59:48], pixel_font[5][59:48], pixel_font[6][59:48], pixel_font[7][59:48], pixel_font[8][59:48], pixel_font[9][59:48]};
			pixel_map_in[479:360] = {pixel_font[0][47:36], pixel_font[1][47:36], pixel_font[2][47:36], pixel_font[3][47:36], pixel_font[4][47:36], pixel_font[5][47:36], pixel_font[6][47:36], pixel_font[7][47:36], pixel_font[8][47:36], pixel_font[9][47:36]};
			pixel_map_in[359:240] = {pixel_font[0][35:24], pixel_font[1][35:24], pixel_font[2][35:24], pixel_font[3][35:24], pixel_font[4][35:24], pixel_font[5][35:24], pixel_font[6][35:24], pixel_font[7][35:24], pixel_font[8][35:24], pixel_font[9][35:24]};
			pixel_map_in[239:120] = {pixel_font[0][23:12], pixel_font[1][23:12], pixel_font[2][23:12], pixel_font[3][23:12], pixel_font[4][23:12], pixel_font[5][23:12], pixel_font[6][23:12], pixel_font[7][23:12], pixel_font[8][23:12], pixel_font[9][23:12]};
			pixel_map_in[119:0] = {pixel_font[0][11:0], pixel_font[1][11:0], pixel_font[2][11:0], pixel_font[3][11:0], pixel_font[4][11:0], pixel_font[5][11:0], pixel_font[6][11:0], pixel_font[7][11:0], pixel_font[8][11:0], pixel_font[9][11:0]};
			
			
			X_Pos_in = 10'd418;
			
		end
endmodule