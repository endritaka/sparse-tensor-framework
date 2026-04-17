`define DWIDTH 32
module simple_adder (clk, reset, a, b, sum);



input clk, reset;
input [`DWIDTH-1:0] a, b;
output [`DWIDTH-1:0] sum;

// input comes from register to measure delay (frequency),
// because we constraint input/outputs (not included in final Fmax)
reg [`DWIDTH-1:0] a_reg, b_reg;
reg [`DWIDTH-1:0] sum_reg;


always @(posedge clk)
begin
	if (reset) begin
        a_reg <= 0;
        b_reg <= 0;
        sum_reg <= 0;
	end
	else begin
        a_reg <= a;
        b_reg <= b;
        sum_reg <= a_reg + b_reg;
              
	end
end


assign sum = ~(sum_reg & a_reg);


endmodule