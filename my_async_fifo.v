module my_async_fifo(
	input	clk_w,
	input	clk_r,
	input	nrst,
	input	w_en,
	input	r_en,
	input	[7:0]	w_data,
	output	reg	[7:0]	r_data,
	output	empty,
	output	full
);
// let's assume the size of this fifo is 8; 
//address pointer
reg	[3:0]	w_add_pointer,r_add_pointer;
always@(posedge clk_w or negedge nrst)begin
	if(!nrst)
		w_add_pointer	<=	4'd0;
	else	if(w_en &&	(!full))
		w_add_pointer	<=	w_add_pointer	+	1'b1;
	else
		w_add_pointer	<=	w_add_pointer;
end
always@(posedge clk_r or negedge nrst)begin
	if(!nrst)
		r_add_pointer	<=	4'd0;
	else	if(r_en	&&	(!empty))
		r_add_pointer	<=	r_add_pointer	+	1'b1;
	else
		r_add_pointer	<=	r_add_pointer;
end
//gary code
wire	[3:0]	w_add_gary,r_add_gary;
assign	w_add_gary	=	(w_add_pointer	>>	1)	^	w_add_pointer;
assign	r_add_gary	=	(r_add_pointer	>>	1)	^	r_add_pointer;
//cdc
reg	[3:0]	w_add_gary_r,w_add_gary_rr,r_add_gary_r,r_add_gary_rr;
always@(posedge clk_w or negedge nrst)begin
	if(!nrst)begin
		r_add_gary_r	<=	4'd0;
		r_add_gary_rr	<=	4'd0;
	end
	else	begin
		r_add_gary_r	<=	r_add_gary;
		r_add_gary_rr	<=	r_add_gary_r;
	end
end
always@(posedge clk_r or negedge nrst)begin
	if(!nrst)begin
		w_add_gary_r	<=	4'd0;
		w_add_gary_rr	<=	4'd0;
	end
	else	begin
		w_add_gary_r	<=	w_add_gary;
		w_add_gary_rr	<=	w_add_gary_r;
	end
end
// full and empty
assign	empty	=	(r_add_gary	==	w_add_gary_rr);
assign	full	=	(w_add_gary[3:2]	!=	r_add_gary_rr[3:2])	&	(w_add_gary[1:0]	==	r_add_gary_rr[1:0]);
//address
wire	[2:0]	w_add	=	w_add_pointer[2:0];
wire	[2:0]	r_add	=	r_add_pointer[2:0];
//read and write
integer i;
reg	[7:0]	ram	[7:0];
always@(posedge	clk_w or negedge nrst)begin
	if(!nrst)begin
		for(i=0;i<7;i=i+1)
			ram[i]	<=	8'd0;
	end
	else if(w_en & (!full))
			ram[w_add]	<=	w_data;
end
always@(posedge clk_r or negedge nrst)begin
	if(!nrst)
		r_data	<=	8'd0;
	else if(r_en & (!empty))
		r_data	<=	ram[r_add];
end
endmodule

		
		
		
			
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
