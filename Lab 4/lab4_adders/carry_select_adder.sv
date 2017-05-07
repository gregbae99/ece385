module carry_select_adder
(
    input   logic[15:0]     A, // A value input (16-bit)
    input   logic[15:0]     B, // B value input (16-bit)
    output  logic[15:0]     Sum, // Sum of A and B (16-bit)
    output  logic           CO // carryout bit
);

    /* TODO
     *
     * Insert code here to implement a carry select.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	  
	 // create an array of carry bits
	logic [2:0] c;
	
	// hierarchy of carry select 4-bit adders. The carryin bit is a 0.
	carry_select_adder_4 CSA0(.A(A[3:0]), .B(B[3:0]), .C_in(0), .Sum(Sum[3:0]), .CO(c[0]));
	carry_select_adder_4 CSA1(.A(A[7:4]), .B(B[7:4]), .C_in(c[0]), .Sum(Sum[7:4]), .CO(c[1]));
	carry_select_adder_4 CSA2(.A(A[11:8]), .B(B[11:8]), .C_in(c[1]), .Sum(Sum[11:8]), .CO(c[2]));
	carry_select_adder_4 CSA3(.A(A[15:12]), .B(B[15:12]), .C_in(c[2]), .Sum(Sum[15:12]), .CO(CO));

endmodule
