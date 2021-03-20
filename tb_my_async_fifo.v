module tb_my_async_fifo;
reg	clk_w,clk_r,nrst,w_en,r_en;
reg	[7:0]	w_data;
wire	[7:0]	r_data;
wire	empty,full;
initial begin
	clk_r	=	1'b0;
	clk_w	=	1'b0;
	nrst	=	1'b0;
	w_en	=	1'b0;
	r_en	=	1'b0;
	w_data	=	8'd0;
	#100	nrst	=	1'b1;
	#20	gen_data;
	@(posedge clk_r);
	r_en	=	1'b1;
	repeat(8)@(posedge clk_r);
	r_en	=	1'b0;
end
always #10	clk_w	=	!clk_w;
always #5	clk_r	=	!clk_r;
task	gen_data;
	integer i;
	begin
		for(i=0;i<7;i=i+1)begin
			w_en	=	1'b1;
			w_data	=	i;
			#20;
		end
		w_en	=	1'b0;
		w_data	=	8'd0;
	end
endtask
my_async_fifo	u0(
	.clk_w(clk_w),
	.clk_r(clk_r),
	.nrst(nrst),
	.w_en(w_en),
	.r_en(r_en),
	.w_data(w_data),
	.r_data(r_data),
	.empty(empty),
	.full(full)
);


endmodule