
`define DWIDTH 8
`define ACCWIDTH 32
`define MAC_PIPE_STAGES 3
`define DENSE 0
`define SPARSE_2_4 1
`define SPARSE_1_4 2
`define SPARSE_1_3 3
`define K 64
`define U 8
`define V 8
`define A_cnt_width 9
`define B_cnt_width 9
`define C_cnt_width 8
`define U_bits 3
`define V_bits 3
 
module sparse_dense_gemm(
    clk,
    reset,
    enable,
    sparsity_level,
    cout_data);
    
input clk, reset, enable;
input [1:0] sparsity_level;
output [35:0] cout_data;

// Ay wires
wire [40-1:0] A0_data;
wire [40-1:0] A1_data;
wire [40-1:0] A2_data;


// Bx wires
wire [128-1:0] B0_data;
wire [128-1:0] B1_data;
wire [128-1:0] B2_data;


// valid_out_x_y signals
wire valid_out0_0;
wire valid_out0_1;
wire valid_out0_2;
wire valid_out1_0;
wire valid_out1_1;
wire valid_out1_2;
wire valid_out2_0;
wire valid_out2_1;
wire valid_out2_2;


// Cx_y signals
wire [128-1:0] C0_0_data;
wire [128-1:0] C0_1_data;
wire [128-1:0] C0_2_data;
wire [128-1:0] C1_0_data;
wire [128-1:0] C1_1_data;
wire [128-1:0] C1_2_data;
wire [128-1:0] C2_0_data;
wire [128-1:0] C2_1_data;
wire [128-1:0] C2_2_data;


wire [128-1:0] C0_0_data_out_mem;
wire [128-1:0] C0_1_data_out_mem;
wire [128-1:0] C0_2_data_out_mem;
wire [128-1:0] C1_0_data_out_mem;
wire [128-1:0] C1_1_data_out_mem;
wire [128-1:0] C1_2_data_out_mem;
wire [128-1:0] C2_0_data_out_mem;
wire [128-1:0] C2_1_data_out_mem;
wire [128-1:0] C2_2_data_out_mem;


// horizontal connections
wire [40-1:0] A_out0_0_in1_0;
wire [40-1:0] A_out1_0_in2_0;
wire [40-1:0] A_out0_1_in1_1;
wire [40-1:0] A_out1_1_in2_1;
wire [40-1:0] A_out0_2_in1_2;
wire [40-1:0] A_out1_2_in2_2;


// vertical connections
wire [128-1:0] B_out0_0_in0_1;
wire [128-1:0] B_out0_1_in0_2;
wire [128-1:0] B_out1_0_in1_1;
wire [128-1:0] B_out1_1_in1_2;
wire [128-1:0] B_out2_0_in2_1;
wire [128-1:0] B_out2_1_in2_2;


// accumulate signal for tiling (generated from control logic)
wire acc_in;


// accumulate_out connections
wire accumulate_out0_0;
wire accumulate_out0_1;
wire accumulate_out1_0;
wire accumulate_out1_1;
wire accumulate_out2_0;
wire accumulate_out2_1;


// Ay
A0_input_mem_control_logic #(.mwidth(40), .addr_width(`A_cnt_width), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 A0 (.clk(clk), .reset(reset), .enable(enable), .sparsity_level(sparsity_level), .data_out(A0_data), .accumulate_out(acc_in));

Ay_input_mem_control_logic #(.mwidth(40), .addr_width(`A_cnt_width), .start_cnt_bits(2), .start_val(3), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 A1 (.clk(clk), .reset(reset), .enable(enable), .sparsity_level(sparsity_level), .data_out(A1_data));

Ay_input_mem_control_logic #(.mwidth(40), .addr_width(`A_cnt_width), .start_cnt_bits(3), .start_val(7), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 A2 (.clk(clk), .reset(reset), .enable(enable), .sparsity_level(sparsity_level), .data_out(A2_data));

// Bx
B0_input_mem_control_logic #(.mwidth(32), .addr_width(`B_cnt_width), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 B0 (.clk(clk), .reset(reset), .enable(enable), .sparsity_level(sparsity_level),
					 .data_out_0(B0_data[31:0]), .data_out_1(B0_data[63:32]), .data_out_2(B0_data[95:64]), .data_out_3(B0_data[127:96]));

Bx_input_mem_control_logic #(.mwidth(32), .addr_width(`B_cnt_width), .start_cnt_bits(2), .start_val(3), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 B1 (.clk(clk), .reset(reset), .enable(enable), .sparsity_level(sparsity_level),
					 .data_out_0(B1_data[31:0]), .data_out_1(B1_data[63:32]), .data_out_2(B1_data[95:64]), .data_out_3(B1_data[127:96]));

Bx_input_mem_control_logic #(.mwidth(32), .addr_width(`B_cnt_width), .start_cnt_bits(3), .start_val(7), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 B2 (.clk(clk), .reset(reset), .enable(enable), .sparsity_level(sparsity_level),
					 .data_out_0(B2_data[31:0]), .data_out_1(B2_data[63:32]), .data_out_2(B2_data[95:64]), .data_out_3(B2_data[127:96]));


