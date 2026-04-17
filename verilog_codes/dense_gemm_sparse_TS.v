
// `define DWIDTH 8
// `define ACCWIDTH 32
`define DENSE 0
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
    cout_data);
        
input clk, reset, enable;
output [399:0] cout_data;

// Ay wires
wire [32-1:0] A0_data;
wire [32-1:0] A1_data;
wire [32-1:0] A2_data;
wire [32-1:0] A3_data;
wire [32-1:0] A4_data;
wire [32-1:0] A5_data;
wire [32-1:0] A6_data;
wire [32-1:0] A7_data;
wire [32-1:0] A8_data;
wire [32-1:0] A9_data;

wire [40-1:0] A_in0_0;
wire [40-1:0] A_in0_1;
wire [40-1:0] A_in0_2;
wire [40-1:0] A_in0_3;
wire [40-1:0] A_in0_4;
wire [40-1:0] A_in0_5;
wire [40-1:0] A_in0_6;
wire [40-1:0] A_in0_7;
wire [40-1:0] A_in0_8;
wire [40-1:0] A_in0_9;

wire [8-1:0] uncon_a0_0;
wire [8-1:0] uncon_a0_1;
wire [8-1:0] uncon_a0_2;
wire [8-1:0] uncon_a0_3;
wire [8-1:0] uncon_a0_4;
wire [8-1:0] uncon_a0_5;
wire [8-1:0] uncon_a0_6;
wire [8-1:0] uncon_a0_7;
wire [8-1:0] uncon_a0_8;
wire [8-1:0] uncon_a0_9;

assign A_in0_0 = {uncon_a0_0, A0_data};
assign A_in0_1 = {uncon_a0_1, A1_data};
assign A_in0_2 = {uncon_a0_2, A2_data};
assign A_in0_3 = {uncon_a0_3, A3_data};
assign A_in0_4 = {uncon_a0_4, A4_data};
assign A_in0_5 = {uncon_a0_5, A5_data};
assign A_in0_6 = {uncon_a0_6, A6_data};
assign A_in0_7 = {uncon_a0_7, A7_data};
assign A_in0_8 = {uncon_a0_8, A8_data};
assign A_in0_9 = {uncon_a0_9, A9_data};

// Bx wires
wire [32-1:0] B0_data;
wire [32-1:0] B1_data;
wire [32-1:0] B2_data;
wire [32-1:0] B3_data;
wire [32-1:0] B4_data;
wire [32-1:0] B5_data;
wire [32-1:0] B6_data;
wire [32-1:0] B7_data;
wire [32-1:0] B8_data;
wire [32-1:0] B9_data;

wire [128-1:0] B_in0_0;
wire [128-1:0] B_in1_0;
wire [128-1:0] B_in2_0;
wire [128-1:0] B_in3_0;
wire [128-1:0] B_in4_0;
wire [128-1:0] B_in5_0;
wire [128-1:0] B_in6_0;
wire [128-1:0] B_in7_0;
wire [128-1:0] B_in8_0;
wire [128-1:0] B_in9_0;

wire [96-1:0] uncon_b0_0;
wire [96-1:0] uncon_b1_0;
wire [96-1:0] uncon_b2_0;
wire [96-1:0] uncon_b3_0;
wire [96-1:0] uncon_b4_0;
wire [96-1:0] uncon_b5_0;
wire [96-1:0] uncon_b6_0;
wire [96-1:0] uncon_b7_0;
wire [96-1:0] uncon_b8_0;
wire [96-1:0] uncon_b9_0;

assign B_in0_0 = {uncon_b0_0, B0_data};
assign B_in1_0 = {uncon_b1_0, B1_data};
assign B_in2_0 = {uncon_b2_0, B2_data};
assign B_in3_0 = {uncon_b3_0, B3_data};
assign B_in4_0 = {uncon_b4_0, B4_data};
assign B_in5_0 = {uncon_b5_0, B5_data};
assign B_in6_0 = {uncon_b6_0, B6_data};
assign B_in7_0 = {uncon_b7_0, B7_data};
assign B_in8_0 = {uncon_b8_0, B8_data};
assign B_in9_0 = {uncon_b9_0, B9_data};


// valid_out_x_y signals
wire valid_out0_0;
wire valid_out0_1;
wire valid_out0_2;
wire valid_out0_3;
wire valid_out0_4;
wire valid_out0_5;
wire valid_out0_6;
wire valid_out0_7;
wire valid_out0_8;
wire valid_out0_9;
wire valid_out1_0;
wire valid_out1_1;
wire valid_out1_2;
wire valid_out1_3;
wire valid_out1_4;
wire valid_out1_5;
wire valid_out1_6;
wire valid_out1_7;
wire valid_out1_8;
wire valid_out1_9;
wire valid_out2_0;
wire valid_out2_1;
wire valid_out2_2;
wire valid_out2_3;
wire valid_out2_4;
wire valid_out2_5;
wire valid_out2_6;
wire valid_out2_7;
wire valid_out2_8;
wire valid_out2_9;
wire valid_out3_0;
wire valid_out3_1;
wire valid_out3_2;
wire valid_out3_3;
wire valid_out3_4;
wire valid_out3_5;
wire valid_out3_6;
wire valid_out3_7;
wire valid_out3_8;
wire valid_out3_9;
wire valid_out4_0;
wire valid_out4_1;
wire valid_out4_2;
wire valid_out4_3;
wire valid_out4_4;
wire valid_out4_5;
wire valid_out4_6;
wire valid_out4_7;
wire valid_out4_8;
wire valid_out4_9;
wire valid_out5_0;
wire valid_out5_1;
wire valid_out5_2;
wire valid_out5_3;
wire valid_out5_4;
wire valid_out5_5;
wire valid_out5_6;
wire valid_out5_7;
wire valid_out5_8;
wire valid_out5_9;
wire valid_out6_0;
wire valid_out6_1;
wire valid_out6_2;
wire valid_out6_3;
wire valid_out6_4;
wire valid_out6_5;
wire valid_out6_6;
wire valid_out6_7;
wire valid_out6_8;
wire valid_out6_9;
wire valid_out7_0;
wire valid_out7_1;
wire valid_out7_2;
wire valid_out7_3;
wire valid_out7_4;
wire valid_out7_5;
wire valid_out7_6;
wire valid_out7_7;
wire valid_out7_8;
wire valid_out7_9;
wire valid_out8_0;
wire valid_out8_1;
wire valid_out8_2;
wire valid_out8_3;
wire valid_out8_4;
wire valid_out8_5;
wire valid_out8_6;
wire valid_out8_7;
wire valid_out8_8;
wire valid_out8_9;
wire valid_out9_0;
wire valid_out9_1;
wire valid_out9_2;
wire valid_out9_3;
wire valid_out9_4;
wire valid_out9_5;
wire valid_out9_6;
wire valid_out9_7;
wire valid_out9_8;
wire valid_out9_9;


// Cx_y signals
wire [128-1:0] C0_0_data;
wire [128-1:0] C0_1_data;
wire [128-1:0] C0_2_data;
wire [128-1:0] C0_3_data;
wire [128-1:0] C0_4_data;
wire [128-1:0] C0_5_data;
wire [128-1:0] C0_6_data;
wire [128-1:0] C0_7_data;
wire [128-1:0] C0_8_data;
wire [128-1:0] C0_9_data;
wire [128-1:0] C1_0_data;
wire [128-1:0] C1_1_data;
wire [128-1:0] C1_2_data;
wire [128-1:0] C1_3_data;
wire [128-1:0] C1_4_data;
wire [128-1:0] C1_5_data;
wire [128-1:0] C1_6_data;
wire [128-1:0] C1_7_data;
wire [128-1:0] C1_8_data;
wire [128-1:0] C1_9_data;
wire [128-1:0] C2_0_data;
wire [128-1:0] C2_1_data;
wire [128-1:0] C2_2_data;
wire [128-1:0] C2_3_data;
wire [128-1:0] C2_4_data;
wire [128-1:0] C2_5_data;
wire [128-1:0] C2_6_data;
wire [128-1:0] C2_7_data;
wire [128-1:0] C2_8_data;
wire [128-1:0] C2_9_data;
wire [128-1:0] C3_0_data;
wire [128-1:0] C3_1_data;
wire [128-1:0] C3_2_data;
wire [128-1:0] C3_3_data;
wire [128-1:0] C3_4_data;
wire [128-1:0] C3_5_data;
wire [128-1:0] C3_6_data;
wire [128-1:0] C3_7_data;
wire [128-1:0] C3_8_data;
wire [128-1:0] C3_9_data;
wire [128-1:0] C4_0_data;
wire [128-1:0] C4_1_data;
wire [128-1:0] C4_2_data;
wire [128-1:0] C4_3_data;
wire [128-1:0] C4_4_data;
wire [128-1:0] C4_5_data;
wire [128-1:0] C4_6_data;
wire [128-1:0] C4_7_data;
wire [128-1:0] C4_8_data;
wire [128-1:0] C4_9_data;
wire [128-1:0] C5_0_data;
wire [128-1:0] C5_1_data;
wire [128-1:0] C5_2_data;
wire [128-1:0] C5_3_data;
wire [128-1:0] C5_4_data;
wire [128-1:0] C5_5_data;
wire [128-1:0] C5_6_data;
wire [128-1:0] C5_7_data;
wire [128-1:0] C5_8_data;
wire [128-1:0] C5_9_data;
wire [128-1:0] C6_0_data;
wire [128-1:0] C6_1_data;
wire [128-1:0] C6_2_data;
wire [128-1:0] C6_3_data;
wire [128-1:0] C6_4_data;
wire [128-1:0] C6_5_data;
wire [128-1:0] C6_6_data;
wire [128-1:0] C6_7_data;
wire [128-1:0] C6_8_data;
wire [128-1:0] C6_9_data;
wire [128-1:0] C7_0_data;
wire [128-1:0] C7_1_data;
wire [128-1:0] C7_2_data;
wire [128-1:0] C7_3_data;
wire [128-1:0] C7_4_data;
wire [128-1:0] C7_5_data;
wire [128-1:0] C7_6_data;
wire [128-1:0] C7_7_data;
wire [128-1:0] C7_8_data;
wire [128-1:0] C7_9_data;
wire [128-1:0] C8_0_data;
wire [128-1:0] C8_1_data;
wire [128-1:0] C8_2_data;
wire [128-1:0] C8_3_data;
wire [128-1:0] C8_4_data;
wire [128-1:0] C8_5_data;
wire [128-1:0] C8_6_data;
wire [128-1:0] C8_7_data;
wire [128-1:0] C8_8_data;
wire [128-1:0] C8_9_data;
wire [128-1:0] C9_0_data;
wire [128-1:0] C9_1_data;
wire [128-1:0] C9_2_data;
wire [128-1:0] C9_3_data;
wire [128-1:0] C9_4_data;
wire [128-1:0] C9_5_data;
wire [128-1:0] C9_6_data;
wire [128-1:0] C9_7_data;
wire [128-1:0] C9_8_data;
wire [128-1:0] C9_9_data;


wire [128-1:0] C0_0_data_out_mem;
wire [128-1:0] C0_1_data_out_mem;
wire [128-1:0] C0_2_data_out_mem;
wire [128-1:0] C0_3_data_out_mem;
wire [128-1:0] C0_4_data_out_mem;
wire [128-1:0] C0_5_data_out_mem;
wire [128-1:0] C0_6_data_out_mem;
wire [128-1:0] C0_7_data_out_mem;
wire [128-1:0] C0_8_data_out_mem;
wire [128-1:0] C0_9_data_out_mem;
wire [128-1:0] C1_0_data_out_mem;
wire [128-1:0] C1_1_data_out_mem;
wire [128-1:0] C1_2_data_out_mem;
wire [128-1:0] C1_3_data_out_mem;
wire [128-1:0] C1_4_data_out_mem;
wire [128-1:0] C1_5_data_out_mem;
wire [128-1:0] C1_6_data_out_mem;
wire [128-1:0] C1_7_data_out_mem;
wire [128-1:0] C1_8_data_out_mem;
wire [128-1:0] C1_9_data_out_mem;
wire [128-1:0] C2_0_data_out_mem;
wire [128-1:0] C2_1_data_out_mem;
wire [128-1:0] C2_2_data_out_mem;
wire [128-1:0] C2_3_data_out_mem;
wire [128-1:0] C2_4_data_out_mem;
wire [128-1:0] C2_5_data_out_mem;
wire [128-1:0] C2_6_data_out_mem;
wire [128-1:0] C2_7_data_out_mem;
wire [128-1:0] C2_8_data_out_mem;
wire [128-1:0] C2_9_data_out_mem;
wire [128-1:0] C3_0_data_out_mem;
wire [128-1:0] C3_1_data_out_mem;
wire [128-1:0] C3_2_data_out_mem;
wire [128-1:0] C3_3_data_out_mem;
wire [128-1:0] C3_4_data_out_mem;
wire [128-1:0] C3_5_data_out_mem;
wire [128-1:0] C3_6_data_out_mem;
wire [128-1:0] C3_7_data_out_mem;
wire [128-1:0] C3_8_data_out_mem;
wire [128-1:0] C3_9_data_out_mem;
wire [128-1:0] C4_0_data_out_mem;
wire [128-1:0] C4_1_data_out_mem;
wire [128-1:0] C4_2_data_out_mem;
wire [128-1:0] C4_3_data_out_mem;
wire [128-1:0] C4_4_data_out_mem;
wire [128-1:0] C4_5_data_out_mem;
wire [128-1:0] C4_6_data_out_mem;
wire [128-1:0] C4_7_data_out_mem;
wire [128-1:0] C4_8_data_out_mem;
wire [128-1:0] C4_9_data_out_mem;
wire [128-1:0] C5_0_data_out_mem;
wire [128-1:0] C5_1_data_out_mem;
wire [128-1:0] C5_2_data_out_mem;
wire [128-1:0] C5_3_data_out_mem;
wire [128-1:0] C5_4_data_out_mem;
wire [128-1:0] C5_5_data_out_mem;
wire [128-1:0] C5_6_data_out_mem;
wire [128-1:0] C5_7_data_out_mem;
wire [128-1:0] C5_8_data_out_mem;
wire [128-1:0] C5_9_data_out_mem;
wire [128-1:0] C6_0_data_out_mem;
wire [128-1:0] C6_1_data_out_mem;
wire [128-1:0] C6_2_data_out_mem;
wire [128-1:0] C6_3_data_out_mem;
wire [128-1:0] C6_4_data_out_mem;
wire [128-1:0] C6_5_data_out_mem;
wire [128-1:0] C6_6_data_out_mem;
wire [128-1:0] C6_7_data_out_mem;
wire [128-1:0] C6_8_data_out_mem;
wire [128-1:0] C6_9_data_out_mem;
wire [128-1:0] C7_0_data_out_mem;
wire [128-1:0] C7_1_data_out_mem;
wire [128-1:0] C7_2_data_out_mem;
wire [128-1:0] C7_3_data_out_mem;
wire [128-1:0] C7_4_data_out_mem;
wire [128-1:0] C7_5_data_out_mem;
wire [128-1:0] C7_6_data_out_mem;
wire [128-1:0] C7_7_data_out_mem;
wire [128-1:0] C7_8_data_out_mem;
wire [128-1:0] C7_9_data_out_mem;
wire [128-1:0] C8_0_data_out_mem;
wire [128-1:0] C8_1_data_out_mem;
wire [128-1:0] C8_2_data_out_mem;
wire [128-1:0] C8_3_data_out_mem;
wire [128-1:0] C8_4_data_out_mem;
wire [128-1:0] C8_5_data_out_mem;
wire [128-1:0] C8_6_data_out_mem;
wire [128-1:0] C8_7_data_out_mem;
wire [128-1:0] C8_8_data_out_mem;
wire [128-1:0] C8_9_data_out_mem;
wire [128-1:0] C9_0_data_out_mem;
wire [128-1:0] C9_1_data_out_mem;
wire [128-1:0] C9_2_data_out_mem;
wire [128-1:0] C9_3_data_out_mem;
wire [128-1:0] C9_4_data_out_mem;
wire [128-1:0] C9_5_data_out_mem;
wire [128-1:0] C9_6_data_out_mem;
wire [128-1:0] C9_7_data_out_mem;
wire [128-1:0] C9_8_data_out_mem;
wire [128-1:0] C9_9_data_out_mem;


// horizontal connections
wire [40-1:0] A_out0_0;
wire [40-1:0] A_out1_0;
wire [40-1:0] A_out2_0;
wire [40-1:0] A_out3_0;
wire [40-1:0] A_out4_0;
wire [40-1:0] A_out5_0;
wire [40-1:0] A_out6_0;
wire [40-1:0] A_out7_0;
wire [40-1:0] A_out8_0;
wire [40-1:0] A_out0_1;
wire [40-1:0] A_out1_1;
wire [40-1:0] A_out2_1;
wire [40-1:0] A_out3_1;
wire [40-1:0] A_out4_1;
wire [40-1:0] A_out5_1;
wire [40-1:0] A_out6_1;
wire [40-1:0] A_out7_1;
wire [40-1:0] A_out8_1;
wire [40-1:0] A_out0_2;
wire [40-1:0] A_out1_2;
wire [40-1:0] A_out2_2;
wire [40-1:0] A_out3_2;
wire [40-1:0] A_out4_2;
wire [40-1:0] A_out5_2;
wire [40-1:0] A_out6_2;
wire [40-1:0] A_out7_2;
wire [40-1:0] A_out8_2;
wire [40-1:0] A_out0_3;
wire [40-1:0] A_out1_3;
wire [40-1:0] A_out2_3;
wire [40-1:0] A_out3_3;
wire [40-1:0] A_out4_3;
wire [40-1:0] A_out5_3;
wire [40-1:0] A_out6_3;
wire [40-1:0] A_out7_3;
wire [40-1:0] A_out8_3;
wire [40-1:0] A_out0_4;
wire [40-1:0] A_out1_4;
wire [40-1:0] A_out2_4;
wire [40-1:0] A_out3_4;
wire [40-1:0] A_out4_4;
wire [40-1:0] A_out5_4;
wire [40-1:0] A_out6_4;
wire [40-1:0] A_out7_4;
wire [40-1:0] A_out8_4;
wire [40-1:0] A_out0_5;
wire [40-1:0] A_out1_5;
wire [40-1:0] A_out2_5;
wire [40-1:0] A_out3_5;
wire [40-1:0] A_out4_5;
wire [40-1:0] A_out5_5;
wire [40-1:0] A_out6_5;
wire [40-1:0] A_out7_5;
wire [40-1:0] A_out8_5;
wire [40-1:0] A_out0_6;
wire [40-1:0] A_out1_6;
wire [40-1:0] A_out2_6;
wire [40-1:0] A_out3_6;
wire [40-1:0] A_out4_6;
wire [40-1:0] A_out5_6;
wire [40-1:0] A_out6_6;
wire [40-1:0] A_out7_6;
wire [40-1:0] A_out8_6;
wire [40-1:0] A_out0_7;
wire [40-1:0] A_out1_7;
wire [40-1:0] A_out2_7;
wire [40-1:0] A_out3_7;
wire [40-1:0] A_out4_7;
wire [40-1:0] A_out5_7;
wire [40-1:0] A_out6_7;
wire [40-1:0] A_out7_7;
wire [40-1:0] A_out8_7;
wire [40-1:0] A_out0_8;
wire [40-1:0] A_out1_8;
wire [40-1:0] A_out2_8;
wire [40-1:0] A_out3_8;
wire [40-1:0] A_out4_8;
wire [40-1:0] A_out5_8;
wire [40-1:0] A_out6_8;
wire [40-1:0] A_out7_8;
wire [40-1:0] A_out8_8;
wire [40-1:0] A_out0_9;
wire [40-1:0] A_out1_9;
wire [40-1:0] A_out2_9;
wire [40-1:0] A_out3_9;
wire [40-1:0] A_out4_9;
wire [40-1:0] A_out5_9;
wire [40-1:0] A_out6_9;
wire [40-1:0] A_out7_9;
wire [40-1:0] A_out8_9;

wire [40-1:0] A_in1_0;
wire [40-1:0] A_in2_0;
wire [40-1:0] A_in3_0;
wire [40-1:0] A_in4_0;
wire [40-1:0] A_in5_0;
wire [40-1:0] A_in6_0;
wire [40-1:0] A_in7_0;
wire [40-1:0] A_in8_0;
wire [40-1:0] A_in9_0;
wire [40-1:0] A_in1_1;
wire [40-1:0] A_in2_1;
wire [40-1:0] A_in3_1;
wire [40-1:0] A_in4_1;
wire [40-1:0] A_in5_1;
wire [40-1:0] A_in6_1;
wire [40-1:0] A_in7_1;
wire [40-1:0] A_in8_1;
wire [40-1:0] A_in9_1;
wire [40-1:0] A_in1_2;
wire [40-1:0] A_in2_2;
wire [40-1:0] A_in3_2;
wire [40-1:0] A_in4_2;
wire [40-1:0] A_in5_2;
wire [40-1:0] A_in6_2;
wire [40-1:0] A_in7_2;
wire [40-1:0] A_in8_2;
wire [40-1:0] A_in9_2;
wire [40-1:0] A_in1_3;
wire [40-1:0] A_in2_3;
wire [40-1:0] A_in3_3;
wire [40-1:0] A_in4_3;
wire [40-1:0] A_in5_3;
wire [40-1:0] A_in6_3;
wire [40-1:0] A_in7_3;
wire [40-1:0] A_in8_3;
wire [40-1:0] A_in9_3;
wire [40-1:0] A_in1_4;
wire [40-1:0] A_in2_4;
wire [40-1:0] A_in3_4;
wire [40-1:0] A_in4_4;
wire [40-1:0] A_in5_4;
wire [40-1:0] A_in6_4;
wire [40-1:0] A_in7_4;
wire [40-1:0] A_in8_4;
wire [40-1:0] A_in9_4;
wire [40-1:0] A_in1_5;
wire [40-1:0] A_in2_5;
wire [40-1:0] A_in3_5;
wire [40-1:0] A_in4_5;
wire [40-1:0] A_in5_5;
wire [40-1:0] A_in6_5;
wire [40-1:0] A_in7_5;
wire [40-1:0] A_in8_5;
wire [40-1:0] A_in9_5;
wire [40-1:0] A_in1_6;
wire [40-1:0] A_in2_6;
wire [40-1:0] A_in3_6;
wire [40-1:0] A_in4_6;
wire [40-1:0] A_in5_6;
wire [40-1:0] A_in6_6;
wire [40-1:0] A_in7_6;
wire [40-1:0] A_in8_6;
wire [40-1:0] A_in9_6;
wire [40-1:0] A_in1_7;
wire [40-1:0] A_in2_7;
wire [40-1:0] A_in3_7;
wire [40-1:0] A_in4_7;
wire [40-1:0] A_in5_7;
wire [40-1:0] A_in6_7;
wire [40-1:0] A_in7_7;
wire [40-1:0] A_in8_7;
wire [40-1:0] A_in9_7;
wire [40-1:0] A_in1_8;
wire [40-1:0] A_in2_8;
wire [40-1:0] A_in3_8;
wire [40-1:0] A_in4_8;
wire [40-1:0] A_in5_8;
wire [40-1:0] A_in6_8;
wire [40-1:0] A_in7_8;
wire [40-1:0] A_in8_8;
wire [40-1:0] A_in9_8;
wire [40-1:0] A_in1_9;
wire [40-1:0] A_in2_9;
wire [40-1:0] A_in3_9;
wire [40-1:0] A_in4_9;
wire [40-1:0] A_in5_9;
wire [40-1:0] A_in6_9;
wire [40-1:0] A_in7_9;
wire [40-1:0] A_in8_9;
wire [40-1:0] A_in9_9;

wire [8-1:0] uncon_in1_0;
wire [8-1:0] uncon_in2_0;
wire [8-1:0] uncon_in3_0;
wire [8-1:0] uncon_in4_0;
wire [8-1:0] uncon_in5_0;
wire [8-1:0] uncon_in6_0;
wire [8-1:0] uncon_in7_0;
wire [8-1:0] uncon_in8_0;
wire [8-1:0] uncon_in9_0;
wire [8-1:0] uncon_in1_1;
wire [8-1:0] uncon_in2_1;
wire [8-1:0] uncon_in3_1;
wire [8-1:0] uncon_in4_1;
wire [8-1:0] uncon_in5_1;
wire [8-1:0] uncon_in6_1;
wire [8-1:0] uncon_in7_1;
wire [8-1:0] uncon_in8_1;
wire [8-1:0] uncon_in9_1;
wire [8-1:0] uncon_in1_2;
wire [8-1:0] uncon_in2_2;
wire [8-1:0] uncon_in3_2;
wire [8-1:0] uncon_in4_2;
wire [8-1:0] uncon_in5_2;
wire [8-1:0] uncon_in6_2;
wire [8-1:0] uncon_in7_2;
wire [8-1:0] uncon_in8_2;
wire [8-1:0] uncon_in9_2;
wire [8-1:0] uncon_in1_3;
wire [8-1:0] uncon_in2_3;
wire [8-1:0] uncon_in3_3;
wire [8-1:0] uncon_in4_3;
wire [8-1:0] uncon_in5_3;
wire [8-1:0] uncon_in6_3;
wire [8-1:0] uncon_in7_3;
wire [8-1:0] uncon_in8_3;
wire [8-1:0] uncon_in9_3;
wire [8-1:0] uncon_in1_4;
wire [8-1:0] uncon_in2_4;
wire [8-1:0] uncon_in3_4;
wire [8-1:0] uncon_in4_4;
wire [8-1:0] uncon_in5_4;
wire [8-1:0] uncon_in6_4;
wire [8-1:0] uncon_in7_4;
wire [8-1:0] uncon_in8_4;
wire [8-1:0] uncon_in9_4;
wire [8-1:0] uncon_in1_5;
wire [8-1:0] uncon_in2_5;
wire [8-1:0] uncon_in3_5;
wire [8-1:0] uncon_in4_5;
wire [8-1:0] uncon_in5_5;
wire [8-1:0] uncon_in6_5;
wire [8-1:0] uncon_in7_5;
wire [8-1:0] uncon_in8_5;
wire [8-1:0] uncon_in9_5;
wire [8-1:0] uncon_in1_6;
wire [8-1:0] uncon_in2_6;
wire [8-1:0] uncon_in3_6;
wire [8-1:0] uncon_in4_6;
wire [8-1:0] uncon_in5_6;
wire [8-1:0] uncon_in6_6;
wire [8-1:0] uncon_in7_6;
wire [8-1:0] uncon_in8_6;
wire [8-1:0] uncon_in9_6;
wire [8-1:0] uncon_in1_7;
wire [8-1:0] uncon_in2_7;
wire [8-1:0] uncon_in3_7;
wire [8-1:0] uncon_in4_7;
wire [8-1:0] uncon_in5_7;
wire [8-1:0] uncon_in6_7;
wire [8-1:0] uncon_in7_7;
wire [8-1:0] uncon_in8_7;
wire [8-1:0] uncon_in9_7;
wire [8-1:0] uncon_in1_8;
wire [8-1:0] uncon_in2_8;
wire [8-1:0] uncon_in3_8;
wire [8-1:0] uncon_in4_8;
wire [8-1:0] uncon_in5_8;
wire [8-1:0] uncon_in6_8;
wire [8-1:0] uncon_in7_8;
wire [8-1:0] uncon_in8_8;
wire [8-1:0] uncon_in9_8;
wire [8-1:0] uncon_in1_9;
wire [8-1:0] uncon_in2_9;
wire [8-1:0] uncon_in3_9;
wire [8-1:0] uncon_in4_9;
wire [8-1:0] uncon_in5_9;
wire [8-1:0] uncon_in6_9;
wire [8-1:0] uncon_in7_9;
wire [8-1:0] uncon_in8_9;
wire [8-1:0] uncon_in9_9;

assign A_in1_0 = {uncon_in1_0, A_out0_0[31:0]};
assign A_in2_0 = {uncon_in2_0, A_out1_0[31:0]};
assign A_in3_0 = {uncon_in3_0, A_out2_0[31:0]};
assign A_in4_0 = {uncon_in4_0, A_out3_0[31:0]};
assign A_in5_0 = {uncon_in5_0, A_out4_0[31:0]};
assign A_in6_0 = {uncon_in6_0, A_out5_0[31:0]};
assign A_in7_0 = {uncon_in7_0, A_out6_0[31:0]};
assign A_in8_0 = {uncon_in8_0, A_out7_0[31:0]};
assign A_in9_0 = {uncon_in9_0, A_out8_0[31:0]};
assign A_in1_1 = {uncon_in1_1, A_out0_1[31:0]};
assign A_in2_1 = {uncon_in2_1, A_out1_1[31:0]};
assign A_in3_1 = {uncon_in3_1, A_out2_1[31:0]};
assign A_in4_1 = {uncon_in4_1, A_out3_1[31:0]};
assign A_in5_1 = {uncon_in5_1, A_out4_1[31:0]};
assign A_in6_1 = {uncon_in6_1, A_out5_1[31:0]};
assign A_in7_1 = {uncon_in7_1, A_out6_1[31:0]};
assign A_in8_1 = {uncon_in8_1, A_out7_1[31:0]};
assign A_in9_1 = {uncon_in9_1, A_out8_1[31:0]};
assign A_in1_2 = {uncon_in1_2, A_out0_2[31:0]};
assign A_in2_2 = {uncon_in2_2, A_out1_2[31:0]};
assign A_in3_2 = {uncon_in3_2, A_out2_2[31:0]};
assign A_in4_2 = {uncon_in4_2, A_out3_2[31:0]};
assign A_in5_2 = {uncon_in5_2, A_out4_2[31:0]};
assign A_in6_2 = {uncon_in6_2, A_out5_2[31:0]};
assign A_in7_2 = {uncon_in7_2, A_out6_2[31:0]};
assign A_in8_2 = {uncon_in8_2, A_out7_2[31:0]};
assign A_in9_2 = {uncon_in9_2, A_out8_2[31:0]};
assign A_in1_3 = {uncon_in1_3, A_out0_3[31:0]};
assign A_in2_3 = {uncon_in2_3, A_out1_3[31:0]};
assign A_in3_3 = {uncon_in3_3, A_out2_3[31:0]};
assign A_in4_3 = {uncon_in4_3, A_out3_3[31:0]};
assign A_in5_3 = {uncon_in5_3, A_out4_3[31:0]};
assign A_in6_3 = {uncon_in6_3, A_out5_3[31:0]};
assign A_in7_3 = {uncon_in7_3, A_out6_3[31:0]};
assign A_in8_3 = {uncon_in8_3, A_out7_3[31:0]};
assign A_in9_3 = {uncon_in9_3, A_out8_3[31:0]};
assign A_in1_4 = {uncon_in1_4, A_out0_4[31:0]};
assign A_in2_4 = {uncon_in2_4, A_out1_4[31:0]};
assign A_in3_4 = {uncon_in3_4, A_out2_4[31:0]};
assign A_in4_4 = {uncon_in4_4, A_out3_4[31:0]};
assign A_in5_4 = {uncon_in5_4, A_out4_4[31:0]};
assign A_in6_4 = {uncon_in6_4, A_out5_4[31:0]};
assign A_in7_4 = {uncon_in7_4, A_out6_4[31:0]};
assign A_in8_4 = {uncon_in8_4, A_out7_4[31:0]};
assign A_in9_4 = {uncon_in9_4, A_out8_4[31:0]};
assign A_in1_5 = {uncon_in1_5, A_out0_5[31:0]};
assign A_in2_5 = {uncon_in2_5, A_out1_5[31:0]};
assign A_in3_5 = {uncon_in3_5, A_out2_5[31:0]};
assign A_in4_5 = {uncon_in4_5, A_out3_5[31:0]};
assign A_in5_5 = {uncon_in5_5, A_out4_5[31:0]};
assign A_in6_5 = {uncon_in6_5, A_out5_5[31:0]};
assign A_in7_5 = {uncon_in7_5, A_out6_5[31:0]};
assign A_in8_5 = {uncon_in8_5, A_out7_5[31:0]};
assign A_in9_5 = {uncon_in9_5, A_out8_5[31:0]};
assign A_in1_6 = {uncon_in1_6, A_out0_6[31:0]};
assign A_in2_6 = {uncon_in2_6, A_out1_6[31:0]};
assign A_in3_6 = {uncon_in3_6, A_out2_6[31:0]};
assign A_in4_6 = {uncon_in4_6, A_out3_6[31:0]};
assign A_in5_6 = {uncon_in5_6, A_out4_6[31:0]};
assign A_in6_6 = {uncon_in6_6, A_out5_6[31:0]};
assign A_in7_6 = {uncon_in7_6, A_out6_6[31:0]};
assign A_in8_6 = {uncon_in8_6, A_out7_6[31:0]};
assign A_in9_6 = {uncon_in9_6, A_out8_6[31:0]};
assign A_in1_7 = {uncon_in1_7, A_out0_7[31:0]};
assign A_in2_7 = {uncon_in2_7, A_out1_7[31:0]};
assign A_in3_7 = {uncon_in3_7, A_out2_7[31:0]};
assign A_in4_7 = {uncon_in4_7, A_out3_7[31:0]};
assign A_in5_7 = {uncon_in5_7, A_out4_7[31:0]};
assign A_in6_7 = {uncon_in6_7, A_out5_7[31:0]};
assign A_in7_7 = {uncon_in7_7, A_out6_7[31:0]};
assign A_in8_7 = {uncon_in8_7, A_out7_7[31:0]};
assign A_in9_7 = {uncon_in9_7, A_out8_7[31:0]};
assign A_in1_8 = {uncon_in1_8, A_out0_8[31:0]};
assign A_in2_8 = {uncon_in2_8, A_out1_8[31:0]};
assign A_in3_8 = {uncon_in3_8, A_out2_8[31:0]};
assign A_in4_8 = {uncon_in4_8, A_out3_8[31:0]};
assign A_in5_8 = {uncon_in5_8, A_out4_8[31:0]};
assign A_in6_8 = {uncon_in6_8, A_out5_8[31:0]};
assign A_in7_8 = {uncon_in7_8, A_out6_8[31:0]};
assign A_in8_8 = {uncon_in8_8, A_out7_8[31:0]};
assign A_in9_8 = {uncon_in9_8, A_out8_8[31:0]};
assign A_in1_9 = {uncon_in1_9, A_out0_9[31:0]};
assign A_in2_9 = {uncon_in2_9, A_out1_9[31:0]};
assign A_in3_9 = {uncon_in3_9, A_out2_9[31:0]};
assign A_in4_9 = {uncon_in4_9, A_out3_9[31:0]};
assign A_in5_9 = {uncon_in5_9, A_out4_9[31:0]};
assign A_in6_9 = {uncon_in6_9, A_out5_9[31:0]};
assign A_in7_9 = {uncon_in7_9, A_out6_9[31:0]};
assign A_in8_9 = {uncon_in8_9, A_out7_9[31:0]};
assign A_in9_9 = {uncon_in9_9, A_out8_9[31:0]};


// vertical connections
wire [10-1:0] B_out0_0_in0_1;
wire [10-1:0] B_out0_1_in0_2;
wire [10-1:0] B_out0_2_in0_3;
wire [10-1:0] B_out0_3_in0_4;
wire [10-1:0] B_out0_4_in0_5;
wire [10-1:0] B_out0_5_in0_6;
wire [10-1:0] B_out0_6_in0_7;
wire [10-1:0] B_out0_7_in0_8;
wire [10-1:0] B_out0_8_in0_9;
wire [10-1:0] B_out1_0_in1_1;
wire [10-1:0] B_out1_1_in1_2;
wire [10-1:0] B_out1_2_in1_3;
wire [10-1:0] B_out1_3_in1_4;
wire [10-1:0] B_out1_4_in1_5;
wire [10-1:0] B_out1_5_in1_6;
wire [10-1:0] B_out1_6_in1_7;
wire [10-1:0] B_out1_7_in1_8;
wire [10-1:0] B_out1_8_in1_9;
wire [10-1:0] B_out2_0_in2_1;
wire [10-1:0] B_out2_1_in2_2;
wire [10-1:0] B_out2_2_in2_3;
wire [10-1:0] B_out2_3_in2_4;
wire [10-1:0] B_out2_4_in2_5;
wire [10-1:0] B_out2_5_in2_6;
wire [10-1:0] B_out2_6_in2_7;
wire [10-1:0] B_out2_7_in2_8;
wire [10-1:0] B_out2_8_in2_9;
wire [10-1:0] B_out3_0_in3_1;
wire [10-1:0] B_out3_1_in3_2;
wire [10-1:0] B_out3_2_in3_3;
wire [10-1:0] B_out3_3_in3_4;
wire [10-1:0] B_out3_4_in3_5;
wire [10-1:0] B_out3_5_in3_6;
wire [10-1:0] B_out3_6_in3_7;
wire [10-1:0] B_out3_7_in3_8;
wire [10-1:0] B_out3_8_in3_9;
wire [10-1:0] B_out4_0_in4_1;
wire [10-1:0] B_out4_1_in4_2;
wire [10-1:0] B_out4_2_in4_3;
wire [10-1:0] B_out4_3_in4_4;
wire [10-1:0] B_out4_4_in4_5;
wire [10-1:0] B_out4_5_in4_6;
wire [10-1:0] B_out4_6_in4_7;
wire [10-1:0] B_out4_7_in4_8;
wire [10-1:0] B_out4_8_in4_9;
wire [10-1:0] B_out5_0_in5_1;
wire [10-1:0] B_out5_1_in5_2;
wire [10-1:0] B_out5_2_in5_3;
wire [10-1:0] B_out5_3_in5_4;
wire [10-1:0] B_out5_4_in5_5;
wire [10-1:0] B_out5_5_in5_6;
wire [10-1:0] B_out5_6_in5_7;
wire [10-1:0] B_out5_7_in5_8;
wire [10-1:0] B_out5_8_in5_9;
wire [10-1:0] B_out6_0_in6_1;
wire [10-1:0] B_out6_1_in6_2;
wire [10-1:0] B_out6_2_in6_3;
wire [10-1:0] B_out6_3_in6_4;
wire [10-1:0] B_out6_4_in6_5;
wire [10-1:0] B_out6_5_in6_6;
wire [10-1:0] B_out6_6_in6_7;
wire [10-1:0] B_out6_7_in6_8;
wire [10-1:0] B_out6_8_in6_9;
wire [10-1:0] B_out7_0_in7_1;
wire [10-1:0] B_out7_1_in7_2;
wire [10-1:0] B_out7_2_in7_3;
wire [10-1:0] B_out7_3_in7_4;
wire [10-1:0] B_out7_4_in7_5;
wire [10-1:0] B_out7_5_in7_6;
wire [10-1:0] B_out7_6_in7_7;
wire [10-1:0] B_out7_7_in7_8;
wire [10-1:0] B_out7_8_in7_9;
wire [10-1:0] B_out8_0_in8_1;
wire [10-1:0] B_out8_1_in8_2;
wire [10-1:0] B_out8_2_in8_3;
wire [10-1:0] B_out8_3_in8_4;
wire [10-1:0] B_out8_4_in8_5;
wire [10-1:0] B_out8_5_in8_6;
wire [10-1:0] B_out8_6_in8_7;
wire [10-1:0] B_out8_7_in8_8;
wire [10-1:0] B_out8_8_in8_9;
wire [10-1:0] B_out9_0_in9_1;
wire [10-1:0] B_out9_1_in9_2;
wire [10-1:0] B_out9_2_in9_3;
wire [10-1:0] B_out9_3_in9_4;
wire [10-1:0] B_out9_4_in9_5;
wire [10-1:0] B_out9_5_in9_6;
wire [10-1:0] B_out9_6_in9_7;
wire [10-1:0] B_out9_7_in9_8;
wire [10-1:0] B_out9_8_in9_9;


// accumulate signal for tiling (generated from control logic)
wire acc_in;


// accumulate_in (unconnected)
wire acc_in0_1;
wire acc_in0_2;
wire acc_in0_3;
wire acc_in0_4;
wire acc_in0_5;
wire acc_in0_6;
wire acc_in0_7;
wire acc_in0_8;
wire acc_in0_9;
wire acc_in1_1;
wire acc_in1_2;
wire acc_in1_3;
wire acc_in1_4;
wire acc_in1_5;
wire acc_in1_6;
wire acc_in1_7;
wire acc_in1_8;
wire acc_in1_9;
wire acc_in2_1;
wire acc_in2_2;
wire acc_in2_3;
wire acc_in2_4;
wire acc_in2_5;
wire acc_in2_6;
wire acc_in2_7;
wire acc_in2_8;
wire acc_in2_9;
wire acc_in3_1;
wire acc_in3_2;
wire acc_in3_3;
wire acc_in3_4;
wire acc_in3_5;
wire acc_in3_6;
wire acc_in3_7;
wire acc_in3_8;
wire acc_in3_9;
wire acc_in4_1;
wire acc_in4_2;
wire acc_in4_3;
wire acc_in4_4;
wire acc_in4_5;
wire acc_in4_6;
wire acc_in4_7;
wire acc_in4_8;
wire acc_in4_9;
wire acc_in5_1;
wire acc_in5_2;
wire acc_in5_3;
wire acc_in5_4;
wire acc_in5_5;
wire acc_in5_6;
wire acc_in5_7;
wire acc_in5_8;
wire acc_in5_9;
wire acc_in6_1;
wire acc_in6_2;
wire acc_in6_3;
wire acc_in6_4;
wire acc_in6_5;
wire acc_in6_6;
wire acc_in6_7;
wire acc_in6_8;
wire acc_in6_9;
wire acc_in7_1;
wire acc_in7_2;
wire acc_in7_3;
wire acc_in7_4;
wire acc_in7_5;
wire acc_in7_6;
wire acc_in7_7;
wire acc_in7_8;
wire acc_in7_9;
wire acc_in8_1;
wire acc_in8_2;
wire acc_in8_3;
wire acc_in8_4;
wire acc_in8_5;
wire acc_in8_6;
wire acc_in8_7;
wire acc_in8_8;
wire acc_in8_9;
wire acc_in9_1;
wire acc_in9_2;
wire acc_in9_3;
wire acc_in9_4;
wire acc_in9_5;
wire acc_in9_6;
wire acc_in9_7;
wire acc_in9_8;
wire acc_in9_9;


// accumulate_out connections (row-wise, x-direction)
wire acc_out0_0_acc_in1_0;
wire acc_out1_0_acc_in2_0;
wire acc_out2_0_acc_in3_0;
wire acc_out3_0_acc_in4_0;
wire acc_out4_0_acc_in5_0;
wire acc_out5_0_acc_in6_0;
wire acc_out6_0_acc_in7_0;
wire acc_out7_0_acc_in8_0;
wire acc_out8_0_acc_in9_0;


// Ay
A0_input_mem_control_logic #(.mwidth(32), .addr_width(`A_cnt_width), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 A0 (.clk(clk), .reset(reset), .enable(enable), .data_out(A0_data), .accumulate_out(acc_in));

