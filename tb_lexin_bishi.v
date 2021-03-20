module	tb_lexin_bishi;
reg	clk,nrst;
reg	[7:0]	value;
wire	[7:0]	check_sum;
initial begin
	clk = 1'b0;
	nrst = 1'b0;
	value = 8'h00;
	#5 nrst =1'b1;
	# 10	value = value +1'b1;
	# 10	value = value +1'b1;
	# 10	value = value +1'b1;
	# 10	value = value +1'b1;
	# 10	value = value +1'b1;
	# 10	value = value +1'b1;
	# 10	value = value +1'b1;
	# 10	value = value +1'b1;
	# 10	value = value +1'b1;
	# 10	value = value +1'b1;
	# 10	value = value +1'b1;
	# 10	value = value +1'b1;
	# 10	value = value +1'b1;
	# 10	value = value +1'b1;
	# 10	value = value +1'b1;
end
always # 5 clk = !clk;
lexin_bishi	u0(
	.clk(clk),
	.nrst(nrst),
	.value(value),
	.check_sum(check_sum)
	);
endmodule