`timescale 1ns/1ps
module poker(type, i0, i1, i2, i3, i4);
//DO NOT CHANGE!
	input  [5:0] i0, i1, i2, i3, i4;
	output [3:0] type;
//---------------------------------------------------

	wire flush;
	
	Flush u_flush(
		.c1			(i0[5:4]),
		.c2			(i1[5:4]),
		.c3			(i2[5:4]),
		.c4			(i3[5:4]),
		.c5			(i4[5:4]),
		.result		(flush)
	);

	wire       	four;
	wire       	three;
	wire     	full_house;
	wire       	two_pair;
	wire       	one_pair;
	wire       	straight;
	
	rank_type u_rank_type(
		.n0				(i0[3:0]),
		.n1				(i1[3:0]),
		.n2				(i2[3:0]),
		.n3				(i3[3:0]),
		.n4				(i4[3:0]),
		.four			(four),
		.three			(three),
		.full_house		(full_house),
		.two_pair		(two_pair),
		.one_pair		(one_pair),
		.straight		(straight),
		.inv_straight	(inv_straight)
	);
	
	card_type u_card_type(
		.flush      	(flush),
		.four       	(four),
		.three      	(three),
		.full_house 	(full_house),
		.two_pair   	(two_pair),
		.one_pair   	(one_pair),
		.straight   	(straight),
		.type       	(type),
		.inv_straight   (inv_straight)
	);

endmodule

module Flush(c1, c2, c3, c4, c5, result);
	input [1:0] c1, c2, c3, c4, c5;
	output result;
	
	EO u_EO_12_0(.Z(c12_0),.A(c1[0]),.B(c2[0]));
	EO u_EO_12_1(.Z(c12_1),.A(c1[1]),.B(c2[1]));
	NR2 u_NR2_12(.Z(c12),.A(c12_0),.B(c12_1));

	EO u_EO_23_0(.Z(c23_0),.A(c2[0]),.B(c3[0]));
	EO u_EO_23_1(.Z(c23_1),.A(c2[1]),.B(c3[1]));
	NR2 u_NR2_23(.Z(c23),.A(c23_0),.B(c23_1));

	EO u_EO_34_0(.Z(c34_0),.A(c3[0]),.B(c4[0]));
	EO u_EO_34_1(.Z(c34_1),.A(c3[1]),.B(c4[1]));
	NR2 u_NR2_34(.Z(c34),.A(c34_0),.B(c34_1));

	EO u_EO_45_0(.Z(c45_0),.A(c4[0]),.B(c5[0]));
	EO u_EO_45_1(.Z(c45_1),.A(c4[1]),.B(c5[1]));
	NR2 u_NR2_45(.Z(c45),.A(c45_0),.B(c45_1));
	
	AN4 u_AN4_result(.Z(result),.A(c12),.B(c23),.C(c34),.D(c45));
endmodule


module rank_type(n0, n1, n2, n3, n4, four, three, full_house, two_pair, one_pair, straight, inv_straight);
	input [3:0] n0, n1, n2, n3, n4;
	output four, three, full_house, two_pair, one_pair, straight, inv_straight;

	//------------------------------------------------------------------------------------------------------

	EO u_EO_01_0(.Z(n01_0),.A(n0[0]),.B(n1[0]));
	EO u_EO_01_1(.Z(n01_1),.A(n0[1]),.B(n1[1]));
	EO u_EO_01_2(.Z(n01_2),.A(n0[2]),.B(n1[2]));
	EO u_EO_01_3(.Z(n01_3),.A(n0[3]),.B(n1[3]));
	NR4 u_NR4_01(.Z(n01),.A(n01_0),.B(n01_1),.C(n01_2),.D(n01_3));

	EO u_EO_02_0(.Z(n02_0),.A(n0[0]),.B(n2[0]));
	EO u_EO_02_1(.Z(n02_1),.A(n0[1]),.B(n2[1]));
	EO u_EO_02_2(.Z(n02_2),.A(n0[2]),.B(n2[2]));
	EO u_EO_02_3(.Z(n02_3),.A(n0[3]),.B(n2[3]));
	NR4 u_NR4_02(.Z(n02),.A(n02_0),.B(n02_1),.C(n02_2),.D(n02_3));

	EO u_EO_03_0(.Z(n03_0),.A(n0[0]),.B(n3[0]));
	EO u_EO_03_1(.Z(n03_1),.A(n0[1]),.B(n3[1]));
	EO u_EO_03_2(.Z(n03_2),.A(n0[2]),.B(n3[2]));
	EO u_EO_03_3(.Z(n03_3),.A(n0[3]),.B(n3[3]));
	NR4 u_NR4_03(.Z(n03),.A(n03_0),.B(n03_1),.C(n03_2),.D(n03_3));

	EO u_EO_04_0(.Z(n04_0),.A(n0[0]),.B(n4[0]));
	EO u_EO_04_1(.Z(n04_1),.A(n0[1]),.B(n4[1]));
	EO u_EO_04_2(.Z(n04_2),.A(n0[2]),.B(n4[2]));
	EO u_EO_04_3(.Z(n04_3),.A(n0[3]),.B(n4[3]));
	NR4 u_NR4_04(.Z(n04),.A(n04_0),.B(n04_1),.C(n04_2),.D(n04_3));

	//------------------------------------------------------------------------------------------------------

	EO u_EO_12_0(.Z(n12_0),.A(n1[0]),.B(n2[0]));
	EO u_EO_12_1(.Z(n12_1),.A(n1[1]),.B(n2[1]));
	EO u_EO_12_2(.Z(n12_2),.A(n1[2]),.B(n2[2]));
	EO u_EO_12_3(.Z(n12_3),.A(n1[3]),.B(n2[3]));
	NR4 u_NR4_12(.Z(n12),.A(n12_0),.B(n12_1),.C(n12_2),.D(n12_3));

	EO u_EO_13_0(.Z(n13_0),.A(n1[0]),.B(n3[0]));
	EO u_EO_13_1(.Z(n13_1),.A(n1[1]),.B(n3[1]));
	EO u_EO_13_2(.Z(n13_2),.A(n1[2]),.B(n3[2]));
	EO u_EO_13_3(.Z(n13_3),.A(n1[3]),.B(n3[3]));
	NR4 u_NR4_13(.Z(n13),.A(n13_0),.B(n13_1),.C(n13_2),.D(n13_3));

	EO u_EO_14_0(.Z(n14_0),.A(n1[0]),.B(n4[0]));
	EO u_EO_14_1(.Z(n14_1),.A(n1[1]),.B(n4[1]));
	EO u_EO_14_2(.Z(n14_2),.A(n1[2]),.B(n4[2]));
	EO u_EO_14_3(.Z(n14_3),.A(n1[3]),.B(n4[3]));
	NR4 u_NR4_14(.Z(n14),.A(n14_0),.B(n14_1),.C(n14_2),.D(n14_3));

	//------------------------------------------------------------------------------------------------------

	EO u_EO_23_0(.Z(n23_0),.A(n2[0]),.B(n3[0]));
	EO u_EO_23_1(.Z(n23_1),.A(n2[1]),.B(n3[1]));
	EO u_EO_23_2(.Z(n23_2),.A(n2[2]),.B(n3[2]));
	EO u_EO_23_3(.Z(n23_3),.A(n2[3]),.B(n3[3]));
	NR4 u_NR4_23(.Z(n23),.A(n23_0),.B(n23_1),.C(n23_2),.D(n23_3));

	EO u_EO_24_0(.Z(n24_0),.A(n2[0]),.B(n4[0]));
	EO u_EO_24_1(.Z(n24_1),.A(n2[1]),.B(n4[1]));
	EO u_EO_24_2(.Z(n24_2),.A(n2[2]),.B(n4[2]));
	EO u_EO_24_3(.Z(n24_3),.A(n2[3]),.B(n4[3]));
	NR4 u_NR4_24(.Z(n24),.A(n24_0),.B(n24_1),.C(n24_2),.D(n24_3));

	//------------------------------------------------------------------------------------------------------

	EO u_EO_34_0(.Z(n34_0),.A(n3[0]),.B(n4[0]));
	EO u_EO_34_1(.Z(n34_1),.A(n3[1]),.B(n4[1]));
	EO u_EO_34_2(.Z(n34_2),.A(n3[2]),.B(n4[2]));
	EO u_EO_34_3(.Z(n34_3),.A(n3[3]),.B(n4[3]));
	NR4 u_NR4_34(.Z(n34),.A(n34_0),.B(n34_1),.C(n34_2),.D(n34_3));

	//------------------------------------------------------------------------------------------------------

	IV iv3_n01(inv_n01, n01);
	IV iv3_n02(inv_n02, n02);
	IV iv3_n03(inv_n03, n03);
	IV iv3_n04(inv_n04, n04);

	IV iv3_n12(inv_n12, n12);
	IV iv3_n13(inv_n13, n13);
	IV iv3_n14(inv_n14, n14);

	IV iv3_n23(inv_n23, n23);
	IV iv3_n24(inv_n24, n24);

	IV iv3_n34(inv_n34, n34);

	//------------------------------------------------------------------------------------------------------

	wire [3:0] inv_n0, inv_n1, inv_n2, inv_n3, inv_n4;

	IV iv_n0_0(inv_n0[0], n0[0]);
	IV iv_n0_1(inv_n0[1], n0[1]);
	IV iv_n0_2(inv_n0[2], n0[2]);
	IV iv_n0_3(inv_n0[3], n0[3]);
	
	IV iv_n1_0(inv_n1[0], n1[0]);
	IV iv_n1_1(inv_n1[1], n1[1]);
	IV iv_n1_2(inv_n1[2], n1[2]);
	IV iv_n1_3(inv_n1[3], n1[3]);

	IV iv_n2_0(inv_n2[0], n2[0]);
	IV iv_n2_1(inv_n2[1], n2[1]);
	IV iv_n2_2(inv_n2[2], n2[2]);
	IV iv_n2_3(inv_n2[3], n2[3]);

	IV iv_n3_0(inv_n3[0], n3[0]);
	IV iv_n3_1(inv_n3[1], n3[1]);
	IV iv_n3_2(inv_n3[2], n3[2]);
	IV iv_n3_3(inv_n3[3], n3[3]);

	IV iv_n4_0(inv_n4[0], n4[0]);
	IV iv_n4_1(inv_n4[1], n4[1]);
	IV iv_n4_2(inv_n4[2], n4[2]);
	IV iv_n4_3(inv_n4[3], n4[3]);

	//------------------------------------------------------------------------------------------------------

	// four (5)
	ND4 u_AN4_1(.Z(t1),.A(inv_n01),.B(n12),.C(n23),.D(n34));
	ND4 u_AN4_81(.Z(t81),.A(n02),.B(inv_n12),.C(n23),.D(n34));
	ND4 u_AN4_82(.Z(t82),.A(n01),.B(n13),.C(inv_n23),.D(n34));
	ND4 u_AN4_89(.Z(t89),.A(n01),.B(n12),.C(inv_n23),.D(n24));
	ND4 u_AN4_2(.Z(t2),.A(n01),.B(n12),.C(n23),.D(inv_n34));

	ND3 u_OR3_1(.Z(kkk1),.A(t1),.B(t2),.C(t81));
	ND2 u_OR3_22(.Z(kkk2),.A(t82),.B(t89));
	OR2 u_OR2_24(.Z(four),.A(kkk1),.B(kkk2));

	//------------------------------------------------------------------------------------------------------

	// three (10)
	ND3 u_AN3_3(.Z(t3),.A(n01),.B(n12),.C(inv_n23));
	ND2 u_AN3_4(.Z(t4),.A(inv_n24),.B(inv_n34));
	NR2 u_AN2_4_4(.Z(t4_4),.A(t3),.B(t4));

	ND3 u_AN3_5(.Z(t5),.A(inv_n01),.B(n12),.C(n23));
	ND2 u_AN3_6(.Z(t6),.A(inv_n04),.B(inv_n34));
	NR2 u_AN2_6_6(.Z(t6_6),.A(t5),.B(t6));

	ND3 u_AN3_7(.Z(t7),.A(inv_n01),.B(inv_n12),.C(n23));
	ND2 u_AN3_8(.Z(t8),.A(inv_n02),.B(n34));
	NR2 u_AN2_8_8(.Z(t8_8),.A(t7),.B(t8));

	ND3 u_AN3_67(.Z(t67),.A(n02),.B(n23),.C(inv_n01));
	ND2 u_AN3_68(.Z(t68),.A(inv_n14),.B(inv_n04));
	NR2 u_AN2_68_68(.Z(t68_68),.A(t67),.B(t68));

	ND3 u_AN3_69(.Z(t69),.A(n01),.B(n13),.C(inv_n12));
	ND2 u_AN3_70(.Z(t70),.A(inv_n24),.B(inv_n14));
	NR2 u_AN2_70_70(.Z(t70_70),.A(t69),.B(t70));

	ND3 u_AN3_71(.Z(t71),.A(n01),.B(n14),.C(inv_n23));
	ND2 u_AN3_72(.Z(t72),.A(inv_n12),.B(inv_n13));
	NR2 u_AN2_72_72(.Z(t72_72),.A(t71),.B(t72));

	ND3 u_AN3_73(.Z(t73),.A(n03),.B(n34),.C(inv_n12));
	ND2 u_AN3_74(.Z(t74),.A(inv_n02),.B(inv_n01));
	NR2 u_AN2_74_74(.Z(t74_74),.A(t73),.B(t74));

	ND3 u_AN3_75(.Z(t75),.A(n02),.B(n24),.C(inv_n13));
	ND2 u_AN3_76(.Z(t76),.A(inv_n01),.B(inv_n03));
	NR2 u_AN2_76_76(.Z(t76_76),.A(t75),.B(t76));

	ND3 u_AN3_77(.Z(t77),.A(n13),.B(n14),.C(inv_n02));
	ND2 u_AN3_78(.Z(t78),.A(inv_n12),.B(inv_n01));
	NR2 u_AN2_78_78(.Z(t78_78),.A(t77),.B(t78));

	ND3 u_AN3_79(.Z(t79),.A(n12),.B(n24),.C(inv_n03));
	ND2 u_AN3_80(.Z(t80),.A(inv_n01),.B(inv_n13));
	NR2 u_AN2_80_80(.Z(t80_80),.A(t79),.B(t80));

	NR3 u_OR3_14(.Z(yyy1),.A(t4_4),.B(t6_6),.C(t8_8));
	NR3 u_OR3_15(.Z(yyy2),.A(t68_68),.B(t70_70),.C(t72_72));
	NR3 u_OR3_16(.Z(yyy3),.A(t74_74),.B(t76_76),.C(t78_78));

	IV u_IV_t80_80(.Z(inv_t80_80),.A(t80_80));
	
	ND4 u_OR4_17(.Z(three),.A(yyy1),.B(yyy2),.C(yyy3),.D(inv_t80_80));

	//------------------------------------------------------------------------------------------------------

	// full house (10)
	ND4 u_AN4_9(.Z(t9),.A(n01),.B(inv_n12),.C(n23),.D(n34));
	ND4 u_AN4_10(.Z(t10),.A(n01),.B(n12),.C(inv_n23),.D(n34));
	ND4 u_AN4_11(.Z(t11),.A(n02),.B(n23),.C(inv_n01),.D(n14));
	ND4 u_AN4_12(.Z(t12),.A(n03),.B(n34),.C(inv_n01),.D(n12));
	ND4 u_AN4_83(.Z(t83),.A(n01),.B(n13),.C(inv_n02),.D(n24));
	ND4 u_AN4_84(.Z(t84),.A(n02),.B(n24),.C(inv_n01),.D(n13));
	ND4 u_AN4_85(.Z(t85),.A(n01),.B(n14),.C(inv_n02),.D(n23));
	ND4 u_AN4_86(.Z(t86),.A(n12),.B(n23),.C(inv_n01),.D(n04));
	ND4 u_AN4_87(.Z(t87),.A(n13),.B(n34),.C(inv_n01),.D(n02));
	ND4 u_AN4_88(.Z(t88),.A(n12),.B(n24),.C(inv_n01),.D(n03));

	ND3 u_OR3_18(.Z(hhh1),.A(t9),.B(t10),.C(t11));
	ND3 u_OR3_19(.Z(hhh2),.A(t12),.B(t83),.C(t84));
	ND3 u_OR3_20(.Z(hhh3),.A(t85),.B(t86),.C(t87));

	IV u_IV_t88(.Z(inv_t88),.A(t88));

	NR4 u_OR4_21(.Z(jjj),.A(hhh1),.B(hhh2),.C(hhh3),.D(inv_t88));

	IV u_IV_full_house(.Z(full_house),.A(jjj));

	//------------------------------------------------------------------------------------------------------

	// one pair (10)
	ND4 u_AN4_13(.Z(t13),.A(n01),.B(inv_n12),.C(inv_n13),.D(inv_n14));
	ND3 u_AN4_14(.Z(t14),.A(inv_n34),.B(inv_n23),.C(inv_n24));
	NR2 u_AN2_14_14(.Z(t14_14),.A(t13),.B(t14));

	ND4 u_AN4_15(.Z(t15),.A(n02),.B(inv_n12),.C(inv_n13),.D(inv_n14));
	ND3 u_AN4_16(.Z(t16),.A(inv_n34),.B(inv_n23),.C(inv_n24));
	NR2 u_AN2_16_16(.Z(t16_16),.A(t15),.B(t16));

	ND4 u_AN4_17(.Z(t17),.A(n03),.B(inv_n12),.C(inv_n13),.D(inv_n14));
	ND3 u_AN4_18(.Z(t18),.A(inv_n34),.B(inv_n23),.C(inv_n24));
	NR2 u_AN2_18_18(.Z(t18_18),.A(t17),.B(t18));

	ND4 u_AN4_19(.Z(t19),.A(n04),.B(inv_n12),.C(inv_n13),.D(inv_n14));
	ND3 u_AN4_20(.Z(t20),.A(inv_n34),.B(inv_n23),.C(inv_n24));
	NR2 u_AN2_20_20(.Z(t20_20),.A(t19),.B(t20));


	ND4 u_AN4_21(.Z(t21),.A(n12),.B(inv_n02),.C(inv_n03),.D(inv_n04));
	ND3 u_AN4_22(.Z(t22),.A(inv_n34),.B(inv_n23),.C(inv_n24));
	NR2 u_AN2_22_22(.Z(t22_22),.A(t21),.B(t22));

	ND4 u_AN4_23(.Z(t23),.A(n13),.B(inv_n02),.C(inv_n03),.D(inv_n04));
	ND3 u_AN4_24(.Z(t24),.A(inv_n34),.B(inv_n23),.C(inv_n24));
	NR2 u_AN2_24_24(.Z(t24_24),.A(t23),.B(t24));

	ND4 u_AN4_25(.Z(t25),.A(n14),.B(inv_n02),.C(inv_n03),.D(inv_n04));
	ND3 u_AN4_26(.Z(t26),.A(inv_n34),.B(inv_n23),.C(inv_n24));
	NR2 u_AN2_26_26(.Z(t26_26),.A(t25),.B(t26));


	ND4 u_AN4_27(.Z(t27),.A(n23),.B(inv_n01),.C(inv_n03),.D(inv_n04));
	ND3 u_AN4_28(.Z(t28),.A(inv_n34),.B(inv_n13),.C(inv_n14));
	NR2 u_AN2_28_28(.Z(t28_28),.A(t27),.B(t28));

	ND4 u_AN4_29(.Z(t29),.A(n24),.B(inv_n01),.C(inv_n03),.D(inv_n04));
	ND3 u_AN4_30(.Z(t30),.A(inv_n34),.B(inv_n13),.C(inv_n14));
	NR2 u_AN2_30_30(.Z(t30_30),.A(t29),.B(t30));


	ND4 u_AN4_31(.Z(t31),.A(n34),.B(inv_n01),.C(inv_n02),.D(inv_n04));
	ND3 u_AN4_32(.Z(t32),.A(inv_n24),.B(inv_n12),.C(inv_n14));
	NR2 u_AN2_32_32(.Z(t32_32),.A(t31),.B(t32));


	NR3 u_OR3_4(.Z(ttt1),.A(t14_14),.B(t16_16),.C(t18_18));
	NR3 u_OR3_5(.Z(ttt2),.A(t20_20),.B(t22_22),.C(t24_24));
	NR3 u_OR3_6(.Z(ttt3),.A(t26_26),.B(t28_28),.C(t30_30));

	IV u_IV_t32_32(.Z(inv_t32_32),.A(t32_32));

	ND4 u_OR4_7(.Z(one_pair),.A(ttt1),.B(ttt2),.C(ttt3),.D(inv_t32_32));

	//------------------------------------------------------------------------------------------------------

	// two pair (15)
	ND3 u_AN3_33(.Z(t33),.A(n01),.B(n23),.C(inv_n12));
	ND2 u_AN3_34(.Z(t34),.A(inv_n34),.B(inv_n14));
	NR2 u_AN2_34_34(.Z(t34_34),.A(t33),.B(t34));

	ND3 u_AN3_35(.Z(t35),.A(n01),.B(n24),.C(inv_n12));
	ND2 u_AN3_36(.Z(t36),.A(inv_n23),.B(inv_n13));
	NR2 u_AN2_36_36(.Z(t36_36),.A(t35),.B(t36));

	ND3 u_AN3_37(.Z(t37),.A(n01),.B(n34),.C(inv_n12));
	ND2 u_AN3_38(.Z(t38),.A(inv_n23),.B(inv_n13));
	NR2 u_AN2_38_38(.Z(t38_38),.A(t37),.B(t38));

	ND3 u_AN3_39(.Z(t39),.A(n02),.B(n13),.C(inv_n12));
	ND2 u_AN3_40(.Z(t40),.A(inv_n34),.B(inv_n24));
	NR2 u_AN2_40_40(.Z(t40_40),.A(t39),.B(t40));

	ND3 u_AN3_41(.Z(t41),.A(n02),.B(n14),.C(inv_n12));
	ND2 u_AN3_42(.Z(t42),.A(inv_n23),.B(inv_n13));
	NR2 u_AN2_42_42(.Z(t42_42),.A(t41),.B(t42));

	ND3 u_AN3_43(.Z(t43),.A(n02),.B(n34),.C(inv_n12));
	ND2 u_AN3_44(.Z(t44),.A(inv_n23),.B(inv_n13));
	NR2 u_AN2_44_44(.Z(t44_44),.A(t43),.B(t44));

	ND3 u_AN3_45(.Z(t45),.A(n03),.B(n12),.C(inv_n23));
	ND2 u_AN3_46(.Z(t46),.A(inv_n24),.B(inv_n34));
	NR2 u_AN2_46_46(.Z(t46_46),.A(t45),.B(t46));

	ND3 u_AN3_47(.Z(t47),.A(n03),.B(n14),.C(inv_n34));
	ND2 u_AN3_48(.Z(t48),.A(inv_n23),.B(inv_n24));
	NR2 u_AN2_48_48(.Z(t48_48),.A(t47),.B(t48));

	ND3 u_AN3_49(.Z(t49),.A(n03),.B(n24),.C(inv_n12));
	ND2 u_AN3_50(.Z(t50),.A(inv_n23),.B(inv_n13));
	NR2 u_AN2_50_50(.Z(t50_50),.A(t49),.B(t50));

	ND3 u_AN3_51(.Z(t51),.A(n04),.B(n12),.C(inv_n24));
	ND2 u_AN3_52(.Z(t52),.A(inv_n23),.B(inv_n34));
	NR2 u_AN2_52_52(.Z(t52_52),.A(t51),.B(t52));

	ND3 u_AN3_53(.Z(t53),.A(n04),.B(n13),.C(inv_n24));
	ND2 u_AN3_54(.Z(t54),.A(inv_n23),.B(inv_n34));
	NR2 u_AN2_54_54(.Z(t54_54),.A(t53),.B(t54));

	ND3 u_AN3_55(.Z(t55),.A(n04),.B(n23),.C(inv_n01));
	ND2 u_AN3_56(.Z(t56),.A(inv_n02),.B(inv_n12));
	NR2 u_AN2_56_56(.Z(t56_56),.A(t55),.B(t56));

	ND3 u_AN3_57(.Z(t57),.A(n12),.B(n34),.C(inv_n01));
	ND2 u_AN3_58(.Z(t58),.A(inv_n13),.B(inv_n03));
	NR2 u_AN2_58_58(.Z(t58_58),.A(t57),.B(t58));

	ND3 u_AN3_59(.Z(t59),.A(n13),.B(n24),.C(inv_n01));
	ND2 u_AN3_60(.Z(t60),.A(inv_n12),.B(inv_n02));
	NR2 u_AN2_60_60(.Z(t60_60),.A(t59),.B(t60));

	ND3 u_AN3_61(.Z(t61),.A(n14),.B(n23),.C(inv_n01));
	ND2 u_AN3_62(.Z(t62),.A(inv_n12),.B(inv_n02));
	NR2 u_AN2_62_62(.Z(t62_62),.A(t61),.B(t62));

	NR4 u_OR4_8(.Z(tttt1),.A(t34_34),.B(t36_36),.C(t38_38),.D(t40_40));
	NR4 u_OR4_9(.Z(tttt2),.A(t42_42),.B(t44_44),.C(t46_46),.D(t48_48));
	NR4 u_OR4_10(.Z(tttt3),.A(t50_50),.B(t52_52),.C(t54_54),.D(t56_56));
	NR3 u_OR4_11(.Z(tttt4),.A(t58_58),.B(t60_60),.C(t62_62));
	ND4 u_OR4_12(.Z(two_pair),.A(tttt1),.B(tttt2),.C(tttt3),.D(tttt4));

	//------------------------------------------------------------------------------------------------------

	// straight

	ND3 u_ND3_1(.Z(t63),.A(inv_n01),.B(inv_n02),.C(inv_n03));
	ND3 u_ND3_2(.Z(t64),.A(inv_n04),.B(inv_n12),.C(inv_n13));
	ND3 u_ND3_3(.Z(t65),.A(inv_n14),.B(inv_n23),.C(inv_n24));
	NR4 u_ND3_123(.Z(t66),.A(t63),.B(t64),.C(t65),.D(n34));
	
	//--------------------------------------------------------- 12345
	ND2 u_ND3_12345_n0_2(.Z(g2),.A(inv_n0[3]),.B(inv_n0[1]));
	ND2 u_ND3_12345_n0_3(.Z(g3),.A(inv_n0[3]),.B(inv_n0[2]));
	ND2 u_ND3_12345_n0(.Z(gg1),.A(g2),.B(g3));

	ND2 u_ND3_12345_n1_2(.Z(g5),.A(inv_n1[3]),.B(inv_n1[1]));
	ND2 u_ND3_12345_n1_3(.Z(g6),.A(inv_n1[3]),.B(inv_n1[2]));
	ND2 u_ND3_12345_n1(.Z(gg2),.A(g5),.B(g6));

	ND2 u_ND3_12345_n2_2(.Z(g8),.A(inv_n2[3]),.B(inv_n2[1]));
	ND2 u_ND3_12345_n2_3(.Z(g9),.A(inv_n2[3]),.B(inv_n2[2]));
	ND2 u_ND3_12345_n2(.Z(gg3),.A(g8),.B(g9));

	ND2 u_ND3_12345_n3_2(.Z(g11),.A(inv_n3[3]),.B(inv_n3[1]));
	ND2 u_ND3_12345_n3_3(.Z(g12),.A(inv_n3[3]),.B(inv_n3[2]));
	ND2 u_ND3_12345_n3(.Z(gg4),.A(g11),.B(g12));

	ND2 u_ND3_12345_n4_2(.Z(g14),.A(inv_n4[3]),.B(inv_n4[1]));
	ND2 u_ND3_12345_n4_3(.Z(g15),.A(inv_n4[3]),.B(inv_n4[2]));
	ND2 u_ND3_12345_n4(.Z(gg5),.A(g14),.B(g15));

	ND3 u_ND3_12345_1(.Z(ggg1),.A(gg1),.B(gg2),.C(gg3));
	ND2 u_ND3_12345_2(.Z(ggg2),.A(gg4),.B(gg5));
	NR2 u_ND3_12345(.Z(gggg1),.A(ggg1),.B(ggg2));

	//---------------------------------------------------------23456
	ND3 u_ND3_23456_n0_1(.Z(g16),.A(inv_n0[3]),.B(n0[2]),.C(inv_n0[1]));
	ND3 u_ND3_23456_n0_2(.Z(g17),.A(inv_n0[3]),.B(inv_n0[2]),.C(n0[1]));
	ND2 u_ND3_23456_n0_3(.Z(g18),.A(inv_n0[3]),.B(inv_n0[0]));
	ND3 u_ND3_23456_n0(.Z(gg6),.A(g16),.B(g17),.C(g18));

	ND3 u_ND3_23456_n1_1(.Z(g19),.A(inv_n1[3]),.B(n1[2]),.C(inv_n1[1]));
	ND3 u_ND3_23456_n1_2(.Z(g20),.A(inv_n1[3]),.B(inv_n1[2]),.C(n1[1]));
	ND2 u_ND3_23456_n1_3(.Z(g21),.A(inv_n1[3]),.B(inv_n1[0]));
	ND3 u_ND3_23456_n1(.Z(gg7),.A(g19),.B(g20),.C(g21));

	ND3 u_ND3_23456_n2_1(.Z(g22),.A(inv_n2[3]),.B(n2[2]),.C(inv_n2[1]));
	ND3 u_ND3_23456_n2_2(.Z(g23),.A(inv_n2[3]),.B(inv_n2[2]),.C(n2[1]));
	ND2 u_ND3_23456_n2_3(.Z(g24),.A(inv_n2[3]),.B(inv_n2[0]));
	ND3 u_ND3_23456_n2(.Z(gg8),.A(g22),.B(g23),.C(g24));

	ND3 u_ND3_23456_n3_1(.Z(g25),.A(inv_n3[3]),.B(n3[2]),.C(inv_n3[1]));
	ND3 u_ND3_23456_n3_2(.Z(g26),.A(inv_n3[3]),.B(inv_n3[2]),.C(n3[1]));
	ND2 u_ND3_23456_n3_3(.Z(g27),.A(inv_n3[3]),.B(inv_n3[0]));
	ND3 u_ND3_23456_n3(.Z(gg9),.A(g25),.B(g26),.C(g27));

	ND3 u_ND3_23456_n4_1(.Z(g28),.A(inv_n4[3]),.B(n4[2]),.C(inv_n4[1]));
	ND3 u_ND3_23456_n4_2(.Z(g29),.A(inv_n4[3]),.B(inv_n4[2]),.C(n4[1]));
	ND2 u_ND3_23456_n4_3(.Z(g30),.A(inv_n4[3]),.B(inv_n4[0]));
	ND3 u_ND3_23456_n4(.Z(gg10),.A(g28),.B(g29),.C(g30));

	ND3 u_ND3_23456_1(.Z(ggg3),.A(gg6),.B(gg7),.C(gg8));
	ND2 u_ND3_23456_2(.Z(ggg4),.A(gg9),.B(gg10));
	NR2 u_ND3_23456(.Z(gggg2),.A(ggg3),.B(ggg4));

	//---------------------------------------------------------34567
	ND2 u_ND3_34567_n0_1(.Z(g31),.A(inv_n0[3]),.B(n0[2]));
	ND3 u_ND3_34567_n0_2(.Z(g32),.A(inv_n0[3]),.B(n0[1]),.C(n0[0]));
	ND2 u_ND3_34567_n0(.Z(gg11),.A(g31),.B(g32));
	
	ND2 u_ND3_34567_n1_1(.Z(g33),.A(inv_n1[3]),.B(n1[2]));
	ND3 u_ND3_34567_n1_2(.Z(g34),.A(inv_n1[3]),.B(n1[1]),.C(n1[0]));
	ND2 u_ND3_34567_n1(.Z(gg12),.A(g33),.B(g34));

	ND2 u_ND3_34567_n2_1(.Z(g35),.A(inv_n2[3]),.B(n2[2]));
	ND3 u_ND3_34567_n2_2(.Z(g36),.A(inv_n2[3]),.B(n2[1]),.C(n2[0]));
	ND2 u_ND3_34567_n2(.Z(gg13),.A(g35),.B(g36));

	ND2 u_ND3_34567_n3_1(.Z(g37),.A(inv_n3[3]),.B(n3[2]));
	ND3 u_ND3_34567_n3_2(.Z(g38),.A(inv_n3[3]),.B(n3[1]),.C(n3[0]));
	ND2 u_ND3_34567_n3(.Z(gg14),.A(g37),.B(g38));

	ND2 u_ND3_34567_n4_1(.Z(g39),.A(inv_n4[3]),.B(n4[2]));
	ND3 u_ND3_34567_n4_2(.Z(g40),.A(inv_n4[3]),.B(n4[1]),.C(n4[0]));
	ND2 u_ND3_34567_n4(.Z(gg15),.A(g39),.B(g40));

	ND3 u_ND3_34567_1(.Z(ggg5),.A(gg11),.B(gg12),.C(gg13));
	ND2 u_ND3_34567_2(.Z(ggg6),.A(gg14),.B(gg15));
	NR2 u_ND3_34567(.Z(gggg3),.A(ggg5),.B(ggg6));

	//---------------------------------------------------------45678
	ND2 u_ND3_45678_n0_1(.Z(g41),.A(inv_n0[3]),.B(n0[2]));
	ND3 u_ND3_45678_n0_2(.Z(g42),.A(inv_n0[2]),.B(inv_n0[1]),.C(inv_n0[0]));
	ND2 u_ND3_45678_n0(.Z(gg16),.A(g41),.B(g42));

	ND2 u_ND3_45678_n1_1(.Z(g43),.A(inv_n1[3]),.B(n1[2]));
	ND3 u_ND3_45678_n1_2(.Z(g44),.A(inv_n1[2]),.B(inv_n1[1]),.C(inv_n1[0]));
	ND2 u_ND3_45678_n1(.Z(gg17),.A(g43),.B(g44));

	ND2 u_ND3_45678_n2_1(.Z(g45),.A(inv_n2[3]),.B(n2[2]));
	ND3 u_ND3_45678_n2_2(.Z(g46),.A(inv_n2[2]),.B(inv_n2[1]),.C(inv_n2[0]));
	ND2 u_ND3_45678_n2(.Z(gg18),.A(g45),.B(g46));

	ND2 u_ND3_45678_n3_1(.Z(g47),.A(inv_n3[3]),.B(n3[2]));
	ND3 u_ND3_45678_n3_2(.Z(g48),.A(inv_n3[2]),.B(inv_n3[1]),.C(inv_n3[0]));
	ND2 u_ND3_45678_n3(.Z(gg19),.A(g47),.B(g48));

	ND2 u_ND3_45678_n4_1(.Z(g49),.A(inv_n4[3]),.B(n4[2]));
	ND3 u_ND3_45678_n4_2(.Z(g50),.A(inv_n4[2]),.B(inv_n4[1]),.C(inv_n4[0]));
	ND2 u_ND3_45678_n4(.Z(gg20),.A(g49),.B(g50));

	ND3 u_ND3_45678_1(.Z(ggg7),.A(gg16),.B(gg17),.C(gg18));
	ND2 u_ND3_45678_2(.Z(ggg8),.A(gg19),.B(gg20));
	NR2 u_ND3_45678(.Z(gggg4),.A(ggg7),.B(ggg8));

	//---------------------------------------------------------56789
	ND3 u_ND3_56789_n0_1(.Z(g51),.A(n0[3]),.B(inv_n0[2]),.C(inv_n0[1]));
	ND3 u_ND3_56789_n0_2(.Z(g52),.A(inv_n0[3]),.B(n0[2]),.C(n0[0]));
	ND3 u_ND3_56789_n0_3(.Z(g53),.A(inv_n0[3]),.B(n0[2]),.C(n0[1]));
	ND3 u_ND3_56789_n0(.Z(gg21),.A(g51),.B(g52),.C(g53));

	ND3 u_ND3_56789_n1_1(.Z(g54),.A(n1[3]),.B(inv_n1[2]),.C(inv_n1[1]));
	ND3 u_ND3_56789_n1_2(.Z(g55),.A(inv_n1[3]),.B(n1[2]),.C(n1[0]));
	ND3 u_ND3_56789_n1_3(.Z(g56),.A(inv_n1[3]),.B(n1[2]),.C(n1[1]));
	ND3 u_ND3_56789_n1(.Z(gg22),.A(g54),.B(g55),.C(g56));

	ND3 u_ND3_56789_n2_1(.Z(g57),.A(n2[3]),.B(inv_n2[2]),.C(inv_n2[1]));
	ND3 u_ND3_56789_n2_2(.Z(g58),.A(inv_n2[3]),.B(n2[2]),.C(n2[0]));
	ND3 u_ND3_56789_n2_3(.Z(g59),.A(inv_n2[3]),.B(n2[2]),.C(n2[1]));
	ND3 u_ND3_56789_n2(.Z(gg23),.A(g57),.B(g58),.C(g59));

	ND3 u_ND3_56789_n3_1(.Z(g60),.A(n3[3]),.B(inv_n3[2]),.C(inv_n3[1]));
	ND3 u_ND3_56789_n3_2(.Z(g61),.A(inv_n3[3]),.B(n3[2]),.C(n3[0]));
	ND3 u_ND3_56789_n3_3(.Z(g62),.A(inv_n3[3]),.B(n3[2]),.C(n3[1]));
	ND3 u_ND3_56789_n3(.Z(gg24),.A(g60),.B(g61),.C(g62));

	ND3 u_ND3_56789_n4_1(.Z(g63),.A(n4[3]),.B(inv_n4[2]),.C(inv_n4[1]));
	ND3 u_ND3_56789_n4_2(.Z(g64),.A(inv_n4[3]),.B(n4[2]),.C(n4[0]));
	ND3 u_ND3_56789_n4_3(.Z(g65),.A(inv_n4[3]),.B(n4[2]),.C(n4[1]));
	ND3 u_ND3_56789_n4(.Z(gg25),.A(g63),.B(g64),.C(g65));

	ND3 u_ND3_56789_1(.Z(ggg9),.A(gg21),.B(gg22),.C(gg23));
	ND2 u_ND3_56789_2(.Z(ggg10),.A(gg24),.B(gg25));
	NR2 u_ND3_56789(.Z(gggg5),.A(ggg9),.B(ggg10));

	//---------------------------------------------------------6789 10
	ND2 u_ND3_678910_n0_1(.Z(g66),.A(n0[2]),.B(n0[1]));
	ND3 u_ND3_678910_n0_2(.Z(g67),.A(n0[3]),.B(inv_n0[2]),.C(inv_n0[1]));
	ND3 u_ND3_678910_n0_3(.Z(g68),.A(n0[3]),.B(inv_n0[2]),.C(inv_n0[0]));
	ND3 u_ND3_678910_n0(.Z(gg26),.A(g66),.B(g67),.C(g68));
	
	ND2 u_ND3_678910_n1_1(.Z(g69),.A(n1[2]),.B(n1[1]));
	ND3 u_ND3_678910_n1_2(.Z(g70),.A(n1[3]),.B(inv_n1[2]),.C(inv_n1[1]));
	ND3 u_ND3_678910_n1_3(.Z(g71),.A(n1[3]),.B(inv_n1[2]),.C(inv_n1[0]));
	ND3 u_ND3_678910_n1(.Z(gg27),.A(g69),.B(g70),.C(g71));
	
	ND2 u_ND3_678910_n2_1(.Z(g72),.A(n2[2]),.B(n2[1]));
	ND3 u_ND3_678910_n2_2(.Z(g73),.A(n2[3]),.B(inv_n2[2]),.C(inv_n2[1]));
	ND3 u_ND3_678910_n2_3(.Z(g74),.A(n2[3]),.B(inv_n2[2]),.C(inv_n2[0]));
	ND3 u_ND3_678910_n2(.Z(gg28),.A(g72),.B(g73),.C(g74));

	ND2 u_ND3_678910_n3_1(.Z(g75),.A(n3[2]),.B(n3[1]));
	ND3 u_ND3_678910_n3_2(.Z(g76),.A(n3[3]),.B(inv_n3[2]),.C(inv_n3[1]));
	ND3 u_ND3_678910_n3_3(.Z(g77),.A(n3[3]),.B(inv_n3[2]),.C(inv_n3[0]));
	ND3 u_ND3_678910_n3(.Z(gg29),.A(g75),.B(g76),.C(g77));

	ND2 u_ND3_678910_n4_1(.Z(g78),.A(n4[2]),.B(n4[1]));
	ND3 u_ND3_678910_n4_2(.Z(g79),.A(n4[3]),.B(inv_n4[2]),.C(inv_n4[1]));
	ND3 u_ND3_678910_n4_3(.Z(g80),.A(n4[3]),.B(inv_n4[2]),.C(inv_n4[0]));
	ND3 u_ND3_678910_n4(.Z(gg30),.A(g78),.B(g79),.C(g80));

	ND3 u_ND3_678910_1(.Z(ggg11),.A(gg26),.B(gg27),.C(gg28));
	ND2 u_ND3_678910_2(.Z(ggg12),.A(gg29),.B(gg30));
	NR2 u_ND3_678910(.Z(gggg6),.A(ggg11),.B(ggg12));

	//---------------------------------------------------------789 10 11
	ND2 u_ND3_7891011_n0_1(.Z(g81),.A(n0[3]),.B(inv_n0[2]));
	ND3 u_ND3_7891011_n0_2(.Z(g82),.A(n0[2]),.B(n0[1]),.C(n0[0]));
	ND2 u_ND3_7891011_n0(.Z(gg31),.A(g81),.B(g82));

	ND2 u_ND3_7891011_n1_1(.Z(g83),.A(n1[3]),.B(inv_n1[2]));
	ND3 u_ND3_7891011_n1_2(.Z(g84),.A(n1[2]),.B(n1[1]),.C(n1[0]));
	ND2 u_ND3_7891011_n1(.Z(gg32),.A(g83),.B(g84));

	ND2 u_ND3_7891011_n2_1(.Z(g85),.A(n2[3]),.B(inv_n2[2]));
	ND3 u_ND3_7891011_n2_2(.Z(g86),.A(n2[2]),.B(n2[1]),.C(n2[0]));
	ND2 u_ND3_7891011_n2(.Z(gg33),.A(g85),.B(g86));

	ND2 u_ND3_7891011_n3_1(.Z(g87),.A(n3[3]),.B(inv_n3[2]));
	ND3 u_ND3_7891011_n3_2(.Z(g88),.A(n3[2]),.B(n3[1]),.C(n3[0]));
	ND2 u_ND3_7891011_n3(.Z(gg34),.A(g87),.B(g88));

	ND2 u_ND3_7891011_n4_1(.Z(g89),.A(n4[3]),.B(inv_n4[2]));
	ND3 u_ND3_7891011_n4_2(.Z(g90),.A(n4[2]),.B(n4[1]),.C(n4[0]));
	ND2 u_ND3_7891011_n4(.Z(gg35),.A(g89),.B(g90));

	ND3 u_ND3_7891011_1(.Z(ggg13),.A(gg31),.B(gg32),.C(gg33));
	ND2 u_ND3_7891011_2(.Z(ggg14),.A(gg34),.B(gg35));
	NR2 u_ND3_7891011(.Z(gggg7),.A(ggg13),.B(ggg14));

	//---------------------------------------------------------89 10 11 12
	ND2 u_ND3_89101112_n0_1(.Z(g91),.A(n0[3]),.B(inv_n0[2]));
	ND2 u_ND3_89101112_n0_2(.Z(g92),.A(n0[3]),.B(inv_n0[0]));
	ND2 u_ND3_89101112_n0(.Z(gg36),.A(g91),.B(g92));
	
	ND2 u_ND3_89101112_n1_1(.Z(g93),.A(n1[3]),.B(inv_n1[2]));
	ND2 u_ND3_89101112_n1_2(.Z(g94),.A(n1[3]),.B(inv_n1[0]));
	ND2 u_ND3_89101112_n1(.Z(gg37),.A(g93),.B(g94));
	
	ND2 u_ND3_89101112_n2_1(.Z(g95),.A(n2[3]),.B(inv_n2[2]));
	ND2 u_ND3_89101112_n2_2(.Z(g96),.A(n2[3]),.B(inv_n2[0]));
	ND2 u_ND3_89101112_n2(.Z(gg38),.A(g95),.B(g96));

	ND2 u_ND3_89101112_n3_1(.Z(g97),.A(n3[3]),.B(inv_n3[2]));
	ND2 u_ND3_89101112_n3_2(.Z(g98),.A(n3[3]),.B(inv_n3[0]));
	ND2 u_ND3_89101112_n3(.Z(gg39),.A(g97),.B(g98));

	ND2 u_ND3_89101112_n4_1(.Z(g99),.A(n4[3]),.B(inv_n4[2]));
	ND2 u_ND3_89101112_n4_2(.Z(g100),.A(n4[3]),.B(inv_n4[0]));
	ND2 u_ND3_89101112_n4(.Z(gg40),.A(g99),.B(g100));

	ND3 u_ND3_89101112_1(.Z(ggg15),.A(gg36),.B(gg37),.C(gg38));
	ND2 u_ND3_89101112_2(.Z(ggg16),.A(gg39),.B(gg40));
	NR2 u_ND3_89101112(.Z(gggg8),.A(ggg15),.B(ggg16));

	//---------------------------------------------------------9 10 11 12 13
	ND2 u_ND3_910111213_n0_1(.Z(g101),.A(n0[3]),.B(n0[2]));
	ND2 u_ND3_910111213_n0_2(.Z(g102),.A(n0[3]),.B(n0[0]));
	ND2 u_ND3_910111213_n0_3(.Z(g103),.A(n0[3]),.B(n0[1]));
	ND3 u_ND3_910111213_n0(.Z(gg41),.A(g101),.B(g102),.C(g103));
	
	ND2 u_ND3_910111213_n1_1(.Z(g104),.A(n1[3]),.B(n1[2]));
	ND2 u_ND3_910111213_n1_2(.Z(g105),.A(n1[3]),.B(n1[0]));
	ND2 u_ND3_910111213_n1_3(.Z(g106),.A(n1[3]),.B(n1[1]));
	ND3 u_ND3_910111213_n1(.Z(gg42),.A(g104),.B(g105),.C(g106));
	
	ND2 u_ND3_910111213_n2_1(.Z(g107),.A(n2[3]),.B(n2[2]));
	ND2 u_ND3_910111213_n2_2(.Z(g108),.A(n2[3]),.B(n2[0]));
	ND2 u_ND3_910111213_n2_3(.Z(g109),.A(n2[3]),.B(n2[1]));
	ND3 u_ND3_910111213_n2(.Z(gg43),.A(g107),.B(g108),.C(g109));

	ND2 u_ND3_910111213_n3_1(.Z(g110),.A(n3[3]),.B(n3[2]));
	ND2 u_ND3_910111213_n3_2(.Z(g111),.A(n3[3]),.B(n3[0]));
	ND2 u_ND3_910111213_n3_3(.Z(g112),.A(n3[3]),.B(n3[1]));
	ND3 u_ND3_910111213_n3(.Z(gg44),.A(g110),.B(g111),.C(g112));

	ND2 u_ND3_910111213_n4_1(.Z(g113),.A(n4[3]),.B(n4[2]));
	ND2 u_ND3_910111213_n4_2(.Z(g114),.A(n4[3]),.B(n4[0]));
	ND2 u_ND3_910111213_n4_3(.Z(g115),.A(n4[3]),.B(n4[1]));
	ND3 u_ND3_910111213_n4(.Z(gg45),.A(g113),.B(g114),.C(g115));

	ND3 u_ND3_910111213_1(.Z(ggg17),.A(gg41),.B(gg42),.C(gg43));
	ND2 u_ND3_910111213_2(.Z(ggg18),.A(gg44),.B(gg45));
	NR2 u_ND3_910111213(.Z(gggg9),.A(ggg17),.B(ggg18));

	//---------------------------------------------------------10 11 12 13 1
	ND2 u_ND3_101112131_n0_1(.Z(g116),.A(n0[3]),.B(n0[1]));
	ND2 u_ND3_101112131_n0_2(.Z(g117),.A(n0[3]),.B(n0[2]));
	ND3 u_ND3_101112131_n0_3(.Z(g118),.A(inv_n0[3]),.B(inv_n0[2]),.C(inv_n0[1]));
	ND3 u_ND3_101112131_n0(.Z(gg46),.A(g116),.B(g117),.C(g118));
	
	ND2 u_ND3_101112131_n1_1(.Z(g119),.A(n1[3]),.B(n1[1]));
	ND2 u_ND3_101112131_n1_2(.Z(g120),.A(n1[3]),.B(n1[2]));
	ND3 u_ND3_101112131_n1_3(.Z(g121),.A(inv_n1[3]),.B(inv_n1[2]),.C(inv_n1[1]));
	ND3 u_ND3_101112131_n1(.Z(gg47),.A(g119),.B(g120),.C(g121));
	
	ND2 u_ND3_101112131_n2_1(.Z(g122),.A(n2[3]),.B(n2[1]));
	ND2 u_ND3_101112131_n2_2(.Z(g123),.A(n2[3]),.B(n2[2]));
	ND3 u_ND3_101112131_n2_3(.Z(g124),.A(inv_n2[3]),.B(inv_n2[2]),.C(inv_n2[1]));
	ND3 u_ND3_101112131_n2(.Z(gg48),.A(g122),.B(g123),.C(g124));

	ND2 u_ND3_101112131_n3_1(.Z(g125),.A(n3[3]),.B(n3[1]));
	ND2 u_ND3_101112131_n3_2(.Z(g126),.A(n3[3]),.B(n3[2]));
	ND3 u_ND3_101112131_n3_3(.Z(g127),.A(inv_n3[3]),.B(inv_n3[2]),.C(inv_n3[1]));
	ND3 u_ND3_101112131_n3(.Z(gg49),.A(g125),.B(g126),.C(g127));

	ND2 u_ND3_101112131_n4_1(.Z(g128),.A(n4[3]),.B(n4[1]));
	ND2 u_ND3_101112131_n4_2(.Z(g129),.A(n4[3]),.B(n4[2]));
	ND3 u_ND3_101112131_n4_3(.Z(g130),.A(inv_n4[3]),.B(inv_n4[2]),.C(inv_n4[1]));
	ND3 u_ND3_101112131_n4(.Z(gg50),.A(g128),.B(g129),.C(g130));

	ND3 u_ND3_101112131_1(.Z(ggg19),.A(gg46),.B(gg47),.C(gg48));
	ND2 u_ND3_101112131_2(.Z(ggg20),.A(gg49),.B(gg50));
	NR2 u_ND3_101112131(.Z(gggg10),.A(ggg19),.B(ggg20));

	//-------------------------------------------------------------------------------------------
	
	IV u_IV_gggg10(.Z(inv_gggg10),.A(gggg10));
	
	NR3 u_OR3_ggggg1(.Z(ggggg1),.A(gggg1),.B(gggg2),.C(gggg3));
	NR3 u_OR3_ggggg2(.Z(ggggg2),.A(gggg4),.B(gggg5),.C(gggg6));
	NR3 u_OR3_ggggg3(.Z(ggggg3),.A(gggg7),.B(gggg8),.C(gggg9));
	ND4 u_OR4_straight(.Z(qqq),.A(ggggg1),.B(ggggg2),.C(ggggg3),.D(inv_gggg10));

	AN2 and_straight(.Z(straight),.A(qqq),.B(t66));

	ND2 and_inv_straight(.Z(inv_straight),.A(qqq),.B(t66));

	//------------------------------------------------------------------------------------------------------
endmodule

module card_type(flush, four, three, full_house, two_pair, one_pair, straight, type, inv_straight);
	input flush, four, three, full_house, two_pair, one_pair, straight, inv_straight;
	output [3:0] type;

	// type[3]
	AN2 u_AN2_1(.Z(type[3]),.A(flush),.B(straight));

	// type[2]
	IV iv_flush(inv_flush, flush);
	IV iv_full_house(inv_full_house, full_house);
	IV iv_four(inv_four, four);
	ND2 flush_straight_1(.Z(www1),.A(inv_straight),.B(flush));
	ND2 flush_straight_2(.Z(www2),.A(straight),.B(inv_flush));
	ND4 type2(.Z(type[2]),.A(www1),.B(www2),.C(inv_full_house),.D(inv_four));

	// type[1]
	NR4 u_OR4_1(.Z(fff),.A(two_pair),.B(three),.C(full_house),.D(four));
	IV iv_type1(type[1], fff);

	// type[0]
	ND2 u_AN2_2(.Z(t2),.A(flush),.B(inv_straight));
	IV iv_one_pair(inv_one_pair, one_pair);
	IV iv_three(inv_three, three);
	ND4 u_OR4_2(.Z(type[0]),.A(inv_one_pair),.B(inv_three),.C(t2),.D(inv_four));
endmodule