Ay_input_mem_control_logic #(.mwidth(32), .addr_width(`A_cnt_width), .start_cnt_bits(2), .start_val(3), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 A1 (.clk(clk), .reset(reset), .enable(enable), .data_out(A1_data));

Ay_input_mem_control_logic #(.mwidth(32), .addr_width(`A_cnt_width), .start_cnt_bits(3), .start_val(7), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 A2 (.clk(clk), .reset(reset), .enable(enable), .data_out(A2_data));

Ay_input_mem_control_logic #(.mwidth(32), .addr_width(`A_cnt_width), .start_cnt_bits(4), .start_val(11), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 A3 (.clk(clk), .reset(reset), .enable(enable), .data_out(A3_data));

Ay_input_mem_control_logic #(.mwidth(32), .addr_width(`A_cnt_width), .start_cnt_bits(4), .start_val(15), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 A4 (.clk(clk), .reset(reset), .enable(enable), .data_out(A4_data));

Ay_input_mem_control_logic #(.mwidth(32), .addr_width(`A_cnt_width), .start_cnt_bits(5), .start_val(19), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 A5 (.clk(clk), .reset(reset), .enable(enable), .data_out(A5_data));

Ay_input_mem_control_logic #(.mwidth(32), .addr_width(`A_cnt_width), .start_cnt_bits(5), .start_val(23), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 A6 (.clk(clk), .reset(reset), .enable(enable), .data_out(A6_data));

