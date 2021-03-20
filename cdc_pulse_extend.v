module Sync_Pulse
(
    input   clka,
    input   clkb,
    input   rst_n,
    input   pulse_ina,      //??????????
    output  pulse_outb,     //????
    output  signal_outb     //????
);
//--------------------------------------------------------
reg         signal_a;
reg         signal_a_r1;
reg         signal_a_r2;
reg         signal_b;
reg         signal_b_r1;
//--------------------------------------------------------
//--    a?????????
//--------------------------------------------------------
always @(posedge clka or negedge rst_n)begin
    if(!rst_n)begin
        signal_a <= 1'b0;
    end
    else if(pulse_ina) begin        //?????
        signal_a <= 1'b1;           //??
    end
    else if(signal_a_r2) begin      //???b????a
        signal_a <= 1'b0;           //?????????
    end
end
//--------------------------------------------------------
//--    ???????b???????a???
//--------------------------------------------------------
always @(posedge clkb or negedge rst_n)begin
    if(!rst_n)begin
        signal_b    <= 1'b0;
        signal_b_r1 <= 1'b0;
    end
    else begin
        signal_b    <= signal_a;
        signal_b_r1 <= signal_b;
    end
end

always @(posedge clka or negedge rst_n)begin
    if(!rst_n)begin
        signal_a_r1 <= 1'b0;
        signal_a_r2 <= 1'b0;
    end
    else begin
        signal_a_r1 <= signal_b_r1;
        signal_a_r2 <= signal_a_r1;
    end
end
//--------------------------------------------------------
//--    ??????,?????
//--------------------------------------------------------
assign pulse_outb = ~signal_b_r1 & signal_b;
//--------------------------------------------------------
//--    ???????b???????
//--------------------------------------------------------
assign signal_outb = signal_b_r1;


endmodule