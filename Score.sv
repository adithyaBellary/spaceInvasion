module Score (
	input draw_explosion, Clk, Reset,
	output [3:0] score
);
logic [3:0] count, count_in;

assign score = count;


always_ff @(posedge Clk or posedge Reset)
begin
	if(Reset == 1'b1)
		count = 4'b0;
	else
		count <= count_in;
end

always_comb
begin
	if(draw_explosion == 1'b1)
		count_in = count + 1'b1;
	else
		count_in = count;
end


endmodule