Ay_input_mem_control_logic #(.mwidth(32), .addr_width(`A_cnt_width), .start_cnt_bits(5), .start_val(27), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 A7 (.clk(clk), .reset(reset), .enable(enable), .data_out(A7_data));

Ay_input_mem_control_logic #(.mwidth(32), .addr_width(`A_cnt_width), .start_cnt_bits(5), .start_val(31), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 A8 (.clk(clk), .reset(reset), .enable(enable), .data_out(A8_data));

Ay_input_mem_control_logic #(.mwidth(32), .addr_width(`A_cnt_width), .start_cnt_bits(6), .start_val(35), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 A9 (.clk(clk), .reset(reset), .enable(enable), .data_out(A9_data));

// Bx
B0_input_mem_control_logic #(.mwidth(32), .addr_width(`B_cnt_width), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits)) 
					 B0 (.clk(clk), .reset(reset), .enable(enable), .data_out(B0_data));

Bx_input_mem_control_logic #(.mwidth(32), .addr_width(`B_cnt_width), .start_cnt_bits(2), .start_val(3), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 B1 (.clk(clk), .reset(reset), .enable(enable), .data_out(B1_data));

Bx_input_mem_control_logic #(.mwidth(32), .addr_width(`B_cnt_width), .start_cnt_bits(3), .start_val(7), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 B2 (.clk(clk), .reset(reset), .enable(enable), .data_out(B2_data));

Bx_input_mem_control_logic #(.mwidth(32), .addr_width(`B_cnt_width), .start_cnt_bits(4), .start_val(11), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 B3 (.clk(clk), .reset(reset), .enable(enable), .data_out(B3_data));

Bx_input_mem_control_logic #(.mwidth(32), .addr_width(`B_cnt_width), .start_cnt_bits(4), .start_val(15), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 B4 (.clk(clk), .reset(reset), .enable(enable), .data_out(B4_data));

Bx_input_mem_control_logic #(.mwidth(32), .addr_width(`B_cnt_width), .start_cnt_bits(5), .start_val(19), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 B5 (.clk(clk), .reset(reset), .enable(enable), .data_out(B5_data));

Bx_input_mem_control_logic #(.mwidth(32), .addr_width(`B_cnt_width), .start_cnt_bits(5), .start_val(23), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 B6 (.clk(clk), .reset(reset), .enable(enable), .data_out(B6_data));

Bx_input_mem_control_logic #(.mwidth(32), .addr_width(`B_cnt_width), .start_cnt_bits(5), .start_val(27), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 B7 (.clk(clk), .reset(reset), .enable(enable), .data_out(B7_data));

Bx_input_mem_control_logic #(.mwidth(32), .addr_width(`B_cnt_width), .start_cnt_bits(5), .start_val(31), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 B8 (.clk(clk), .reset(reset), .enable(enable), .data_out(B8_data));

Bx_input_mem_control_logic #(.mwidth(32), .addr_width(`B_cnt_width), .start_cnt_bits(6), .start_val(35), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 B9 (.clk(clk), .reset(reset), .enable(enable), .data_out(B9_data));


// TS_xy
sparse_dense_init TS_0_0 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in0_0), .b_data(B_in0_0), .a_data_out(A_out0_0), .c_data(C0_0_data),
						 .accumulate_out(acc_out0_0_acc_in1_0), .valid_out(valid_out0_0), .b_ded_out(B_out0_0_in0_1));

sparse_dense_middle TS_0_1 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in0_1), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in0_1), .a_data_out(A_out0_1), .c_data(C0_1_data), .accumulate_out(), .valid_out(valid_out0_1),
						 .b_ded_in(B_out0_0_in0_1), .b_ded_out(B_out0_1_in0_2));

sparse_dense_middle TS_0_2 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in0_2), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in0_2), .a_data_out(A_out0_2), .c_data(C0_2_data), .accumulate_out(), .valid_out(valid_out0_2),
						 .b_ded_in(B_out0_1_in0_2), .b_ded_out(B_out0_2_in0_3));

sparse_dense_middle TS_0_3 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in0_3), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in0_3), .a_data_out(A_out0_3), .c_data(C0_3_data), .accumulate_out(), .valid_out(valid_out0_3),
						 .b_ded_in(B_out0_2_in0_3), .b_ded_out(B_out0_3_in0_4));

sparse_dense_middle TS_0_4 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in0_4), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in0_4), .a_data_out(A_out0_4), .c_data(C0_4_data), .accumulate_out(), .valid_out(valid_out0_4),
						 .b_ded_in(B_out0_3_in0_4), .b_ded_out(B_out0_4_in0_5));

sparse_dense_middle TS_0_5 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in0_5), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in0_5), .a_data_out(A_out0_5), .c_data(C0_5_data), .accumulate_out(), .valid_out(valid_out0_5),
						 .b_ded_in(B_out0_4_in0_5), .b_ded_out(B_out0_5_in0_6));

sparse_dense_middle TS_0_6 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in0_6), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in0_6), .a_data_out(A_out0_6), .c_data(C0_6_data), .accumulate_out(), .valid_out(valid_out0_6),
						 .b_ded_in(B_out0_5_in0_6), .b_ded_out(B_out0_6_in0_7));

sparse_dense_middle TS_0_7 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in0_7), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in0_7), .a_data_out(A_out0_7), .c_data(C0_7_data), .accumulate_out(), .valid_out(valid_out0_7),
						 .b_ded_in(B_out0_6_in0_7), .b_ded_out(B_out0_7_in0_8));

sparse_dense_middle TS_0_8 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in0_8), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in0_8), .a_data_out(A_out0_8), .c_data(C0_8_data), .accumulate_out(), .valid_out(valid_out0_8),
						 .b_ded_in(B_out0_7_in0_8), .b_ded_out(B_out0_8_in0_9));

sparse_dense_last TS_0_9 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in0_9), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in0_9), .a_data_out(A_out0_9), .c_data(C0_9_data), .accumulate_out(),
						 .valid_out(valid_out0_9), .b_ded_in(B_out0_8_in0_9));

sparse_dense_init TS_1_0 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_out0_0_acc_in1_0), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in1_0), .b_data(B_in1_0), .a_data_out(A_out1_0), .c_data(C1_0_data),
						 .accumulate_out(acc_out1_0_acc_in2_0), .valid_out(valid_out1_0), .b_ded_out(B_out1_0_in1_1));

sparse_dense_middle TS_1_1 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in1_1), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in1_1), .a_data_out(A_out1_1), .c_data(C1_1_data), .accumulate_out(), .valid_out(valid_out1_1),
						 .b_ded_in(B_out1_0_in1_1), .b_ded_out(B_out1_1_in1_2));

sparse_dense_middle TS_1_2 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in1_2), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in1_2), .a_data_out(A_out1_2), .c_data(C1_2_data), .accumulate_out(), .valid_out(valid_out1_2),
						 .b_ded_in(B_out1_1_in1_2), .b_ded_out(B_out1_2_in1_3));

sparse_dense_middle TS_1_3 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in1_3), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in1_3), .a_data_out(A_out1_3), .c_data(C1_3_data), .accumulate_out(), .valid_out(valid_out1_3),
						 .b_ded_in(B_out1_2_in1_3), .b_ded_out(B_out1_3_in1_4));

sparse_dense_middle TS_1_4 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in1_4), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in1_4), .a_data_out(A_out1_4), .c_data(C1_4_data), .accumulate_out(), .valid_out(valid_out1_4),
						 .b_ded_in(B_out1_3_in1_4), .b_ded_out(B_out1_4_in1_5));

sparse_dense_middle TS_1_5 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in1_5), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in1_5), .a_data_out(A_out1_5), .c_data(C1_5_data), .accumulate_out(), .valid_out(valid_out1_5),
						 .b_ded_in(B_out1_4_in1_5), .b_ded_out(B_out1_5_in1_6));

sparse_dense_middle TS_1_6 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in1_6), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in1_6), .a_data_out(A_out1_6), .c_data(C1_6_data), .accumulate_out(), .valid_out(valid_out1_6),
						 .b_ded_in(B_out1_5_in1_6), .b_ded_out(B_out1_6_in1_7));

sparse_dense_middle TS_1_7 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in1_7), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in1_7), .a_data_out(A_out1_7), .c_data(C1_7_data), .accumulate_out(), .valid_out(valid_out1_7),
						 .b_ded_in(B_out1_6_in1_7), .b_ded_out(B_out1_7_in1_8));

sparse_dense_middle TS_1_8 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in1_8), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in1_8), .a_data_out(A_out1_8), .c_data(C1_8_data), .accumulate_out(), .valid_out(valid_out1_8),
						 .b_ded_in(B_out1_7_in1_8), .b_ded_out(B_out1_8_in1_9));

sparse_dense_last TS_1_9 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in1_9), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in1_9), .a_data_out(A_out1_9), .c_data(C1_9_data), .accumulate_out(),
						 .valid_out(valid_out1_9), .b_ded_in(B_out1_8_in1_9));

sparse_dense_init TS_2_0 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_out1_0_acc_in2_0), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in2_0), .b_data(B_in2_0), .a_data_out(A_out2_0), .c_data(C2_0_data),
						 .accumulate_out(acc_out2_0_acc_in3_0), .valid_out(valid_out2_0), .b_ded_out(B_out2_0_in2_1));

sparse_dense_middle TS_2_1 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in2_1), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in2_1), .a_data_out(A_out2_1), .c_data(C2_1_data), .accumulate_out(), .valid_out(valid_out2_1),
						 .b_ded_in(B_out2_0_in2_1), .b_ded_out(B_out2_1_in2_2));

sparse_dense_middle TS_2_2 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in2_2), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in2_2), .a_data_out(A_out2_2), .c_data(C2_2_data), .accumulate_out(), .valid_out(valid_out2_2),
						 .b_ded_in(B_out2_1_in2_2), .b_ded_out(B_out2_2_in2_3));

sparse_dense_middle TS_2_3 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in2_3), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in2_3), .a_data_out(A_out2_3), .c_data(C2_3_data), .accumulate_out(), .valid_out(valid_out2_3),
						 .b_ded_in(B_out2_2_in2_3), .b_ded_out(B_out2_3_in2_4));

sparse_dense_middle TS_2_4 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in2_4), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in2_4), .a_data_out(A_out2_4), .c_data(C2_4_data), .accumulate_out(), .valid_out(valid_out2_4),
						 .b_ded_in(B_out2_3_in2_4), .b_ded_out(B_out2_4_in2_5));

sparse_dense_middle TS_2_5 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in2_5), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in2_5), .a_data_out(A_out2_5), .c_data(C2_5_data), .accumulate_out(), .valid_out(valid_out2_5),
						 .b_ded_in(B_out2_4_in2_5), .b_ded_out(B_out2_5_in2_6));