// TS_xy
SA_4x4 TS_0_0 (.clk(clk), .reset(reset), .a_data(A0_data), .b_data(B0_data),
				 .a_data_out(A_out0_0_in1_0), .b_data_out(B_out0_0_in0_1), .c_data(C0_0_data),
				 .K_size(`K), .enable(enable), .accumulate(acc_in), .sparsity_level(sparsity_level), .x_loc(0), .y_loc(0),
				 .accumulate_out(accumulate_out0_0), .valid_out(valid_out0_0));

SA_4x4 TS_0_1 (.clk(clk), .reset(reset), .a_data(A1_data), .b_data(B_out0_0_in0_1),
				 .a_data_out(A_out0_1_in1_1), .b_data_out(B_out0_1_in0_2), .c_data(C0_1_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out0_0), .sparsity_level(sparsity_level), .x_loc(0), .y_loc(1),
				 .accumulate_out(accumulate_out0_1), .valid_out(valid_out0_1));

SA_4x4 TS_0_2 (.clk(clk), .reset(reset), .a_data(A2_data), .b_data(B_out0_1_in0_2),
				 .a_data_out(A_out0_2_in1_2), .b_data_out(), .c_data(C0_2_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out0_1), .sparsity_level(sparsity_level), .x_loc(0), .y_loc(2),
				 .accumulate_out(), .valid_out(valid_out0_2));

SA_4x4 TS_1_0 (.clk(clk), .reset(reset), .a_data(A_out0_0_in1_0), .b_data(B1_data),
				 .a_data_out(A_out1_0_in2_0), .b_data_out(B_out1_0_in1_1), .c_data(C1_0_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out0_0), .sparsity_level(sparsity_level), .x_loc(1), .y_loc(0),
				 .accumulate_out(accumulate_out1_0), .valid_out(valid_out1_0));

SA_4x4 TS_1_1 (.clk(clk), .reset(reset), .a_data(A_out0_1_in1_1), .b_data(B_out1_0_in1_1),
				 .a_data_out(A_out1_1_in2_1), .b_data_out(B_out1_1_in1_2), .c_data(C1_1_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out1_0), .sparsity_level(sparsity_level), .x_loc(1), .y_loc(1),
				 .accumulate_out(accumulate_out1_1), .valid_out(valid_out1_1));

SA_4x4 TS_1_2 (.clk(clk), .reset(reset), .a_data(A_out0_2_in1_2), .b_data(B_out1_1_in1_2),
				 .a_data_out(A_out1_2_in2_2), .b_data_out(), .c_data(C1_2_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out1_1), .sparsity_level(sparsity_level), .x_loc(1), .y_loc(2),
				 .accumulate_out(), .valid_out(valid_out1_2));

SA_4x4 TS_2_0 (.clk(clk), .reset(reset), .a_data(A_out1_0_in2_0), .b_data(B2_data),
				 .a_data_out(), .b_data_out(B_out2_0_in2_1), .c_data(C2_0_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out1_0), .sparsity_level(sparsity_level), .x_loc(2), .y_loc(0),
				 .accumulate_out(accumulate_out2_0), .valid_out(valid_out2_0));

SA_4x4 TS_2_1 (.clk(clk), .reset(reset), .a_data(A_out1_1_in2_1), .b_data(B_out2_0_in2_1),
				 .a_data_out(), .b_data_out(B_out2_1_in2_2), .c_data(C2_1_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out2_0), .sparsity_level(sparsity_level), .x_loc(2), .y_loc(1),
				 .accumulate_out(accumulate_out2_1), .valid_out(valid_out2_1));

SA_4x4 TS_2_2 (.clk(clk), .reset(reset), .a_data(A_out1_2_in2_2), .b_data(B_out2_1_in2_2),
				 .a_data_out(), .b_data_out(), .c_data(C2_2_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out2_1), .sparsity_level(sparsity_level), .x_loc(2), .y_loc(2),
				 .accumulate_out(), .valid_out(valid_out2_2));


// Cxy
output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C0_0 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out0_0),
						 .data_in_0(C0_0_data[31:0]), .data_in_1(C0_0_data[63:32]), .data_in_2(C0_0_data[95:64]), .data_in_3(C0_0_data[127:96]),
						 .data_out_0(C0_0_data_out_mem[31:0]), .data_out_1(C0_0_data_out_mem[63:32]), .data_out_2(C0_0_data_out_mem[95:64]), .data_out_3(C0_0_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C0_1 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out0_1),
						 .data_in_0(C0_1_data[31:0]), .data_in_1(C0_1_data[63:32]), .data_in_2(C0_1_data[95:64]), .data_in_3(C0_1_data[127:96]),
						 .data_out_0(C0_1_data_out_mem[31:0]), .data_out_1(C0_1_data_out_mem[63:32]), .data_out_2(C0_1_data_out_mem[95:64]), .data_out_3(C0_1_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C0_2 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out0_2),
						 .data_in_0(C0_2_data[31:0]), .data_in_1(C0_2_data[63:32]), .data_in_2(C0_2_data[95:64]), .data_in_3(C0_2_data[127:96]),
						 .data_out_0(C0_2_data_out_mem[31:0]), .data_out_1(C0_2_data_out_mem[63:32]), .data_out_2(C0_2_data_out_mem[95:64]), .data_out_3(C0_2_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C1_0 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out1_0),
						 .data_in_0(C1_0_data[31:0]), .data_in_1(C1_0_data[63:32]), .data_in_2(C1_0_data[95:64]), .data_in_3(C1_0_data[127:96]),
						 .data_out_0(C1_0_data_out_mem[31:0]), .data_out_1(C1_0_data_out_mem[63:32]), .data_out_2(C1_0_data_out_mem[95:64]), .data_out_3(C1_0_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C1_1 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out1_1),
						 .data_in_0(C1_1_data[31:0]), .data_in_1(C1_1_data[63:32]), .data_in_2(C1_1_data[95:64]), .data_in_3(C1_1_data[127:96]),
						 .data_out_0(C1_1_data_out_mem[31:0]), .data_out_1(C1_1_data_out_mem[63:32]), .data_out_2(C1_1_data_out_mem[95:64]), .data_out_3(C1_1_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C1_2 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out1_2),
						 .data_in_0(C1_2_data[31:0]), .data_in_1(C1_2_data[63:32]), .data_in_2(C1_2_data[95:64]), .data_in_3(C1_2_data[127:96]),
						 .data_out_0(C1_2_data_out_mem[31:0]), .data_out_1(C1_2_data_out_mem[63:32]), .data_out_2(C1_2_data_out_mem[95:64]), .data_out_3(C1_2_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C2_0 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out2_0),
						 .data_in_0(C2_0_data[31:0]), .data_in_1(C2_0_data[63:32]), .data_in_2(C2_0_data[95:64]), .data_in_3(C2_0_data[127:96]),
						 .data_out_0(C2_0_data_out_mem[31:0]), .data_out_1(C2_0_data_out_mem[63:32]), .data_out_2(C2_0_data_out_mem[95:64]), .data_out_3(C2_0_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C2_1 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out2_1),
						 .data_in_0(C2_1_data[31:0]), .data_in_1(C2_1_data[63:32]), .data_in_2(C2_1_data[95:64]), .data_in_3(C2_1_data[127:96]),
						 .data_out_0(C2_1_data_out_mem[31:0]), .data_out_1(C2_1_data_out_mem[63:32]), .data_out_2(C2_1_data_out_mem[95:64]), .data_out_3(C2_1_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C2_2 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out2_2),
						 .data_in_0(C2_2_data[31:0]), .data_in_1(C2_2_data[63:32]), .data_in_2(C2_2_data[95:64]), .data_in_3(C2_2_data[127:96]),
						 .data_out_0(C2_2_data_out_mem[31:0]), .data_out_1(C2_2_data_out_mem[63:32]), .data_out_2(C2_2_data_out_mem[95:64]), .data_out_3(C2_2_data_out_mem[127:96]));

// perform reduction operation so Cxy memories don't get optimized out
assign cout_data[0] = &C0_0_data_out_mem[31:0];
assign cout_data[1] = &C0_0_data_out_mem[63:32];
assign cout_data[2] = &C0_0_data_out_mem[95:64];
assign cout_data[3] = &C0_0_data_out_mem[127:96];

assign cout_data[4] = &C0_1_data_out_mem[31:0];
assign cout_data[5] = &C0_1_data_out_mem[63:32];
assign cout_data[6] = &C0_1_data_out_mem[95:64];
assign cout_data[7] = &C0_1_data_out_mem[127:96];

assign cout_data[8] = &C0_2_data_out_mem[31:0];
assign cout_data[9] = &C0_2_data_out_mem[63:32];
assign cout_data[10] = &C0_2_data_out_mem[95:64];
assign cout_data[11] = &C0_2_data_out_mem[127:96];

assign cout_data[12] = &C1_0_data_out_mem[31:0];
assign cout_data[13] = &C1_0_data_out_mem[63:32];
assign cout_data[14] = &C1_0_data_out_mem[95:64];
assign cout_data[15] = &C1_0_data_out_mem[127:96];

assign cout_data[16] = &C1_1_data_out_mem[31:0];
assign cout_data[17] = &C1_1_data_out_mem[63:32];
assign cout_data[18] = &C1_1_data_out_mem[95:64];
assign cout_data[19] = &C1_1_data_out_mem[127:96];

assign cout_data[20] = &C1_2_data_out_mem[31:0];
assign cout_data[21] = &C1_2_data_out_mem[63:32];
assign cout_data[22] = &C1_2_data_out_mem[95:64];
assign cout_data[23] = &C1_2_data_out_mem[127:96];

assign cout_data[24] = &C2_0_data_out_mem[31:0];
assign cout_data[25] = &C2_0_data_out_mem[63:32];
assign cout_data[26] = &C2_0_data_out_mem[95:64];
assign cout_data[27] = &C2_0_data_out_mem[127:96];

assign cout_data[28] = &C2_1_data_out_mem[31:0];
assign cout_data[29] = &C2_1_data_out_mem[63:32];
assign cout_data[30] = &C2_1_data_out_mem[95:64];
assign cout_data[31] = &C2_1_data_out_mem[127:96];

assign cout_data[32] = &C2_2_data_out_mem[31:0];
assign cout_data[33] = &C2_2_data_out_mem[63:32];
assign cout_data[34] = &C2_2_data_out_mem[95:64];
assign cout_data[35] = &C2_2_data_out_mem[127:96];

endmodule




module SA_4x4(
	clk, 
	reset, 
	a_data,
	a_data_out,
	b_data,
	b_data_out,
	c_data, 
	enable,
	accumulate,
	K_size,
	sparsity_level,
	x_loc,
	y_loc,
	accumulate_out,
	valid_out);


//a0 = a_data[`DWIDTH-1:0], a1 = a_data[2*`DWIDTH-1:`DWIDTH]
//a2 = a_data[3*`DWIDTH-1:2*`DWIDTH], a3 = a_data[4*`DWIDTH-1:3*`DWIDTH]

//b0 = b_data[4*`DWIDTH-1:0], b1 = b_data[2*4*`DWIDTH-1:4*`DWIDTH]
//b2 = b_data[3*4*`DWIDTH-1:2*4*`DWIDTH], b3 = b_data[4*4*`DWIDTH-1:3*4*`DWIDTH]

// weight_index_0 = a_data[4*`DWIDTH + 1:4*`DWIDTH], weight_index_1 = a_data[4*`DWIDTH + 3:4*`DWIDTH + 2]
// weight_index_2 = a_data[4*`DWIDTH + 5:4*`DWIDTH + 4], weight_index_3 = a_data[4*`DWIDTH + 7:4*`DWIDTH + 6]

input clk, reset;
input [4*`DWIDTH + 4*2-1:0] a_data;
input [4*4*`DWIDTH-1:0] b_data;
output [4*`DWIDTH + 4*2-1:0] a_data_out;
output [4*4*`DWIDTH-1:0] b_data_out;
input [11:0] K_size;
input [1:0] sparsity_level;
input [4:0] x_loc, y_loc;
output reg [4*`ACCWIDTH-1:0] c_data;
input enable, accumulate;
output reg valid_out;
output accumulate_out;


// horizontal connections
wire [`DWIDTH-1:0] out_a00_in_a01;
wire [`DWIDTH-1:0] out_a01_in_a02;
wire [`DWIDTH-1:0] out_a02_in_a03;
wire [1:0] out_weight_ind_00_in_weight_ind_01;
wire [1:0] out_weight_ind_01_in_weight_ind_02;
wire [1:0] out_weight_ind_02_in_weight_ind_03;

wire [`DWIDTH-1:0] out_a10_in_a11;
wire [`DWIDTH-1:0] out_a11_in_a12;
wire [`DWIDTH-1:0] out_a12_in_a13;
wire [1:0] out_weight_ind_10_in_weight_ind_11;
wire [1:0] out_weight_ind_11_in_weight_ind_12;
wire [1:0] out_weight_ind_12_in_weight_ind_13;

wire [`DWIDTH-1:0] out_a20_in_a21;
wire [`DWIDTH-1:0] out_a21_in_a22;
wire [`DWIDTH-1:0] out_a22_in_a23;
wire [1:0] out_weight_ind_20_in_weight_ind_21;
wire [1:0] out_weight_ind_21_in_weight_ind_22;
wire [1:0] out_weight_ind_22_in_weight_ind_23;

wire [`DWIDTH-1:0] out_a30_in_a31;
wire [`DWIDTH-1:0] out_a31_in_a32;
wire [`DWIDTH-1:0] out_a32_in_a33;
wire [1:0] out_weight_ind_30_in_weight_ind_31;
wire [1:0] out_weight_ind_31_in_weight_ind_32;
wire [1:0] out_weight_ind_32_in_weight_ind_33;

// vertical connections
wire [4*`DWIDTH-1:0] out_b00_in_b10;
wire [4*`DWIDTH-1:0] out_b10_in_b20;
wire [4*`DWIDTH-1:0] out_b20_in_b30;

wire [4*`DWIDTH-1:0] out_b01_in_b11;
wire [4*`DWIDTH-1:0] out_b11_in_b21;
wire [4*`DWIDTH-1:0] out_b21_in_b31;

wire [4*`DWIDTH-1:0] out_b02_in_b12;
wire [4*`DWIDTH-1:0] out_b12_in_b22;
wire [4*`DWIDTH-1:0] out_b22_in_b32;

wire [4*`DWIDTH-1:0] out_b03_in_b13;
wire [4*`DWIDTH-1:0] out_b13_in_b23;
wire [4*`DWIDTH-1:0] out_b23_in_b33;



// accumulate signals for PEs (they propagate diagonally)
wire accumulate_1_00;
assign accumulate_1_00 = accumulate;
wire accumulate_2_01_10;
wire accumulate_3_02_20_11;
wire accumulate_4_03_30_21_12;
wire accumulate_5_13_31_22;
wire accumulate_6_23_32;
wire accumulate_7_33;

// accumulate_out signal is passed to the next tensor slices
assign accumulate_out = accumulate_5_13_31_22;


// input setup, each d denotes one cc delay
wire [`DWIDTH-1:0] a1_d, a2_d, a2_dd, a3_d, a3_dd, a3_ddd;
wire [1:0] weight_ind_1d, weight_ind_2d, weight_ind_2dd, weight_ind_3d, weight_ind_3dd, weight_ind_3ddd;
wire [4*`DWIDTH-1:0] b1_d, b2_d, b2_dd, b3_d, b3_dd, b3_ddd;

// assign wires for instantiation
wire [`DWIDTH-1:0] wire_a0, wire_a1, wire_a2, wire_a3;
wire [1:0] wire_weight_ind_0, wire_weight_ind_1, wire_weight_ind_2, wire_weight_ind_3;
wire [4*`DWIDTH-1:0] wire_b0, wire_b1, wire_b2, wire_b3;



// weight_index_0 = a_data[4*`DWIDTH + 1:4*`DWIDTH], weight_index_1 = a_data[4*`DWIDTH + 3:4*`DWIDTH + 2]
// weight_index_2 = a_data[4*`DWIDTH + 5:4*`DWIDTH + 4], weight_index_3 = a_data[4*`DWIDTH + 7:4*`DWIDTH + 6]

assign wire_a0 = a_data[`DWIDTH-1:0];
assign wire_weight_ind_0 = a_data[4*`DWIDTH + 1:4*`DWIDTH];
assign wire_b0 = b_data[4*`DWIDTH-1:0];

assign wire_a1 = (x_loc == 0) ? a1_d : a_data[2*`DWIDTH-1:`DWIDTH];
assign wire_weight_ind_1 = (x_loc == 0) ? weight_ind_1d : a_data[4*`DWIDTH + 3:4*`DWIDTH + 2];
assign wire_b1 = (y_loc == 0) ? b1_d : b_data[2*4*`DWIDTH-1:4*`DWIDTH];

assign wire_a2 = (x_loc == 0) ? a2_dd : a_data[3*`DWIDTH-1:2*`DWIDTH];
assign wire_weight_ind_2 = (x_loc == 0) ? weight_ind_2dd : a_data[4*`DWIDTH + 5:4*`DWIDTH + 4];
assign wire_b2 = (y_loc == 0) ? b2_dd : b_data[3*4*`DWIDTH-1:2*4*`DWIDTH];

assign wire_a3 = (x_loc == 0) ? a3_ddd : a_data[4*`DWIDTH-1:3*`DWIDTH];
assign wire_weight_ind_3 = (x_loc == 0) ? weight_ind_3ddd : a_data[4*`DWIDTH + 7:4*`DWIDTH + 6];
assign wire_b3 = (y_loc == 0) ? b3_ddd : b_data[4*4*`DWIDTH-1:3*4*`DWIDTH];



// output MAC wires
wire [`ACCWIDTH-1:0] out_mac_00,out_mac_01,out_mac_10,out_mac_02,out_mac_20,out_mac_11,
					 out_mac_03,out_mac_30,out_mac_21,out_mac_12,out_mac_13,out_mac_31,
					 out_mac_22,out_mac_23,out_mac_32,out_mac_33;


// 10 element output register to extract data without penalty on latency. 
// With this approach you can extract N^2 data over N cc (maximum possible with N^2 PEs)
// Then 10 element register increase area should be a good trade-off for latency,
// given also the fact that otherwise diagonal irregularity will make the next layer logic (typically in CLB) complex
reg [`ACCWIDTH-1:0] mac_out_reg [9:0];

// initial_counter => same bits are K_size
// for control_counter 5-bits are enough
reg [4:0] control_counter;
reg [11:0] initial_counter;

// used to control when tensor slice should start operation due to location (x_loc, y_loc)
// 9-bits are enough for 5-bits x_loc and y_loc (31+31)*8 = 496 < 2^9 - 1 = 511
reg [8:0] location_counter;

// enable tensor operation based on location
reg loc_tensor_load_en;

// register to hold if the SA is in steady state
reg steady_state;

// 1-bit counter to control the load_enable for B registers (load_enable_B_regs)
reg sparse_2_4_1bit_counter;

wire load_enable_B_regs;

// assign load enable to counter for simplicity of logic design (we want them in the same clock cycle)
assign load_enable_B_regs = ((sparsity_level == `DENSE) || (sparsity_level == `SPARSE_1_4)) ? 1'b1 : sparse_2_4_1bit_counter;

// calculate the effective K_size depending on sparsity level
reg [11:0] effective_K_size;


// selects second register for 2:4 sparse operation
wire second_reg_select_sparse_2_4;

assign second_reg_select_sparse_2_4 = (sparsity_level == `SPARSE_2_4);


always @(*)
begin
	if (sparsity_level == `DENSE) begin
		effective_K_size = K_size;
	end	
	else if (sparsity_level == `SPARSE_2_4) begin
		effective_K_size = K_size >> 1;
	end
	else if (sparsity_level == `SPARSE_1_4) begin
		effective_K_size = K_size >> 2;
	end
	else begin
		effective_K_size = K_size;
	end	
end	

// enable based on location logic
always @(*)
begin
	if (reset) begin
		loc_tensor_load_en = 0;
	end	
	else if ((x_loc + y_loc) == 0) begin
		loc_tensor_load_en = 1;
	end	
	else begin
		if (sparsity_level == `SPARSE_2_4) begin
			if (location_counter == (((x_loc + y_loc)<<3))) begin
				loc_tensor_load_en = 1;
			end
			else begin
				loc_tensor_load_en = 0;
			end
		end
		else begin
			if (location_counter == (((x_loc + y_loc)<<2))) begin
				loc_tensor_load_en = 1;
			end
			else begin
				loc_tensor_load_en = 0;
			end
		end
	end
end	

// SA control logic
always @(posedge clk)
begin
	if (reset) begin
		control_counter <= 0;
		initial_counter <= 0;
		valid_out <= 0;
		steady_state <= 0;
		location_counter <= 0;
		sparse_2_4_1bit_counter <= 0;

	end else begin
		
		if (enable) begin

			if (sparsity_level == `SPARSE_2_4) begin
				if (location_counter < (((x_loc + y_loc)<<3))) begin
					location_counter <= location_counter + 1;
				end
			end
			else begin
				if (location_counter < (((x_loc + y_loc)<<2))) begin
					location_counter <= location_counter + 1;
				end
			end	

			// start tensor operation only when it should based on location (x_loc, y_loc)
			if (loc_tensor_load_en == 1) begin

				if (sparsity_level == `SPARSE_2_4) begin
					sparse_2_4_1bit_counter <= sparse_2_4_1bit_counter + 1;
				end
				else begin
					sparse_2_4_1bit_counter <= 0;
				end


				if (initial_counter < (effective_K_size - 1)) begin
					initial_counter <= initial_counter + 1;
				end	

				else if (initial_counter == (effective_K_size - 1)) begin
					control_counter <= 1;
					steady_state <= 1;
					initial_counter <= 0;
				end
			

				if (steady_state == 1) begin	// steady state

					if (control_counter == (2 + `MAC_PIPE_STAGES) && (sparsity_level != `SPARSE_2_4)) begin
						valid_out <= 1;
						control_counter <= control_counter + 1;
					end
					else if (control_counter == (6 + `MAC_PIPE_STAGES) && (sparsity_level != `SPARSE_2_4)) begin
						valid_out <= 0;

						// this may happen when there is overlap between the initial counter and the control counter
						// assures correct operation of SA
						if (initial_counter == (effective_K_size - 1)) begin
							control_counter <= 1;
							steady_state <= 1;
							initial_counter <= 0;
						end
						else begin
							control_counter <= 0;
							steady_state <= 0;
						end	
					end
					else if (control_counter == (12 + `MAC_PIPE_STAGES) && (sparsity_level == `SPARSE_2_4)) begin
						valid_out <= 0;

						// this may happen when there is overlap between the initial counter and the control counter
						// assures correct operation of SA
						if (initial_counter == (effective_K_size - 1)) begin
							control_counter <= 1;
							steady_state <= 1;
							initial_counter <= 0;
						end
						else begin
							control_counter <= 0;
							steady_state <= 0;
						end	
					end
					else if (control_counter >= (5 + `MAC_PIPE_STAGES) && (sparsity_level == `SPARSE_2_4)) begin
						valid_out <= sparse_2_4_1bit_counter;
						control_counter <= control_counter + 1;
					end
					else if (control_counter != 0) begin
						control_counter <= control_counter + 1;
					end


				end
			end
		end
		
		else begin
			if (valid_out == 1) begin
				valid_out <= 0;
			end	
		end	
	end
end




// output extraction sequential logic for no latency degradation
// data are assigned to the mac out register in a circular manner
always @(posedge clk)
begin
	if (reset) begin

        mac_out_reg[0] <= 0;
        mac_out_reg[1] <= 0;
        mac_out_reg[2] <= 0;
        mac_out_reg[3] <= 0;
        mac_out_reg[4] <= 0;
        mac_out_reg[5] <= 0;
        mac_out_reg[6] <= 0;
        mac_out_reg[7] <= 0;
        mac_out_reg[8] <= 0;
        mac_out_reg[9] <= 0;
		
	end
	else begin
		if (enable) begin

			if (sparsity_level != `SPARSE_2_4) begin
				if (control_counter == `MAC_PIPE_STAGES) begin
					mac_out_reg[0] <= out_mac_00;
				end
				else if (control_counter == (1 + `MAC_PIPE_STAGES)) begin
					mac_out_reg[1] <= out_mac_01;
					mac_out_reg[2] <= out_mac_10;
				end
				else if (control_counter == (2 + `MAC_PIPE_STAGES)) begin
					mac_out_reg[3] <= out_mac_02;
					mac_out_reg[4] <= out_mac_11;
					mac_out_reg[5] <= out_mac_20;
				end
				else if (control_counter == (3 + `MAC_PIPE_STAGES)) begin
					mac_out_reg[6] <= out_mac_03;
					mac_out_reg[7] <= out_mac_12;
					mac_out_reg[8] <= out_mac_21;
					mac_out_reg[9] <= out_mac_30;
				end
				else if (control_counter == (4 + `MAC_PIPE_STAGES)) begin
					mac_out_reg[0] <= out_mac_13;
					mac_out_reg[1] <= out_mac_22;
					mac_out_reg[2] <= out_mac_31;
				end
				else if (control_counter == (5 + `MAC_PIPE_STAGES)) begin
					mac_out_reg[3] <= out_mac_23;
					mac_out_reg[4] <= out_mac_32;
				end
			end
			// sparsity is 2:4
			else begin
				if (control_counter == (`MAC_PIPE_STAGES)) begin
					mac_out_reg[0] <= out_mac_00;
				end
				else if (control_counter == (2 + `MAC_PIPE_STAGES)) begin
					mac_out_reg[1] <= out_mac_01;
					mac_out_reg[2] <= out_mac_10;
				end
				else if (control_counter == (4 + `MAC_PIPE_STAGES)) begin
					mac_out_reg[3] <= out_mac_02;
					mac_out_reg[4] <= out_mac_11;
					mac_out_reg[5] <= out_mac_20;
				end
				else if (control_counter == (6 + `MAC_PIPE_STAGES)) begin
					mac_out_reg[6] <= out_mac_03;
					mac_out_reg[7] <= out_mac_12;
					mac_out_reg[8] <= out_mac_21;
					mac_out_reg[9] <= out_mac_30;
				end
				else if (control_counter == (8 + `MAC_PIPE_STAGES)) begin
					mac_out_reg[0] <= out_mac_13;
					mac_out_reg[1] <= out_mac_22;
					mac_out_reg[2] <= out_mac_31;
				end
				else if (control_counter == (10 + `MAC_PIPE_STAGES)) begin
					mac_out_reg[3] <= out_mac_23;
					mac_out_reg[4] <= out_mac_32;
				end
			end		
		end	
	end	
end	


// weight_index_0 = a_data[4*`DWIDTH + 1:4*`DWIDTH], weight_index_1 = a_data[4*`DWIDTH + 3:4*`DWIDTH + 2]
// weight_index_2 = a_data[4*`DWIDTH + 5:4*`DWIDTH + 4], weight_index_3 = a_data[4*`DWIDTH + 7:4*`DWIDTH + 6]

// input logic FFs instantiation
double_registers_sparse_2_4 #(.reg_width(`DWIDTH)) two_regs_a1_d (.clk(clk), .reset(reset), .IN(a_data[2*`DWIDTH-1:`DWIDTH]), .OUT(a1_d), .select_signal(second_reg_select_sparse_2_4), .enable(enable & loc_tensor_load_en));
double_registers_sparse_2_4 #(.reg_width(`DWIDTH)) two_regs_a2_d (.clk(clk), .reset(reset), .IN(a_data[3*`DWIDTH-1:2*`DWIDTH]), .OUT(a2_d), .select_signal(second_reg_select_sparse_2_4), .enable(enable & loc_tensor_load_en));
double_registers_sparse_2_4 #(.reg_width(`DWIDTH)) two_regs_a3_d (.clk(clk), .reset(reset), .IN(a_data[4*`DWIDTH-1:3*`DWIDTH]), .OUT(a3_d), .select_signal(second_reg_select_sparse_2_4), .enable(enable & loc_tensor_load_en));
double_registers_sparse_2_4 #(.reg_width(2)) two_regs_weight_ind_1d (.clk(clk), .reset(reset), .IN(a_data[4*`DWIDTH + 3:4*`DWIDTH + 2]), .OUT(weight_ind_1d), .select_signal(second_reg_select_sparse_2_4), .enable(enable & loc_tensor_load_en));
double_registers_sparse_2_4 #(.reg_width(2)) two_regs_weight_ind_2d (.clk(clk), .reset(reset), .IN(a_data[4*`DWIDTH + 5:4*`DWIDTH + 4]), .OUT(weight_ind_2d), .select_signal(second_reg_select_sparse_2_4), .enable(enable & loc_tensor_load_en));
double_registers_sparse_2_4 #(.reg_width(2)) two_regs_weight_ind_3d (.clk(clk), .reset(reset), .IN(a_data[4*`DWIDTH + 7:4*`DWIDTH + 6]), .OUT(weight_ind_3d), .select_signal(second_reg_select_sparse_2_4), .enable(enable & loc_tensor_load_en));


// FF_enable #(.FF_width(`DWIDTH)) FF_a1_d (.clk(clk), .reset(reset), .data_in(a_demux_triagonal[2*`DWIDTH-1:`DWIDTH]), .data_out(a1_d), .enable(enable & loc_tensor_load_en));
// FF_enable #(.FF_width(`DWIDTH)) FF_a2_d (.clk(clk), .reset(reset), .data_in(a_demux_triagonal[3*`DWIDTH-1:2*`DWIDTH]), .data_out(a2_d), .enable(enable & loc_tensor_load_en));
// FF_enable #(.FF_width(`DWIDTH)) FF_a3_d (.clk(clk), .reset(reset), .data_in(a_demux_triagonal[4*`DWIDTH-1:3*`DWIDTH]), .data_out(a3_d), .enable(enable & loc_tensor_load_en));
// FF_enable #(.FF_width(2)) FF_weight_ind_1d (.clk(clk), .reset(reset), .data_in(weight_ind_demux_triagonal[3:2]), .data_out(weight_ind_1d), .enable(enable & loc_tensor_load_en));
// FF_enable #(.FF_width(2)) FF_weight_ind_2d (.clk(clk), .reset(reset), .data_in(weight_ind_demux_triagonal[5:4]), .data_out(weight_ind_2d), .enable(enable & loc_tensor_load_en));
// FF_enable #(.FF_width(2)) FF_weight_ind_3d (.clk(clk), .reset(reset), .data_in(weight_ind_demux_triagonal[7:6]), .data_out(weight_ind_3d), .enable(enable & loc_tensor_load_en));


FF_enable #(.FF_width(4*`DWIDTH)) FF_b1_d (.clk(clk), .reset(reset), .data_in(b_data[2*4*`DWIDTH-1:4*`DWIDTH]), .data_out(b1_d), .enable(enable & loc_tensor_load_en & load_enable_B_regs));
FF_enable #(.FF_width(4*`DWIDTH)) FF_b2_d (.clk(clk), .reset(reset), .data_in(b_data[3*4*`DWIDTH-1:2*4*`DWIDTH]), .data_out(b2_d), .enable(enable & loc_tensor_load_en & load_enable_B_regs));
FF_enable #(.FF_width(4*`DWIDTH)) FF_b3_d (.clk(clk), .reset(reset), .data_in(b_data[4*4*`DWIDTH-1:3*4*`DWIDTH]), .data_out(b3_d), .enable(enable & loc_tensor_load_en & load_enable_B_regs));


double_registers_sparse_2_4 #(.reg_width(`DWIDTH)) two_regs_a2_dd (.clk(clk), .reset(reset), .IN(a2_d), .OUT(a2_dd), .select_signal(second_reg_select_sparse_2_4), .enable(enable & loc_tensor_load_en));
double_registers_sparse_2_4 #(.reg_width(`DWIDTH)) two_regs_a3_dd (.clk(clk), .reset(reset), .IN(a3_d), .OUT(a3_dd), .select_signal(second_reg_select_sparse_2_4), .enable(enable & loc_tensor_load_en));
double_registers_sparse_2_4 #(.reg_width(2)) two_regs_weight_ind_2dd (.clk(clk), .reset(reset), .IN(weight_ind_2d), .OUT(weight_ind_2dd), .select_signal(second_reg_select_sparse_2_4), .enable(enable & loc_tensor_load_en));
double_registers_sparse_2_4 #(.reg_width(2)) two_regs_weight_ind_3dd (.clk(clk), .reset(reset), .IN(weight_ind_3d), .OUT(weight_ind_3dd), .select_signal(second_reg_select_sparse_2_4), .enable(enable & loc_tensor_load_en));


// FF_enable #(.FF_width(`DWIDTH)) FF_a2_dd (.clk(clk), .reset(reset), .data_in(a2_d), .data_out(a2_dd), .enable(enable & loc_tensor_load_en));
// FF_enable #(.FF_width(`DWIDTH)) FF_a3_dd (.clk(clk), .reset(reset), .data_in(a3_d), .data_out(a3_dd), .enable(enable & loc_tensor_load_en));
// FF_enable #(.FF_width(2)) FF_weight_ind_2dd (.clk(clk), .reset(reset), .data_in(weight_ind_2d), .data_out(weight_ind_2dd), .enable(enable & loc_tensor_load_en));
// FF_enable #(.FF_width(2)) FF_weight_ind_3dd (.clk(clk), .reset(reset), .data_in(weight_ind_3d), .data_out(weight_ind_3dd), .enable(enable & loc_tensor_load_en));

FF_enable #(.FF_width(4*`DWIDTH)) FF_b2_dd (.clk(clk), .reset(reset), .data_in(b2_d), .data_out(b2_dd), .enable(enable & loc_tensor_load_en & load_enable_B_regs));
FF_enable #(.FF_width(4*`DWIDTH)) FF_b3_dd (.clk(clk), .reset(reset), .data_in(b3_d), .data_out(b3_dd), .enable(enable & loc_tensor_load_en & load_enable_B_regs));


double_registers_sparse_2_4 #(.reg_width(`DWIDTH)) two_regs_a3_ddd (.clk(clk), .reset(reset), .IN(a3_dd), .OUT(a3_ddd), .select_signal(second_reg_select_sparse_2_4), .enable(enable & loc_tensor_load_en));
double_registers_sparse_2_4 #(.reg_width(2)) two_regs_weight_ind_3ddd (.clk(clk), .reset(reset), .IN(weight_ind_3dd), .OUT(weight_ind_3ddd), .select_signal(second_reg_select_sparse_2_4), .enable(enable & loc_tensor_load_en));

// FF_enable #(.FF_width(`DWIDTH)) FF_a3_ddd (.clk(clk), .reset(reset), .data_in(a3_dd), .data_out(a3_ddd), .enable(enable & loc_tensor_load_en));
// FF_enable #(.FF_width(2)) FF_weight_ind_3ddd (.clk(clk), .reset(reset), .data_in(weight_ind_3dd), .data_out(weight_ind_3ddd), .enable(enable & loc_tensor_load_en));

FF_enable #(.FF_width(4*`DWIDTH)) FF_b3_ddd (.clk(clk), .reset(reset), .data_in(b3_dd), .data_out(b3_ddd), .enable(enable & loc_tensor_load_en & load_enable_B_regs));


// weight_index_0 = a_data[4*`DWIDTH + 1:4*`DWIDTH], weight_index_1 = a_data[4*`DWIDTH + 3:4*`DWIDTH + 2]
// weight_index_2 = a_data[4*`DWIDTH + 5:4*`DWIDTH + 4], weight_index_3 = a_data[4*`DWIDTH + 7:4*`DWIDTH + 6]

// PEs instantiation
PE PE_00(.clk(clk), .reset(reset), .accumulate(accumulate_1_00), .accumulate_out(accumulate_2_01_10), .IN_A(wire_a0), .IN_B(wire_b0), .weight_index(wire_weight_ind_0), .weight_index_out(out_weight_ind_00_in_weight_ind_01), .OUT_A(out_a00_in_a01), .OUT_B(out_b00_in_b10), .OUT_MAC(out_mac_00), .enable(enable & loc_tensor_load_en), .enable_B_regs(load_enable_B_regs), .sparse_2_4_select(second_reg_select_sparse_2_4));

PE PE_01(.clk(clk), .reset(reset), .accumulate(accumulate_2_01_10), .accumulate_out(accumulate_3_02_20_11), .IN_A(out_a00_in_a01), .IN_B(wire_b1), .weight_index(out_weight_ind_00_in_weight_ind_01), .weight_index_out(out_weight_ind_01_in_weight_ind_02), .OUT_A(out_a01_in_a02), .OUT_B(out_b01_in_b11), .OUT_MAC(out_mac_01), .enable(enable & loc_tensor_load_en), .enable_B_regs(load_enable_B_regs), .sparse_2_4_select(second_reg_select_sparse_2_4));
PE PE_10(.clk(clk), .reset(reset), .accumulate(accumulate_2_01_10), .accumulate_out(accumulate_3_02_20_11), .IN_A(wire_a1), .IN_B(out_b00_in_b10), .weight_index(wire_weight_ind_1), .weight_index_out(out_weight_ind_10_in_weight_ind_11), .OUT_A(out_a10_in_a11), .OUT_B(out_b10_in_b20), .OUT_MAC(out_mac_10), .enable(enable & loc_tensor_load_en), .enable_B_regs(load_enable_B_regs), .sparse_2_4_select(second_reg_select_sparse_2_4));

PE PE_02(.clk(clk), .reset(reset), .accumulate(accumulate_3_02_20_11), .accumulate_out(accumulate_4_03_30_21_12), .IN_A(out_a01_in_a02), .IN_B(wire_b2), .weight_index(out_weight_ind_01_in_weight_ind_02), .weight_index_out(out_weight_ind_02_in_weight_ind_03), .OUT_A(out_a02_in_a03), .OUT_B(out_b02_in_b12), .OUT_MAC(out_mac_02), .enable(enable & loc_tensor_load_en), .enable_B_regs(load_enable_B_regs), .sparse_2_4_select(second_reg_select_sparse_2_4));
PE PE_20(.clk(clk), .reset(reset), .accumulate(accumulate_3_02_20_11), .accumulate_out(accumulate_4_03_30_21_12), .IN_A(wire_a2), .IN_B(out_b10_in_b20), .weight_index(wire_weight_ind_2), .weight_index_out(out_weight_ind_20_in_weight_ind_21), .OUT_A(out_a20_in_a21), .OUT_B(out_b20_in_b30), .OUT_MAC(out_mac_20), .enable(enable & loc_tensor_load_en), .enable_B_regs(load_enable_B_regs), .sparse_2_4_select(second_reg_select_sparse_2_4));
PE PE_11(.clk(clk), .reset(reset), .accumulate(accumulate_3_02_20_11), .accumulate_out(accumulate_4_03_30_21_12), .IN_A(out_a10_in_a11), .IN_B(out_b01_in_b11), .weight_index(out_weight_ind_10_in_weight_ind_11), .weight_index_out(out_weight_ind_11_in_weight_ind_12), .OUT_A(out_a11_in_a12), .OUT_B(out_b11_in_b21), .OUT_MAC(out_mac_11), .enable(enable & loc_tensor_load_en), .enable_B_regs(load_enable_B_regs), .sparse_2_4_select(second_reg_select_sparse_2_4));

PE PE_03(.clk(clk), .reset(reset), .accumulate(accumulate_4_03_30_21_12), .accumulate_out(accumulate_5_13_31_22), .IN_A(out_a02_in_a03), .IN_B(wire_b3), .weight_index(out_weight_ind_02_in_weight_ind_03), .weight_index_out(a_data_out[4*`DWIDTH + 1:4*`DWIDTH]), .OUT_A(a_data_out[`DWIDTH-1:0]), .OUT_B(out_b03_in_b13), .OUT_MAC(out_mac_03), .enable(enable & loc_tensor_load_en), .enable_B_regs(load_enable_B_regs), .sparse_2_4_select(second_reg_select_sparse_2_4));
PE PE_30(.clk(clk), .reset(reset), .accumulate(accumulate_4_03_30_21_12), .accumulate_out(accumulate_5_13_31_22), .IN_A(wire_a3), .IN_B(out_b20_in_b30), .weight_index(wire_weight_ind_3), .weight_index_out(out_weight_ind_30_in_weight_ind_31), .OUT_A(out_a30_in_a31), .OUT_B(b_data_out[4*`DWIDTH-1:0]), .OUT_MAC(out_mac_30), .enable(enable & loc_tensor_load_en), .enable_B_regs(load_enable_B_regs), .sparse_2_4_select(second_reg_select_sparse_2_4));
PE PE_21(.clk(clk), .reset(reset), .accumulate(accumulate_4_03_30_21_12), .accumulate_out(accumulate_5_13_31_22), .IN_A(out_a20_in_a21), .IN_B(out_b11_in_b21), .weight_index(out_weight_ind_20_in_weight_ind_21), .weight_index_out(out_weight_ind_21_in_weight_ind_22), .OUT_A(out_a21_in_a22), .OUT_B(out_b21_in_b31), .OUT_MAC(out_mac_21), .enable(enable & loc_tensor_load_en), .enable_B_regs(load_enable_B_regs), .sparse_2_4_select(second_reg_select_sparse_2_4));
PE PE_12(.clk(clk), .reset(reset), .accumulate(accumulate_4_03_30_21_12), .accumulate_out(accumulate_5_13_31_22), .IN_A(out_a11_in_a12), .IN_B(out_b02_in_b12), .weight_index(out_weight_ind_11_in_weight_ind_12), .weight_index_out(out_weight_ind_12_in_weight_ind_13), .OUT_A(out_a12_in_a13), .OUT_B(out_b12_in_b22), .OUT_MAC(out_mac_12), .enable(enable & loc_tensor_load_en), .enable_B_regs(load_enable_B_regs), .sparse_2_4_select(second_reg_select_sparse_2_4));

PE PE_13(.clk(clk), .reset(reset), .accumulate(accumulate_5_13_31_22), .accumulate_out(accumulate_6_23_32), .IN_A(out_a12_in_a13), .IN_B(out_b03_in_b13), .weight_index(out_weight_ind_12_in_weight_ind_13), .weight_index_out(a_data_out[4*`DWIDTH + 3:4*`DWIDTH + 2]), .OUT_A(a_data_out[2*`DWIDTH-1:`DWIDTH]), .OUT_B(out_b13_in_b23), .OUT_MAC(out_mac_13), .enable(enable & loc_tensor_load_en), .enable_B_regs(load_enable_B_regs), .sparse_2_4_select(second_reg_select_sparse_2_4));
PE PE_31(.clk(clk), .reset(reset), .accumulate(accumulate_5_13_31_22), .accumulate_out(accumulate_6_23_32), .IN_A(out_a30_in_a31), .IN_B(out_b21_in_b31), .weight_index(out_weight_ind_30_in_weight_ind_31), .weight_index_out(out_weight_ind_31_in_weight_ind_32), .OUT_A(out_a31_in_a32), .OUT_B(b_data_out[2*4*`DWIDTH-1:4*`DWIDTH]), .OUT_MAC(out_mac_31), .enable(enable & loc_tensor_load_en), .enable_B_regs(load_enable_B_regs), .sparse_2_4_select(second_reg_select_sparse_2_4));
PE PE_22(.clk(clk), .reset(reset), .accumulate(accumulate_5_13_31_22), .accumulate_out(accumulate_6_23_32), .IN_A(out_a21_in_a22), .IN_B(out_b12_in_b22), .weight_index(out_weight_ind_21_in_weight_ind_22), .weight_index_out(out_weight_ind_22_in_weight_ind_23), .OUT_A(out_a22_in_a23), .OUT_B(out_b22_in_b32), .OUT_MAC(out_mac_22), .enable(enable & loc_tensor_load_en), .enable_B_regs(load_enable_B_regs), .sparse_2_4_select(second_reg_select_sparse_2_4));

PE PE_23(.clk(clk), .reset(reset), .accumulate(accumulate_6_23_32), .accumulate_out(accumulate_7_33), .IN_A(out_a22_in_a23), .IN_B(out_b13_in_b23), .weight_index(out_weight_ind_22_in_weight_ind_23), .weight_index_out(a_data_out[4*`DWIDTH + 5:4*`DWIDTH + 4]), .OUT_A(a_data_out[3*`DWIDTH-1:2*`DWIDTH]), .OUT_B(out_b23_in_b33), .OUT_MAC(out_mac_23), .enable(enable & loc_tensor_load_en), .enable_B_regs(load_enable_B_regs), .sparse_2_4_select(second_reg_select_sparse_2_4));
PE PE_32(.clk(clk), .reset(reset), .accumulate(accumulate_6_23_32), .accumulate_out(accumulate_7_33), .IN_A(out_a31_in_a32), .IN_B(out_b22_in_b32), .weight_index(out_weight_ind_31_in_weight_ind_32), .weight_index_out(out_weight_ind_32_in_weight_ind_33), .OUT_A(out_a32_in_a33), .OUT_B(b_data_out[3*4*`DWIDTH-1:2*4*`DWIDTH]), .OUT_MAC(out_mac_32), .enable(enable & loc_tensor_load_en), .enable_B_regs(load_enable_B_regs), .sparse_2_4_select(second_reg_select_sparse_2_4));

PE PE_33(.clk(clk), .reset(reset), .accumulate(accumulate_7_33), .accumulate_out(), .IN_A(out_a32_in_a33), .IN_B(out_b23_in_b33), .weight_index(out_weight_ind_32_in_weight_ind_33), .weight_index_out(a_data_out[4*`DWIDTH + 7:4*`DWIDTH + 6]), .OUT_A(a_data_out[4*`DWIDTH-1:3*`DWIDTH]), .OUT_B(b_data_out[4*4*`DWIDTH-1:3*4*`DWIDTH]), .OUT_MAC(out_mac_33), .enable(enable & loc_tensor_load_en), .enable_B_regs(load_enable_B_regs), .sparse_2_4_select(second_reg_select_sparse_2_4));



// data extraction combinational logic in column format
// always the last data is coming from the SA array itself, while the others from the mac out register
always @(*)
begin

	if (sparsity_level != `SPARSE_2_4) begin
		if ((control_counter == (3 + `MAC_PIPE_STAGES))) begin

			c_data[4*`ACCWIDTH-1:3*`ACCWIDTH] = {out_mac_30};
			c_data[3*`ACCWIDTH-1:2*`ACCWIDTH] = {mac_out_reg[5]};
			c_data[2*`ACCWIDTH-1:1*`ACCWIDTH] = {mac_out_reg[2]};
			c_data[`ACCWIDTH-1:0] = {mac_out_reg[0]};
		end
		else if ((control_counter == (4 + `MAC_PIPE_STAGES))) begin
			c_data[4*`ACCWIDTH-1:3*`ACCWIDTH] = {out_mac_31};
			c_data[3*`ACCWIDTH-1:2*`ACCWIDTH] = {mac_out_reg[8]};
			c_data[2*`ACCWIDTH-1:1*`ACCWIDTH] = {mac_out_reg[4]};
			c_data[`ACCWIDTH-1:0] = {mac_out_reg[1]};
		end

		else if ((control_counter == (5 + `MAC_PIPE_STAGES))) begin
			c_data[4*`ACCWIDTH-1:3*`ACCWIDTH] = {out_mac_32};
			c_data[3*`ACCWIDTH-1:2*`ACCWIDTH] = {mac_out_reg[1]};
			c_data[2*`ACCWIDTH-1:1*`ACCWIDTH] = {mac_out_reg[7]};
			c_data[`ACCWIDTH-1:0] = {mac_out_reg[3]};
			
		end
		else if ((control_counter == (6 + `MAC_PIPE_STAGES))) begin
			c_data[4*`ACCWIDTH-1:3*`ACCWIDTH] = {out_mac_33};
			c_data[3*`ACCWIDTH-1:2*`ACCWIDTH] = {mac_out_reg[3]};
			c_data[2*`ACCWIDTH-1:1*`ACCWIDTH] = {mac_out_reg[0]};
			c_data[`ACCWIDTH-1:0] = {mac_out_reg[6]};
			
		end
		// in every other case, just put 0, because data are not valid
		else begin
			c_data[4*`ACCWIDTH-1:3*`ACCWIDTH] = {`ACCWIDTH'd0};
			c_data[3*`ACCWIDTH-1:2*`ACCWIDTH] = {`ACCWIDTH'd0};
			c_data[2*`ACCWIDTH-1:1*`ACCWIDTH] = {`ACCWIDTH'd0};
			c_data[`ACCWIDTH-1:0] = {`ACCWIDTH'd0};
		end	
	end

	// sparsity is 2:4
	else begin
		if ((control_counter == (6 + `MAC_PIPE_STAGES))) begin

			c_data[4*`ACCWIDTH-1:3*`ACCWIDTH] = {out_mac_30};
			c_data[3*`ACCWIDTH-1:2*`ACCWIDTH] = {mac_out_reg[5]};
			c_data[2*`ACCWIDTH-1:1*`ACCWIDTH] = {mac_out_reg[2]};
			c_data[`ACCWIDTH-1:0] = {mac_out_reg[0]};
		end
		else if ((control_counter == (8 + `MAC_PIPE_STAGES))) begin
			c_data[4*`ACCWIDTH-1:3*`ACCWIDTH] = {out_mac_31};
			c_data[3*`ACCWIDTH-1:2*`ACCWIDTH] = {mac_out_reg[8]};
			c_data[2*`ACCWIDTH-1:1*`ACCWIDTH] = {mac_out_reg[4]};
			c_data[`ACCWIDTH-1:0] = {mac_out_reg[1]};
		end

		else if ((control_counter == (10 + `MAC_PIPE_STAGES))) begin
			c_data[4*`ACCWIDTH-1:3*`ACCWIDTH] = {out_mac_32};
			c_data[3*`ACCWIDTH-1:2*`ACCWIDTH] = {mac_out_reg[1]};
			c_data[2*`ACCWIDTH-1:1*`ACCWIDTH] = {mac_out_reg[7]};
			c_data[`ACCWIDTH-1:0] = {mac_out_reg[3]};
			
		end
		else if ((control_counter == (12 + `MAC_PIPE_STAGES))) begin
			c_data[4*`ACCWIDTH-1:3*`ACCWIDTH] = {out_mac_33};
			c_data[3*`ACCWIDTH-1:2*`ACCWIDTH] = {mac_out_reg[3]};
			c_data[2*`ACCWIDTH-1:1*`ACCWIDTH] = {mac_out_reg[0]};
			c_data[`ACCWIDTH-1:0] = {mac_out_reg[6]};
			
		end
		// in every other case, just put 0, because data are not valid
		else begin
			c_data[4*`ACCWIDTH-1:3*`ACCWIDTH] = {`ACCWIDTH'd0};
			c_data[3*`ACCWIDTH-1:2*`ACCWIDTH] = {`ACCWIDTH'd0};
			c_data[2*`ACCWIDTH-1:1*`ACCWIDTH] = {`ACCWIDTH'd0};
			c_data[`ACCWIDTH-1:0] = {`ACCWIDTH'd0};
		end	
	end		

end	


endmodule



//////// PE ///////////////////////////////////
///////////////////////////////////////////////
module PE(clk, reset, accumulate, accumulate_out, IN_A, IN_B, weight_index, weight_index_out, OUT_A, OUT_B, OUT_MAC, enable, enable_B_regs, sparse_2_4_select);

input accumulate, enable, enable_B_regs, sparse_2_4_select;
input clk, reset;
input [1:0] weight_index;
input [`DWIDTH-1:0] IN_A;
input [4*`DWIDTH-1:0] IN_B;
output accumulate_out;
output [`DWIDTH-1:0] OUT_A;
output reg [4*`DWIDTH-1:0] OUT_B;
output [`ACCWIDTH-1:0] OUT_MAC;
output [1:0] weight_index_out;

wire [`DWIDTH-1:0] MUX_OUT;

double_registers_sparse_2_4 #(.reg_width(`DWIDTH)) two_regs_A (.clk(clk), .reset(reset), .IN(IN_A), .OUT(OUT_A), .select_signal(sparse_2_4_select), .enable(enable));
double_registers_sparse_2_4 #(.reg_width(2)) two_regs_weight_ind (.clk(clk), .reset(reset), .IN(weight_index), .OUT(weight_index_out), .select_signal(sparse_2_4_select), .enable(enable));
double_registers_sparse_2_4 #(.reg_width(1)) two_regs_accumulate_signal (.clk(clk), .reset(reset), .IN(accumulate), .OUT(accumulate_out), .select_signal(sparse_2_4_select), .enable(enable));


Mux_4_to_1 Mux_inst (.IN_0(IN_B[`DWIDTH-1:0]), .IN_1(IN_B[2*`DWIDTH-1:`DWIDTH]), .IN_2(IN_B[3*`DWIDTH-1:2*`DWIDTH]), .IN_3(IN_B[4*`DWIDTH-1:3*`DWIDTH]), .weight_index(weight_index), .MUX_OUT(MUX_OUT));

MAC_unit_3stages MAC_inst (.clk(clk), .reset(reset), .accumulate(accumulate), .IN_A(IN_A), .IN_B(MUX_OUT), .OUT_C(OUT_MAC), .enable(enable));


always @(posedge clk)
begin
	if (reset) begin
		OUT_B <= 0;
	end else begin

		if (enable) begin
			
			if (enable_B_regs) begin
				OUT_B <= IN_B;
			end


		end	
	end
end


endmodule



//////// MAC unit /////////////////////////////
///////////////////////////////////////////////
module MAC_unit_3stages(clk, reset, accumulate, IN_A, IN_B, OUT_C, enable);


// accumulate signal to select either accumulation or '0'
input accumulate, enable;
input clk, reset;
input [`DWIDTH-1:0] IN_A, IN_B;
output reg [`ACCWIDTH-1:0] OUT_C;

wire [2*`DWIDTH-1:0] mult_out;
reg [2*`DWIDTH-1:0] mult_out_reg;

wire [`ACCWIDTH-1:0] add_out;

reg [`DWIDTH-1:0] IN_A_d, IN_B_d;

reg accumulate_d, accumulate_dd;


// assing a feedback signal for port mapping with the adder
wire [`ACCWIDTH-1:0] add_feedback;

// multiplexer to select either accumulation or '0'
assign add_feedback = (accumulate_dd == 1) ? OUT_C : (`ACCWIDTH'd0);

custom_multiplier mult_inst(.A(IN_A_d), .B(IN_B_d), .C(mult_out));

custom_adder add_inst(.A(mult_out_reg), .B(add_feedback), .C(add_out));

// input FFs
always @(posedge clk)
begin
	if (reset) begin
		IN_A_d <= 0;
		IN_B_d <= 0;
		accumulate_d <= 0;
		accumulate_dd <= 0;
	end
	else begin
		if (enable) begin

			accumulate_d <= accumulate;
			accumulate_dd <= accumulate_d;

			IN_A_d <= IN_A;
			IN_B_d <= IN_B;
			
		end	
	end
end

// multiplier FF
always @(posedge clk)
begin
	if (reset) begin
		mult_out_reg <= 0;
	end
	else begin

		if (enable) begin
			
			mult_out_reg <= mult_out;

		end	
	end
end

// output FF
always @(posedge clk)
begin
	if (reset) begin
		OUT_C <= 0;
	end
	else begin

		if (enable) begin
			
			OUT_C <= add_out;

		end	
	end
end

endmodule



//////// Multiplier /////////////////////////////
/////////////////////////////////////////////////
module custom_multiplier(A, B, C);

input [`DWIDTH-1:0] A, B;
output [2*`DWIDTH-1:0] C;

assign C = A * B;

endmodule


//////// Adder //////////////////////////////////
/////////////////////////////////////////////////
module custom_adder(A, B, C);

// get input A as the output from the multiplier (2*`DWIDTH)
input [2*`DWIDTH-1:0] A; 

// get input B as the output of accumulator (`ACCWIDTH)
input [`ACCWIDTH-1:0] B;

output [`ACCWIDTH-1:0] C;

assign C = A + B;

endmodule




//////// FF with enable logic ///////////////////
/////////////////////////////////////////////////
module FF_enable #(parameter FF_width=8)
				  (clk, reset, data_in, data_out, enable);

input clk, reset, enable;
input [FF_width-1:0] data_in;

output reg [FF_width-1:0] data_out;


always @(posedge clk)
begin
	if (reset) begin
		data_out <= 0;
	end
	else begin
		if (enable) begin
			data_out <= data_in;
		end
	end
end

endmodule



/////////////////// 4:1 Mux /////////////////////
/////////////////////////////////////////////////
module Mux_4_to_1(IN_0, IN_1, IN_2, IN_3, weight_index, MUX_OUT);

input [`DWIDTH-1:0] IN_0, IN_1, IN_2, IN_3;
input [1:0] weight_index;
output reg [`DWIDTH-1:0] MUX_OUT;

always @(*)
begin
	case(weight_index)
	2'b00 	: MUX_OUT = IN_0;
	2'b01 	: MUX_OUT = IN_1;
	2'b10 	: MUX_OUT = IN_2;
	2'b11	: MUX_OUT = IN_3;
	default : MUX_OUT = 0;
	endcase
end

endmodule


/////////////////// two registers for weights and indices  ///////////////////////
///////////////////       for sparse 2:4 pattern           ///////////////////////
module double_registers_sparse_2_4 #(parameter reg_width=8)
									  (clk, reset, IN, OUT, select_signal, enable);

input clk, reset, enable;
input select_signal;
input [reg_width-1:0] IN;
output [reg_width-1:0] OUT;

wire [reg_width-1:0] first_reg, second_reg;

FF_enable #(.FF_width(reg_width)) FF_first_reg (.clk(clk), .reset(reset), .data_in(IN), .data_out(first_reg), .enable(enable));
FF_enable #(.FF_width(reg_width)) FF_second_reg (.clk(clk), .reset(reset), .data_in(first_reg), .data_out(second_reg), .enable(enable));

assign OUT = select_signal ? second_reg : first_reg;

endmodule									  









/*
 * This is the control logic for parametric tiling along with 
 * the ram module to feed the first tensor slice (TS_00),
 * for A (use for A0 only)
 */
module A0_input_mem_control_logic
      #(parameter mwidth = 40,
        parameter addr_width = 9,
        parameter K_const = 128,
        parameter U_const = 4,
        parameter V_const = 4,
        parameter U_bits = 3,
        parameter V_bits = 3)(
        
        clk, 
        reset, 
        enable,
        sparsity_level,
        data_out,
        accumulate_out);

input clk, reset, enable;
input [1:0] sparsity_level;
output [mwidth-1:0] data_out;
output reg accumulate_out;

reg [addr_width-1:0] addr_counter;
reg [V_bits-1:0] v_counter;
reg [U_bits-1:0] u_counter;
reg [addr_width-1:0] offset_reg;
reg [addr_width-1:0] upper_reg;

parameter K_2_4 = K_const/2;
parameter K_1_4 = K_const/4;
parameter K_1_3 = K_const/3;

reg [addr_width-1:0] K_val;

always @(*)
begin
	case(sparsity_level)
	2'b00 	: K_val = K_const;
	2'b01 	: K_val = K_2_4;
	2'b10 	: K_val = K_1_4;
	2'b11	: K_val = K_1_3;
	endcase
end

always @ (posedge clk) 
begin
    if (reset) begin
        addr_counter <= 0;
        v_counter <= 0;
        u_counter <= 0;
        offset_reg <= 0;
        accumulate_out <= 1;
        upper_reg <= K_val - 1;
    end
    else begin
        if (enable) begin

            if (u_counter < U_const) begin

                if (addr_counter == upper_reg) begin
                    v_counter <= v_counter + 1;
                    addr_counter <= offset_reg;
                    accumulate_out <= 0;
                end
                else begin
                    addr_counter <= addr_counter + 1;
                    accumulate_out <= 1;
                end

                if (v_counter == (V_const - 1)) begin
                    offset_reg <= offset_reg + K_val;
                    upper_reg <= upper_reg + K_val;
                    u_counter <= u_counter + 1;
                    v_counter <= 0;
                end

            end
        end
    end
end

// depth is K_cons * U_const
ram_module #(.mwidth(mwidth), .num_words(K_const*U_const), .addr_width(addr_width)) mem_0 (.clk(clk), .wren(0), .addr(addr_counter),
                                                                                 .data(), .out(data_out));
endmodule





/*
 * This is the control logic for parametric tiling along with 
 * the ram module to feed the first tensor slice (TS_00),
 * for B (use for B0 only)
 */
module B0_input_mem_control_logic
      #(parameter mwidth = 32,
        parameter addr_width = 9,
        parameter K_const = 128,
        parameter U_const = 4,
        parameter V_const = 4,
        parameter U_bits = 3,
        parameter V_bits = 3
        )(
        
        clk, 
        reset, 
        enable,
        sparsity_level,
        data_out_0,
        data_out_1,
        data_out_2,
        data_out_3);


input clk, reset, enable;
input [1:0] sparsity_level;
output [mwidth-1:0] data_out_0, data_out_1, data_out_2, data_out_3;

reg [addr_width-1:0] addr_counter;
reg [U_bits-1:0] u_counter;
reg [V_bits-1:0] v_counter;
reg [addr_width-1:0] upper_reg;

wire [mwidth-1:0] mem_out_0, mem_out_1, mem_out_2, mem_out_3;
wire [mwidth-1:0] mux_out;

reg [1:0] sel_cnt;
reg sparse_2_4_1bit_cnt;

parameter K_2_4 = K_const/2;
parameter K_1_4 = K_const/4;
parameter K_1_3 = K_const/3;

reg [addr_width-1:0] K_val;

always @(*)
begin
	case(sparsity_level)
	2'b00 	: K_val = K_const;
	2'b01 	: K_val = K_2_4;
	2'b10 	: K_val = K_1_4;
	2'b11	: K_val = K_1_3;
	endcase
end



always @ (posedge clk) 
begin
    if (reset) begin
        addr_counter <= 0;
        u_counter <= 0;
        v_counter <= 0;
        sel_cnt <= 0;
        sparse_2_4_1bit_cnt <= 0;
        upper_reg <= K_val - 1;
    end
    else begin
        if (enable) begin

            if (u_counter < U_const) begin

                if (v_counter < V_const) begin

                    if (addr_counter == upper_reg) begin
                        v_counter <= v_counter + 1;
                        upper_reg <= upper_reg + K_val;
                    end

                    if (sparsity_level == `DENSE) begin

                        sel_cnt <= sel_cnt + 1;

                        // increase address counter when all 4 memories have been read once
                        if (sel_cnt == 3) begin
                            addr_counter <= addr_counter + 1;
                        end
                    end
                    else if (sparsity_level == `SPARSE_2_4) begin

                        // select mem_0
                        sel_cnt <= 0;

                        sparse_2_4_1bit_cnt <= sparse_2_4_1bit_cnt + 1;

                        // read every 2 cycles (data kept for 2 cycles for correct operation of 2:4 sparsity)
                        if (sparse_2_4_1bit_cnt == 1) begin
                            addr_counter <= addr_counter + 1;
                        end
                    end
                    else if (sparsity_level == `SPARSE_1_4 || sparsity_level == `SPARSE_1_3) begin
                        
                        // select mem_0
                        sel_cnt <= 0;

                        // increase counter every cycle in this case
                        // mem_3 will not be used in 1:3 sparsity
                        addr_counter <= addr_counter + 1;
                    end
                end     
                else begin
                    addr_counter <= 0;
                    u_counter <= u_counter + 1;
                    v_counter <= 0;
                end      
            end
        end
    end
end


// mux for data_out_0
always @(*)
begin
	case(sel_cnt)
	2'b00 	: mux_out = mem_out_0;
	2'b01 	: mux_out = mem_out_1;
	2'b10 	: mux_out = mem_out_2;
	2'b11	: mux_out = mem_out_3;
	endcase
end

// assign data out
assign data_out_0 = mux_out;
assign data_out_1 = mem_out_1;
assign data_out_2 = mem_out_2;
assign data_out_3 = mem_out_3;


// depth is K_cons * V_const
ram_module #(.mwidth(mwidth), .num_words(K_const*V_const), .addr_width(addr_width)) mem_0 (.clk(clk), .wren(0), .addr(addr_counter),
                                                                                 .data(), .out(mem_out_0));

ram_module #(.mwidth(mwidth), .num_words(K_const*V_const), .addr_width(addr_width)) mem_1 (.clk(clk), .wren(0), .addr(addr_counter),
                                                                                 .data(), .out(mem_out_1));

ram_module #(.mwidth(mwidth), .num_words(K_const*V_const), .addr_width(addr_width)) mem_2 (.clk(clk), .wren(0), .addr(addr_counter),
                                                                                 .data(), .out(mem_out_2));

ram_module #(.mwidth(mwidth), .num_words(K_const*V_const), .addr_width(addr_width)) mem_3 (.clk(clk), .wren(0), .addr(addr_counter),
                                                                                 .data(), .out(mem_out_3));
endmodule



/*
 * This is the control logic for parametric tiling along with 
 * the ram module to feed the REST tensor slices (EXCEPT TS_00),
 * for A (use for Ay, y>=1).
 * 
 */
module Ay_input_mem_control_logic
      #(parameter mwidth = 40,
        parameter addr_width = 9,
        parameter start_cnt_bits = 2,
        parameter start_val = 4,
        parameter K_const = 128,
        parameter U_const = 4,
        parameter V_const = 4,
        parameter U_bits = 3,
        parameter V_bits = 3)(

        clk, 
        reset, 
        enable,
        sparsity_level,
        data_out);

input clk, reset, enable;
input [1:0] sparsity_level;
output [mwidth-1:0] data_out;

reg [addr_width-1:0] addr_counter;
reg [V_bits-1:0] v_counter;
reg [U_bits-1:0] u_counter;
reg [addr_width-1:0] offset_reg;
reg [addr_width-1:0] upper_reg;

// start counter
reg [start_cnt_bits-1:0] start_counter;

parameter K_2_4 = K_const/2;
parameter K_1_4 = K_const/4;
parameter K_1_3 = K_const/3;

reg [addr_width-1:0] K_val;

always @(*)
begin
	case(sparsity_level)
	2'b00 	: K_val = K_const;
	2'b01 	: K_val = K_2_4;
	2'b10 	: K_val = K_1_4;
	2'b11	: K_val = K_1_3;
	endcase
end


always @ (posedge clk) 
begin
    if (reset) begin
        start_counter <= 0;
        addr_counter <= 0;
        v_counter <= 0;
        u_counter <= 0;
        offset_reg <= 0;
        upper_reg <= K_val - 1;
    end
    else begin
        if (enable) begin
            if (start_counter < start_val) begin
                start_counter <= start_counter + 1;   
            end
            else begin

                if (u_counter < U_const) begin
                    
                    if (addr_counter == upper_reg) begin
                        v_counter <= v_counter + 1;
                        addr_counter <= offset_reg;
                    end
                    else begin
                        addr_counter <= addr_counter + 1;
                    end

                    if (v_counter == (V_const - 1)) begin
                        offset_reg <= offset_reg + K_val;
                        upper_reg <= upper_reg + K_val;
                        u_counter <= u_counter + 1;
                        v_counter <= 0;
                    end

                end
            end
        end
    end
end

// depth is K_cons * U_const
ram_module #(.mwidth(mwidth), .num_words(K_const*U_const), .addr_width(addr_width)) mem_y (.clk(clk), .wren(0), .addr(addr_counter),
                                                                                   .data(), .out(data_out));
endmodule


/*
 * This is the control logic for parametric tiling along with 
 * the ram module to feed the REST tensor slices (EXCEPT TS_00),
 * for B (use for Bx, x>=1).
 */
module Bx_input_mem_control_logic
      #(parameter mwidth = 32,
        parameter addr_width = 9,
        parameter start_cnt_bits = 2,
        parameter start_val = 4,
        parameter K_const = 128,
        parameter U_const = 4,
        parameter V_const = 4,
        parameter U_bits = 3,
        parameter V_bits = 3
        )(

        clk, 
        reset, 
        enable,
        sparsity_level,
        data_out_0,
        data_out_1,
        data_out_2,
        data_out_3);


input clk, reset, enable;
input [1:0] sparsity_level;
output [mwidth-1:0] data_out_0, data_out_1, data_out_2, data_out_3;

reg [addr_width-1:0] addr_counter;
reg [U_bits-1:0] u_counter;
reg [V_bits-1:0] v_counter;
reg [addr_width-1:0] upper_reg;

// start counter
reg [start_cnt_bits-1:0] start_counter;

wire [mwidth-1:0] mem_out_0, mem_out_1, mem_out_2, mem_out_3;
wire [mwidth-1:0] mux_out;

reg [1:0] sel_cnt;
reg sparse_2_4_1bit_cnt;

parameter K_2_4 = K_const/2;
parameter K_1_4 = K_const/4;
parameter K_1_3 = K_const/3;

reg [addr_width-1:0] K_val;

always @(*)
begin
	case(sparsity_level)
	2'b00 	: K_val = K_const;
	2'b01 	: K_val = K_2_4;
	2'b10 	: K_val = K_1_4;
	2'b11	: K_val = K_1_3;
	endcase
end


always @ (posedge clk) 
begin
    if (reset) begin
        start_counter <= 0;
        addr_counter <= 0;
        u_counter <= 0;
        v_counter <= 0;
        sel_cnt <= 0;
        sparse_2_4_1bit_cnt <= 0;
        upper_reg <= K_val - 1;
    end
    else begin
        if (enable) begin
            if (start_counter < start_val) begin
                start_counter <= start_counter + 1;   
            end
            else begin
                if (u_counter < U_const) begin

                    if (v_counter < V_const) begin

                        if (addr_counter == upper_reg) begin
                            v_counter <= v_counter + 1;
                            upper_reg <= upper_reg + K_val;
                        end

                        if (sparsity_level == `DENSE) begin

                            sel_cnt <= sel_cnt + 1;

                            // increase address counter when all 4 memories have been read once (every 4 cycles)
                            if (sel_cnt == 3) begin
                                addr_counter <= addr_counter + 1;
                            end
                        end
                        else if (sparsity_level == `SPARSE_2_4) begin

                            // select mem_0
                            sel_cnt <= 0;

                            sparse_2_4_1bit_cnt <= sparse_2_4_1bit_cnt + 1;

                            // read every 2 cycles (data kept for 2 cycles for correct operation of 2:4 sparsity)
                            if (sparse_2_4_1bit_cnt == 1) begin
                                addr_counter <= addr_counter + 1;
                            end
                        end
                        else if (sparsity_level == `SPARSE_1_4 || sparsity_level == `SPARSE_1_3) begin
                            
                            // select mem_0
                            sel_cnt <= 0;

                            // increase counter every cycle in this case
                            // mem_3 will not be used in 1:3 sparsity
                            addr_counter <= addr_counter + 1;
                        end
                    end      
                    else begin
                        addr_counter <= 0;
                        u_counter <= u_counter + 1;
                        v_counter <= 0;
                    end      
                end
                
            end
        end
    end
end


// mux for data_out_0
always @(*)
begin
	case(sel_cnt)
	2'b00 	: mux_out = mem_out_0;
	2'b01 	: mux_out = mem_out_1;
	2'b10 	: mux_out = mem_out_2;
	2'b11	: mux_out = mem_out_3;
	endcase
end

// assign data out
assign data_out_0 = mux_out;
assign data_out_1 = mem_out_1;
assign data_out_2 = mem_out_2;
assign data_out_3 = mem_out_3;


// depth is K_cons * V_const
ram_module #(.mwidth(mwidth), .num_words(K_const*V_const), .addr_width(addr_width)) mem_0 (.clk(clk), .wren(0), .addr(addr_counter),
                                                                                 .data(), .out(mem_out_0));

ram_module #(.mwidth(mwidth), .num_words(K_const*V_const), .addr_width(addr_width)) mem_1 (.clk(clk), .wren(0), .addr(addr_counter),
                                                                                 .data(), .out(mem_out_1));

ram_module #(.mwidth(mwidth), .num_words(K_const*V_const), .addr_width(addr_width)) mem_2 (.clk(clk), .wren(0), .addr(addr_counter),
                                                                                 .data(), .out(mem_out_2));

