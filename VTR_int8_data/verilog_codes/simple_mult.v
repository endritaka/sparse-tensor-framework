`define DWIDTH 36

module my_multiplier_top(a_act0, b_act0, a_act1, b_act1, a_weight0, b_weight0, a_weight1, b_weight1, clk, reset, out_act0, out_act1);

input [36-1:0] a_act0, a_act1, b_act0, b_act1;
input [36-1:0] a_weight0, a_weight1, b_weight0, b_weight1;
input clk, reset;

output [72-1:0] out_act0, out_act1;


reg [36-1:0] a_act_reg0, a_act_reg1, b_act_reg0, b_act_reg1;
reg [36-1:0] a_weight_reg0, a_weight_reg1, b_weight_reg0, b_weight_reg1;

wire [72-1:0] init_ded_00;
wire [72-1:0] init_ded_10;

wire [72-1:0] init_ded_01;
wire [72-1:0] init_ded_11;

wire [72-1:0] out_00_in_10;
wire [72-1:0] out_10_in_11;

always @(posedge clk)
begin
	if (reset) begin
        a_act_reg0 <= 0;
        a_act_reg1 <= 0;
        b_act_reg0 <= 0;
        b_act_reg1 <= 0;
        a_weight_reg0 <= 0;
        a_weight_reg1 <= 0;
        b_weight_reg0 <= 0;
        b_weight_reg1 <= 0;
	end
	else begin
        a_act_reg0 <= a_act0 + a_weight0;
        a_act_reg1 <= a_act1;
        b_act_reg0 <= b_act0;
        b_act_reg1 <= b_act1;
        a_weight_reg0 <= a_weight0;
        a_weight_reg1 <= a_weight1;
        b_weight_reg0 <= b_weight0;
        b_weight_reg1 <= b_weight1;
	end
end


hard_model_initial u_hard_model_init_00 (.clk(clk), .reset(reset), .a(a_act_reg0), .b(b_act_reg0), .out(), .out_ded(init_ded_00));

hard_model_rest u_hard_model_00 (.clk(clk), .reset(reset), .a(a_weight_reg0), .b(b_weight_reg0), .ab_ded(init_ded_00), .out(out_00_in_10), .out_ded(init_ded_10));

hard_model_rest u_hard_model_10 (.clk(clk), .reset(reset), .a(a_weight_reg1), .b(b_weight_reg1), .ab_ded(init_ded_10), .out(out_act0), .out_ded());


hard_model_initial u_hard_model_init_01 (.clk(clk), .reset(reset), .a(a_act_reg1), .b(b_act_reg1), .out(), .out_ded(init_ded_01));

hard_model_rest u_hard_model_01 (.clk(clk), .reset(reset), .a(out_00_in_10[35:0]), .b(out_00_in_10[71:36]), .ab_ded(init_ded_01), .out(), .out_ded(init_ded_11));

hard_model_rest u_hard_model_11 (.clk(clk), .reset(reset), .a(), .b(), .ab_ded(init_ded_11), .out(out_act1), .out_ded());

endmodule