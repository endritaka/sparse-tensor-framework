`define DWIDTH 32

module mux_4_1 (clk, reset, sel, a, b, c, d, out);

input clk, reset;
input [1:0] sel;
input [`DWIDTH-1:0] a, b, c, d;
output reg [`DWIDTH-1:0] out;

// input comes from register to measure delay (frequency),
// because we constraint input/outputs (not included in final Fmax)
reg [`DWIDTH-1:0] a_reg, b_reg, c_reg, d_reg;

reg [1:0] sel_reg;

// output of combinational mux
reg [`DWIDTH-1:0] out_comb_mux;

always @(posedge clk)
begin
	if (reset) begin
        a_reg <= 0;
        b_reg <= 0;
        c_reg <= 0;
        d_reg <= 0;
        sel_reg <= 0;
        out <= 0;
	end
	else begin
        a_reg <= a;
        b_reg <= b;
        c_reg <= c;
        d_reg <= d;
        sel_reg <= sel;
        out <= out_comb_mux;
	end
end


// combinational mux 
always @(*)
begin
    case(sel_reg)
    2'b00 : out_comb_mux = a_reg;
    2'b01 : out_comb_mux = b_reg;
    2'b10 : out_comb_mux = c_reg;
    2'b11 : out_comb_mux = d_reg;
    endcase
end


endmodule