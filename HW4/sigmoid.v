// `include "./sigmoid.v"
// `include "./lib.v"
module sigmoid (
	input         clk,
	input         rst_n,
	input         i_in_valid,
	input  [ 7:0] i_x,
	output [15:0] o_y,
	output        o_out_valid,
	output [50:0] number
);

	// Your design
	wire [2:0] sel;
	wire [5:0] intercept;
	wire [5:0] y;
	wire [2:0] inv_sel;
	wire [50:0] numbers [0:23];
	wire [9:0] shifted_x;

	Range_Selecter u_Range_Selecter(.i_x(i_x),.i_in_valid(i_in_valid),.o_sel(sel), .number(numbers[0]));

	IV u_IV_0(.Z(inv_sel[0]),.A(sel[0]),.number(numbers[1]));
	IV u_IV_1(.Z(inv_sel[1]),.A(sel[1]),.number(numbers[2]));
	IV u_IV_2(.Z(inv_sel[2]),.A(sel[2]),.number(numbers[3]));
	
	Intercept u_Intercept(.i_sel(sel),.inv_sel(inv_sel),.o_intercept(intercept),.number(numbers[6]));

	getshift u_getshift(.i_x(i_x), .i_sel(sel), .shift(shifted_x), .number(numbers[7]));
  	
	Carry_Skip_6Bit_Adder u_Carry_Skip_6Bit_Adder(.a(shifted_x[9:4]),.b(intercept),.cin(1'b0),.sum(y),.cout(cout),.number(numbers[9]));

	FD2 u_FD2(.Q(o_out_valid),.D(i_in_valid),.CLK(clk),.RESET(rst_n),.number(numbers[10]));

	FD2 f0_32(o_y[0], 0, clk, rst_n, numbers[11]);
	FD2 f0_33(o_y[1], 0, clk, rst_n, numbers[12]);
	FD2 f0_34(o_y[2], 0, clk, rst_n, numbers[13]);
	FD2 f0_35(o_y[3], 0, clk, rst_n, numbers[14]);
	FD2 f0_36(o_y[4], 0, clk, rst_n, numbers[15]);
	FD2 f0_37(o_y[5], shifted_x[0], clk, rst_n, numbers[16]);
	FD2 f0_38(o_y[6], shifted_x[1], clk, rst_n, numbers[17]);
	FD2 f0_39(o_y[7], shifted_x[2], clk, rst_n, numbers[18]);
	FD2 f0_24(o_y[8], shifted_x[3], clk, rst_n, numbers[19]);
	FD2 f0_25(o_y[9], y[0], clk, rst_n, numbers[20]);
	FD2 f0_26(o_y[10], y[1], clk, rst_n, numbers[21]);
	FD2 f0_27(o_y[11], y[2], clk, rst_n, numbers[22]);
	FD2 f0_28(o_y[12], y[3], clk, rst_n, numbers[23]);
	FD2 f0_29(o_y[13], y[4], clk, rst_n, numbers[8]);
	FD2 f0_30(o_y[14], y[5], clk, rst_n, numbers[4]);
	FD2 f0_31(o_y[15], 0, clk, rst_n, numbers[5]);
	
	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j=0; j<24; j=j+1) begin 
			sum = sum + numbers[j];
		end
	end

	assign number = sum;
endmodule

module getshift(i_x, i_sel, shift, number);
	input [7:0] i_x;
	input [2:0] i_sel;
	output [9:0] shift;
	output [50:0] number;

	wire [50:0] numbers [0:1];

	wire [12:0] shift2_x;
	wire [12:0] shift3_x;
	wire [12:0] shift5_x; 
	wire [9:0]  shift23_x;

	assign shift2_x = {{2{i_x[7]}}, i_x, 3'b000};
	assign shift3_x = {{3{i_x[7]}}, i_x, 2'b00};
	assign shift5_x = {{5{i_x[7]}}, i_x};

	MUXbus #(10) mux_const1 (shift23_x, shift3_x[9:0], shift2_x[9:0], i_sel[2], numbers[0]);
	MUXbus #(10) mux_const2 (shift, shift23_x, shift5_x[9:0], i_sel[1], numbers[1]);

	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j=0; j<2; j=j+1) begin 
			sum = sum + numbers[j];
		end
	end

	assign number = sum;
endmodule

module Intercept(i_sel, inv_sel, o_intercept, number);
	input [2:0] i_sel;
	input [2:0] inv_sel;
	output [5:0] o_intercept;
	output [50:0] number;

	wire [50:0] numbers [0:7];
	
	assign o_intercept[0] = i_sel[1];
	assign o_intercept[1] = o_intercept[2];
	
	NR2 u_OR2_2(.Z(o_intercept[2]),.A(i_sel[0]),.B(inv_sel[1]),.number(numbers[0]));

	ND2 u_AN2_3(.Z(t3),.A(inv_sel[1]),.B(inv_sel[2]),.number(numbers[1]));
	ND2 u_AN2_4(.Z(t4),.A(i_sel[0]),.B(i_sel[1]),.number(numbers[2]));
	ND2 u_OR2_3(.Z(o_intercept[3]),.A(t3),.B(t4),.number(numbers[3]));

	ND3 u_AN3_1(.Z(t5),.A(i_sel[0]),.B(inv_sel[1]),.C(inv_sel[2]),.number(numbers[4]));
	ND2 u_AN2_7(.Z(t6),.A(inv_sel[0]),.B(i_sel[1]),.number(numbers[5]));
	ND2 u_AN3_5(.Z(o_intercept[4]),.A(t5),.B(t6),.number(numbers[6]));

	ND2 u_AN3_6(.Z(o_intercept[5]),.A(i_sel[0]),.B(inv_sel[2]),.number(numbers[7]));

	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j=0; j<8; j=j+1) begin 
			sum = sum + numbers[j];
		end
	end
	assign number = sum;
endmodule

module Range_Selecter(i_x, i_in_valid, o_sel, number);
	input [7:0] i_x;
	input i_in_valid;
	output [2:0] o_sel;
	output [50:0] number;

	wire [50:0] numbers [0:2];

	comparator_2375 u_comparator_2375(.i_x(i_x),.LE(point_2_375),.number(numbers[0]));
	comparator_1 u_comparator_1(.i_x(i_x),.LE(point_1),.number(numbers[1]));

	NR2 u_AN2_5(.Z(point_middle),.A(point_2_375),.B(point_1),.number(numbers[2]));

	assign o_sel[0] = i_x[7];         // sign-bit
	assign o_sel[1] = point_2_375;    // True -> 2.375 ; Flase -> 1
	assign o_sel[2] = point_middle;   // -1 < x < 1

	reg [50:0] sum;
	integer j;
	always @(*) begin
		sum = 0;
		for (j=0; j<3; j=j+1) begin 
			sum = sum + numbers[j];
		end
	end

	assign number = sum;
endmodule

module Carry_Skip_6Bit_Adder(a, b, cin, sum, cout, number);
	input [5:0] a,b;
	input cin;
	output [5:0] sum;
	output cout;
	output [50:0] number;

	wire [50:0] numbers [0:2];
	
	Carry_Skip_Adder csa1(.a(a[3:0]), .b(b[3:0]), .cin(cin), .sum(sum[3:0]), .cout(c_temp), .number(numbers[0]));
	FA1 u_FA1_1(.S(sum[4]),.CO(c1),.A(a[4]),.B(b[4]),.CI(c_temp),.number(numbers[1]));
	FA1 u_FA1_5(.S(sum[5]),.CO(cout),.A(a[5]),.B(b[5]),.CI(c1),.number(numbers[2]));
	
	reg [50:0] sum_t;
	integer j;
	always @(*) begin
		sum_t = 0;
		for (j=0; j<3; j=j+1) begin 
			sum_t = sum_t + numbers[j];
		end
	end

	assign number = sum_t;
endmodule
 
module Carry_Skip_Adder(a, b, cin, sum, cout, number);
	input [3:0] a,b;
	input cin;
	output [3:0] sum;
	output cout;
	output [50:0] number;

	wire [50:0] numbers [0:6];
	wire [3:0] p;

	EO u_EO_1(.Z(p[0]),.A(a[0]),.B(b[0]),.number(numbers[0]));
	EO u_EO_2(.Z(p[1]),.A(a[1]),.B(b[1]),.number(numbers[1]));
	EO u_EO_3(.Z(p[2]),.A(a[2]),.B(b[2]),.number(numbers[2]));
	EO u_EO_4(.Z(p[3]),.A(a[3]),.B(b[3]),.number(numbers[3]));
	AN4 u_AN4(.Z(Propagate),.A(p[0]),.B(p[1]),.C(p[2]),.D(p[3]),.number(numbers[4]));

	Ripple_Carry_Adder rca1 (.a(a[3:0]), .b(b[3:0]), .cin(cin), .sum(sum[3:0]), .cout(c3), .number(numbers[5]));
	MUX21H u_MUX21H_1(.Z(cout),.A(c3),.B(cin),.CTRL(Propagate),.number(numbers[6]));

	reg [50:0] sum_t;
	integer j;
	always @(*) begin
		sum_t = 0;
		for (j=0; j<7; j=j+1) begin 
			sum_t = sum_t + numbers[j];
		end
	end

	assign number = sum_t;
endmodule

module Ripple_Carry_Adder(a, b, cin, sum, cout, number);
	input [3:0] a,b;
	input cin;
	output [3:0] sum;
	output cout;
	output [50:0] number;

	wire [50:0] numbers [0:3];
	
	FA1 u_FA1_1(.S(sum[0]),.CO(c1),.A(a[0]),.B(b[0]),.CI(cin),.number(numbers[0]));
	FA1 u_FA1_2(.S(sum[1]),.CO(c2),.A(a[1]),.B(b[1]),.CI(c1),.number(numbers[1]));
	FA1 u_FA1_3(.S(sum[2]),.CO(c3),.A(a[2]),.B(b[2]),.CI(c2),.number(numbers[2]));
	FA1 u_FA1_4(.S(sum[3]),.CO(cout),.A(a[3]),.B(b[3]),.CI(c3),.number(numbers[3]));

	reg [50:0] sum_t;
	integer j;
	always @(*) begin
		sum_t = 0;
		for (j=0; j<4; j=j+1) begin 
			sum_t = sum_t + numbers[j];
		end
	end

	assign number = sum_t;
endmodule

module comparator_2375 (i_x, LE, number);
	input [7:0] i_x;
	output LE;
	output [50:0] number;

	wire [50:0] numbers[0:38];

	wire [7:0] inv_num;

	IV u_IV_0(.Z(inv_num[0]),.A(i_x[0]),.number(numbers[0]));
	IV u_IV_1(.Z(inv_num[1]),.A(i_x[1]),.number(numbers[1]));
	IV u_IV_2(.Z(inv_num[2]),.A(i_x[2]),.number(numbers[2]));
	IV u_IV_3(.Z(inv_num[3]),.A(i_x[3]),.number(numbers[3]));
	IV u_IV_4(.Z(inv_num[4]),.A(i_x[4]),.number(numbers[4]));
	IV u_IV_5(.Z(inv_num[5]),.A(i_x[5]),.number(numbers[5]));
	IV u_IV_6(.Z(inv_num[6]),.A(i_x[6]),.number(numbers[6]));
	IV u_IV_7(.Z(inv_num[7]),.A(i_x[7]),.number(numbers[7]));

	wire [6:2] B;

	MUX21H u_MUX21H_2(B[2],i_x[2],inv_num[2],i_x[7],numbers[8]);
	MUX21H u_MUX21H_3(B[3],i_x[3],inv_num[3],i_x[7],numbers[9]);
	MUX21H u_MUX21H_4(B[4],i_x[4],inv_num[4],i_x[7],numbers[10]);
	MUX21H u_MUX21H_5(B[5],i_x[5],inv_num[5],i_x[7],numbers[11]);
	MUX21H u_MUX21H_6(B[6],i_x[6],inv_num[6],i_x[7],numbers[12]);

	wire [6:2] A;
	assign A = {1'b1, 1'b0, 1'b0, 1'b1, 1'b1};

	// A[6] is smaller than B[6]
	IV iv9(inv_a6, A[6], numbers[13]);
	AN2 an9(W6, inv_a6, B[6], numbers[14]);
	// A[6] == B[6] and A[5] is smaller than B[5]
	EO eo9(E6, A[6], B[6], numbers[15]);
	IV iv8(inv_a5, A[5], numbers[16]);
	ND2 nd8(L5, inv_a5, B[5], numbers[17]);
	NR2 nr8(W5, E6, L5, numbers[18]);
	// A[6] == B[6], A[5] == B[5] and A[4] is smaller than B[4]
	EO eo8(E5, A[5], B[5], numbers[19]);
	IV iv7(inv_a4, A[4], numbers[20]);
	ND2 nd7(L4, inv_a4, B[4], numbers[21]);
	NR3 nr7(W4, E6, E5, L4, numbers[22]);
	// A[6] == B[6], A[5] == B[5], A[4] == B[4] and A[3] is smaller than B[3]
	EO eo7(E4, A[4], B[4], numbers[23]);
	IV iv6(inv_a3, A[3], numbers[24]);
	ND2 nd6(L3, inv_a3, B[3], numbers[25]);
	NR4 nr6(W3, E6, E5, E4, L3, numbers[26]);
	// A[6] == B[6], A[5] == B[5], A[4] == B[4], A[3] == B[3] and A[2] is smaller than B[2]
	EO eo6(E3, A[3], B[3], numbers[27]);
	IV iv5(inv_a2, A[2], numbers[28]);
	ND2 nd5(L2, inv_a2, B[2], numbers[29]);
	NR3 nr_t1(T1, E6, E5, E4, numbers[30]);
	NR2 nr_t2(T2, E3, L2, numbers[31]);
	AN2 an_w5(W2, T1, T2, numbers[32]);
	// A == B
	EO eo0(E2, A[2], B[2], numbers[33]);
	NR2 nr_t3(T3, E3, E2, numbers[34]);
	AN2 an_w00(W22, T1, T3, numbers[35]);
	// combine
	NR3 nrall1(ALL1 ,W6, W5, W4, numbers[36]);
	NR3 nrall2(ALL2 ,W3, W2, W22, numbers[37]);
	ND2 ndall(LE, ALL1, ALL2, numbers[38]);
	// sum number of transistors
	reg [50:0] sum;
	integer i;
	always @(*) begin
		sum = 0;
		for (i = 0; i < 39; i = i + 1) begin
			sum = sum + numbers[i];
		end
	end
	// transistor number
	assign number = sum;
endmodule

module comparator_1 (i_x, LE, number);
	input [7:0] i_x;
	output LE;
	output [50:0] number;

	wire [50:0] numbers[0:12];

	wire [7:0] inv_num;

	IV u_IV_5(.Z(inv_num[5]),.A(i_x[5]),.number(numbers[0]));
	IV u_IV_6(.Z(inv_num[6]),.A(i_x[6]),.number(numbers[1]));

	wire [6:5] B;

	MUX21H u_MUX21H_5(B[5],i_x[5],inv_num[5],i_x[7],numbers[2]);
	MUX21H u_MUX21H_6(B[6],i_x[6],inv_num[6],i_x[7],numbers[3]);

	wire [6:5] A;
	assign A = {1'b0, 1'b1};

	// A[6] is smaller than B[6]
	IV iv9(inv_a6, A[6], numbers[4]);
	ND2 an9(W6, inv_a6, B[6], numbers[5]);
	// A[6] == B[6] and A[5] is smaller than B[5]
	EO eo9(E6, A[6], B[6], numbers[6]);
	IV iv8(inv_a5, A[5], numbers[7]);
	ND2 nd8(L5, inv_a5, B[5], numbers[8]);
	OR2 nr8(W5, E6, L5, numbers[9]);
	// A == B
	EO eo0(E5, A[5], B[5], numbers[10]);
	OR2 nr_t3(W4, E6, E5, numbers[11]);
	// combine
	ND3 nrall1(LE ,W6, W5, W4, numbers[12]);
	// sum number of transistors
	reg [50:0] sum;
	integer i;
	always @(*) begin
		sum = 0;
		for (i = 0; i < 13; i = i + 1) begin
			sum = sum + numbers[i];
		end
	end
	// transistor number
	assign number = sum;
endmodule

module MUXbus #(parameter BW = 7) (Z, A, B, i_ctrl, number);
	input [BW-1:0] A;
	input [BW-1:0] B;
	input i_ctrl;
	output [BW-1:0] Z;
	output [50:0] number;

	wire [50:0] num [0:BW-1];

	genvar j;
	generate
		for (j=0; j<BW; j=j+1) begin
			MUX21H mux_ux (Z[j], A[j], B[j] ,i_ctrl, num[j]);
		end
	endgenerate

	reg [50:0] sum;
	integer i;
	always @(*) begin
		sum = 0;
		for (i=0; i<BW; i=i+1) begin 
			sum = sum + num[i];
		end
	end
	assign number = sum;

endmodule

// //BW-bit FD2
// module REGP#(
// 	parameter BW = 2
// )(
// 	input           clk,
// 	input           rst_n,
// 	output [BW-1:0] Q,
// 	input  [BW-1:0] D,
// 	output [  50:0] number
// );

// wire [50:0] numbers [0:BW-1];

// genvar i;
// generate
// 	for (i=0; i<BW; i=i+1) begin
// 		FD2 f0(Q[i], D[i], clk, rst_n, numbers[i]);
// 	end
// endgenerate

// //sum number of transistors
// reg [50:0] sum;
// integer j;
// always @(*) begin
// 	sum = 0;
// 	for (j=0; j<BW; j=j+1) begin 
// 		sum = sum + numbers[j];
// 	end
// end

// assign number = sum;

// endmodule

