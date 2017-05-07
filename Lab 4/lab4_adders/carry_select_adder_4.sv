module carry_select_adder_4
(
    input   logic[3:0]     A, // A input value (4-bit)
    input   logic[3:0]     B, // B input value (4-bit)
	 input	logic				C_in, // carryin bit
    output  logic[3:0]     Sum, // Sum of A and B (4-bit)
    output  logic           CO // carry out bit
);

	 // unit assuming C_in is 0.
	 logic[3:0] c0; // create an arry of carry bits
	 logic[3:0] Sum0; // create an arry of Sum bits
	
	 // unit assuming C_in is 1.
  	 logic[3:0] c1; // create an arry of carry bits
	 logic[3:0] Sum1; // create an arry of Sum bits

	 // below runs two sets of ripple adders, one for each possible carry in bit.
	 // performs regular full adder operations for initial carry in = 0.
	 full_adder FA0(.x(A[0]), .y(B[0]), .z(0), .s(Sum0[0]), .c(c0[0]));
	 full_adder FA1(.x(A[1]), .y(B[1]), .z(c0[0]), .s(Sum0[1]), .c(c0[1]));
	 full_adder FA2(.x(A[2]), .y(B[2]), .z(c0[1]), .s(Sum0[2]), .c(c0[2]));
	 full_adder FA3(.x(A[3]), .y(B[3]), .z(c0[2]), .s(Sum0[3]), .c(c0[3]));
	 
	 // performs regular full adder operations for initial carry in = 1.
	 full_adder FA4(.x(A[0]), .y(B[0]), .z(1), .s(Sum1[0]), .c(c1[0]));
	 full_adder FA5(.x(A[1]), .y(B[1]), .z(c1[0]), .s(Sum1[1]), .c(c1[1]));
	 full_adder FA6(.x(A[2]), .y(B[2]), .z(c1[1]), .s(Sum1[2]), .c(c1[2]));
	 full_adder FA7(.x(A[3]), .y(B[3]), .z(c1[2]), .s(Sum1[3]), .c(c1[3]));
	
	always_comb
	begin
		// if else works as a mux, with C_in as the selector.
		if (C_in == 0) begin
			// if C_in was 0, assign the sum and carryout bit to the 0-calculations
			Sum = Sum0;
			CO = c0[3];
		end else begin
			// if C_in was 1, assign the sum and carryout bit to the 1-calculations
			Sum = Sum1;
			CO = c1[3];
		end
	end
	
endmodule
