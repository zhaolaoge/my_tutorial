module tb_my_fifo;
  reg clk,nrst,wen,ren;
  reg [7:0] in_data;
  wire  empty,full;
  wire  [7:0] out_data;
initial begin
  clk = 1'b0;
  nrst = 1'b0;
  wen = 1'b0;
  ren = 1'b0;
  in_data = 8'd1;
  #5 nrst = 1'b1;
  
  #5  wen = 1'b1;
  #5  in_data = 8'd2;
  #5  wen = 1'b0;
      ren = 1'b1;
  #10 ren = 1'b0;
  
  #5  wen = 1'b1;
  #5  in_data = 8'd3;
  #5  wen = 1'b0;
  
  #5  wen = 1'b1;
  #5  in_data = 8'd4;
  #5  wen = 1'b0;
  
  #5  wen = 1'b1;
  #5  in_data = 8'd5;
  #5  wen = 1'b0;
      ren = 1'b1;
  #10 ren = 1'b0;
  
  #5  wen = 1'b1;
  #5  in_data = 8'd6;
  #5  wen = 1'b0;
  
  #5  wen = 1'b1;
  #5  in_data = 8'd7;
  #5  wen = 1'b0;
  
  #5  wen = 1'b1;
  #5  in_data = 8'd8;
  #5  wen = 1'b0;
  
  #5  wen = 1'b1;
  #5  in_data = 8'd9;
  #5  wen = 1'b0;
      ren = 1'b1;
  #10 ren = 1'b0;
  
  #5  wen = 1'b1;
  #5  in_data = 8'd10;
  #5  wen = 1'b0;
  
  #5  wen = 1'b1;
  #5  in_data = 8'd11;
  #5  wen = 1'b0;
  
  #5  wen = 1'b1;
  #5  in_data = 8'd12;
  #5  wen = 1'b0;
      ren = 1'b1;
  #10 ren = 1'b0;
end
always #5 clk = !clk;
my_fifo u0(
	.clk(clk),
	.nrst(nrst),
	.wen(wen),
	.in_data(in_data),
	.ren(ren),
	.out_data(out_data),
	.empty(empty),
	.full(full)
);

endmodule