sparse_dense_middle TS_2_6 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in2_6), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in2_6), .a_data_out(A_out2_6), .c_data(C2_6_data), .accumulate_out(), .valid_out(valid_out2_6),
						 .b_ded_in(B_out2_5_in2_6), .b_ded_out(B_out2_6_in2_7));

sparse_dense_middle TS_2_7 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in2_7), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in2_7), .a_data_out(A_out2_7), .c_data(C2_7_data), .accumulate_out(), .valid_out(valid_out2_7),
						 .b_ded_in(B_out2_6_in2_7), .b_ded_out(B_out2_7_in2_8));

sparse_dense_middle TS_2_8 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in2_8), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in2_8), .a_data_out(A_out2_8), .c_data(C2_8_data), .accumulate_out(), .valid_out(valid_out2_8),
						 .b_ded_in(B_out2_7_in2_8), .b_ded_out(B_out2_8_in2_9));

sparse_dense_last TS_2_9 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in2_9), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in2_9), .a_data_out(A_out2_9), .c_data(C2_9_data), .accumulate_out(),
						 .valid_out(valid_out2_9), .b_ded_in(B_out2_8_in2_9));

sparse_dense_init TS_3_0 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_out2_0_acc_in3_0), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in3_0), .b_data(B_in3_0), .a_data_out(A_out3_0), .c_data(C3_0_data),
						 .accumulate_out(acc_out3_0_acc_in4_0), .valid_out(valid_out3_0), .b_ded_out(B_out3_0_in3_1));

sparse_dense_middle TS_3_1 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in3_1), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in3_1), .a_data_out(A_out3_1), .c_data(C3_1_data), .accumulate_out(), .valid_out(valid_out3_1),
						 .b_ded_in(B_out3_0_in3_1), .b_ded_out(B_out3_1_in3_2));

sparse_dense_middle TS_3_2 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in3_2), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in3_2), .a_data_out(A_out3_2), .c_data(C3_2_data), .accumulate_out(), .valid_out(valid_out3_2),
						 .b_ded_in(B_out3_1_in3_2), .b_ded_out(B_out3_2_in3_3));

sparse_dense_middle TS_3_3 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in3_3), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in3_3), .a_data_out(A_out3_3), .c_data(C3_3_data), .accumulate_out(), .valid_out(valid_out3_3),
						 .b_ded_in(B_out3_2_in3_3), .b_ded_out(B_out3_3_in3_4));

sparse_dense_middle TS_3_4 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in3_4), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in3_4), .a_data_out(A_out3_4), .c_data(C3_4_data), .accumulate_out(), .valid_out(valid_out3_4),
						 .b_ded_in(B_out3_3_in3_4), .b_ded_out(B_out3_4_in3_5));

sparse_dense_middle TS_3_5 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in3_5), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in3_5), .a_data_out(A_out3_5), .c_data(C3_5_data), .accumulate_out(), .valid_out(valid_out3_5),
						 .b_ded_in(B_out3_4_in3_5), .b_ded_out(B_out3_5_in3_6));

sparse_dense_middle TS_3_6 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in3_6), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in3_6), .a_data_out(A_out3_6), .c_data(C3_6_data), .accumulate_out(), .valid_out(valid_out3_6),
						 .b_ded_in(B_out3_5_in3_6), .b_ded_out(B_out3_6_in3_7));

sparse_dense_middle TS_3_7 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in3_7), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in3_7), .a_data_out(A_out3_7), .c_data(C3_7_data), .accumulate_out(), .valid_out(valid_out3_7),
						 .b_ded_in(B_out3_6_in3_7), .b_ded_out(B_out3_7_in3_8));

sparse_dense_middle TS_3_8 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in3_8), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in3_8), .a_data_out(A_out3_8), .c_data(C3_8_data), .accumulate_out(), .valid_out(valid_out3_8),
						 .b_ded_in(B_out3_7_in3_8), .b_ded_out(B_out3_8_in3_9));

sparse_dense_last TS_3_9 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in3_9), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in3_9), .a_data_out(A_out3_9), .c_data(C3_9_data), .accumulate_out(),
						 .valid_out(valid_out3_9), .b_ded_in(B_out3_8_in3_9));

sparse_dense_init TS_4_0 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_out3_0_acc_in4_0), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in4_0), .b_data(B_in4_0), .a_data_out(A_out4_0), .c_data(C4_0_data),
						 .accumulate_out(acc_out4_0_acc_in5_0), .valid_out(valid_out4_0), .b_ded_out(B_out4_0_in4_1));

sparse_dense_middle TS_4_1 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in4_1), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in4_1), .a_data_out(A_out4_1), .c_data(C4_1_data), .accumulate_out(), .valid_out(valid_out4_1),
						 .b_ded_in(B_out4_0_in4_1), .b_ded_out(B_out4_1_in4_2));

sparse_dense_middle TS_4_2 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in4_2), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in4_2), .a_data_out(A_out4_2), .c_data(C4_2_data), .accumulate_out(), .valid_out(valid_out4_2),
						 .b_ded_in(B_out4_1_in4_2), .b_ded_out(B_out4_2_in4_3));

sparse_dense_middle TS_4_3 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in4_3), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in4_3), .a_data_out(A_out4_3), .c_data(C4_3_data), .accumulate_out(), .valid_out(valid_out4_3),
						 .b_ded_in(B_out4_2_in4_3), .b_ded_out(B_out4_3_in4_4));

sparse_dense_middle TS_4_4 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in4_4), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in4_4), .a_data_out(A_out4_4), .c_data(C4_4_data), .accumulate_out(), .valid_out(valid_out4_4),
						 .b_ded_in(B_out4_3_in4_4), .b_ded_out(B_out4_4_in4_5));

sparse_dense_middle TS_4_5 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in4_5), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in4_5), .a_data_out(A_out4_5), .c_data(C4_5_data), .accumulate_out(), .valid_out(valid_out4_5),
						 .b_ded_in(B_out4_4_in4_5), .b_ded_out(B_out4_5_in4_6));

sparse_dense_middle TS_4_6 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in4_6), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in4_6), .a_data_out(A_out4_6), .c_data(C4_6_data), .accumulate_out(), .valid_out(valid_out4_6),
						 .b_ded_in(B_out4_5_in4_6), .b_ded_out(B_out4_6_in4_7));

sparse_dense_middle TS_4_7 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in4_7), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in4_7), .a_data_out(A_out4_7), .c_data(C4_7_data), .accumulate_out(), .valid_out(valid_out4_7),
						 .b_ded_in(B_out4_6_in4_7), .b_ded_out(B_out4_7_in4_8));

sparse_dense_middle TS_4_8 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in4_8), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in4_8), .a_data_out(A_out4_8), .c_data(C4_8_data), .accumulate_out(), .valid_out(valid_out4_8),
						 .b_ded_in(B_out4_7_in4_8), .b_ded_out(B_out4_8_in4_9));

sparse_dense_last TS_4_9 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in4_9), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in4_9), .a_data_out(A_out4_9), .c_data(C4_9_data), .accumulate_out(),
						 .valid_out(valid_out4_9), .b_ded_in(B_out4_8_in4_9));

sparse_dense_init TS_5_0 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_out4_0_acc_in5_0), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in5_0), .b_data(B_in5_0), .a_data_out(A_out5_0), .c_data(C5_0_data),
						 .accumulate_out(acc_out5_0_acc_in6_0), .valid_out(valid_out5_0), .b_ded_out(B_out5_0_in5_1));

sparse_dense_middle TS_5_1 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in5_1), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in5_1), .a_data_out(A_out5_1), .c_data(C5_1_data), .accumulate_out(), .valid_out(valid_out5_1),
						 .b_ded_in(B_out5_0_in5_1), .b_ded_out(B_out5_1_in5_2));

sparse_dense_middle TS_5_2 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in5_2), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in5_2), .a_data_out(A_out5_2), .c_data(C5_2_data), .accumulate_out(), .valid_out(valid_out5_2),
						 .b_ded_in(B_out5_1_in5_2), .b_ded_out(B_out5_2_in5_3));

sparse_dense_middle TS_5_3 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in5_3), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in5_3), .a_data_out(A_out5_3), .c_data(C5_3_data), .accumulate_out(), .valid_out(valid_out5_3),
						 .b_ded_in(B_out5_2_in5_3), .b_ded_out(B_out5_3_in5_4));

sparse_dense_middle TS_5_4 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in5_4), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in5_4), .a_data_out(A_out5_4), .c_data(C5_4_data), .accumulate_out(), .valid_out(valid_out5_4),
						 .b_ded_in(B_out5_3_in5_4), .b_ded_out(B_out5_4_in5_5));

sparse_dense_middle TS_5_5 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in5_5), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in5_5), .a_data_out(A_out5_5), .c_data(C5_5_data), .accumulate_out(), .valid_out(valid_out5_5),
						 .b_ded_in(B_out5_4_in5_5), .b_ded_out(B_out5_5_in5_6));

sparse_dense_middle TS_5_6 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in5_6), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in5_6), .a_data_out(A_out5_6), .c_data(C5_6_data), .accumulate_out(), .valid_out(valid_out5_6),
						 .b_ded_in(B_out5_5_in5_6), .b_ded_out(B_out5_6_in5_7));

sparse_dense_middle TS_5_7 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in5_7), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in5_7), .a_data_out(A_out5_7), .c_data(C5_7_data), .accumulate_out(), .valid_out(valid_out5_7),
						 .b_ded_in(B_out5_6_in5_7), .b_ded_out(B_out5_7_in5_8));

sparse_dense_middle TS_5_8 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in5_8), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in5_8), .a_data_out(A_out5_8), .c_data(C5_8_data), .accumulate_out(), .valid_out(valid_out5_8),
						 .b_ded_in(B_out5_7_in5_8), .b_ded_out(B_out5_8_in5_9));

sparse_dense_last TS_5_9 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in5_9), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in5_9), .a_data_out(A_out5_9), .c_data(C5_9_data), .accumulate_out(),
						 .valid_out(valid_out5_9), .b_ded_in(B_out5_8_in5_9));

sparse_dense_init TS_6_0 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_out5_0_acc_in6_0), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in6_0), .b_data(B_in6_0), .a_data_out(A_out6_0), .c_data(C6_0_data),
						 .accumulate_out(acc_out6_0_acc_in7_0), .valid_out(valid_out6_0), .b_ded_out(B_out6_0_in6_1));

sparse_dense_middle TS_6_1 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in6_1), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in6_1), .a_data_out(A_out6_1), .c_data(C6_1_data), .accumulate_out(), .valid_out(valid_out6_1),
						 .b_ded_in(B_out6_0_in6_1), .b_ded_out(B_out6_1_in6_2));

sparse_dense_middle TS_6_2 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in6_2), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in6_2), .a_data_out(A_out6_2), .c_data(C6_2_data), .accumulate_out(), .valid_out(valid_out6_2),
						 .b_ded_in(B_out6_1_in6_2), .b_ded_out(B_out6_2_in6_3));

sparse_dense_middle TS_6_3 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in6_3), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in6_3), .a_data_out(A_out6_3), .c_data(C6_3_data), .accumulate_out(), .valid_out(valid_out6_3),
						 .b_ded_in(B_out6_2_in6_3), .b_ded_out(B_out6_3_in6_4));

sparse_dense_middle TS_6_4 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in6_4), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in6_4), .a_data_out(A_out6_4), .c_data(C6_4_data), .accumulate_out(), .valid_out(valid_out6_4),
						 .b_ded_in(B_out6_3_in6_4), .b_ded_out(B_out6_4_in6_5));

sparse_dense_middle TS_6_5 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in6_5), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in6_5), .a_data_out(A_out6_5), .c_data(C6_5_data), .accumulate_out(), .valid_out(valid_out6_5),
						 .b_ded_in(B_out6_4_in6_5), .b_ded_out(B_out6_5_in6_6));

sparse_dense_middle TS_6_6 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in6_6), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in6_6), .a_data_out(A_out6_6), .c_data(C6_6_data), .accumulate_out(), .valid_out(valid_out6_6),
						 .b_ded_in(B_out6_5_in6_6), .b_ded_out(B_out6_6_in6_7));

sparse_dense_middle TS_6_7 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in6_7), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in6_7), .a_data_out(A_out6_7), .c_data(C6_7_data), .accumulate_out(), .valid_out(valid_out6_7),
						 .b_ded_in(B_out6_6_in6_7), .b_ded_out(B_out6_7_in6_8));

sparse_dense_middle TS_6_8 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in6_8), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in6_8), .a_data_out(A_out6_8), .c_data(C6_8_data), .accumulate_out(), .valid_out(valid_out6_8),
						 .b_ded_in(B_out6_7_in6_8), .b_ded_out(B_out6_8_in6_9));

sparse_dense_last TS_6_9 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in6_9), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in6_9), .a_data_out(A_out6_9), .c_data(C6_9_data), .accumulate_out(),
						 .valid_out(valid_out6_9), .b_ded_in(B_out6_8_in6_9));

sparse_dense_init TS_7_0 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_out6_0_acc_in7_0), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in7_0), .b_data(B_in7_0), .a_data_out(A_out7_0), .c_data(C7_0_data),
						 .accumulate_out(acc_out7_0_acc_in8_0), .valid_out(valid_out7_0), .b_ded_out(B_out7_0_in7_1));

sparse_dense_middle TS_7_1 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in7_1), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in7_1), .a_data_out(A_out7_1), .c_data(C7_1_data), .accumulate_out(), .valid_out(valid_out7_1),
						 .b_ded_in(B_out7_0_in7_1), .b_ded_out(B_out7_1_in7_2));

sparse_dense_middle TS_7_2 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in7_2), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in7_2), .a_data_out(A_out7_2), .c_data(C7_2_data), .accumulate_out(), .valid_out(valid_out7_2),
						 .b_ded_in(B_out7_1_in7_2), .b_ded_out(B_out7_2_in7_3));

sparse_dense_middle TS_7_3 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in7_3), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in7_3), .a_data_out(A_out7_3), .c_data(C7_3_data), .accumulate_out(), .valid_out(valid_out7_3),
						 .b_ded_in(B_out7_2_in7_3), .b_ded_out(B_out7_3_in7_4));

sparse_dense_middle TS_7_4 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in7_4), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in7_4), .a_data_out(A_out7_4), .c_data(C7_4_data), .accumulate_out(), .valid_out(valid_out7_4),
						 .b_ded_in(B_out7_3_in7_4), .b_ded_out(B_out7_4_in7_5));

sparse_dense_middle TS_7_5 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in7_5), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in7_5), .a_data_out(A_out7_5), .c_data(C7_5_data), .accumulate_out(), .valid_out(valid_out7_5),
						 .b_ded_in(B_out7_4_in7_5), .b_ded_out(B_out7_5_in7_6));

sparse_dense_middle TS_7_6 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in7_6), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in7_6), .a_data_out(A_out7_6), .c_data(C7_6_data), .accumulate_out(), .valid_out(valid_out7_6),
						 .b_ded_in(B_out7_5_in7_6), .b_ded_out(B_out7_6_in7_7));

sparse_dense_middle TS_7_7 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in7_7), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in7_7), .a_data_out(A_out7_7), .c_data(C7_7_data), .accumulate_out(), .valid_out(valid_out7_7),
						 .b_ded_in(B_out7_6_in7_7), .b_ded_out(B_out7_7_in7_8));

sparse_dense_middle TS_7_8 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in7_8), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in7_8), .a_data_out(A_out7_8), .c_data(C7_8_data), .accumulate_out(), .valid_out(valid_out7_8),
						 .b_ded_in(B_out7_7_in7_8), .b_ded_out(B_out7_8_in7_9));

sparse_dense_last TS_7_9 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in7_9), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in7_9), .a_data_out(A_out7_9), .c_data(C7_9_data), .accumulate_out(),
						 .valid_out(valid_out7_9), .b_ded_in(B_out7_8_in7_9));

sparse_dense_init TS_8_0 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_out7_0_acc_in8_0), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in8_0), .b_data(B_in8_0), .a_data_out(A_out8_0), .c_data(C8_0_data),
						 .accumulate_out(acc_out8_0_acc_in9_0), .valid_out(valid_out8_0), .b_ded_out(B_out8_0_in8_1));

sparse_dense_middle TS_8_1 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in8_1), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in8_1), .a_data_out(A_out8_1), .c_data(C8_1_data), .accumulate_out(), .valid_out(valid_out8_1),
						 .b_ded_in(B_out8_0_in8_1), .b_ded_out(B_out8_1_in8_2));

sparse_dense_middle TS_8_2 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in8_2), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in8_2), .a_data_out(A_out8_2), .c_data(C8_2_data), .accumulate_out(), .valid_out(valid_out8_2),
						 .b_ded_in(B_out8_1_in8_2), .b_ded_out(B_out8_2_in8_3));

sparse_dense_middle TS_8_3 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in8_3), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in8_3), .a_data_out(A_out8_3), .c_data(C8_3_data), .accumulate_out(), .valid_out(valid_out8_3),
						 .b_ded_in(B_out8_2_in8_3), .b_ded_out(B_out8_3_in8_4));

sparse_dense_middle TS_8_4 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in8_4), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in8_4), .a_data_out(A_out8_4), .c_data(C8_4_data), .accumulate_out(), .valid_out(valid_out8_4),
						 .b_ded_in(B_out8_3_in8_4), .b_ded_out(B_out8_4_in8_5));

sparse_dense_middle TS_8_5 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in8_5), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in8_5), .a_data_out(A_out8_5), .c_data(C8_5_data), .accumulate_out(), .valid_out(valid_out8_5),
						 .b_ded_in(B_out8_4_in8_5), .b_ded_out(B_out8_5_in8_6));

sparse_dense_middle TS_8_6 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in8_6), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in8_6), .a_data_out(A_out8_6), .c_data(C8_6_data), .accumulate_out(), .valid_out(valid_out8_6),
						 .b_ded_in(B_out8_5_in8_6), .b_ded_out(B_out8_6_in8_7));

sparse_dense_middle TS_8_7 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in8_7), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in8_7), .a_data_out(A_out8_7), .c_data(C8_7_data), .accumulate_out(), .valid_out(valid_out8_7),
						 .b_ded_in(B_out8_6_in8_7), .b_ded_out(B_out8_7_in8_8));

