module	tb_frequency_dividers;
reg	clk,nrst;
wire	out1,out2,out3,out4;
initial	begin
	nrst	=	1'b0;
	clk	=	1'b0;
	#5	nrst	=	1'b1;
end
always	#5	clk	=	!clk;
frequency_dividers	u0(
	.clkin(clk),
	.nrst(nrst),
	.clk_1(out1),  //	2n1	times
	.clk_2(out2),	//	2n2+1	times
	.clk_3(out3),	//	n3+0.5	times
	.clk_4(out4)	//	m/n	times
);
endmodule