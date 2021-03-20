module high_level_test(
	input	clk,
	input	nrst,
	input	[12:0]	data,
	output	reg	[3:0]	sum
);
integer i;
always@(posedge clk	or negedge nrst)begin
	if(!nrst)
		sum	<=	4'd0;
	else begin
		sum	=	4'd0;
		for(i=0;i<13;i=i+1)
			if(data[i])
				sum	=	sum + 1'b1;
	end
end
endmodule