sparse_dense_middle TS_8_8 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in8_8), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in8_8), .a_data_out(A_out8_8), .c_data(C8_8_data), .accumulate_out(), .valid_out(valid_out8_8),
						 .b_ded_in(B_out8_7_in8_8), .b_ded_out(B_out8_8_in8_9));

sparse_dense_last TS_8_9 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in8_9), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in8_9), .a_data_out(A_out8_9), .c_data(C8_9_data), .accumulate_out(),
						 .valid_out(valid_out8_9), .b_ded_in(B_out8_8_in8_9));

sparse_dense_init TS_9_0 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_out8_0_acc_in9_0), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in9_0), .b_data(B_in9_0), .a_data_out(), .c_data(C9_0_data),
						 .accumulate_out(), .valid_out(valid_out9_0), .b_ded_out(B_out9_0_in9_1));

sparse_dense_middle TS_9_1 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in9_1), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in9_1), .a_data_out(), .c_data(C9_1_data), .accumulate_out(), .valid_out(valid_out9_1),
						 .b_ded_in(B_out9_0_in9_1), .b_ded_out(B_out9_1_in9_2));

sparse_dense_middle TS_9_2 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in9_2), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in9_2), .a_data_out(), .c_data(C9_2_data), .accumulate_out(), .valid_out(valid_out9_2),
						 .b_ded_in(B_out9_1_in9_2), .b_ded_out(B_out9_2_in9_3));

sparse_dense_middle TS_9_3 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in9_3), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in9_3), .a_data_out(), .c_data(C9_3_data), .accumulate_out(), .valid_out(valid_out9_3),
						 .b_ded_in(B_out9_2_in9_3), .b_ded_out(B_out9_3_in9_4));

sparse_dense_middle TS_9_4 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in9_4), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in9_4), .a_data_out(), .c_data(C9_4_data), .accumulate_out(), .valid_out(valid_out9_4),
						 .b_ded_in(B_out9_3_in9_4), .b_ded_out(B_out9_4_in9_5));

sparse_dense_middle TS_9_5 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in9_5), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in9_5), .a_data_out(), .c_data(C9_5_data), .accumulate_out(), .valid_out(valid_out9_5),
						 .b_ded_in(B_out9_4_in9_5), .b_ded_out(B_out9_5_in9_6));

sparse_dense_middle TS_9_6 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in9_6), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in9_6), .a_data_out(), .c_data(C9_6_data), .accumulate_out(), .valid_out(valid_out9_6),
						 .b_ded_in(B_out9_5_in9_6), .b_ded_out(B_out9_6_in9_7));

sparse_dense_middle TS_9_7 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in9_7), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in9_7), .a_data_out(), .c_data(C9_7_data), .accumulate_out(), .valid_out(valid_out9_7),
						 .b_ded_in(B_out9_6_in9_7), .b_ded_out(B_out9_7_in9_8));

sparse_dense_middle TS_9_8 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in9_8), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in9_8), .a_data_out(), .c_data(C9_8_data), .accumulate_out(), .valid_out(valid_out9_8),
						 .b_ded_in(B_out9_7_in9_8), .b_ded_out(B_out9_8_in9_9));

