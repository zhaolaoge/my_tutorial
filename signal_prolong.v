module signal_prolong(
	input	clk1,	// high frequency
	input	clk2,	// low frequency
	input	nrst,
	input	in_pulse,
	output	out_pulse,
	output	out_level
);
reg pulse_broaden,pulse_clk1_r,pulse_clk1_rr,pulse_clk2_r,pulse_clk2_rr;

always@(posedge clk1 or negedge nrst)begin
	if(!nrst)
		pulse_broaden	<=	1'b0;
	else if(in_pulse	==	1'b1)
		pulse_broaden	<=	1'b1;
	else if(pulse_clk1_rr	== 1'b1)
		pulse_broaden	<=	1'b0;
	else
		pulse_broaden	<=	pulse_broaden;
end

always@(posedge	clk2 or negedge	nrst)begin
	if(!nrst)begin
		pulse_clk2_r	<=	1'b0;
		pulse_clk2_rr	<=	1'b0;
	end
	else begin
		pulse_clk2_r	<=	pulse_broaden;
		pulse_clk2_rr	<=	pulse_clk2_r;
	end
end

always@(posedge	clk1 or negedge	nrst)begin
	if(!nrst)begin
		pulse_clk1_r	<=	1'b0;
		pulse_clk1_rr	<=	1'b0;
	end
	else begin
		pulse_clk1_r	<=	pulse_clk2_rr;
		pulse_clk1_rr	<=	pulse_clk1_r;
	end
end

assign	out_pulse	=	(pulse_clk2_rr && (!pulse_clk2_r));
assign  out_level	=	pulse_clk2_rr;

endmodule
	
	