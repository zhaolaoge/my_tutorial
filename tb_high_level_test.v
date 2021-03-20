module	tb_high_level_test;
reg	clk,nrst;
reg	[12:0]	data;
wire	[3:0]	sum;
initial	begin
	clk	=	1'b0;
	nrst	=	1'b0;
	data	=	13'b1_1010_0101_1100;
	#5	nrst	=	1'b1;
end
always #5	clk	=	!clk;
high_level_test	uo(
	.clk(clk),
	.nrst(nrst),
	.data(data),
	.sum(sum)
);
endmodule