sparse_dense_last TS_9_9 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in9_9), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in9_9), .a_data_out(), .c_data(C9_9_data), .accumulate_out(),
						 .valid_out(valid_out9_9), .b_ded_in(B_out9_8_in9_9));


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
						 C0_3 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out0_3),
						 .data_in_0(C0_3_data[31:0]), .data_in_1(C0_3_data[63:32]), .data_in_2(C0_3_data[95:64]), .data_in_3(C0_3_data[127:96]),
						 .data_out_0(C0_3_data_out_mem[31:0]), .data_out_1(C0_3_data_out_mem[63:32]), .data_out_2(C0_3_data_out_mem[95:64]), .data_out_3(C0_3_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C0_4 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out0_4),
						 .data_in_0(C0_4_data[31:0]), .data_in_1(C0_4_data[63:32]), .data_in_2(C0_4_data[95:64]), .data_in_3(C0_4_data[127:96]),
						 .data_out_0(C0_4_data_out_mem[31:0]), .data_out_1(C0_4_data_out_mem[63:32]), .data_out_2(C0_4_data_out_mem[95:64]), .data_out_3(C0_4_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C0_5 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out0_5),
						 .data_in_0(C0_5_data[31:0]), .data_in_1(C0_5_data[63:32]), .data_in_2(C0_5_data[95:64]), .data_in_3(C0_5_data[127:96]),
						 .data_out_0(C0_5_data_out_mem[31:0]), .data_out_1(C0_5_data_out_mem[63:32]), .data_out_2(C0_5_data_out_mem[95:64]), .data_out_3(C0_5_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C0_6 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out0_6),
						 .data_in_0(C0_6_data[31:0]), .data_in_1(C0_6_data[63:32]), .data_in_2(C0_6_data[95:64]), .data_in_3(C0_6_data[127:96]),
						 .data_out_0(C0_6_data_out_mem[31:0]), .data_out_1(C0_6_data_out_mem[63:32]), .data_out_2(C0_6_data_out_mem[95:64]), .data_out_3(C0_6_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C0_7 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out0_7),
						 .data_in_0(C0_7_data[31:0]), .data_in_1(C0_7_data[63:32]), .data_in_2(C0_7_data[95:64]), .data_in_3(C0_7_data[127:96]),
						 .data_out_0(C0_7_data_out_mem[31:0]), .data_out_1(C0_7_data_out_mem[63:32]), .data_out_2(C0_7_data_out_mem[95:64]), .data_out_3(C0_7_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C0_8 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out0_8),
						 .data_in_0(C0_8_data[31:0]), .data_in_1(C0_8_data[63:32]), .data_in_2(C0_8_data[95:64]), .data_in_3(C0_8_data[127:96]),
						 .data_out_0(C0_8_data_out_mem[31:0]), .data_out_1(C0_8_data_out_mem[63:32]), .data_out_2(C0_8_data_out_mem[95:64]), .data_out_3(C0_8_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C0_9 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out0_9),
						 .data_in_0(C0_9_data[31:0]), .data_in_1(C0_9_data[63:32]), .data_in_2(C0_9_data[95:64]), .data_in_3(C0_9_data[127:96]),
						 .data_out_0(C0_9_data_out_mem[31:0]), .data_out_1(C0_9_data_out_mem[63:32]), .data_out_2(C0_9_data_out_mem[95:64]), .data_out_3(C0_9_data_out_mem[127:96]));

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
						 C1_3 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out1_3),
						 .data_in_0(C1_3_data[31:0]), .data_in_1(C1_3_data[63:32]), .data_in_2(C1_3_data[95:64]), .data_in_3(C1_3_data[127:96]),
						 .data_out_0(C1_3_data_out_mem[31:0]), .data_out_1(C1_3_data_out_mem[63:32]), .data_out_2(C1_3_data_out_mem[95:64]), .data_out_3(C1_3_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C1_4 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out1_4),
						 .data_in_0(C1_4_data[31:0]), .data_in_1(C1_4_data[63:32]), .data_in_2(C1_4_data[95:64]), .data_in_3(C1_4_data[127:96]),
						 .data_out_0(C1_4_data_out_mem[31:0]), .data_out_1(C1_4_data_out_mem[63:32]), .data_out_2(C1_4_data_out_mem[95:64]), .data_out_3(C1_4_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C1_5 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out1_5),
						 .data_in_0(C1_5_data[31:0]), .data_in_1(C1_5_data[63:32]), .data_in_2(C1_5_data[95:64]), .data_in_3(C1_5_data[127:96]),
						 .data_out_0(C1_5_data_out_mem[31:0]), .data_out_1(C1_5_data_out_mem[63:32]), .data_out_2(C1_5_data_out_mem[95:64]), .data_out_3(C1_5_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C1_6 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out1_6),
						 .data_in_0(C1_6_data[31:0]), .data_in_1(C1_6_data[63:32]), .data_in_2(C1_6_data[95:64]), .data_in_3(C1_6_data[127:96]),
						 .data_out_0(C1_6_data_out_mem[31:0]), .data_out_1(C1_6_data_out_mem[63:32]), .data_out_2(C1_6_data_out_mem[95:64]), .data_out_3(C1_6_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C1_7 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out1_7),
						 .data_in_0(C1_7_data[31:0]), .data_in_1(C1_7_data[63:32]), .data_in_2(C1_7_data[95:64]), .data_in_3(C1_7_data[127:96]),
						 .data_out_0(C1_7_data_out_mem[31:0]), .data_out_1(C1_7_data_out_mem[63:32]), .data_out_2(C1_7_data_out_mem[95:64]), .data_out_3(C1_7_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C1_8 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out1_8),
						 .data_in_0(C1_8_data[31:0]), .data_in_1(C1_8_data[63:32]), .data_in_2(C1_8_data[95:64]), .data_in_3(C1_8_data[127:96]),
						 .data_out_0(C1_8_data_out_mem[31:0]), .data_out_1(C1_8_data_out_mem[63:32]), .data_out_2(C1_8_data_out_mem[95:64]), .data_out_3(C1_8_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C1_9 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out1_9),
						 .data_in_0(C1_9_data[31:0]), .data_in_1(C1_9_data[63:32]), .data_in_2(C1_9_data[95:64]), .data_in_3(C1_9_data[127:96]),
						 .data_out_0(C1_9_data_out_mem[31:0]), .data_out_1(C1_9_data_out_mem[63:32]), .data_out_2(C1_9_data_out_mem[95:64]), .data_out_3(C1_9_data_out_mem[127:96]));

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

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C2_3 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out2_3),
						 .data_in_0(C2_3_data[31:0]), .data_in_1(C2_3_data[63:32]), .data_in_2(C2_3_data[95:64]), .data_in_3(C2_3_data[127:96]),
						 .data_out_0(C2_3_data_out_mem[31:0]), .data_out_1(C2_3_data_out_mem[63:32]), .data_out_2(C2_3_data_out_mem[95:64]), .data_out_3(C2_3_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C2_4 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out2_4),
						 .data_in_0(C2_4_data[31:0]), .data_in_1(C2_4_data[63:32]), .data_in_2(C2_4_data[95:64]), .data_in_3(C2_4_data[127:96]),
						 .data_out_0(C2_4_data_out_mem[31:0]), .data_out_1(C2_4_data_out_mem[63:32]), .data_out_2(C2_4_data_out_mem[95:64]), .data_out_3(C2_4_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C2_5 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out2_5),
						 .data_in_0(C2_5_data[31:0]), .data_in_1(C2_5_data[63:32]), .data_in_2(C2_5_data[95:64]), .data_in_3(C2_5_data[127:96]),
						 .data_out_0(C2_5_data_out_mem[31:0]), .data_out_1(C2_5_data_out_mem[63:32]), .data_out_2(C2_5_data_out_mem[95:64]), .data_out_3(C2_5_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C2_6 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out2_6),
						 .data_in_0(C2_6_data[31:0]), .data_in_1(C2_6_data[63:32]), .data_in_2(C2_6_data[95:64]), .data_in_3(C2_6_data[127:96]),
						 .data_out_0(C2_6_data_out_mem[31:0]), .data_out_1(C2_6_data_out_mem[63:32]), .data_out_2(C2_6_data_out_mem[95:64]), .data_out_3(C2_6_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C2_7 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out2_7),
						 .data_in_0(C2_7_data[31:0]), .data_in_1(C2_7_data[63:32]), .data_in_2(C2_7_data[95:64]), .data_in_3(C2_7_data[127:96]),
						 .data_out_0(C2_7_data_out_mem[31:0]), .data_out_1(C2_7_data_out_mem[63:32]), .data_out_2(C2_7_data_out_mem[95:64]), .data_out_3(C2_7_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C2_8 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out2_8),
						 .data_in_0(C2_8_data[31:0]), .data_in_1(C2_8_data[63:32]), .data_in_2(C2_8_data[95:64]), .data_in_3(C2_8_data[127:96]),
						 .data_out_0(C2_8_data_out_mem[31:0]), .data_out_1(C2_8_data_out_mem[63:32]), .data_out_2(C2_8_data_out_mem[95:64]), .data_out_3(C2_8_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C2_9 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out2_9),
						 .data_in_0(C2_9_data[31:0]), .data_in_1(C2_9_data[63:32]), .data_in_2(C2_9_data[95:64]), .data_in_3(C2_9_data[127:96]),
						 .data_out_0(C2_9_data_out_mem[31:0]), .data_out_1(C2_9_data_out_mem[63:32]), .data_out_2(C2_9_data_out_mem[95:64]), .data_out_3(C2_9_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C3_0 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out3_0),
						 .data_in_0(C3_0_data[31:0]), .data_in_1(C3_0_data[63:32]), .data_in_2(C3_0_data[95:64]), .data_in_3(C3_0_data[127:96]),
						 .data_out_0(C3_0_data_out_mem[31:0]), .data_out_1(C3_0_data_out_mem[63:32]), .data_out_2(C3_0_data_out_mem[95:64]), .data_out_3(C3_0_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C3_1 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out3_1),
						 .data_in_0(C3_1_data[31:0]), .data_in_1(C3_1_data[63:32]), .data_in_2(C3_1_data[95:64]), .data_in_3(C3_1_data[127:96]),
						 .data_out_0(C3_1_data_out_mem[31:0]), .data_out_1(C3_1_data_out_mem[63:32]), .data_out_2(C3_1_data_out_mem[95:64]), .data_out_3(C3_1_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C3_2 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out3_2),
						 .data_in_0(C3_2_data[31:0]), .data_in_1(C3_2_data[63:32]), .data_in_2(C3_2_data[95:64]), .data_in_3(C3_2_data[127:96]),
						 .data_out_0(C3_2_data_out_mem[31:0]), .data_out_1(C3_2_data_out_mem[63:32]), .data_out_2(C3_2_data_out_mem[95:64]), .data_out_3(C3_2_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C3_3 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out3_3),
						 .data_in_0(C3_3_data[31:0]), .data_in_1(C3_3_data[63:32]), .data_in_2(C3_3_data[95:64]), .data_in_3(C3_3_data[127:96]),
						 .data_out_0(C3_3_data_out_mem[31:0]), .data_out_1(C3_3_data_out_mem[63:32]), .data_out_2(C3_3_data_out_mem[95:64]), .data_out_3(C3_3_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C3_4 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out3_4),
						 .data_in_0(C3_4_data[31:0]), .data_in_1(C3_4_data[63:32]), .data_in_2(C3_4_data[95:64]), .data_in_3(C3_4_data[127:96]),
						 .data_out_0(C3_4_data_out_mem[31:0]), .data_out_1(C3_4_data_out_mem[63:32]), .data_out_2(C3_4_data_out_mem[95:64]), .data_out_3(C3_4_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C3_5 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out3_5),
						 .data_in_0(C3_5_data[31:0]), .data_in_1(C3_5_data[63:32]), .data_in_2(C3_5_data[95:64]), .data_in_3(C3_5_data[127:96]),
						 .data_out_0(C3_5_data_out_mem[31:0]), .data_out_1(C3_5_data_out_mem[63:32]), .data_out_2(C3_5_data_out_mem[95:64]), .data_out_3(C3_5_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C3_6 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out3_6),
						 .data_in_0(C3_6_data[31:0]), .data_in_1(C3_6_data[63:32]), .data_in_2(C3_6_data[95:64]), .data_in_3(C3_6_data[127:96]),
						 .data_out_0(C3_6_data_out_mem[31:0]), .data_out_1(C3_6_data_out_mem[63:32]), .data_out_2(C3_6_data_out_mem[95:64]), .data_out_3(C3_6_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C3_7 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out3_7),
						 .data_in_0(C3_7_data[31:0]), .data_in_1(C3_7_data[63:32]), .data_in_2(C3_7_data[95:64]), .data_in_3(C3_7_data[127:96]),
						 .data_out_0(C3_7_data_out_mem[31:0]), .data_out_1(C3_7_data_out_mem[63:32]), .data_out_2(C3_7_data_out_mem[95:64]), .data_out_3(C3_7_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C3_8 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out3_8),
						 .data_in_0(C3_8_data[31:0]), .data_in_1(C3_8_data[63:32]), .data_in_2(C3_8_data[95:64]), .data_in_3(C3_8_data[127:96]),
						 .data_out_0(C3_8_data_out_mem[31:0]), .data_out_1(C3_8_data_out_mem[63:32]), .data_out_2(C3_8_data_out_mem[95:64]), .data_out_3(C3_8_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C3_9 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out3_9),
						 .data_in_0(C3_9_data[31:0]), .data_in_1(C3_9_data[63:32]), .data_in_2(C3_9_data[95:64]), .data_in_3(C3_9_data[127:96]),
						 .data_out_0(C3_9_data_out_mem[31:0]), .data_out_1(C3_9_data_out_mem[63:32]), .data_out_2(C3_9_data_out_mem[95:64]), .data_out_3(C3_9_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C4_0 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out4_0),
						 .data_in_0(C4_0_data[31:0]), .data_in_1(C4_0_data[63:32]), .data_in_2(C4_0_data[95:64]), .data_in_3(C4_0_data[127:96]),
						 .data_out_0(C4_0_data_out_mem[31:0]), .data_out_1(C4_0_data_out_mem[63:32]), .data_out_2(C4_0_data_out_mem[95:64]), .data_out_3(C4_0_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C4_1 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out4_1),
						 .data_in_0(C4_1_data[31:0]), .data_in_1(C4_1_data[63:32]), .data_in_2(C4_1_data[95:64]), .data_in_3(C4_1_data[127:96]),
						 .data_out_0(C4_1_data_out_mem[31:0]), .data_out_1(C4_1_data_out_mem[63:32]), .data_out_2(C4_1_data_out_mem[95:64]), .data_out_3(C4_1_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C4_2 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out4_2),
						 .data_in_0(C4_2_data[31:0]), .data_in_1(C4_2_data[63:32]), .data_in_2(C4_2_data[95:64]), .data_in_3(C4_2_data[127:96]),
						 .data_out_0(C4_2_data_out_mem[31:0]), .data_out_1(C4_2_data_out_mem[63:32]), .data_out_2(C4_2_data_out_mem[95:64]), .data_out_3(C4_2_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C4_3 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out4_3),
						 .data_in_0(C4_3_data[31:0]), .data_in_1(C4_3_data[63:32]), .data_in_2(C4_3_data[95:64]), .data_in_3(C4_3_data[127:96]),
						 .data_out_0(C4_3_data_out_mem[31:0]), .data_out_1(C4_3_data_out_mem[63:32]), .data_out_2(C4_3_data_out_mem[95:64]), .data_out_3(C4_3_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C4_4 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out4_4),
						 .data_in_0(C4_4_data[31:0]), .data_in_1(C4_4_data[63:32]), .data_in_2(C4_4_data[95:64]), .data_in_3(C4_4_data[127:96]),
						 .data_out_0(C4_4_data_out_mem[31:0]), .data_out_1(C4_4_data_out_mem[63:32]), .data_out_2(C4_4_data_out_mem[95:64]), .data_out_3(C4_4_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C4_5 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out4_5),
						 .data_in_0(C4_5_data[31:0]), .data_in_1(C4_5_data[63:32]), .data_in_2(C4_5_data[95:64]), .data_in_3(C4_5_data[127:96]),
						 .data_out_0(C4_5_data_out_mem[31:0]), .data_out_1(C4_5_data_out_mem[63:32]), .data_out_2(C4_5_data_out_mem[95:64]), .data_out_3(C4_5_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C4_6 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out4_6),
						 .data_in_0(C4_6_data[31:0]), .data_in_1(C4_6_data[63:32]), .data_in_2(C4_6_data[95:64]), .data_in_3(C4_6_data[127:96]),
						 .data_out_0(C4_6_data_out_mem[31:0]), .data_out_1(C4_6_data_out_mem[63:32]), .data_out_2(C4_6_data_out_mem[95:64]), .data_out_3(C4_6_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C4_7 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out4_7),
						 .data_in_0(C4_7_data[31:0]), .data_in_1(C4_7_data[63:32]), .data_in_2(C4_7_data[95:64]), .data_in_3(C4_7_data[127:96]),
						 .data_out_0(C4_7_data_out_mem[31:0]), .data_out_1(C4_7_data_out_mem[63:32]), .data_out_2(C4_7_data_out_mem[95:64]), .data_out_3(C4_7_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C4_8 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out4_8),
						 .data_in_0(C4_8_data[31:0]), .data_in_1(C4_8_data[63:32]), .data_in_2(C4_8_data[95:64]), .data_in_3(C4_8_data[127:96]),
						 .data_out_0(C4_8_data_out_mem[31:0]), .data_out_1(C4_8_data_out_mem[63:32]), .data_out_2(C4_8_data_out_mem[95:64]), .data_out_3(C4_8_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C4_9 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out4_9),
						 .data_in_0(C4_9_data[31:0]), .data_in_1(C4_9_data[63:32]), .data_in_2(C4_9_data[95:64]), .data_in_3(C4_9_data[127:96]),
						 .data_out_0(C4_9_data_out_mem[31:0]), .data_out_1(C4_9_data_out_mem[63:32]), .data_out_2(C4_9_data_out_mem[95:64]), .data_out_3(C4_9_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C5_0 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out5_0),
						 .data_in_0(C5_0_data[31:0]), .data_in_1(C5_0_data[63:32]), .data_in_2(C5_0_data[95:64]), .data_in_3(C5_0_data[127:96]),
						 .data_out_0(C5_0_data_out_mem[31:0]), .data_out_1(C5_0_data_out_mem[63:32]), .data_out_2(C5_0_data_out_mem[95:64]), .data_out_3(C5_0_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C5_1 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out5_1),
						 .data_in_0(C5_1_data[31:0]), .data_in_1(C5_1_data[63:32]), .data_in_2(C5_1_data[95:64]), .data_in_3(C5_1_data[127:96]),
						 .data_out_0(C5_1_data_out_mem[31:0]), .data_out_1(C5_1_data_out_mem[63:32]), .data_out_2(C5_1_data_out_mem[95:64]), .data_out_3(C5_1_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C5_2 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out5_2),
						 .data_in_0(C5_2_data[31:0]), .data_in_1(C5_2_data[63:32]), .data_in_2(C5_2_data[95:64]), .data_in_3(C5_2_data[127:96]),
						 .data_out_0(C5_2_data_out_mem[31:0]), .data_out_1(C5_2_data_out_mem[63:32]), .data_out_2(C5_2_data_out_mem[95:64]), .data_out_3(C5_2_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C5_3 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out5_3),
						 .data_in_0(C5_3_data[31:0]), .data_in_1(C5_3_data[63:32]), .data_in_2(C5_3_data[95:64]), .data_in_3(C5_3_data[127:96]),
						 .data_out_0(C5_3_data_out_mem[31:0]), .data_out_1(C5_3_data_out_mem[63:32]), .data_out_2(C5_3_data_out_mem[95:64]), .data_out_3(C5_3_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C5_4 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out5_4),
						 .data_in_0(C5_4_data[31:0]), .data_in_1(C5_4_data[63:32]), .data_in_2(C5_4_data[95:64]), .data_in_3(C5_4_data[127:96]),
						 .data_out_0(C5_4_data_out_mem[31:0]), .data_out_1(C5_4_data_out_mem[63:32]), .data_out_2(C5_4_data_out_mem[95:64]), .data_out_3(C5_4_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C5_5 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out5_5),
						 .data_in_0(C5_5_data[31:0]), .data_in_1(C5_5_data[63:32]), .data_in_2(C5_5_data[95:64]), .data_in_3(C5_5_data[127:96]),
						 .data_out_0(C5_5_data_out_mem[31:0]), .data_out_1(C5_5_data_out_mem[63:32]), .data_out_2(C5_5_data_out_mem[95:64]), .data_out_3(C5_5_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C5_6 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out5_6),
						 .data_in_0(C5_6_data[31:0]), .data_in_1(C5_6_data[63:32]), .data_in_2(C5_6_data[95:64]), .data_in_3(C5_6_data[127:96]),
						 .data_out_0(C5_6_data_out_mem[31:0]), .data_out_1(C5_6_data_out_mem[63:32]), .data_out_2(C5_6_data_out_mem[95:64]), .data_out_3(C5_6_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C5_7 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out5_7),
						 .data_in_0(C5_7_data[31:0]), .data_in_1(C5_7_data[63:32]), .data_in_2(C5_7_data[95:64]), .data_in_3(C5_7_data[127:96]),
						 .data_out_0(C5_7_data_out_mem[31:0]), .data_out_1(C5_7_data_out_mem[63:32]), .data_out_2(C5_7_data_out_mem[95:64]), .data_out_3(C5_7_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C5_8 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out5_8),
						 .data_in_0(C5_8_data[31:0]), .data_in_1(C5_8_data[63:32]), .data_in_2(C5_8_data[95:64]), .data_in_3(C5_8_data[127:96]),
						 .data_out_0(C5_8_data_out_mem[31:0]), .data_out_1(C5_8_data_out_mem[63:32]), .data_out_2(C5_8_data_out_mem[95:64]), .data_out_3(C5_8_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C5_9 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out5_9),
						 .data_in_0(C5_9_data[31:0]), .data_in_1(C5_9_data[63:32]), .data_in_2(C5_9_data[95:64]), .data_in_3(C5_9_data[127:96]),
						 .data_out_0(C5_9_data_out_mem[31:0]), .data_out_1(C5_9_data_out_mem[63:32]), .data_out_2(C5_9_data_out_mem[95:64]), .data_out_3(C5_9_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C6_0 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out6_0),
						 .data_in_0(C6_0_data[31:0]), .data_in_1(C6_0_data[63:32]), .data_in_2(C6_0_data[95:64]), .data_in_3(C6_0_data[127:96]),
						 .data_out_0(C6_0_data_out_mem[31:0]), .data_out_1(C6_0_data_out_mem[63:32]), .data_out_2(C6_0_data_out_mem[95:64]), .data_out_3(C6_0_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C6_1 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out6_1),
						 .data_in_0(C6_1_data[31:0]), .data_in_1(C6_1_data[63:32]), .data_in_2(C6_1_data[95:64]), .data_in_3(C6_1_data[127:96]),
						 .data_out_0(C6_1_data_out_mem[31:0]), .data_out_1(C6_1_data_out_mem[63:32]), .data_out_2(C6_1_data_out_mem[95:64]), .data_out_3(C6_1_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C6_2 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out6_2),
						 .data_in_0(C6_2_data[31:0]), .data_in_1(C6_2_data[63:32]), .data_in_2(C6_2_data[95:64]), .data_in_3(C6_2_data[127:96]),
						 .data_out_0(C6_2_data_out_mem[31:0]), .data_out_1(C6_2_data_out_mem[63:32]), .data_out_2(C6_2_data_out_mem[95:64]), .data_out_3(C6_2_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C6_3 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out6_3),
						 .data_in_0(C6_3_data[31:0]), .data_in_1(C6_3_data[63:32]), .data_in_2(C6_3_data[95:64]), .data_in_3(C6_3_data[127:96]),
						 .data_out_0(C6_3_data_out_mem[31:0]), .data_out_1(C6_3_data_out_mem[63:32]), .data_out_2(C6_3_data_out_mem[95:64]), .data_out_3(C6_3_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C6_4 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out6_4),
						 .data_in_0(C6_4_data[31:0]), .data_in_1(C6_4_data[63:32]), .data_in_2(C6_4_data[95:64]), .data_in_3(C6_4_data[127:96]),
						 .data_out_0(C6_4_data_out_mem[31:0]), .data_out_1(C6_4_data_out_mem[63:32]), .data_out_2(C6_4_data_out_mem[95:64]), .data_out_3(C6_4_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C6_5 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out6_5),
						 .data_in_0(C6_5_data[31:0]), .data_in_1(C6_5_data[63:32]), .data_in_2(C6_5_data[95:64]), .data_in_3(C6_5_data[127:96]),
						 .data_out_0(C6_5_data_out_mem[31:0]), .data_out_1(C6_5_data_out_mem[63:32]), .data_out_2(C6_5_data_out_mem[95:64]), .data_out_3(C6_5_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C6_6 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out6_6),
						 .data_in_0(C6_6_data[31:0]), .data_in_1(C6_6_data[63:32]), .data_in_2(C6_6_data[95:64]), .data_in_3(C6_6_data[127:96]),
						 .data_out_0(C6_6_data_out_mem[31:0]), .data_out_1(C6_6_data_out_mem[63:32]), .data_out_2(C6_6_data_out_mem[95:64]), .data_out_3(C6_6_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C6_7 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out6_7),
						 .data_in_0(C6_7_data[31:0]), .data_in_1(C6_7_data[63:32]), .data_in_2(C6_7_data[95:64]), .data_in_3(C6_7_data[127:96]),
						 .data_out_0(C6_7_data_out_mem[31:0]), .data_out_1(C6_7_data_out_mem[63:32]), .data_out_2(C6_7_data_out_mem[95:64]), .data_out_3(C6_7_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C6_8 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out6_8),
						 .data_in_0(C6_8_data[31:0]), .data_in_1(C6_8_data[63:32]), .data_in_2(C6_8_data[95:64]), .data_in_3(C6_8_data[127:96]),
						 .data_out_0(C6_8_data_out_mem[31:0]), .data_out_1(C6_8_data_out_mem[63:32]), .data_out_2(C6_8_data_out_mem[95:64]), .data_out_3(C6_8_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C6_9 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out6_9),
						 .data_in_0(C6_9_data[31:0]), .data_in_1(C6_9_data[63:32]), .data_in_2(C6_9_data[95:64]), .data_in_3(C6_9_data[127:96]),
						 .data_out_0(C6_9_data_out_mem[31:0]), .data_out_1(C6_9_data_out_mem[63:32]), .data_out_2(C6_9_data_out_mem[95:64]), .data_out_3(C6_9_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C7_0 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out7_0),
						 .data_in_0(C7_0_data[31:0]), .data_in_1(C7_0_data[63:32]), .data_in_2(C7_0_data[95:64]), .data_in_3(C7_0_data[127:96]),
						 .data_out_0(C7_0_data_out_mem[31:0]), .data_out_1(C7_0_data_out_mem[63:32]), .data_out_2(C7_0_data_out_mem[95:64]), .data_out_3(C7_0_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C7_1 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out7_1),
						 .data_in_0(C7_1_data[31:0]), .data_in_1(C7_1_data[63:32]), .data_in_2(C7_1_data[95:64]), .data_in_3(C7_1_data[127:96]),
						 .data_out_0(C7_1_data_out_mem[31:0]), .data_out_1(C7_1_data_out_mem[63:32]), .data_out_2(C7_1_data_out_mem[95:64]), .data_out_3(C7_1_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C7_2 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out7_2),
						 .data_in_0(C7_2_data[31:0]), .data_in_1(C7_2_data[63:32]), .data_in_2(C7_2_data[95:64]), .data_in_3(C7_2_data[127:96]),
						 .data_out_0(C7_2_data_out_mem[31:0]), .data_out_1(C7_2_data_out_mem[63:32]), .data_out_2(C7_2_data_out_mem[95:64]), .data_out_3(C7_2_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C7_3 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out7_3),
						 .data_in_0(C7_3_data[31:0]), .data_in_1(C7_3_data[63:32]), .data_in_2(C7_3_data[95:64]), .data_in_3(C7_3_data[127:96]),
						 .data_out_0(C7_3_data_out_mem[31:0]), .data_out_1(C7_3_data_out_mem[63:32]), .data_out_2(C7_3_data_out_mem[95:64]), .data_out_3(C7_3_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C7_4 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out7_4),
						 .data_in_0(C7_4_data[31:0]), .data_in_1(C7_4_data[63:32]), .data_in_2(C7_4_data[95:64]), .data_in_3(C7_4_data[127:96]),
						 .data_out_0(C7_4_data_out_mem[31:0]), .data_out_1(C7_4_data_out_mem[63:32]), .data_out_2(C7_4_data_out_mem[95:64]), .data_out_3(C7_4_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C7_5 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out7_5),
						 .data_in_0(C7_5_data[31:0]), .data_in_1(C7_5_data[63:32]), .data_in_2(C7_5_data[95:64]), .data_in_3(C7_5_data[127:96]),
						 .data_out_0(C7_5_data_out_mem[31:0]), .data_out_1(C7_5_data_out_mem[63:32]), .data_out_2(C7_5_data_out_mem[95:64]), .data_out_3(C7_5_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C7_6 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out7_6),
						 .data_in_0(C7_6_data[31:0]), .data_in_1(C7_6_data[63:32]), .data_in_2(C7_6_data[95:64]), .data_in_3(C7_6_data[127:96]),
						 .data_out_0(C7_6_data_out_mem[31:0]), .data_out_1(C7_6_data_out_mem[63:32]), .data_out_2(C7_6_data_out_mem[95:64]), .data_out_3(C7_6_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C7_7 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out7_7),
						 .data_in_0(C7_7_data[31:0]), .data_in_1(C7_7_data[63:32]), .data_in_2(C7_7_data[95:64]), .data_in_3(C7_7_data[127:96]),
						 .data_out_0(C7_7_data_out_mem[31:0]), .data_out_1(C7_7_data_out_mem[63:32]), .data_out_2(C7_7_data_out_mem[95:64]), .data_out_3(C7_7_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C7_8 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out7_8),
						 .data_in_0(C7_8_data[31:0]), .data_in_1(C7_8_data[63:32]), .data_in_2(C7_8_data[95:64]), .data_in_3(C7_8_data[127:96]),
						 .data_out_0(C7_8_data_out_mem[31:0]), .data_out_1(C7_8_data_out_mem[63:32]), .data_out_2(C7_8_data_out_mem[95:64]), .data_out_3(C7_8_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C7_9 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out7_9),
						 .data_in_0(C7_9_data[31:0]), .data_in_1(C7_9_data[63:32]), .data_in_2(C7_9_data[95:64]), .data_in_3(C7_9_data[127:96]),
						 .data_out_0(C7_9_data_out_mem[31:0]), .data_out_1(C7_9_data_out_mem[63:32]), .data_out_2(C7_9_data_out_mem[95:64]), .data_out_3(C7_9_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C8_0 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out8_0),
						 .data_in_0(C8_0_data[31:0]), .data_in_1(C8_0_data[63:32]), .data_in_2(C8_0_data[95:64]), .data_in_3(C8_0_data[127:96]),
						 .data_out_0(C8_0_data_out_mem[31:0]), .data_out_1(C8_0_data_out_mem[63:32]), .data_out_2(C8_0_data_out_mem[95:64]), .data_out_3(C8_0_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C8_1 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out8_1),
						 .data_in_0(C8_1_data[31:0]), .data_in_1(C8_1_data[63:32]), .data_in_2(C8_1_data[95:64]), .data_in_3(C8_1_data[127:96]),
						 .data_out_0(C8_1_data_out_mem[31:0]), .data_out_1(C8_1_data_out_mem[63:32]), .data_out_2(C8_1_data_out_mem[95:64]), .data_out_3(C8_1_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C8_2 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out8_2),
						 .data_in_0(C8_2_data[31:0]), .data_in_1(C8_2_data[63:32]), .data_in_2(C8_2_data[95:64]), .data_in_3(C8_2_data[127:96]),
						 .data_out_0(C8_2_data_out_mem[31:0]), .data_out_1(C8_2_data_out_mem[63:32]), .data_out_2(C8_2_data_out_mem[95:64]), .data_out_3(C8_2_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C8_3 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out8_3),
						 .data_in_0(C8_3_data[31:0]), .data_in_1(C8_3_data[63:32]), .data_in_2(C8_3_data[95:64]), .data_in_3(C8_3_data[127:96]),
						 .data_out_0(C8_3_data_out_mem[31:0]), .data_out_1(C8_3_data_out_mem[63:32]), .data_out_2(C8_3_data_out_mem[95:64]), .data_out_3(C8_3_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C8_4 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out8_4),
						 .data_in_0(C8_4_data[31:0]), .data_in_1(C8_4_data[63:32]), .data_in_2(C8_4_data[95:64]), .data_in_3(C8_4_data[127:96]),
						 .data_out_0(C8_4_data_out_mem[31:0]), .data_out_1(C8_4_data_out_mem[63:32]), .data_out_2(C8_4_data_out_mem[95:64]), .data_out_3(C8_4_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C8_5 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out8_5),
						 .data_in_0(C8_5_data[31:0]), .data_in_1(C8_5_data[63:32]), .data_in_2(C8_5_data[95:64]), .data_in_3(C8_5_data[127:96]),
						 .data_out_0(C8_5_data_out_mem[31:0]), .data_out_1(C8_5_data_out_mem[63:32]), .data_out_2(C8_5_data_out_mem[95:64]), .data_out_3(C8_5_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C8_6 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out8_6),
						 .data_in_0(C8_6_data[31:0]), .data_in_1(C8_6_data[63:32]), .data_in_2(C8_6_data[95:64]), .data_in_3(C8_6_data[127:96]),
						 .data_out_0(C8_6_data_out_mem[31:0]), .data_out_1(C8_6_data_out_mem[63:32]), .data_out_2(C8_6_data_out_mem[95:64]), .data_out_3(C8_6_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C8_7 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out8_7),
						 .data_in_0(C8_7_data[31:0]), .data_in_1(C8_7_data[63:32]), .data_in_2(C8_7_data[95:64]), .data_in_3(C8_7_data[127:96]),
						 .data_out_0(C8_7_data_out_mem[31:0]), .data_out_1(C8_7_data_out_mem[63:32]), .data_out_2(C8_7_data_out_mem[95:64]), .data_out_3(C8_7_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C8_8 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out8_8),
						 .data_in_0(C8_8_data[31:0]), .data_in_1(C8_8_data[63:32]), .data_in_2(C8_8_data[95:64]), .data_in_3(C8_8_data[127:96]),
						 .data_out_0(C8_8_data_out_mem[31:0]), .data_out_1(C8_8_data_out_mem[63:32]), .data_out_2(C8_8_data_out_mem[95:64]), .data_out_3(C8_8_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C8_9 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out8_9),
						 .data_in_0(C8_9_data[31:0]), .data_in_1(C8_9_data[63:32]), .data_in_2(C8_9_data[95:64]), .data_in_3(C8_9_data[127:96]),
						 .data_out_0(C8_9_data_out_mem[31:0]), .data_out_1(C8_9_data_out_mem[63:32]), .data_out_2(C8_9_data_out_mem[95:64]), .data_out_3(C8_9_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C9_0 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out9_0),
						 .data_in_0(C9_0_data[31:0]), .data_in_1(C9_0_data[63:32]), .data_in_2(C9_0_data[95:64]), .data_in_3(C9_0_data[127:96]),
						 .data_out_0(C9_0_data_out_mem[31:0]), .data_out_1(C9_0_data_out_mem[63:32]), .data_out_2(C9_0_data_out_mem[95:64]), .data_out_3(C9_0_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C9_1 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out9_1),
						 .data_in_0(C9_1_data[31:0]), .data_in_1(C9_1_data[63:32]), .data_in_2(C9_1_data[95:64]), .data_in_3(C9_1_data[127:96]),
						 .data_out_0(C9_1_data_out_mem[31:0]), .data_out_1(C9_1_data_out_mem[63:32]), .data_out_2(C9_1_data_out_mem[95:64]), .data_out_3(C9_1_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C9_2 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out9_2),
						 .data_in_0(C9_2_data[31:0]), .data_in_1(C9_2_data[63:32]), .data_in_2(C9_2_data[95:64]), .data_in_3(C9_2_data[127:96]),
						 .data_out_0(C9_2_data_out_mem[31:0]), .data_out_1(C9_2_data_out_mem[63:32]), .data_out_2(C9_2_data_out_mem[95:64]), .data_out_3(C9_2_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C9_3 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out9_3),
						 .data_in_0(C9_3_data[31:0]), .data_in_1(C9_3_data[63:32]), .data_in_2(C9_3_data[95:64]), .data_in_3(C9_3_data[127:96]),
						 .data_out_0(C9_3_data_out_mem[31:0]), .data_out_1(C9_3_data_out_mem[63:32]), .data_out_2(C9_3_data_out_mem[95:64]), .data_out_3(C9_3_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C9_4 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out9_4),
						 .data_in_0(C9_4_data[31:0]), .data_in_1(C9_4_data[63:32]), .data_in_2(C9_4_data[95:64]), .data_in_3(C9_4_data[127:96]),
						 .data_out_0(C9_4_data_out_mem[31:0]), .data_out_1(C9_4_data_out_mem[63:32]), .data_out_2(C9_4_data_out_mem[95:64]), .data_out_3(C9_4_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C9_5 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out9_5),
						 .data_in_0(C9_5_data[31:0]), .data_in_1(C9_5_data[63:32]), .data_in_2(C9_5_data[95:64]), .data_in_3(C9_5_data[127:96]),
						 .data_out_0(C9_5_data_out_mem[31:0]), .data_out_1(C9_5_data_out_mem[63:32]), .data_out_2(C9_5_data_out_mem[95:64]), .data_out_3(C9_5_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C9_6 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out9_6),
						 .data_in_0(C9_6_data[31:0]), .data_in_1(C9_6_data[63:32]), .data_in_2(C9_6_data[95:64]), .data_in_3(C9_6_data[127:96]),
						 .data_out_0(C9_6_data_out_mem[31:0]), .data_out_1(C9_6_data_out_mem[63:32]), .data_out_2(C9_6_data_out_mem[95:64]), .data_out_3(C9_6_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C9_7 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out9_7),
						 .data_in_0(C9_7_data[31:0]), .data_in_1(C9_7_data[63:32]), .data_in_2(C9_7_data[95:64]), .data_in_3(C9_7_data[127:96]),
						 .data_out_0(C9_7_data_out_mem[31:0]), .data_out_1(C9_7_data_out_mem[63:32]), .data_out_2(C9_7_data_out_mem[95:64]), .data_out_3(C9_7_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C9_8 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out9_8),
						 .data_in_0(C9_8_data[31:0]), .data_in_1(C9_8_data[63:32]), .data_in_2(C9_8_data[95:64]), .data_in_3(C9_8_data[127:96]),
						 .data_out_0(C9_8_data_out_mem[31:0]), .data_out_1(C9_8_data_out_mem[63:32]), .data_out_2(C9_8_data_out_mem[95:64]), .data_out_3(C9_8_data_out_mem[127:96]));