ram_module #(.mwidth(mwidth), .num_words(K_const*V_const), .addr_width(addr_width)) mem_3 (.clk(clk), .wren(0), .addr(addr_counter),
                                                                                 .data(), .out(mem_out_3));
endmodule




/*
 * This is the control logic along with 
 * the ram module to save the results in the Cxy buffer,
 * of tensor slice xy (TS_xy)
 */
module output_mem_Cxy_control_logic
      #(parameter mwidth = 32,
        parameter addr_width = 9,
        parameter U_const = 4,
        parameter V_const = 4)(
        
        clk, 
        reset, 
        enable,
        valid_in,
        data_in_0,
        data_in_1,
        data_in_2,
        data_in_3,
        data_out_0,
        data_out_1,
        data_out_2,
        data_out_3);

input clk, reset, enable, valid_in;

input [mwidth-1:0] data_in_0, data_in_1, data_in_2, data_in_3;
output [mwidth-1:0] data_out_0, data_out_1, data_out_2, data_out_3;

reg [addr_width-1:0] addr_counter;


always @ (posedge clk) 
begin
        if (reset) begin
                addr_counter <= 0;
        end
        else begin
                if (enable) begin
                        if (valid_in == 1) begin
                                addr_counter <= addr_counter + 1;
                        end
                end
        end
