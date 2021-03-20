module lexin_bishi(
	input	clk,
	input	nrst,
	input	[7:0]	value,
	output	reg	[7:0]	check_sum
	);
always@(posedge clk	or	negedge nrst)begin
	if(!nrst)
		check_sum	<=	8'd0;
	else	begin
		check_sum[7]=	value[3]^value[2]^value[5];
		check_sum[6]=	value[2]^value[1]^value[4]^value[7];
		check_sum[5]=	value[1]^value[7]^value[0]^value[3]^value[6];
		check_sum[4]=	value[7]^value[0]^value[3]^value[6];
		check_sum[3]=	value[3]^value[7]^value[6];
		check_sum[2]=	value[2]^value[6]^value[5];
		check_sum[1]=	value[1]^value[5]^value[4]^value[7];
		check_sum[0]=	value[0]^value[4]^value[3]^value[6];
	end
end
endmodule