output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))
						 C9_9 (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out9_9),
						 .data_in_0(C9_9_data[31:0]), .data_in_1(C9_9_data[63:32]), .data_in_2(C9_9_data[95:64]), .data_in_3(C9_9_data[127:96]),
						 .data_out_0(C9_9_data_out_mem[31:0]), .data_out_1(C9_9_data_out_mem[63:32]), .data_out_2(C9_9_data_out_mem[95:64]), .data_out_3(C9_9_data_out_mem[127:96]));

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

assign cout_data[12] = &C0_3_data_out_mem[31:0];
assign cout_data[13] = &C0_3_data_out_mem[63:32];
assign cout_data[14] = &C0_3_data_out_mem[95:64];
assign cout_data[15] = &C0_3_data_out_mem[127:96];

assign cout_data[16] = &C0_4_data_out_mem[31:0];
assign cout_data[17] = &C0_4_data_out_mem[63:32];
assign cout_data[18] = &C0_4_data_out_mem[95:64];
assign cout_data[19] = &C0_4_data_out_mem[127:96];

assign cout_data[20] = &C0_5_data_out_mem[31:0];
assign cout_data[21] = &C0_5_data_out_mem[63:32];
assign cout_data[22] = &C0_5_data_out_mem[95:64];
assign cout_data[23] = &C0_5_data_out_mem[127:96];

assign cout_data[24] = &C0_6_data_out_mem[31:0];
assign cout_data[25] = &C0_6_data_out_mem[63:32];
assign cout_data[26] = &C0_6_data_out_mem[95:64];
assign cout_data[27] = &C0_6_data_out_mem[127:96];

assign cout_data[28] = &C0_7_data_out_mem[31:0];
assign cout_data[29] = &C0_7_data_out_mem[63:32];
assign cout_data[30] = &C0_7_data_out_mem[95:64];
assign cout_data[31] = &C0_7_data_out_mem[127:96];

assign cout_data[32] = &C0_8_data_out_mem[31:0];
assign cout_data[33] = &C0_8_data_out_mem[63:32];
assign cout_data[34] = &C0_8_data_out_mem[95:64];
assign cout_data[35] = &C0_8_data_out_mem[127:96];

assign cout_data[36] = &C0_9_data_out_mem[31:0];
assign cout_data[37] = &C0_9_data_out_mem[63:32];
assign cout_data[38] = &C0_9_data_out_mem[95:64];
assign cout_data[39] = &C0_9_data_out_mem[127:96];

assign cout_data[40] = &C1_0_data_out_mem[31:0];
assign cout_data[41] = &C1_0_data_out_mem[63:32];
assign cout_data[42] = &C1_0_data_out_mem[95:64];
assign cout_data[43] = &C1_0_data_out_mem[127:96];

assign cout_data[44] = &C1_1_data_out_mem[31:0];
assign cout_data[45] = &C1_1_data_out_mem[63:32];
assign cout_data[46] = &C1_1_data_out_mem[95:64];
assign cout_data[47] = &C1_1_data_out_mem[127:96];

assign cout_data[48] = &C1_2_data_out_mem[31:0];
assign cout_data[49] = &C1_2_data_out_mem[63:32];
assign cout_data[50] = &C1_2_data_out_mem[95:64];
assign cout_data[51] = &C1_2_data_out_mem[127:96];

assign cout_data[52] = &C1_3_data_out_mem[31:0];
assign cout_data[53] = &C1_3_data_out_mem[63:32];
assign cout_data[54] = &C1_3_data_out_mem[95:64];
assign cout_data[55] = &C1_3_data_out_mem[127:96];

assign cout_data[56] = &C1_4_data_out_mem[31:0];
assign cout_data[57] = &C1_4_data_out_mem[63:32];
assign cout_data[58] = &C1_4_data_out_mem[95:64];
assign cout_data[59] = &C1_4_data_out_mem[127:96];

assign cout_data[60] = &C1_5_data_out_mem[31:0];
assign cout_data[61] = &C1_5_data_out_mem[63:32];
assign cout_data[62] = &C1_5_data_out_mem[95:64];
assign cout_data[63] = &C1_5_data_out_mem[127:96];

assign cout_data[64] = &C1_6_data_out_mem[31:0];
assign cout_data[65] = &C1_6_data_out_mem[63:32];
assign cout_data[66] = &C1_6_data_out_mem[95:64];
assign cout_data[67] = &C1_6_data_out_mem[127:96];

assign cout_data[68] = &C1_7_data_out_mem[31:0];
assign cout_data[69] = &C1_7_data_out_mem[63:32];
assign cout_data[70] = &C1_7_data_out_mem[95:64];
assign cout_data[71] = &C1_7_data_out_mem[127:96];

assign cout_data[72] = &C1_8_data_out_mem[31:0];
assign cout_data[73] = &C1_8_data_out_mem[63:32];
assign cout_data[74] = &C1_8_data_out_mem[95:64];
assign cout_data[75] = &C1_8_data_out_mem[127:96];

assign cout_data[76] = &C1_9_data_out_mem[31:0];
assign cout_data[77] = &C1_9_data_out_mem[63:32];
assign cout_data[78] = &C1_9_data_out_mem[95:64];
assign cout_data[79] = &C1_9_data_out_mem[127:96];

assign cout_data[80] = &C2_0_data_out_mem[31:0];
assign cout_data[81] = &C2_0_data_out_mem[63:32];
assign cout_data[82] = &C2_0_data_out_mem[95:64];
assign cout_data[83] = &C2_0_data_out_mem[127:96];

assign cout_data[84] = &C2_1_data_out_mem[31:0];
assign cout_data[85] = &C2_1_data_out_mem[63:32];
assign cout_data[86] = &C2_1_data_out_mem[95:64];
assign cout_data[87] = &C2_1_data_out_mem[127:96];

assign cout_data[88] = &C2_2_data_out_mem[31:0];
assign cout_data[89] = &C2_2_data_out_mem[63:32];
assign cout_data[90] = &C2_2_data_out_mem[95:64];
assign cout_data[91] = &C2_2_data_out_mem[127:96];

assign cout_data[92] = &C2_3_data_out_mem[31:0];
assign cout_data[93] = &C2_3_data_out_mem[63:32];
assign cout_data[94] = &C2_3_data_out_mem[95:64];
assign cout_data[95] = &C2_3_data_out_mem[127:96];

assign cout_data[96] = &C2_4_data_out_mem[31:0];
assign cout_data[97] = &C2_4_data_out_mem[63:32];
assign cout_data[98] = &C2_4_data_out_mem[95:64];
assign cout_data[99] = &C2_4_data_out_mem[127:96];

assign cout_data[100] = &C2_5_data_out_mem[31:0];
assign cout_data[101] = &C2_5_data_out_mem[63:32];
assign cout_data[102] = &C2_5_data_out_mem[95:64];
assign cout_data[103] = &C2_5_data_out_mem[127:96];

assign cout_data[104] = &C2_6_data_out_mem[31:0];
assign cout_data[105] = &C2_6_data_out_mem[63:32];
assign cout_data[106] = &C2_6_data_out_mem[95:64];
assign cout_data[107] = &C2_6_data_out_mem[127:96];

assign cout_data[108] = &C2_7_data_out_mem[31:0];
assign cout_data[109] = &C2_7_data_out_mem[63:32];
assign cout_data[110] = &C2_7_data_out_mem[95:64];
assign cout_data[111] = &C2_7_data_out_mem[127:96];

assign cout_data[112] = &C2_8_data_out_mem[31:0];
assign cout_data[113] = &C2_8_data_out_mem[63:32];
assign cout_data[114] = &C2_8_data_out_mem[95:64];
assign cout_data[115] = &C2_8_data_out_mem[127:96];

assign cout_data[116] = &C2_9_data_out_mem[31:0];
assign cout_data[117] = &C2_9_data_out_mem[63:32];
assign cout_data[118] = &C2_9_data_out_mem[95:64];
assign cout_data[119] = &C2_9_data_out_mem[127:96];

assign cout_data[120] = &C3_0_data_out_mem[31:0];
assign cout_data[121] = &C3_0_data_out_mem[63:32];
assign cout_data[122] = &C3_0_data_out_mem[95:64];
assign cout_data[123] = &C3_0_data_out_mem[127:96];

assign cout_data[124] = &C3_1_data_out_mem[31:0];
assign cout_data[125] = &C3_1_data_out_mem[63:32];
assign cout_data[126] = &C3_1_data_out_mem[95:64];
assign cout_data[127] = &C3_1_data_out_mem[127:96];

assign cout_data[128] = &C3_2_data_out_mem[31:0];
assign cout_data[129] = &C3_2_data_out_mem[63:32];
assign cout_data[130] = &C3_2_data_out_mem[95:64];
assign cout_data[131] = &C3_2_data_out_mem[127:96];

assign cout_data[132] = &C3_3_data_out_mem[31:0];
assign cout_data[133] = &C3_3_data_out_mem[63:32];
assign cout_data[134] = &C3_3_data_out_mem[95:64];
assign cout_data[135] = &C3_3_data_out_mem[127:96];

assign cout_data[136] = &C3_4_data_out_mem[31:0];
assign cout_data[137] = &C3_4_data_out_mem[63:32];
assign cout_data[138] = &C3_4_data_out_mem[95:64];
assign cout_data[139] = &C3_4_data_out_mem[127:96];

assign cout_data[140] = &C3_5_data_out_mem[31:0];
assign cout_data[141] = &C3_5_data_out_mem[63:32];
assign cout_data[142] = &C3_5_data_out_mem[95:64];
assign cout_data[143] = &C3_5_data_out_mem[127:96];

assign cout_data[144] = &C3_6_data_out_mem[31:0];
assign cout_data[145] = &C3_6_data_out_mem[63:32];
assign cout_data[146] = &C3_6_data_out_mem[95:64];
assign cout_data[147] = &C3_6_data_out_mem[127:96];

assign cout_data[148] = &C3_7_data_out_mem[31:0];
assign cout_data[149] = &C3_7_data_out_mem[63:32];
assign cout_data[150] = &C3_7_data_out_mem[95:64];
assign cout_data[151] = &C3_7_data_out_mem[127:96];

assign cout_data[152] = &C3_8_data_out_mem[31:0];
assign cout_data[153] = &C3_8_data_out_mem[63:32];
assign cout_data[154] = &C3_8_data_out_mem[95:64];
assign cout_data[155] = &C3_8_data_out_mem[127:96];

assign cout_data[156] = &C3_9_data_out_mem[31:0];
assign cout_data[157] = &C3_9_data_out_mem[63:32];
assign cout_data[158] = &C3_9_data_out_mem[95:64];
assign cout_data[159] = &C3_9_data_out_mem[127:96];

assign cout_data[160] = &C4_0_data_out_mem[31:0];
assign cout_data[161] = &C4_0_data_out_mem[63:32];
assign cout_data[162] = &C4_0_data_out_mem[95:64];
assign cout_data[163] = &C4_0_data_out_mem[127:96];

assign cout_data[164] = &C4_1_data_out_mem[31:0];
assign cout_data[165] = &C4_1_data_out_mem[63:32];
assign cout_data[166] = &C4_1_data_out_mem[95:64];
assign cout_data[167] = &C4_1_data_out_mem[127:96];

assign cout_data[168] = &C4_2_data_out_mem[31:0];
assign cout_data[169] = &C4_2_data_out_mem[63:32];
assign cout_data[170] = &C4_2_data_out_mem[95:64];
assign cout_data[171] = &C4_2_data_out_mem[127:96];

assign cout_data[172] = &C4_3_data_out_mem[31:0];
assign cout_data[173] = &C4_3_data_out_mem[63:32];
assign cout_data[174] = &C4_3_data_out_mem[95:64];
assign cout_data[175] = &C4_3_data_out_mem[127:96];

assign cout_data[176] = &C4_4_data_out_mem[31:0];
assign cout_data[177] = &C4_4_data_out_mem[63:32];
assign cout_data[178] = &C4_4_data_out_mem[95:64];
assign cout_data[179] = &C4_4_data_out_mem[127:96];

assign cout_data[180] = &C4_5_data_out_mem[31:0];
assign cout_data[181] = &C4_5_data_out_mem[63:32];
assign cout_data[182] = &C4_5_data_out_mem[95:64];
assign cout_data[183] = &C4_5_data_out_mem[127:96];

assign cout_data[184] = &C4_6_data_out_mem[31:0];
assign cout_data[185] = &C4_6_data_out_mem[63:32];
assign cout_data[186] = &C4_6_data_out_mem[95:64];
assign cout_data[187] = &C4_6_data_out_mem[127:96];

assign cout_data[188] = &C4_7_data_out_mem[31:0];
assign cout_data[189] = &C4_7_data_out_mem[63:32];
assign cout_data[190] = &C4_7_data_out_mem[95:64];
assign cout_data[191] = &C4_7_data_out_mem[127:96];