end


// depth is 4*U_const*V_const
ram_module #(.mwidth(mwidth), .num_words(4*U_const*V_const), .addr_width(addr_width)) mem_xy_0 (.clk(clk), .wren(valid_in), .addr(addr_counter),
                                                                                  .data(data_in_0), .out(data_out_0));

ram_module #(.mwidth(mwidth), .num_words(4*U_const*V_const), .addr_width(addr_width)) mem_xy_1 (.clk(clk), .wren(valid_in), .addr(addr_counter),
                                                                                  .data(data_in_1), .out(data_out_1));

ram_module #(.mwidth(mwidth), .num_words(4*U_const*V_const), .addr_width(addr_width)) mem_xy_2 (.clk(clk), .wren(valid_in), .addr(addr_counter),
                                                                                  .data(data_in_2), .out(data_out_2));

ram_module #(.mwidth(mwidth), .num_words(4*U_const*V_const), .addr_width(addr_width)) mem_xy_3 (.clk(clk), .wren(valid_in), .addr(addr_counter),
                                                                                  .data(data_in_3), .out(data_out_3));

endmodule



/*
 * This is a ram module in behavioral verilog.
 * 1) width (MWIDTH)
 * 2) number of words (NUM_WORDS)
 * 3) address width (ADDR_WIDTH)
 * should be provided.
 * VTR handles the mapping to BRAMs,
 * depeding on width and number of words config.
 */
module ram_module
      #(parameter mwidth = 32,
        parameter num_words = 512,
        parameter addr_width = 9)(
        
        clk, 
        wren, 
        addr,
        data, 
        out);
        
input clk, wren;
input [addr_width-1:0] addr;
input [mwidth-1:0] data;
output reg [mwidth-1:0] out;

// RAM
reg [mwidth-1:0] ram[num_words-1:0];


always @ (posedge clk) 
begin 
  if (wren) begin
        ram[addr] <= data;
  end
  else begin
        out <= ram[addr];
  end
end

endmodule

