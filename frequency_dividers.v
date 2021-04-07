module frequency_dividers(
	input	clkin,
	input	nrst,
	output	reg	clk_1,  //	2n1	times
	output	clk_2,	//	2n2+1	times
	output	clk_3,	//	n3+0.5	times
	output	reg	clk_4	//	m/n	times
);
parameter	n1=3,n2=3,n3=5,m=11,n=4;

reg[2:0]	counter1;
always@(posedge	clkin or negedge nrst)begin
	if(!nrst)
		counter1	<=	3'd0;
	else	if(counter1	<	n1-1)
		counter1	<=	counter1	+	1'b1;
	else
		counter1	<=	3'd0;
end
always@(posedge	clkin or negedge nrst)begin
	if(!nrst)
		clk_1	<=	1'd0;
	else	if(counter1	==	3'd1)
		clk_1	<=	!clk_1;
	else
		clk_1	<=	clk_1;
end
////////////////////////////////////////////////
reg	[2:0]	counter2;
always@(posedge	clkin or negedge nrst)begin
	if(!nrst)
		counter2	<=	3'd0;
	else	if(counter2	<	(2*n2))
		counter2	<=	counter2	+	1'b1;
	else
		counter2	<=	3'd0;
end
reg	clk2_pos,clk2_neg;
always@(posedge	clkin or negedge nrst)begin
	if(!nrst)
		clk2_pos	<=	1'd0;
	else	if(counter2	<=	n2-1)
		clk2_pos	<=	1'b1;
	else
		clk2_pos	<=	1'b0;
end
always@(negedge	clkin or negedge nrst)begin
	if(!nrst)
		clk2_neg	<=	1'd0;
	else	if(counter2	<=	n2-1)
		clk2_neg	<=	1'b1;
	else
		clk2_neg	<=	1'b0;
end
assign	clk_2	=	(clk2_pos	|	clk2_neg);
/////////////////////////////////////////////////
reg	[3:0]	counter3;
always@(posedge clkin or negedge nrst)begin
	if(!nrst)
		counter3	<=	3'd0;
	else	if(counter3	<	(2*n3))
		counter3	<=	counter3	+	1'b1;
	else
		counter3	<=	3'd0;
end
reg	clk3_pos,clk3_neg;	
always@(posedge	clkin or negedge nrst)begin
	if(!nrst)
		clk3_pos	<=	1'd0;
	else	if(counter3	<=	n3)
		clk3_pos	<=	1'b1;
	else
		clk3_pos	<=	1'b0;
end
always@(negedge	clkin or negedge nrst)begin
	if(!nrst)
		clk3_neg	<=	1'd0;
	else	if((counter3	<	n3+1)	&&	(counter3	>	0))
		clk3_neg	<=	1'b0;
	else
		clk3_neg	<=	1'b1;
end
assign	clk_3	=	(clk3_pos	&	clk3_neg);
////////////////////////////////////////////////////
reg	[3:0]	counter4;
always@(posedge	clkin or negedge nrst)begin
	if(!nrst)
		counter4	<=	4'd0;
	else	if(counter4	>=	m-n)
		counter4	<=	counter4	+	n - m;
	else
		counter4	<=	counter4	+	n;
end
always@(posedge	clkin or negedge nrst)begin
	if(!nrst)
		clk_4	<=	1'b0;
	else	if(counter4	>=	m-n)
		clk_4	<=	clkin;
	else
		clk_4	<=	1'b0;
end
endmodule