assign cout_data[192] = &C4_8_data_out_mem[31:0];
assign cout_data[193] = &C4_8_data_out_mem[63:32];
assign cout_data[194] = &C4_8_data_out_mem[95:64];
assign cout_data[195] = &C4_8_data_out_mem[127:96];

assign cout_data[196] = &C4_9_data_out_mem[31:0];
assign cout_data[197] = &C4_9_data_out_mem[63:32];
assign cout_data[198] = &C4_9_data_out_mem[95:64];
assign cout_data[199] = &C4_9_data_out_mem[127:96];

assign cout_data[200] = &C5_0_data_out_mem[31:0];
assign cout_data[201] = &C5_0_data_out_mem[63:32];
assign cout_data[202] = &C5_0_data_out_mem[95:64];
assign cout_data[203] = &C5_0_data_out_mem[127:96];

assign cout_data[204] = &C5_1_data_out_mem[31:0];
assign cout_data[205] = &C5_1_data_out_mem[63:32];
assign cout_data[206] = &C5_1_data_out_mem[95:64];
assign cout_data[207] = &C5_1_data_out_mem[127:96];

assign cout_data[208] = &C5_2_data_out_mem[31:0];
assign cout_data[209] = &C5_2_data_out_mem[63:32];
assign cout_data[210] = &C5_2_data_out_mem[95:64];
assign cout_data[211] = &C5_2_data_out_mem[127:96];

assign cout_data[212] = &C5_3_data_out_mem[31:0];
assign cout_data[213] = &C5_3_data_out_mem[63:32];
assign cout_data[214] = &C5_3_data_out_mem[95:64];
assign cout_data[215] = &C5_3_data_out_mem[127:96];

assign cout_data[216] = &C5_4_data_out_mem[31:0];
assign cout_data[217] = &C5_4_data_out_mem[63:32];
assign cout_data[218] = &C5_4_data_out_mem[95:64];
assign cout_data[219] = &C5_4_data_out_mem[127:96];

assign cout_data[220] = &C5_5_data_out_mem[31:0];
assign cout_data[221] = &C5_5_data_out_mem[63:32];
assign cout_data[222] = &C5_5_data_out_mem[95:64];
assign cout_data[223] = &C5_5_data_out_mem[127:96];

assign cout_data[224] = &C5_6_data_out_mem[31:0];
assign cout_data[225] = &C5_6_data_out_mem[63:32];
assign cout_data[226] = &C5_6_data_out_mem[95:64];
assign cout_data[227] = &C5_6_data_out_mem[127:96];

assign cout_data[228] = &C5_7_data_out_mem[31:0];
assign cout_data[229] = &C5_7_data_out_mem[63:32];
assign cout_data[230] = &C5_7_data_out_mem[95:64];
assign cout_data[231] = &C5_7_data_out_mem[127:96];

assign cout_data[232] = &C5_8_data_out_mem[31:0];
assign cout_data[233] = &C5_8_data_out_mem[63:32];
assign cout_data[234] = &C5_8_data_out_mem[95:64];
assign cout_data[235] = &C5_8_data_out_mem[127:96];

assign cout_data[236] = &C5_9_data_out_mem[31:0];
assign cout_data[237] = &C5_9_data_out_mem[63:32];
assign cout_data[238] = &C5_9_data_out_mem[95:64];
assign cout_data[239] = &C5_9_data_out_mem[127:96];

assign cout_data[240] = &C6_0_data_out_mem[31:0];
assign cout_data[241] = &C6_0_data_out_mem[63:32];
assign cout_data[242] = &C6_0_data_out_mem[95:64];
assign cout_data[243] = &C6_0_data_out_mem[127:96];

assign cout_data[244] = &C6_1_data_out_mem[31:0];
assign cout_data[245] = &C6_1_data_out_mem[63:32];
assign cout_data[246] = &C6_1_data_out_mem[95:64];
assign cout_data[247] = &C6_1_data_out_mem[127:96];

assign cout_data[248] = &C6_2_data_out_mem[31:0];
assign cout_data[249] = &C6_2_data_out_mem[63:32];
assign cout_data[250] = &C6_2_data_out_mem[95:64];
assign cout_data[251] = &C6_2_data_out_mem[127:96];

assign cout_data[252] = &C6_3_data_out_mem[31:0];
assign cout_data[253] = &C6_3_data_out_mem[63:32];
assign cout_data[254] = &C6_3_data_out_mem[95:64];
assign cout_data[255] = &C6_3_data_out_mem[127:96];

assign cout_data[256] = &C6_4_data_out_mem[31:0];
assign cout_data[257] = &C6_4_data_out_mem[63:32];
assign cout_data[258] = &C6_4_data_out_mem[95:64];
assign cout_data[259] = &C6_4_data_out_mem[127:96];

assign cout_data[260] = &C6_5_data_out_mem[31:0];
assign cout_data[261] = &C6_5_data_out_mem[63:32];
assign cout_data[262] = &C6_5_data_out_mem[95:64];
assign cout_data[263] = &C6_5_data_out_mem[127:96];

assign cout_data[264] = &C6_6_data_out_mem[31:0];
assign cout_data[265] = &C6_6_data_out_mem[63:32];
assign cout_data[266] = &C6_6_data_out_mem[95:64];
assign cout_data[267] = &C6_6_data_out_mem[127:96];

assign cout_data[268] = &C6_7_data_out_mem[31:0];
assign cout_data[269] = &C6_7_data_out_mem[63:32];
assign cout_data[270] = &C6_7_data_out_mem[95:64];
assign cout_data[271] = &C6_7_data_out_mem[127:96];

assign cout_data[272] = &C6_8_data_out_mem[31:0];
assign cout_data[273] = &C6_8_data_out_mem[63:32];
assign cout_data[274] = &C6_8_data_out_mem[95:64];
assign cout_data[275] = &C6_8_data_out_mem[127:96];

assign cout_data[276] = &C6_9_data_out_mem[31:0];
assign cout_data[277] = &C6_9_data_out_mem[63:32];
assign cout_data[278] = &C6_9_data_out_mem[95:64];
assign cout_data[279] = &C6_9_data_out_mem[127:96];

assign cout_data[280] = &C7_0_data_out_mem[31:0];
assign cout_data[281] = &C7_0_data_out_mem[63:32];
assign cout_data[282] = &C7_0_data_out_mem[95:64];
assign cout_data[283] = &C7_0_data_out_mem[127:96];

assign cout_data[284] = &C7_1_data_out_mem[31:0];
assign cout_data[285] = &C7_1_data_out_mem[63:32];
assign cout_data[286] = &C7_1_data_out_mem[95:64];
assign cout_data[287] = &C7_1_data_out_mem[127:96];

assign cout_data[288] = &C7_2_data_out_mem[31:0];
assign cout_data[289] = &C7_2_data_out_mem[63:32];
assign cout_data[290] = &C7_2_data_out_mem[95:64];
assign cout_data[291] = &C7_2_data_out_mem[127:96];

assign cout_data[292] = &C7_3_data_out_mem[31:0];
assign cout_data[293] = &C7_3_data_out_mem[63:32];
assign cout_data[294] = &C7_3_data_out_mem[95:64];
assign cout_data[295] = &C7_3_data_out_mem[127:96];

assign cout_data[296] = &C7_4_data_out_mem[31:0];
assign cout_data[297] = &C7_4_data_out_mem[63:32];
assign cout_data[298] = &C7_4_data_out_mem[95:64];
assign cout_data[299] = &C7_4_data_out_mem[127:96];

assign cout_data[300] = &C7_5_data_out_mem[31:0];
assign cout_data[301] = &C7_5_data_out_mem[63:32];
assign cout_data[302] = &C7_5_data_out_mem[95:64];
assign cout_data[303] = &C7_5_data_out_mem[127:96];

assign cout_data[304] = &C7_6_data_out_mem[31:0];
assign cout_data[305] = &C7_6_data_out_mem[63:32];
assign cout_data[306] = &C7_6_data_out_mem[95:64];
assign cout_data[307] = &C7_6_data_out_mem[127:96];

assign cout_data[308] = &C7_7_data_out_mem[31:0];
assign cout_data[309] = &C7_7_data_out_mem[63:32];
assign cout_data[310] = &C7_7_data_out_mem[95:64];
assign cout_data[311] = &C7_7_data_out_mem[127:96];

assign cout_data[312] = &C7_8_data_out_mem[31:0];
assign cout_data[313] = &C7_8_data_out_mem[63:32];
assign cout_data[314] = &C7_8_data_out_mem[95:64];
assign cout_data[315] = &C7_8_data_out_mem[127:96];

assign cout_data[316] = &C7_9_data_out_mem[31:0];
assign cout_data[317] = &C7_9_data_out_mem[63:32];
assign cout_data[318] = &C7_9_data_out_mem[95:64];
assign cout_data[319] = &C7_9_data_out_mem[127:96];

assign cout_data[320] = &C8_0_data_out_mem[31:0];
assign cout_data[321] = &C8_0_data_out_mem[63:32];
assign cout_data[322] = &C8_0_data_out_mem[95:64];
assign cout_data[323] = &C8_0_data_out_mem[127:96];

assign cout_data[324] = &C8_1_data_out_mem[31:0];
assign cout_data[325] = &C8_1_data_out_mem[63:32];
assign cout_data[326] = &C8_1_data_out_mem[95:64];
assign cout_data[327] = &C8_1_data_out_mem[127:96];

assign cout_data[328] = &C8_2_data_out_mem[31:0];
assign cout_data[329] = &C8_2_data_out_mem[63:32];
assign cout_data[330] = &C8_2_data_out_mem[95:64];
assign cout_data[331] = &C8_2_data_out_mem[127:96];

assign cout_data[332] = &C8_3_data_out_mem[31:0];
assign cout_data[333] = &C8_3_data_out_mem[63:32];
assign cout_data[334] = &C8_3_data_out_mem[95:64];
assign cout_data[335] = &C8_3_data_out_mem[127:96];

assign cout_data[336] = &C8_4_data_out_mem[31:0];
assign cout_data[337] = &C8_4_data_out_mem[63:32];
assign cout_data[338] = &C8_4_data_out_mem[95:64];
assign cout_data[339] = &C8_4_data_out_mem[127:96];

assign cout_data[340] = &C8_5_data_out_mem[31:0];
assign cout_data[341] = &C8_5_data_out_mem[63:32];
assign cout_data[342] = &C8_5_data_out_mem[95:64];
assign cout_data[343] = &C8_5_data_out_mem[127:96];

assign cout_data[344] = &C8_6_data_out_mem[31:0];
assign cout_data[345] = &C8_6_data_out_mem[63:32];
assign cout_data[346] = &C8_6_data_out_mem[95:64];
assign cout_data[347] = &C8_6_data_out_mem[127:96];

assign cout_data[348] = &C8_7_data_out_mem[31:0];
assign cout_data[349] = &C8_7_data_out_mem[63:32];
assign cout_data[350] = &C8_7_data_out_mem[95:64];
assign cout_data[351] = &C8_7_data_out_mem[127:96];

assign cout_data[352] = &C8_8_data_out_mem[31:0];
assign cout_data[353] = &C8_8_data_out_mem[63:32];
assign cout_data[354] = &C8_8_data_out_mem[95:64];
assign cout_data[355] = &C8_8_data_out_mem[127:96];

assign cout_data[356] = &C8_9_data_out_mem[31:0];
assign cout_data[357] = &C8_9_data_out_mem[63:32];
assign cout_data[358] = &C8_9_data_out_mem[95:64];
assign cout_data[359] = &C8_9_data_out_mem[127:96];

assign cout_data[360] = &C9_0_data_out_mem[31:0];
assign cout_data[361] = &C9_0_data_out_mem[63:32];
assign cout_data[362] = &C9_0_data_out_mem[95:64];
assign cout_data[363] = &C9_0_data_out_mem[127:96];

assign cout_data[364] = &C9_1_data_out_mem[31:0];
assign cout_data[365] = &C9_1_data_out_mem[63:32];
assign cout_data[366] = &C9_1_data_out_mem[95:64];
assign cout_data[367] = &C9_1_data_out_mem[127:96];

assign cout_data[368] = &C9_2_data_out_mem[31:0];
assign cout_data[369] = &C9_2_data_out_mem[63:32];
assign cout_data[370] = &C9_2_data_out_mem[95:64];
assign cout_data[371] = &C9_2_data_out_mem[127:96];

assign cout_data[372] = &C9_3_data_out_mem[31:0];
assign cout_data[373] = &C9_3_data_out_mem[63:32];
assign cout_data[374] = &C9_3_data_out_mem[95:64];
assign cout_data[375] = &C9_3_data_out_mem[127:96];

assign cout_data[376] = &C9_4_data_out_mem[31:0];
assign cout_data[377] = &C9_4_data_out_mem[63:32];
assign cout_data[378] = &C9_4_data_out_mem[95:64];
assign cout_data[379] = &C9_4_data_out_mem[127:96];

assign cout_data[380] = &C9_5_data_out_mem[31:0];
assign cout_data[381] = &C9_5_data_out_mem[63:32];
assign cout_data[382] = &C9_5_data_out_mem[95:64];
assign cout_data[383] = &C9_5_data_out_mem[127:96];

assign cout_data[384] = &C9_6_data_out_mem[31:0];
assign cout_data[385] = &C9_6_data_out_mem[63:32];
assign cout_data[386] = &C9_6_data_out_mem[95:64];
assign cout_data[387] = &C9_6_data_out_mem[127:96];

assign cout_data[388] = &C9_7_data_out_mem[31:0];
assign cout_data[389] = &C9_7_data_out_mem[63:32];
assign cout_data[390] = &C9_7_data_out_mem[95:64];
assign cout_data[391] = &C9_7_data_out_mem[127:96];

assign cout_data[392] = &C9_8_data_out_mem[31:0];
assign cout_data[393] = &C9_8_data_out_mem[63:32];
assign cout_data[394] = &C9_8_data_out_mem[95:64];
assign cout_data[395] = &C9_8_data_out_mem[127:96];

assign cout_data[396] = &C9_9_data_out_mem[31:0];
assign cout_data[397] = &C9_9_data_out_mem[63:32];
assign cout_data[398] = &C9_9_data_out_mem[95:64];
assign cout_data[399] = &C9_9_data_out_mem[127:96];

endmodule



    /*
    * This is the control logic for parametric tiling along with 
    * the ram module to feed the first tensor slice (TS_00),
    * for A (use for A0 only)
    */
    module A0_input_mem_control_logic
        #(parameter mwidth = 32,
            parameter addr_width = 9,
            parameter K_const = 128,
            parameter U_const = 4,
            parameter V_const = 4,
            parameter U_bits = 3,
            parameter V_bits = 3)(
            
            clk, 
            reset, 
            enable,
            data_out,
            accumulate_out);

    input clk, reset, enable;
    output [mwidth-1:0] data_out;
    output reg accumulate_out;

    reg [addr_width-1:0] addr_counter;
    reg [V_bits-1:0] v_counter;
    reg [U_bits-1:0] u_counter;
    reg [addr_width-1:0] offset_reg;
    reg [addr_width-1:0] upper_reg;


    always @ (posedge clk) 
    begin
        if (reset) begin
            addr_counter <= 0;
            v_counter <= 0;
            u_counter <= 0;
            offset_reg <= 0;
            accumulate_out <= 1;
            upper_reg <= K_const - 1;
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
                        offset_reg <= offset_reg + K_const;
                        upper_reg <= upper_reg + K_const;
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
            data_out);


    input clk, reset, enable;
    output [mwidth-1:0] data_out;

    reg [addr_width-1:0] addr_counter;
    reg [U_bits-1:0] u_counter;
    reg [V_bits-1:0] v_counter;
    reg [addr_width-1:0] upper_reg;


    always @ (posedge clk) 
    begin
        if (reset) begin
            addr_counter <= 0;
            u_counter <= 0;
            v_counter <= 0;
            upper_reg <= K_const - 1;
        end
        else begin
            if (enable) begin

                if (u_counter < U_const) begin

                    if (v_counter < V_const) begin

                        if (addr_counter == upper_reg) begin
                            v_counter <= v_counter + 1;
                            upper_reg <= upper_reg + K_const;
                        end

                        addr_counter <= addr_counter + 1;

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


    // depth is K_cons * V_const
    ram_module #(.mwidth(mwidth), .num_words(K_const*V_const), .addr_width(addr_width)) mem_0 (.clk(clk), .wren(0), .addr(addr_counter),
                                                                                    .data(), .out(data_out));
    endmodule



    /*
    * This is the control logic for parametric tiling along with 
    * the ram module to feed the REST tensor slices (EXCEPT TS_00),
    * for A (use for Ay, y>=1).
    * 
    */
    module Ay_input_mem_control_logic
        #(parameter mwidth = 32,
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
            data_out);

    input clk, reset, enable;
    output [mwidth-1:0] data_out;

    reg [addr_width-1:0] addr_counter;
    reg [V_bits-1:0] v_counter;
    reg [U_bits-1:0] u_counter;
    reg [addr_width-1:0] offset_reg;
    reg [addr_width-1:0] upper_reg;

    // start counter
    reg [start_cnt_bits-1:0] start_counter;


    always @ (posedge clk) 
    begin
        if (reset) begin
            start_counter <= 0;
            addr_counter <= 0;
            v_counter <= 0;
            u_counter <= 0;
            offset_reg <= 0;
            upper_reg <= K_const - 1;
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
                            offset_reg <= offset_reg + K_const;
                            upper_reg <= upper_reg + K_const;
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
            data_out);


    input clk, reset, enable;
    output [mwidth-1:0] data_out;

    reg [addr_width-1:0] addr_counter;
    reg [U_bits-1:0] u_counter;
    reg [V_bits-1:0] v_counter;
    reg [addr_width-1:0] upper_reg;

    // start counter
    reg [start_cnt_bits-1:0] start_counter;


    always @ (posedge clk) 
    begin
        if (reset) begin
            start_counter <= 0;
            addr_counter <= 0;
            u_counter <= 0;
            v_counter <= 0;
            upper_reg <= K_const - 1;
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
                                upper_reg <= upper_reg + K_const;
                            end

                            addr_counter <= addr_counter + 1;

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


    // depth is K_cons * V_const
    ram_module #(.mwidth(mwidth), .num_words(K_const*V_const), .addr_width(addr_width)) mem_0 (.clk(clk), .wren(0), .addr(addr_counter),
                                                                                    .data(), .out(data_out));

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
