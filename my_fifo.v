module my_fifo(
	input	clk,
	input	nrst,
	input	wen,
	input	[7:0]	in_data,
	input	ren,
	output	reg	[7:0]	out_data,
	output	empty,
	output	full
);
//	write and read address
reg	[3:0]	w_add,r_add;
always@(posedge clk or negedge nrst)begin
	if(!nrst)
		w_add	<=	4'd0;
	else if(wen == 1'b1	&&	full == 1'b0)begin
		if(w_add == 4'b1111)
			w_add	<=	4'd0;
		else
			w_add	<=	w_add	+	1'b1;
	end
	else
		w_add	<=	w_add;
end

always@(posedge clk or negedge nrst)begin
	if(!nrst)
		r_add	<=	4'd0;
	else if(ren == 1'b1	&&	empty == 1'b0)begin
		if(r_add == 4'b1111)
			r_add	<=	4'd0;
		else
			r_add	<=	r_add	+	1'b1;
	end
	else
		r_add	<=	r_add;
end


//	write and read data
reg	[7:0]	data	[7:0];
integer i;
always@(posedge clk or negedge nrst)begin
	if(!nrst)begin
		for(i = 0 ; i<8; i = i+1)
			data[i]	<=	8'd0;
	end
	else if(wen == 1'b1	&&	full == 1'b0)
		data[w_add]	<=	in_data;
	else if(ren == 1'b1	&&	empty == 1'b0)
		out_data	<=	data[r_add];
end
		
// empty and full signal
assign	empty	=	(r_add	==	w_add)	?	1'b1	:	1'b0;
assign	full	=	((r_add	^	w_add) == 4'b1000)	?	1'b1	:	1'b0;

endmodule