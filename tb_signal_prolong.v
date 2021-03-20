module tb_signal_prolong;
  reg clk1,clk2,nrst,in_pulse;
  wire  out_pulse,out_level;

initial begin
  clk1 = 1'b0;
  clk2 = 1'b0;
  nrst = 1'b0;
  in_pulse = 1'b0;
  #5  nrst = 1'b1;
  #5 in_pulse = 1'b1;
  #6 in_pulse = 1'b0;
end
always # 3  clk1 = !clk1;
always # 9  clk2 = !clk2;

signal_prolong u0(
	.clk1(clk1),	// high frequency
	.clk2(clk2),	// low frequency
	.nrst(nrst),
	.in_pulse(in_pulse),
	.out_pulse(out_pulse),
	.out_level(out_level)
);
endmodule
