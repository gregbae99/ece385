module control (input  logic Clk, Reset, ClearA_LoadB, Run, M,	// signal inputs from buttons
 				output logic Shift_XAB, Clr_Ld, Add, Sub);	// instruction outputs

		// 8 shift states, 8 add states, and a start and hold state (18 total needs 5 bits)
 		enum logic [4:0] {Start, A_S, B_S, C_S, D_S, E_S, F_S, G_S, H_S, A_A, B_A, C_A, D_A, E_A, F_A, G_A, H_A, Hold} curr_state, next_state;

		// flipflop for changing states on posedge of clock or asynchronous reset
 		always_ff @ (posedge Clk or posedge Reset)
 		begin
 			if (Reset)
 				curr_state <= Start;
 			else
 				curr_state <= next_state;
 		end

 		always_comb
 		begin
 			next_state = curr_state;	// continue to next state
 			unique case (curr_state)
				// holds until run, then alternates between shift and add states until hold when complete
 				Start: 	if (Run)
 								next_state = A_A;
 				A_A: 		next_state = A_S;
 				A_S: 		next_state = B_A;
 				B_A: 		next_state = B_S;
 				B_S: 		next_state = C_A;
 				C_A: 		next_state = C_S;
 				C_S: 		next_state = D_A;
 				D_A: 		next_state = D_S;
 				D_S: 		next_state = E_A;
 				E_A: 		next_state = E_S;
 				E_S: 		next_state = F_A;
 				F_A: 		next_state = F_S;
 				F_S: 		next_state = G_A;
 				G_A: 		next_state = G_S;
 				G_S: 		next_state = H_A;
 				H_A: 		next_state = H_S;
 				H_S: 		next_state = Hold;
				// makes sure process runs only once each time run button is pressed.
 				Hold: 		if (~Run)
 								next_state = Start;
 			endcase
 		end

 		always_comb
 		begin
 			case (curr_state)

 				Start, Hold:	// idle states
				begin
 					Clr_Ld = ClearA_LoadB;
 					Shift_XAB = 1'b0;
 					Add = 1'b0;
 					Sub = 1'b0;
				end
 				A_A, B_A, C_A, D_A, E_A, F_A, G_A:
				begin					// add states
 					Clr_Ld = 1'b0;
 					Shift_XAB = 1'b0;
 					if (M)			// only perform addition when M is 1
 					begin
 						Add = 1'b1;
 						Sub = 1'b0;
 					end else begin
 						Add = 1'b0;
 						Sub = 1'b0;
 					end
				end
 				H_A:					// final add state (should perform subtraction)
				begin
 					Clr_Ld = 1'b0;
 					Shift_XAB = 1'b0;
					if (M)
 					begin			// only perform subtraction when M is 1
 						Add = 1'b0;
 						Sub = 1'b1;
 					end else begin
 						Add = 1'b0;
 						Sub = 1'b0;
 					end
				end
 				A_S, B_S, C_S, D_S, E_S, F_S, G_S, H_S:
				begin					// shift states
 					Clr_Ld = 1'b0;
 					Shift_XAB = 1'b1;
 					Add = 1'b0;
 					Sub = 1'b0;
				end
			endcase
 		end
endmodule
