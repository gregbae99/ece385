module Game_Checker (input        [23:0][9:0] Curr_State,
							output                   Rows_Cleared,
							output logic [23:0][9:0] New_State);
			
			logic [23:0] row_cleared;
			
			assign Rows_Cleared = row_cleared[0] + row_cleared[1] + row_cleared[2] + row_cleared[3] + row_cleared[4] + row_cleared[5] + row_cleared[6] + row_cleared[7] + row_cleared[8] + row_cleared[9] + row_cleared[10] + row_cleared[11] + row_cleared[12] + row_cleared[13] + row_cleared[14] + row_cleared[15] + row_cleared[16] + row_cleared[17] + row_cleared[18] + row_cleared[19] + row_cleared[20] + row_cleared[21] + row_cleared[22] + row_cleared[23];
			
			always_comb
			begin
				row_cleared = 24'b0;
				if(~Curr_State[0] == 0) row_cleared[0] = 1;
				if(~Curr_State[1] == 0) row_cleared[1] = 1;
				if(~Curr_State[2] == 0) row_cleared[2] = 1;
				if(~Curr_State[3] == 0) row_cleared[3] = 1;
				if(~Curr_State[4] == 0) row_cleared[4] = 1;
				if(~Curr_State[5] == 0) row_cleared[5] = 1;
				if(~Curr_State[6] == 0) row_cleared[6] = 1;
				if(~Curr_State[7] == 0) row_cleared[7] = 1;
				if(~Curr_State[8] == 0) row_cleared[8] = 1;
				if(~Curr_State[9] == 0) row_cleared[9] = 1;
				if(~Curr_State[10] == 0) row_cleared[10] = 1;
				if(~Curr_State[11] == 0) row_cleared[11] = 1;
				if(~Curr_State[12] == 0) row_cleared[12] = 1;
				if(~Curr_State[13] == 0) row_cleared[13] = 1;
				if(~Curr_State[14] == 0) row_cleared[14] = 1;
				if(~Curr_State[15] == 0) row_cleared[15] = 1;
				if(~Curr_State[16] == 0) row_cleared[16] = 1;
				if(~Curr_State[17] == 0) row_cleared[17] = 1;
				if(~Curr_State[18] == 0) row_cleared[18] = 1;
				if(~Curr_State[19] == 0) row_cleared[19] = 1;
				if(~Curr_State[20] == 0) row_cleared[20] = 1;
				if(~Curr_State[21] == 0) row_cleared[21] = 1;
				if(~Curr_State[22] == 0) row_cleared[22] = 1;
				if(~Curr_State[23] == 0) row_cleared[23] = 1;
				
				New_State = Curr_State;
				
				if(row_cleared[23]) New_State[23] = 24'b0;
				if(row_cleared[22]) New_State[23:22] = {24'b0, New_State[23]};
				if(row_cleared[21]) New_State[23:21] = {24'b0, New_State[23:22]};
				if(row_cleared[20]) New_State[23:20] = {24'b0, New_State[23:21]};
				if(row_cleared[19]) New_State[23:19] = {24'b0, New_State[23:20]};
				if(row_cleared[18]) New_State[23:18] = {24'b0, New_State[23:19]};
				if(row_cleared[17]) New_State[23:17] = {24'b0, New_State[23:18]};
				if(row_cleared[16]) New_State[23:16] = {24'b0, New_State[23:17]};
				if(row_cleared[15]) New_State[23:15] = {24'b0, New_State[23:16]};
				if(row_cleared[14]) New_State[23:14] = {24'b0, New_State[23:15]};
				if(row_cleared[13]) New_State[23:13] = {24'b0, New_State[23:14]};
				if(row_cleared[12]) New_State[23:12] = {24'b0, New_State[23:13]};
				if(row_cleared[11]) New_State[23:11] = {24'b0, New_State[23:12]};
				if(row_cleared[10]) New_State[23:10] = {24'b0, New_State[23:11]};
				if(row_cleared[9]) New_State[23:9] = {24'b0, New_State[23:10]};
				if(row_cleared[8]) New_State[23:8] = {24'b0, New_State[23:9]};
				if(row_cleared[7]) New_State[23:7] = {24'b0, New_State[23:8]};
				if(row_cleared[6]) New_State[23:6] = {24'b0, New_State[23:7]};
				if(row_cleared[5]) New_State[23:5] = {24'b0, New_State[23:6]};
				if(row_cleared[4]) New_State[23:4] = {24'b0, New_State[23:5]};
				if(row_cleared[3]) New_State[23:3] = {24'b0, New_State[23:4]};
				if(row_cleared[2]) New_State[23:2] = {24'b0, New_State[23:3]};
				if(row_cleared[1]) New_State[23:1] = {24'b0, New_State[23:2]};
				if(row_cleared[0]) New_State[23:0] = {24'b0, New_State[23:1]};
				
			end
endmodule