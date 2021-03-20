module tb_cdc_pulse_extend;
  reg clk_a,clk_b,nrst,data;
  wire pulse_b,signal_b;
  initial begin
    nrst  = 1'b1;
    clk_a = 1'b1;
    clk_b = 1'b1;
    data  = 1'b0;
    #5  nrst  = 1'b0;
    #5  nrst  = 1'b1;
    #10 data  = 1'b1;
    #2  data     = 1'b0;
  end
  always  #1  clk_a = ~clk_a;
  always  #5  clk_b = ~clk_b;
Sync_Pulse  u0
(
    .clka(clk_a),
    .clkb(clk_b),
    .rst_n(nrst),
    .pulse_ina(data),      //??????????
    .pulse_outb(pulse_b),     //????
    .signal_outb(signal_b)     //????
);
endmodule