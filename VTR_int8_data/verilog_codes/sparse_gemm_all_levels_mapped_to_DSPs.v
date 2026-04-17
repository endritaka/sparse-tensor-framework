
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
output [399:0] cout_data;

// Ay wires
wire [40-1:0] A0_data;
wire [40-1:0] A1_data;
wire [40-1:0] A2_data;
wire [40-1:0] A3_data;
wire [40-1:0] A4_data;
wire [40-1:0] A5_data;
wire [40-1:0] A6_data;
wire [40-1:0] A7_data;
wire [40-1:0] A8_data;
wire [40-1:0] A9_data;


// Bx wires
wire [128-1:0] B0_data;
wire [128-1:0] B1_data;
wire [128-1:0] B2_data;
wire [128-1:0] B3_data;
wire [128-1:0] B4_data;
wire [128-1:0] B5_data;
wire [128-1:0] B6_data;
wire [128-1:0] B7_data;
wire [128-1:0] B8_data;
wire [128-1:0] B9_data;


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
wire [40-1:0] A_out0_0_in1_0;
wire [40-1:0] A_out1_0_in2_0;
wire [40-1:0] A_out2_0_in3_0;
wire [40-1:0] A_out3_0_in4_0;
wire [40-1:0] A_out4_0_in5_0;
wire [40-1:0] A_out5_0_in6_0;
wire [40-1:0] A_out6_0_in7_0;
wire [40-1:0] A_out7_0_in8_0;
wire [40-1:0] A_out8_0_in9_0;
wire [40-1:0] A_out0_1_in1_1;
wire [40-1:0] A_out1_1_in2_1;
wire [40-1:0] A_out2_1_in3_1;
wire [40-1:0] A_out3_1_in4_1;
wire [40-1:0] A_out4_1_in5_1;
wire [40-1:0] A_out5_1_in6_1;
wire [40-1:0] A_out6_1_in7_1;
wire [40-1:0] A_out7_1_in8_1;
wire [40-1:0] A_out8_1_in9_1;
wire [40-1:0] A_out0_2_in1_2;
wire [40-1:0] A_out1_2_in2_2;
wire [40-1:0] A_out2_2_in3_2;
wire [40-1:0] A_out3_2_in4_2;
wire [40-1:0] A_out4_2_in5_2;
wire [40-1:0] A_out5_2_in6_2;
wire [40-1:0] A_out6_2_in7_2;
wire [40-1:0] A_out7_2_in8_2;
wire [40-1:0] A_out8_2_in9_2;
wire [40-1:0] A_out0_3_in1_3;
wire [40-1:0] A_out1_3_in2_3;
wire [40-1:0] A_out2_3_in3_3;
wire [40-1:0] A_out3_3_in4_3;
wire [40-1:0] A_out4_3_in5_3;
wire [40-1:0] A_out5_3_in6_3;
wire [40-1:0] A_out6_3_in7_3;
wire [40-1:0] A_out7_3_in8_3;
wire [40-1:0] A_out8_3_in9_3;
wire [40-1:0] A_out0_4_in1_4;
wire [40-1:0] A_out1_4_in2_4;
wire [40-1:0] A_out2_4_in3_4;
wire [40-1:0] A_out3_4_in4_4;
wire [40-1:0] A_out4_4_in5_4;
wire [40-1:0] A_out5_4_in6_4;
wire [40-1:0] A_out6_4_in7_4;
wire [40-1:0] A_out7_4_in8_4;
wire [40-1:0] A_out8_4_in9_4;
wire [40-1:0] A_out0_5_in1_5;
wire [40-1:0] A_out1_5_in2_5;
wire [40-1:0] A_out2_5_in3_5;
wire [40-1:0] A_out3_5_in4_5;
wire [40-1:0] A_out4_5_in5_5;
wire [40-1:0] A_out5_5_in6_5;
wire [40-1:0] A_out6_5_in7_5;
wire [40-1:0] A_out7_5_in8_5;
wire [40-1:0] A_out8_5_in9_5;
wire [40-1:0] A_out0_6_in1_6;
wire [40-1:0] A_out1_6_in2_6;
wire [40-1:0] A_out2_6_in3_6;
wire [40-1:0] A_out3_6_in4_6;
wire [40-1:0] A_out4_6_in5_6;
wire [40-1:0] A_out5_6_in6_6;
wire [40-1:0] A_out6_6_in7_6;
wire [40-1:0] A_out7_6_in8_6;
wire [40-1:0] A_out8_6_in9_6;
wire [40-1:0] A_out0_7_in1_7;
wire [40-1:0] A_out1_7_in2_7;
wire [40-1:0] A_out2_7_in3_7;
wire [40-1:0] A_out3_7_in4_7;
wire [40-1:0] A_out4_7_in5_7;
wire [40-1:0] A_out5_7_in6_7;
wire [40-1:0] A_out6_7_in7_7;
wire [40-1:0] A_out7_7_in8_7;
wire [40-1:0] A_out8_7_in9_7;
wire [40-1:0] A_out0_8_in1_8;
wire [40-1:0] A_out1_8_in2_8;
wire [40-1:0] A_out2_8_in3_8;
wire [40-1:0] A_out3_8_in4_8;
wire [40-1:0] A_out4_8_in5_8;
wire [40-1:0] A_out5_8_in6_8;
wire [40-1:0] A_out6_8_in7_8;
wire [40-1:0] A_out7_8_in8_8;
wire [40-1:0] A_out8_8_in9_8;
wire [40-1:0] A_out0_9_in1_9;
wire [40-1:0] A_out1_9_in2_9;
wire [40-1:0] A_out2_9_in3_9;
wire [40-1:0] A_out3_9_in4_9;
wire [40-1:0] A_out4_9_in5_9;
wire [40-1:0] A_out5_9_in6_9;
wire [40-1:0] A_out6_9_in7_9;
wire [40-1:0] A_out7_9_in8_9;
wire [40-1:0] A_out8_9_in9_9;


// vertical connections
wire [128-1:0] B_out0_0_in0_1;
wire [128-1:0] B_out0_1_in0_2;
wire [128-1:0] B_out0_2_in0_3;
wire [128-1:0] B_out0_3_in0_4;
wire [128-1:0] B_out0_4_in0_5;
wire [128-1:0] B_out0_5_in0_6;
wire [128-1:0] B_out0_6_in0_7;
wire [128-1:0] B_out0_7_in0_8;
wire [128-1:0] B_out0_8_in0_9;
wire [128-1:0] B_out1_0_in1_1;
wire [128-1:0] B_out1_1_in1_2;
wire [128-1:0] B_out1_2_in1_3;
wire [128-1:0] B_out1_3_in1_4;
wire [128-1:0] B_out1_4_in1_5;
wire [128-1:0] B_out1_5_in1_6;
wire [128-1:0] B_out1_6_in1_7;
wire [128-1:0] B_out1_7_in1_8;
wire [128-1:0] B_out1_8_in1_9;
wire [128-1:0] B_out2_0_in2_1;
wire [128-1:0] B_out2_1_in2_2;
wire [128-1:0] B_out2_2_in2_3;
wire [128-1:0] B_out2_3_in2_4;
wire [128-1:0] B_out2_4_in2_5;
wire [128-1:0] B_out2_5_in2_6;
wire [128-1:0] B_out2_6_in2_7;
wire [128-1:0] B_out2_7_in2_8;
wire [128-1:0] B_out2_8_in2_9;
wire [128-1:0] B_out3_0_in3_1;
wire [128-1:0] B_out3_1_in3_2;
wire [128-1:0] B_out3_2_in3_3;
wire [128-1:0] B_out3_3_in3_4;
wire [128-1:0] B_out3_4_in3_5;
wire [128-1:0] B_out3_5_in3_6;
wire [128-1:0] B_out3_6_in3_7;
wire [128-1:0] B_out3_7_in3_8;
wire [128-1:0] B_out3_8_in3_9;
wire [128-1:0] B_out4_0_in4_1;
wire [128-1:0] B_out4_1_in4_2;
wire [128-1:0] B_out4_2_in4_3;
wire [128-1:0] B_out4_3_in4_4;
wire [128-1:0] B_out4_4_in4_5;
wire [128-1:0] B_out4_5_in4_6;
wire [128-1:0] B_out4_6_in4_7;
wire [128-1:0] B_out4_7_in4_8;
wire [128-1:0] B_out4_8_in4_9;
wire [128-1:0] B_out5_0_in5_1;
wire [128-1:0] B_out5_1_in5_2;
wire [128-1:0] B_out5_2_in5_3;
wire [128-1:0] B_out5_3_in5_4;
wire [128-1:0] B_out5_4_in5_5;
wire [128-1:0] B_out5_5_in5_6;
wire [128-1:0] B_out5_6_in5_7;
wire [128-1:0] B_out5_7_in5_8;
wire [128-1:0] B_out5_8_in5_9;
wire [128-1:0] B_out6_0_in6_1;
wire [128-1:0] B_out6_1_in6_2;
wire [128-1:0] B_out6_2_in6_3;
wire [128-1:0] B_out6_3_in6_4;
wire [128-1:0] B_out6_4_in6_5;
wire [128-1:0] B_out6_5_in6_6;
wire [128-1:0] B_out6_6_in6_7;
wire [128-1:0] B_out6_7_in6_8;
wire [128-1:0] B_out6_8_in6_9;
wire [128-1:0] B_out7_0_in7_1;
wire [128-1:0] B_out7_1_in7_2;
wire [128-1:0] B_out7_2_in7_3;
wire [128-1:0] B_out7_3_in7_4;
wire [128-1:0] B_out7_4_in7_5;
wire [128-1:0] B_out7_5_in7_6;
wire [128-1:0] B_out7_6_in7_7;
wire [128-1:0] B_out7_7_in7_8;
wire [128-1:0] B_out7_8_in7_9;
wire [128-1:0] B_out8_0_in8_1;
wire [128-1:0] B_out8_1_in8_2;
wire [128-1:0] B_out8_2_in8_3;
wire [128-1:0] B_out8_3_in8_4;
wire [128-1:0] B_out8_4_in8_5;
wire [128-1:0] B_out8_5_in8_6;
wire [128-1:0] B_out8_6_in8_7;
wire [128-1:0] B_out8_7_in8_8;
wire [128-1:0] B_out8_8_in8_9;
wire [128-1:0] B_out9_0_in9_1;
wire [128-1:0] B_out9_1_in9_2;
wire [128-1:0] B_out9_2_in9_3;
wire [128-1:0] B_out9_3_in9_4;
wire [128-1:0] B_out9_4_in9_5;
wire [128-1:0] B_out9_5_in9_6;
wire [128-1:0] B_out9_6_in9_7;
wire [128-1:0] B_out9_7_in9_8;
wire [128-1:0] B_out9_8_in9_9;


// accumulate signal for tiling (generated from control logic)
wire acc_in;


// accumulate_out connections
wire accumulate_out0_0;
wire accumulate_out0_1;
wire accumulate_out0_2;
wire accumulate_out0_3;
wire accumulate_out0_4;
wire accumulate_out0_5;
wire accumulate_out0_6;
wire accumulate_out0_7;
wire accumulate_out0_8;
wire accumulate_out1_0;
wire accumulate_out1_1;
wire accumulate_out1_2;
wire accumulate_out1_3;
wire accumulate_out1_4;
wire accumulate_out1_5;
wire accumulate_out1_6;
wire accumulate_out1_7;
wire accumulate_out1_8;
wire accumulate_out2_0;
wire accumulate_out2_1;
wire accumulate_out2_2;
wire accumulate_out2_3;
wire accumulate_out2_4;
wire accumulate_out2_5;
wire accumulate_out2_6;
wire accumulate_out2_7;
wire accumulate_out2_8;
wire accumulate_out3_0;
wire accumulate_out3_1;
wire accumulate_out3_2;
wire accumulate_out3_3;
wire accumulate_out3_4;
wire accumulate_out3_5;
wire accumulate_out3_6;
wire accumulate_out3_7;
wire accumulate_out3_8;
wire accumulate_out4_0;
wire accumulate_out4_1;
wire accumulate_out4_2;
wire accumulate_out4_3;
wire accumulate_out4_4;
wire accumulate_out4_5;
wire accumulate_out4_6;
wire accumulate_out4_7;
wire accumulate_out4_8;
wire accumulate_out5_0;
wire accumulate_out5_1;
wire accumulate_out5_2;
wire accumulate_out5_3;
wire accumulate_out5_4;
wire accumulate_out5_5;
wire accumulate_out5_6;
wire accumulate_out5_7;
wire accumulate_out5_8;
wire accumulate_out6_0;
wire accumulate_out6_1;
wire accumulate_out6_2;
wire accumulate_out6_3;
wire accumulate_out6_4;
wire accumulate_out6_5;
wire accumulate_out6_6;
wire accumulate_out6_7;
wire accumulate_out6_8;
wire accumulate_out7_0;
wire accumulate_out7_1;
wire accumulate_out7_2;
wire accumulate_out7_3;
wire accumulate_out7_4;
wire accumulate_out7_5;
wire accumulate_out7_6;
wire accumulate_out7_7;
wire accumulate_out7_8;
wire accumulate_out8_0;
wire accumulate_out8_1;
wire accumulate_out8_2;
wire accumulate_out8_3;
wire accumulate_out8_4;
wire accumulate_out8_5;
wire accumulate_out8_6;
wire accumulate_out8_7;
wire accumulate_out8_8;
wire accumulate_out9_0;
wire accumulate_out9_1;
wire accumulate_out9_2;
wire accumulate_out9_3;
wire accumulate_out9_4;
wire accumulate_out9_5;
wire accumulate_out9_6;
wire accumulate_out9_7;
wire accumulate_out9_8;


// Ay
A0_input_mem_control_logic #(.mwidth(40), .addr_width(`A_cnt_width), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 A0 (.clk(clk), .reset(reset), .enable(enable), .sparsity_level(sparsity_level), .data_out(A0_data), .accumulate_out(acc_in));

Ay_input_mem_control_logic #(.mwidth(40), .addr_width(`A_cnt_width), .start_cnt_bits(2), .start_val(3), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 A1 (.clk(clk), .reset(reset), .enable(enable), .sparsity_level(sparsity_level), .data_out(A1_data));

Ay_input_mem_control_logic #(.mwidth(40), .addr_width(`A_cnt_width), .start_cnt_bits(3), .start_val(7), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 A2 (.clk(clk), .reset(reset), .enable(enable), .sparsity_level(sparsity_level), .data_out(A2_data));

Ay_input_mem_control_logic #(.mwidth(40), .addr_width(`A_cnt_width), .start_cnt_bits(4), .start_val(11), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 A3 (.clk(clk), .reset(reset), .enable(enable), .sparsity_level(sparsity_level), .data_out(A3_data));

Ay_input_mem_control_logic #(.mwidth(40), .addr_width(`A_cnt_width), .start_cnt_bits(4), .start_val(15), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 A4 (.clk(clk), .reset(reset), .enable(enable), .sparsity_level(sparsity_level), .data_out(A4_data));

Ay_input_mem_control_logic #(.mwidth(40), .addr_width(`A_cnt_width), .start_cnt_bits(5), .start_val(19), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 A5 (.clk(clk), .reset(reset), .enable(enable), .sparsity_level(sparsity_level), .data_out(A5_data));

Ay_input_mem_control_logic #(.mwidth(40), .addr_width(`A_cnt_width), .start_cnt_bits(5), .start_val(23), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 A6 (.clk(clk), .reset(reset), .enable(enable), .sparsity_level(sparsity_level), .data_out(A6_data));

Ay_input_mem_control_logic #(.mwidth(40), .addr_width(`A_cnt_width), .start_cnt_bits(5), .start_val(27), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 A7 (.clk(clk), .reset(reset), .enable(enable), .sparsity_level(sparsity_level), .data_out(A7_data));

Ay_input_mem_control_logic #(.mwidth(40), .addr_width(`A_cnt_width), .start_cnt_bits(5), .start_val(31), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 A8 (.clk(clk), .reset(reset), .enable(enable), .sparsity_level(sparsity_level), .data_out(A8_data));

Ay_input_mem_control_logic #(.mwidth(40), .addr_width(`A_cnt_width), .start_cnt_bits(6), .start_val(35), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 A9 (.clk(clk), .reset(reset), .enable(enable), .sparsity_level(sparsity_level), .data_out(A9_data));

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

Bx_input_mem_control_logic #(.mwidth(32), .addr_width(`B_cnt_width), .start_cnt_bits(4), .start_val(11), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 B3 (.clk(clk), .reset(reset), .enable(enable), .sparsity_level(sparsity_level),
					 .data_out_0(B3_data[31:0]), .data_out_1(B3_data[63:32]), .data_out_2(B3_data[95:64]), .data_out_3(B3_data[127:96]));

Bx_input_mem_control_logic #(.mwidth(32), .addr_width(`B_cnt_width), .start_cnt_bits(4), .start_val(15), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 B4 (.clk(clk), .reset(reset), .enable(enable), .sparsity_level(sparsity_level),
					 .data_out_0(B4_data[31:0]), .data_out_1(B4_data[63:32]), .data_out_2(B4_data[95:64]), .data_out_3(B4_data[127:96]));

Bx_input_mem_control_logic #(.mwidth(32), .addr_width(`B_cnt_width), .start_cnt_bits(5), .start_val(19), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 B5 (.clk(clk), .reset(reset), .enable(enable), .sparsity_level(sparsity_level),
					 .data_out_0(B5_data[31:0]), .data_out_1(B5_data[63:32]), .data_out_2(B5_data[95:64]), .data_out_3(B5_data[127:96]));

Bx_input_mem_control_logic #(.mwidth(32), .addr_width(`B_cnt_width), .start_cnt_bits(5), .start_val(23), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 B6 (.clk(clk), .reset(reset), .enable(enable), .sparsity_level(sparsity_level),
					 .data_out_0(B6_data[31:0]), .data_out_1(B6_data[63:32]), .data_out_2(B6_data[95:64]), .data_out_3(B6_data[127:96]));

Bx_input_mem_control_logic #(.mwidth(32), .addr_width(`B_cnt_width), .start_cnt_bits(5), .start_val(27), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 B7 (.clk(clk), .reset(reset), .enable(enable), .sparsity_level(sparsity_level),
					 .data_out_0(B7_data[31:0]), .data_out_1(B7_data[63:32]), .data_out_2(B7_data[95:64]), .data_out_3(B7_data[127:96]));

Bx_input_mem_control_logic #(.mwidth(32), .addr_width(`B_cnt_width), .start_cnt_bits(5), .start_val(31), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 B8 (.clk(clk), .reset(reset), .enable(enable), .sparsity_level(sparsity_level),
					 .data_out_0(B8_data[31:0]), .data_out_1(B8_data[63:32]), .data_out_2(B8_data[95:64]), .data_out_3(B8_data[127:96]));

Bx_input_mem_control_logic #(.mwidth(32), .addr_width(`B_cnt_width), .start_cnt_bits(6), .start_val(35), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 B9 (.clk(clk), .reset(reset), .enable(enable), .sparsity_level(sparsity_level),
					 .data_out_0(B9_data[31:0]), .data_out_1(B9_data[63:32]), .data_out_2(B9_data[95:64]), .data_out_3(B9_data[127:96]));


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
				 .a_data_out(A_out0_2_in1_2), .b_data_out(B_out0_2_in0_3), .c_data(C0_2_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out0_1), .sparsity_level(sparsity_level), .x_loc(0), .y_loc(2),
				 .accumulate_out(accumulate_out0_2), .valid_out(valid_out0_2));

SA_4x4 TS_0_3 (.clk(clk), .reset(reset), .a_data(A3_data), .b_data(B_out0_2_in0_3),
				 .a_data_out(A_out0_3_in1_3), .b_data_out(B_out0_3_in0_4), .c_data(C0_3_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out0_2), .sparsity_level(sparsity_level), .x_loc(0), .y_loc(3),
				 .accumulate_out(accumulate_out0_3), .valid_out(valid_out0_3));

SA_4x4 TS_0_4 (.clk(clk), .reset(reset), .a_data(A4_data), .b_data(B_out0_3_in0_4),
				 .a_data_out(A_out0_4_in1_4), .b_data_out(B_out0_4_in0_5), .c_data(C0_4_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out0_3), .sparsity_level(sparsity_level), .x_loc(0), .y_loc(4),
				 .accumulate_out(accumulate_out0_4), .valid_out(valid_out0_4));

SA_4x4 TS_0_5 (.clk(clk), .reset(reset), .a_data(A5_data), .b_data(B_out0_4_in0_5),
				 .a_data_out(A_out0_5_in1_5), .b_data_out(B_out0_5_in0_6), .c_data(C0_5_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out0_4), .sparsity_level(sparsity_level), .x_loc(0), .y_loc(5),
				 .accumulate_out(accumulate_out0_5), .valid_out(valid_out0_5));

SA_4x4 TS_0_6 (.clk(clk), .reset(reset), .a_data(A6_data), .b_data(B_out0_5_in0_6),
				 .a_data_out(A_out0_6_in1_6), .b_data_out(B_out0_6_in0_7), .c_data(C0_6_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out0_5), .sparsity_level(sparsity_level), .x_loc(0), .y_loc(6),
				 .accumulate_out(accumulate_out0_6), .valid_out(valid_out0_6));

SA_4x4 TS_0_7 (.clk(clk), .reset(reset), .a_data(A7_data), .b_data(B_out0_6_in0_7),
				 .a_data_out(A_out0_7_in1_7), .b_data_out(B_out0_7_in0_8), .c_data(C0_7_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out0_6), .sparsity_level(sparsity_level), .x_loc(0), .y_loc(7),
				 .accumulate_out(accumulate_out0_7), .valid_out(valid_out0_7));

SA_4x4 TS_0_8 (.clk(clk), .reset(reset), .a_data(A8_data), .b_data(B_out0_7_in0_8),
				 .a_data_out(A_out0_8_in1_8), .b_data_out(B_out0_8_in0_9), .c_data(C0_8_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out0_7), .sparsity_level(sparsity_level), .x_loc(0), .y_loc(8),
				 .accumulate_out(accumulate_out0_8), .valid_out(valid_out0_8));

SA_4x4 TS_0_9 (.clk(clk), .reset(reset), .a_data(A9_data), .b_data(B_out0_8_in0_9),
				 .a_data_out(A_out0_9_in1_9), .b_data_out(), .c_data(C0_9_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out0_8), .sparsity_level(sparsity_level), .x_loc(0), .y_loc(9),
				 .accumulate_out(), .valid_out(valid_out0_9));

SA_4x4 TS_1_0 (.clk(clk), .reset(reset), .a_data(A_out0_0_in1_0), .b_data(B1_data),
				 .a_data_out(A_out1_0_in2_0), .b_data_out(B_out1_0_in1_1), .c_data(C1_0_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out0_0), .sparsity_level(sparsity_level), .x_loc(1), .y_loc(0),
				 .accumulate_out(accumulate_out1_0), .valid_out(valid_out1_0));

SA_4x4 TS_1_1 (.clk(clk), .reset(reset), .a_data(A_out0_1_in1_1), .b_data(B_out1_0_in1_1),
				 .a_data_out(A_out1_1_in2_1), .b_data_out(B_out1_1_in1_2), .c_data(C1_1_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out1_0), .sparsity_level(sparsity_level), .x_loc(1), .y_loc(1),
				 .accumulate_out(accumulate_out1_1), .valid_out(valid_out1_1));

SA_4x4 TS_1_2 (.clk(clk), .reset(reset), .a_data(A_out0_2_in1_2), .b_data(B_out1_1_in1_2),
				 .a_data_out(A_out1_2_in2_2), .b_data_out(B_out1_2_in1_3), .c_data(C1_2_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out1_1), .sparsity_level(sparsity_level), .x_loc(1), .y_loc(2),
				 .accumulate_out(accumulate_out1_2), .valid_out(valid_out1_2));

SA_4x4 TS_1_3 (.clk(clk), .reset(reset), .a_data(A_out0_3_in1_3), .b_data(B_out1_2_in1_3),
				 .a_data_out(A_out1_3_in2_3), .b_data_out(B_out1_3_in1_4), .c_data(C1_3_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out1_2), .sparsity_level(sparsity_level), .x_loc(1), .y_loc(3),
				 .accumulate_out(accumulate_out1_3), .valid_out(valid_out1_3));

SA_4x4 TS_1_4 (.clk(clk), .reset(reset), .a_data(A_out0_4_in1_4), .b_data(B_out1_3_in1_4),
				 .a_data_out(A_out1_4_in2_4), .b_data_out(B_out1_4_in1_5), .c_data(C1_4_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out1_3), .sparsity_level(sparsity_level), .x_loc(1), .y_loc(4),
				 .accumulate_out(accumulate_out1_4), .valid_out(valid_out1_4));

SA_4x4 TS_1_5 (.clk(clk), .reset(reset), .a_data(A_out0_5_in1_5), .b_data(B_out1_4_in1_5),
				 .a_data_out(A_out1_5_in2_5), .b_data_out(B_out1_5_in1_6), .c_data(C1_5_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out1_4), .sparsity_level(sparsity_level), .x_loc(1), .y_loc(5),
				 .accumulate_out(accumulate_out1_5), .valid_out(valid_out1_5));

SA_4x4 TS_1_6 (.clk(clk), .reset(reset), .a_data(A_out0_6_in1_6), .b_data(B_out1_5_in1_6),
				 .a_data_out(A_out1_6_in2_6), .b_data_out(B_out1_6_in1_7), .c_data(C1_6_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out1_5), .sparsity_level(sparsity_level), .x_loc(1), .y_loc(6),
				 .accumulate_out(accumulate_out1_6), .valid_out(valid_out1_6));

SA_4x4 TS_1_7 (.clk(clk), .reset(reset), .a_data(A_out0_7_in1_7), .b_data(B_out1_6_in1_7),
				 .a_data_out(A_out1_7_in2_7), .b_data_out(B_out1_7_in1_8), .c_data(C1_7_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out1_6), .sparsity_level(sparsity_level), .x_loc(1), .y_loc(7),
				 .accumulate_out(accumulate_out1_7), .valid_out(valid_out1_7));

SA_4x4 TS_1_8 (.clk(clk), .reset(reset), .a_data(A_out0_8_in1_8), .b_data(B_out1_7_in1_8),
				 .a_data_out(A_out1_8_in2_8), .b_data_out(B_out1_8_in1_9), .c_data(C1_8_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out1_7), .sparsity_level(sparsity_level), .x_loc(1), .y_loc(8),
				 .accumulate_out(accumulate_out1_8), .valid_out(valid_out1_8));

SA_4x4 TS_1_9 (.clk(clk), .reset(reset), .a_data(A_out0_9_in1_9), .b_data(B_out1_8_in1_9),
				 .a_data_out(A_out1_9_in2_9), .b_data_out(), .c_data(C1_9_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out1_8), .sparsity_level(sparsity_level), .x_loc(1), .y_loc(9),
				 .accumulate_out(), .valid_out(valid_out1_9));

SA_4x4 TS_2_0 (.clk(clk), .reset(reset), .a_data(A_out1_0_in2_0), .b_data(B2_data),
				 .a_data_out(A_out2_0_in3_0), .b_data_out(B_out2_0_in2_1), .c_data(C2_0_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out1_0), .sparsity_level(sparsity_level), .x_loc(2), .y_loc(0),
				 .accumulate_out(accumulate_out2_0), .valid_out(valid_out2_0));

SA_4x4 TS_2_1 (.clk(clk), .reset(reset), .a_data(A_out1_1_in2_1), .b_data(B_out2_0_in2_1),
				 .a_data_out(A_out2_1_in3_1), .b_data_out(B_out2_1_in2_2), .c_data(C2_1_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out2_0), .sparsity_level(sparsity_level), .x_loc(2), .y_loc(1),
				 .accumulate_out(accumulate_out2_1), .valid_out(valid_out2_1));

SA_4x4 TS_2_2 (.clk(clk), .reset(reset), .a_data(A_out1_2_in2_2), .b_data(B_out2_1_in2_2),
				 .a_data_out(A_out2_2_in3_2), .b_data_out(B_out2_2_in2_3), .c_data(C2_2_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out2_1), .sparsity_level(sparsity_level), .x_loc(2), .y_loc(2),
				 .accumulate_out(accumulate_out2_2), .valid_out(valid_out2_2));

SA_4x4 TS_2_3 (.clk(clk), .reset(reset), .a_data(A_out1_3_in2_3), .b_data(B_out2_2_in2_3),
				 .a_data_out(A_out2_3_in3_3), .b_data_out(B_out2_3_in2_4), .c_data(C2_3_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out2_2), .sparsity_level(sparsity_level), .x_loc(2), .y_loc(3),
				 .accumulate_out(accumulate_out2_3), .valid_out(valid_out2_3));

SA_4x4 TS_2_4 (.clk(clk), .reset(reset), .a_data(A_out1_4_in2_4), .b_data(B_out2_3_in2_4),
				 .a_data_out(A_out2_4_in3_4), .b_data_out(B_out2_4_in2_5), .c_data(C2_4_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out2_3), .sparsity_level(sparsity_level), .x_loc(2), .y_loc(4),
				 .accumulate_out(accumulate_out2_4), .valid_out(valid_out2_4));

SA_4x4 TS_2_5 (.clk(clk), .reset(reset), .a_data(A_out1_5_in2_5), .b_data(B_out2_4_in2_5),
				 .a_data_out(A_out2_5_in3_5), .b_data_out(B_out2_5_in2_6), .c_data(C2_5_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out2_4), .sparsity_level(sparsity_level), .x_loc(2), .y_loc(5),
				 .accumulate_out(accumulate_out2_5), .valid_out(valid_out2_5));

SA_4x4 TS_2_6 (.clk(clk), .reset(reset), .a_data(A_out1_6_in2_6), .b_data(B_out2_5_in2_6),
				 .a_data_out(A_out2_6_in3_6), .b_data_out(B_out2_6_in2_7), .c_data(C2_6_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out2_5), .sparsity_level(sparsity_level), .x_loc(2), .y_loc(6),
				 .accumulate_out(accumulate_out2_6), .valid_out(valid_out2_6));

SA_4x4 TS_2_7 (.clk(clk), .reset(reset), .a_data(A_out1_7_in2_7), .b_data(B_out2_6_in2_7),
				 .a_data_out(A_out2_7_in3_7), .b_data_out(B_out2_7_in2_8), .c_data(C2_7_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out2_6), .sparsity_level(sparsity_level), .x_loc(2), .y_loc(7),
				 .accumulate_out(accumulate_out2_7), .valid_out(valid_out2_7));

SA_4x4 TS_2_8 (.clk(clk), .reset(reset), .a_data(A_out1_8_in2_8), .b_data(B_out2_7_in2_8),
				 .a_data_out(A_out2_8_in3_8), .b_data_out(B_out2_8_in2_9), .c_data(C2_8_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out2_7), .sparsity_level(sparsity_level), .x_loc(2), .y_loc(8),
				 .accumulate_out(accumulate_out2_8), .valid_out(valid_out2_8));

SA_4x4 TS_2_9 (.clk(clk), .reset(reset), .a_data(A_out1_9_in2_9), .b_data(B_out2_8_in2_9),
				 .a_data_out(A_out2_9_in3_9), .b_data_out(), .c_data(C2_9_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out2_8), .sparsity_level(sparsity_level), .x_loc(2), .y_loc(9),
				 .accumulate_out(), .valid_out(valid_out2_9));

SA_4x4 TS_3_0 (.clk(clk), .reset(reset), .a_data(A_out2_0_in3_0), .b_data(B3_data),
				 .a_data_out(A_out3_0_in4_0), .b_data_out(B_out3_0_in3_1), .c_data(C3_0_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out2_0), .sparsity_level(sparsity_level), .x_loc(3), .y_loc(0),
				 .accumulate_out(accumulate_out3_0), .valid_out(valid_out3_0));

SA_4x4 TS_3_1 (.clk(clk), .reset(reset), .a_data(A_out2_1_in3_1), .b_data(B_out3_0_in3_1),
				 .a_data_out(A_out3_1_in4_1), .b_data_out(B_out3_1_in3_2), .c_data(C3_1_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out3_0), .sparsity_level(sparsity_level), .x_loc(3), .y_loc(1),
				 .accumulate_out(accumulate_out3_1), .valid_out(valid_out3_1));

SA_4x4 TS_3_2 (.clk(clk), .reset(reset), .a_data(A_out2_2_in3_2), .b_data(B_out3_1_in3_2),
				 .a_data_out(A_out3_2_in4_2), .b_data_out(B_out3_2_in3_3), .c_data(C3_2_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out3_1), .sparsity_level(sparsity_level), .x_loc(3), .y_loc(2),
				 .accumulate_out(accumulate_out3_2), .valid_out(valid_out3_2));

SA_4x4 TS_3_3 (.clk(clk), .reset(reset), .a_data(A_out2_3_in3_3), .b_data(B_out3_2_in3_3),
				 .a_data_out(A_out3_3_in4_3), .b_data_out(B_out3_3_in3_4), .c_data(C3_3_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out3_2), .sparsity_level(sparsity_level), .x_loc(3), .y_loc(3),
				 .accumulate_out(accumulate_out3_3), .valid_out(valid_out3_3));

SA_4x4 TS_3_4 (.clk(clk), .reset(reset), .a_data(A_out2_4_in3_4), .b_data(B_out3_3_in3_4),
				 .a_data_out(A_out3_4_in4_4), .b_data_out(B_out3_4_in3_5), .c_data(C3_4_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out3_3), .sparsity_level(sparsity_level), .x_loc(3), .y_loc(4),
				 .accumulate_out(accumulate_out3_4), .valid_out(valid_out3_4));

SA_4x4 TS_3_5 (.clk(clk), .reset(reset), .a_data(A_out2_5_in3_5), .b_data(B_out3_4_in3_5),
				 .a_data_out(A_out3_5_in4_5), .b_data_out(B_out3_5_in3_6), .c_data(C3_5_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out3_4), .sparsity_level(sparsity_level), .x_loc(3), .y_loc(5),
				 .accumulate_out(accumulate_out3_5), .valid_out(valid_out3_5));

SA_4x4 TS_3_6 (.clk(clk), .reset(reset), .a_data(A_out2_6_in3_6), .b_data(B_out3_5_in3_6),
				 .a_data_out(A_out3_6_in4_6), .b_data_out(B_out3_6_in3_7), .c_data(C3_6_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out3_5), .sparsity_level(sparsity_level), .x_loc(3), .y_loc(6),
				 .accumulate_out(accumulate_out3_6), .valid_out(valid_out3_6));

SA_4x4 TS_3_7 (.clk(clk), .reset(reset), .a_data(A_out2_7_in3_7), .b_data(B_out3_6_in3_7),
				 .a_data_out(A_out3_7_in4_7), .b_data_out(B_out3_7_in3_8), .c_data(C3_7_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out3_6), .sparsity_level(sparsity_level), .x_loc(3), .y_loc(7),
				 .accumulate_out(accumulate_out3_7), .valid_out(valid_out3_7));

SA_4x4 TS_3_8 (.clk(clk), .reset(reset), .a_data(A_out2_8_in3_8), .b_data(B_out3_7_in3_8),
				 .a_data_out(A_out3_8_in4_8), .b_data_out(B_out3_8_in3_9), .c_data(C3_8_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out3_7), .sparsity_level(sparsity_level), .x_loc(3), .y_loc(8),
				 .accumulate_out(accumulate_out3_8), .valid_out(valid_out3_8));

SA_4x4 TS_3_9 (.clk(clk), .reset(reset), .a_data(A_out2_9_in3_9), .b_data(B_out3_8_in3_9),
				 .a_data_out(A_out3_9_in4_9), .b_data_out(), .c_data(C3_9_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out3_8), .sparsity_level(sparsity_level), .x_loc(3), .y_loc(9),
				 .accumulate_out(), .valid_out(valid_out3_9));

SA_4x4 TS_4_0 (.clk(clk), .reset(reset), .a_data(A_out3_0_in4_0), .b_data(B4_data),
				 .a_data_out(A_out4_0_in5_0), .b_data_out(B_out4_0_in4_1), .c_data(C4_0_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out3_0), .sparsity_level(sparsity_level), .x_loc(4), .y_loc(0),
				 .accumulate_out(accumulate_out4_0), .valid_out(valid_out4_0));

SA_4x4 TS_4_1 (.clk(clk), .reset(reset), .a_data(A_out3_1_in4_1), .b_data(B_out4_0_in4_1),
				 .a_data_out(A_out4_1_in5_1), .b_data_out(B_out4_1_in4_2), .c_data(C4_1_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out4_0), .sparsity_level(sparsity_level), .x_loc(4), .y_loc(1),
				 .accumulate_out(accumulate_out4_1), .valid_out(valid_out4_1));

SA_4x4 TS_4_2 (.clk(clk), .reset(reset), .a_data(A_out3_2_in4_2), .b_data(B_out4_1_in4_2),
				 .a_data_out(A_out4_2_in5_2), .b_data_out(B_out4_2_in4_3), .c_data(C4_2_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out4_1), .sparsity_level(sparsity_level), .x_loc(4), .y_loc(2),
				 .accumulate_out(accumulate_out4_2), .valid_out(valid_out4_2));

SA_4x4 TS_4_3 (.clk(clk), .reset(reset), .a_data(A_out3_3_in4_3), .b_data(B_out4_2_in4_3),
				 .a_data_out(A_out4_3_in5_3), .b_data_out(B_out4_3_in4_4), .c_data(C4_3_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out4_2), .sparsity_level(sparsity_level), .x_loc(4), .y_loc(3),
				 .accumulate_out(accumulate_out4_3), .valid_out(valid_out4_3));

SA_4x4 TS_4_4 (.clk(clk), .reset(reset), .a_data(A_out3_4_in4_4), .b_data(B_out4_3_in4_4),
				 .a_data_out(A_out4_4_in5_4), .b_data_out(B_out4_4_in4_5), .c_data(C4_4_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out4_3), .sparsity_level(sparsity_level), .x_loc(4), .y_loc(4),
				 .accumulate_out(accumulate_out4_4), .valid_out(valid_out4_4));

SA_4x4 TS_4_5 (.clk(clk), .reset(reset), .a_data(A_out3_5_in4_5), .b_data(B_out4_4_in4_5),
				 .a_data_out(A_out4_5_in5_5), .b_data_out(B_out4_5_in4_6), .c_data(C4_5_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out4_4), .sparsity_level(sparsity_level), .x_loc(4), .y_loc(5),
				 .accumulate_out(accumulate_out4_5), .valid_out(valid_out4_5));

SA_4x4 TS_4_6 (.clk(clk), .reset(reset), .a_data(A_out3_6_in4_6), .b_data(B_out4_5_in4_6),
				 .a_data_out(A_out4_6_in5_6), .b_data_out(B_out4_6_in4_7), .c_data(C4_6_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out4_5), .sparsity_level(sparsity_level), .x_loc(4), .y_loc(6),
				 .accumulate_out(accumulate_out4_6), .valid_out(valid_out4_6));

SA_4x4 TS_4_7 (.clk(clk), .reset(reset), .a_data(A_out3_7_in4_7), .b_data(B_out4_6_in4_7),
				 .a_data_out(A_out4_7_in5_7), .b_data_out(B_out4_7_in4_8), .c_data(C4_7_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out4_6), .sparsity_level(sparsity_level), .x_loc(4), .y_loc(7),
				 .accumulate_out(accumulate_out4_7), .valid_out(valid_out4_7));

SA_4x4 TS_4_8 (.clk(clk), .reset(reset), .a_data(A_out3_8_in4_8), .b_data(B_out4_7_in4_8),
				 .a_data_out(A_out4_8_in5_8), .b_data_out(B_out4_8_in4_9), .c_data(C4_8_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out4_7), .sparsity_level(sparsity_level), .x_loc(4), .y_loc(8),
				 .accumulate_out(accumulate_out4_8), .valid_out(valid_out4_8));

SA_4x4 TS_4_9 (.clk(clk), .reset(reset), .a_data(A_out3_9_in4_9), .b_data(B_out4_8_in4_9),
				 .a_data_out(A_out4_9_in5_9), .b_data_out(), .c_data(C4_9_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out4_8), .sparsity_level(sparsity_level), .x_loc(4), .y_loc(9),
				 .accumulate_out(), .valid_out(valid_out4_9));

SA_4x4 TS_5_0 (.clk(clk), .reset(reset), .a_data(A_out4_0_in5_0), .b_data(B5_data),
				 .a_data_out(A_out5_0_in6_0), .b_data_out(B_out5_0_in5_1), .c_data(C5_0_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out4_0), .sparsity_level(sparsity_level), .x_loc(5), .y_loc(0),
				 .accumulate_out(accumulate_out5_0), .valid_out(valid_out5_0));

SA_4x4 TS_5_1 (.clk(clk), .reset(reset), .a_data(A_out4_1_in5_1), .b_data(B_out5_0_in5_1),
				 .a_data_out(A_out5_1_in6_1), .b_data_out(B_out5_1_in5_2), .c_data(C5_1_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out5_0), .sparsity_level(sparsity_level), .x_loc(5), .y_loc(1),
				 .accumulate_out(accumulate_out5_1), .valid_out(valid_out5_1));

SA_4x4 TS_5_2 (.clk(clk), .reset(reset), .a_data(A_out4_2_in5_2), .b_data(B_out5_1_in5_2),
				 .a_data_out(A_out5_2_in6_2), .b_data_out(B_out5_2_in5_3), .c_data(C5_2_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out5_1), .sparsity_level(sparsity_level), .x_loc(5), .y_loc(2),
				 .accumulate_out(accumulate_out5_2), .valid_out(valid_out5_2));

SA_4x4 TS_5_3 (.clk(clk), .reset(reset), .a_data(A_out4_3_in5_3), .b_data(B_out5_2_in5_3),
				 .a_data_out(A_out5_3_in6_3), .b_data_out(B_out5_3_in5_4), .c_data(C5_3_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out5_2), .sparsity_level(sparsity_level), .x_loc(5), .y_loc(3),
				 .accumulate_out(accumulate_out5_3), .valid_out(valid_out5_3));

SA_4x4 TS_5_4 (.clk(clk), .reset(reset), .a_data(A_out4_4_in5_4), .b_data(B_out5_3_in5_4),
				 .a_data_out(A_out5_4_in6_4), .b_data_out(B_out5_4_in5_5), .c_data(C5_4_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out5_3), .sparsity_level(sparsity_level), .x_loc(5), .y_loc(4),
				 .accumulate_out(accumulate_out5_4), .valid_out(valid_out5_4));

SA_4x4 TS_5_5 (.clk(clk), .reset(reset), .a_data(A_out4_5_in5_5), .b_data(B_out5_4_in5_5),
				 .a_data_out(A_out5_5_in6_5), .b_data_out(B_out5_5_in5_6), .c_data(C5_5_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out5_4), .sparsity_level(sparsity_level), .x_loc(5), .y_loc(5),
				 .accumulate_out(accumulate_out5_5), .valid_out(valid_out5_5));

SA_4x4 TS_5_6 (.clk(clk), .reset(reset), .a_data(A_out4_6_in5_6), .b_data(B_out5_5_in5_6),
				 .a_data_out(A_out5_6_in6_6), .b_data_out(B_out5_6_in5_7), .c_data(C5_6_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out5_5), .sparsity_level(sparsity_level), .x_loc(5), .y_loc(6),
				 .accumulate_out(accumulate_out5_6), .valid_out(valid_out5_6));

SA_4x4 TS_5_7 (.clk(clk), .reset(reset), .a_data(A_out4_7_in5_7), .b_data(B_out5_6_in5_7),
				 .a_data_out(A_out5_7_in6_7), .b_data_out(B_out5_7_in5_8), .c_data(C5_7_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out5_6), .sparsity_level(sparsity_level), .x_loc(5), .y_loc(7),
				 .accumulate_out(accumulate_out5_7), .valid_out(valid_out5_7));

SA_4x4 TS_5_8 (.clk(clk), .reset(reset), .a_data(A_out4_8_in5_8), .b_data(B_out5_7_in5_8),
				 .a_data_out(A_out5_8_in6_8), .b_data_out(B_out5_8_in5_9), .c_data(C5_8_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out5_7), .sparsity_level(sparsity_level), .x_loc(5), .y_loc(8),
				 .accumulate_out(accumulate_out5_8), .valid_out(valid_out5_8));

SA_4x4 TS_5_9 (.clk(clk), .reset(reset), .a_data(A_out4_9_in5_9), .b_data(B_out5_8_in5_9),
				 .a_data_out(A_out5_9_in6_9), .b_data_out(), .c_data(C5_9_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out5_8), .sparsity_level(sparsity_level), .x_loc(5), .y_loc(9),
				 .accumulate_out(), .valid_out(valid_out5_9));

SA_4x4 TS_6_0 (.clk(clk), .reset(reset), .a_data(A_out5_0_in6_0), .b_data(B6_data),
				 .a_data_out(A_out6_0_in7_0), .b_data_out(B_out6_0_in6_1), .c_data(C6_0_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out5_0), .sparsity_level(sparsity_level), .x_loc(6), .y_loc(0),
				 .accumulate_out(accumulate_out6_0), .valid_out(valid_out6_0));

SA_4x4 TS_6_1 (.clk(clk), .reset(reset), .a_data(A_out5_1_in6_1), .b_data(B_out6_0_in6_1),
				 .a_data_out(A_out6_1_in7_1), .b_data_out(B_out6_1_in6_2), .c_data(C6_1_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out6_0), .sparsity_level(sparsity_level), .x_loc(6), .y_loc(1),
				 .accumulate_out(accumulate_out6_1), .valid_out(valid_out6_1));

SA_4x4 TS_6_2 (.clk(clk), .reset(reset), .a_data(A_out5_2_in6_2), .b_data(B_out6_1_in6_2),
				 .a_data_out(A_out6_2_in7_2), .b_data_out(B_out6_2_in6_3), .c_data(C6_2_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out6_1), .sparsity_level(sparsity_level), .x_loc(6), .y_loc(2),
				 .accumulate_out(accumulate_out6_2), .valid_out(valid_out6_2));

SA_4x4 TS_6_3 (.clk(clk), .reset(reset), .a_data(A_out5_3_in6_3), .b_data(B_out6_2_in6_3),
				 .a_data_out(A_out6_3_in7_3), .b_data_out(B_out6_3_in6_4), .c_data(C6_3_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out6_2), .sparsity_level(sparsity_level), .x_loc(6), .y_loc(3),
				 .accumulate_out(accumulate_out6_3), .valid_out(valid_out6_3));

SA_4x4 TS_6_4 (.clk(clk), .reset(reset), .a_data(A_out5_4_in6_4), .b_data(B_out6_3_in6_4),
				 .a_data_out(A_out6_4_in7_4), .b_data_out(B_out6_4_in6_5), .c_data(C6_4_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out6_3), .sparsity_level(sparsity_level), .x_loc(6), .y_loc(4),
				 .accumulate_out(accumulate_out6_4), .valid_out(valid_out6_4));

SA_4x4 TS_6_5 (.clk(clk), .reset(reset), .a_data(A_out5_5_in6_5), .b_data(B_out6_4_in6_5),
				 .a_data_out(A_out6_5_in7_5), .b_data_out(B_out6_5_in6_6), .c_data(C6_5_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out6_4), .sparsity_level(sparsity_level), .x_loc(6), .y_loc(5),
				 .accumulate_out(accumulate_out6_5), .valid_out(valid_out6_5));

SA_4x4 TS_6_6 (.clk(clk), .reset(reset), .a_data(A_out5_6_in6_6), .b_data(B_out6_5_in6_6),
				 .a_data_out(A_out6_6_in7_6), .b_data_out(B_out6_6_in6_7), .c_data(C6_6_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out6_5), .sparsity_level(sparsity_level), .x_loc(6), .y_loc(6),
				 .accumulate_out(accumulate_out6_6), .valid_out(valid_out6_6));

SA_4x4 TS_6_7 (.clk(clk), .reset(reset), .a_data(A_out5_7_in6_7), .b_data(B_out6_6_in6_7),
				 .a_data_out(A_out6_7_in7_7), .b_data_out(B_out6_7_in6_8), .c_data(C6_7_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out6_6), .sparsity_level(sparsity_level), .x_loc(6), .y_loc(7),
				 .accumulate_out(accumulate_out6_7), .valid_out(valid_out6_7));

SA_4x4 TS_6_8 (.clk(clk), .reset(reset), .a_data(A_out5_8_in6_8), .b_data(B_out6_7_in6_8),
				 .a_data_out(A_out6_8_in7_8), .b_data_out(B_out6_8_in6_9), .c_data(C6_8_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out6_7), .sparsity_level(sparsity_level), .x_loc(6), .y_loc(8),
				 .accumulate_out(accumulate_out6_8), .valid_out(valid_out6_8));

SA_4x4 TS_6_9 (.clk(clk), .reset(reset), .a_data(A_out5_9_in6_9), .b_data(B_out6_8_in6_9),
				 .a_data_out(A_out6_9_in7_9), .b_data_out(), .c_data(C6_9_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out6_8), .sparsity_level(sparsity_level), .x_loc(6), .y_loc(9),
				 .accumulate_out(), .valid_out(valid_out6_9));

SA_4x4 TS_7_0 (.clk(clk), .reset(reset), .a_data(A_out6_0_in7_0), .b_data(B7_data),
				 .a_data_out(A_out7_0_in8_0), .b_data_out(B_out7_0_in7_1), .c_data(C7_0_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out6_0), .sparsity_level(sparsity_level), .x_loc(7), .y_loc(0),
				 .accumulate_out(accumulate_out7_0), .valid_out(valid_out7_0));

SA_4x4 TS_7_1 (.clk(clk), .reset(reset), .a_data(A_out6_1_in7_1), .b_data(B_out7_0_in7_1),
				 .a_data_out(A_out7_1_in8_1), .b_data_out(B_out7_1_in7_2), .c_data(C7_1_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out7_0), .sparsity_level(sparsity_level), .x_loc(7), .y_loc(1),
				 .accumulate_out(accumulate_out7_1), .valid_out(valid_out7_1));

SA_4x4 TS_7_2 (.clk(clk), .reset(reset), .a_data(A_out6_2_in7_2), .b_data(B_out7_1_in7_2),
				 .a_data_out(A_out7_2_in8_2), .b_data_out(B_out7_2_in7_3), .c_data(C7_2_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out7_1), .sparsity_level(sparsity_level), .x_loc(7), .y_loc(2),
				 .accumulate_out(accumulate_out7_2), .valid_out(valid_out7_2));

SA_4x4 TS_7_3 (.clk(clk), .reset(reset), .a_data(A_out6_3_in7_3), .b_data(B_out7_2_in7_3),
				 .a_data_out(A_out7_3_in8_3), .b_data_out(B_out7_3_in7_4), .c_data(C7_3_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out7_2), .sparsity_level(sparsity_level), .x_loc(7), .y_loc(3),
				 .accumulate_out(accumulate_out7_3), .valid_out(valid_out7_3));

SA_4x4 TS_7_4 (.clk(clk), .reset(reset), .a_data(A_out6_4_in7_4), .b_data(B_out7_3_in7_4),
				 .a_data_out(A_out7_4_in8_4), .b_data_out(B_out7_4_in7_5), .c_data(C7_4_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out7_3), .sparsity_level(sparsity_level), .x_loc(7), .y_loc(4),
				 .accumulate_out(accumulate_out7_4), .valid_out(valid_out7_4));

SA_4x4 TS_7_5 (.clk(clk), .reset(reset), .a_data(A_out6_5_in7_5), .b_data(B_out7_4_in7_5),
				 .a_data_out(A_out7_5_in8_5), .b_data_out(B_out7_5_in7_6), .c_data(C7_5_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out7_4), .sparsity_level(sparsity_level), .x_loc(7), .y_loc(5),
				 .accumulate_out(accumulate_out7_5), .valid_out(valid_out7_5));

SA_4x4 TS_7_6 (.clk(clk), .reset(reset), .a_data(A_out6_6_in7_6), .b_data(B_out7_5_in7_6),
				 .a_data_out(A_out7_6_in8_6), .b_data_out(B_out7_6_in7_7), .c_data(C7_6_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out7_5), .sparsity_level(sparsity_level), .x_loc(7), .y_loc(6),
				 .accumulate_out(accumulate_out7_6), .valid_out(valid_out7_6));

SA_4x4 TS_7_7 (.clk(clk), .reset(reset), .a_data(A_out6_7_in7_7), .b_data(B_out7_6_in7_7),
				 .a_data_out(A_out7_7_in8_7), .b_data_out(B_out7_7_in7_8), .c_data(C7_7_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out7_6), .sparsity_level(sparsity_level), .x_loc(7), .y_loc(7),
				 .accumulate_out(accumulate_out7_7), .valid_out(valid_out7_7));

SA_4x4 TS_7_8 (.clk(clk), .reset(reset), .a_data(A_out6_8_in7_8), .b_data(B_out7_7_in7_8),
				 .a_data_out(A_out7_8_in8_8), .b_data_out(B_out7_8_in7_9), .c_data(C7_8_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out7_7), .sparsity_level(sparsity_level), .x_loc(7), .y_loc(8),
				 .accumulate_out(accumulate_out7_8), .valid_out(valid_out7_8));

SA_4x4 TS_7_9 (.clk(clk), .reset(reset), .a_data(A_out6_9_in7_9), .b_data(B_out7_8_in7_9),
				 .a_data_out(A_out7_9_in8_9), .b_data_out(), .c_data(C7_9_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out7_8), .sparsity_level(sparsity_level), .x_loc(7), .y_loc(9),
				 .accumulate_out(), .valid_out(valid_out7_9));

SA_4x4 TS_8_0 (.clk(clk), .reset(reset), .a_data(A_out7_0_in8_0), .b_data(B8_data),
				 .a_data_out(A_out8_0_in9_0), .b_data_out(B_out8_0_in8_1), .c_data(C8_0_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out7_0), .sparsity_level(sparsity_level), .x_loc(8), .y_loc(0),
				 .accumulate_out(accumulate_out8_0), .valid_out(valid_out8_0));

SA_4x4 TS_8_1 (.clk(clk), .reset(reset), .a_data(A_out7_1_in8_1), .b_data(B_out8_0_in8_1),
				 .a_data_out(A_out8_1_in9_1), .b_data_out(B_out8_1_in8_2), .c_data(C8_1_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out8_0), .sparsity_level(sparsity_level), .x_loc(8), .y_loc(1),
				 .accumulate_out(accumulate_out8_1), .valid_out(valid_out8_1));

SA_4x4 TS_8_2 (.clk(clk), .reset(reset), .a_data(A_out7_2_in8_2), .b_data(B_out8_1_in8_2),
				 .a_data_out(A_out8_2_in9_2), .b_data_out(B_out8_2_in8_3), .c_data(C8_2_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out8_1), .sparsity_level(sparsity_level), .x_loc(8), .y_loc(2),
				 .accumulate_out(accumulate_out8_2), .valid_out(valid_out8_2));

SA_4x4 TS_8_3 (.clk(clk), .reset(reset), .a_data(A_out7_3_in8_3), .b_data(B_out8_2_in8_3),
				 .a_data_out(A_out8_3_in9_3), .b_data_out(B_out8_3_in8_4), .c_data(C8_3_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out8_2), .sparsity_level(sparsity_level), .x_loc(8), .y_loc(3),
				 .accumulate_out(accumulate_out8_3), .valid_out(valid_out8_3));

SA_4x4 TS_8_4 (.clk(clk), .reset(reset), .a_data(A_out7_4_in8_4), .b_data(B_out8_3_in8_4),
				 .a_data_out(A_out8_4_in9_4), .b_data_out(B_out8_4_in8_5), .c_data(C8_4_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out8_3), .sparsity_level(sparsity_level), .x_loc(8), .y_loc(4),
				 .accumulate_out(accumulate_out8_4), .valid_out(valid_out8_4));

SA_4x4 TS_8_5 (.clk(clk), .reset(reset), .a_data(A_out7_5_in8_5), .b_data(B_out8_4_in8_5),
				 .a_data_out(A_out8_5_in9_5), .b_data_out(B_out8_5_in8_6), .c_data(C8_5_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out8_4), .sparsity_level(sparsity_level), .x_loc(8), .y_loc(5),
				 .accumulate_out(accumulate_out8_5), .valid_out(valid_out8_5));

SA_4x4 TS_8_6 (.clk(clk), .reset(reset), .a_data(A_out7_6_in8_6), .b_data(B_out8_5_in8_6),
				 .a_data_out(A_out8_6_in9_6), .b_data_out(B_out8_6_in8_7), .c_data(C8_6_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out8_5), .sparsity_level(sparsity_level), .x_loc(8), .y_loc(6),
				 .accumulate_out(accumulate_out8_6), .valid_out(valid_out8_6));

SA_4x4 TS_8_7 (.clk(clk), .reset(reset), .a_data(A_out7_7_in8_7), .b_data(B_out8_6_in8_7),
				 .a_data_out(A_out8_7_in9_7), .b_data_out(B_out8_7_in8_8), .c_data(C8_7_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out8_6), .sparsity_level(sparsity_level), .x_loc(8), .y_loc(7),
				 .accumulate_out(accumulate_out8_7), .valid_out(valid_out8_7));

SA_4x4 TS_8_8 (.clk(clk), .reset(reset), .a_data(A_out7_8_in8_8), .b_data(B_out8_7_in8_8),
				 .a_data_out(A_out8_8_in9_8), .b_data_out(B_out8_8_in8_9), .c_data(C8_8_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out8_7), .sparsity_level(sparsity_level), .x_loc(8), .y_loc(8),
				 .accumulate_out(accumulate_out8_8), .valid_out(valid_out8_8));

SA_4x4 TS_8_9 (.clk(clk), .reset(reset), .a_data(A_out7_9_in8_9), .b_data(B_out8_8_in8_9),
				 .a_data_out(A_out8_9_in9_9), .b_data_out(), .c_data(C8_9_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out8_8), .sparsity_level(sparsity_level), .x_loc(8), .y_loc(9),
				 .accumulate_out(), .valid_out(valid_out8_9));

SA_4x4 TS_9_0 (.clk(clk), .reset(reset), .a_data(A_out8_0_in9_0), .b_data(B9_data),
				 .a_data_out(), .b_data_out(B_out9_0_in9_1), .c_data(C9_0_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out8_0), .sparsity_level(sparsity_level), .x_loc(9), .y_loc(0),
				 .accumulate_out(accumulate_out9_0), .valid_out(valid_out9_0));

SA_4x4 TS_9_1 (.clk(clk), .reset(reset), .a_data(A_out8_1_in9_1), .b_data(B_out9_0_in9_1),
				 .a_data_out(), .b_data_out(B_out9_1_in9_2), .c_data(C9_1_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out9_0), .sparsity_level(sparsity_level), .x_loc(9), .y_loc(1),
				 .accumulate_out(accumulate_out9_1), .valid_out(valid_out9_1));

SA_4x4 TS_9_2 (.clk(clk), .reset(reset), .a_data(A_out8_2_in9_2), .b_data(B_out9_1_in9_2),
				 .a_data_out(), .b_data_out(B_out9_2_in9_3), .c_data(C9_2_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out9_1), .sparsity_level(sparsity_level), .x_loc(9), .y_loc(2),
				 .accumulate_out(accumulate_out9_2), .valid_out(valid_out9_2));

SA_4x4 TS_9_3 (.clk(clk), .reset(reset), .a_data(A_out8_3_in9_3), .b_data(B_out9_2_in9_3),
				 .a_data_out(), .b_data_out(B_out9_3_in9_4), .c_data(C9_3_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out9_2), .sparsity_level(sparsity_level), .x_loc(9), .y_loc(3),
				 .accumulate_out(accumulate_out9_3), .valid_out(valid_out9_3));

SA_4x4 TS_9_4 (.clk(clk), .reset(reset), .a_data(A_out8_4_in9_4), .b_data(B_out9_3_in9_4),
				 .a_data_out(), .b_data_out(B_out9_4_in9_5), .c_data(C9_4_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out9_3), .sparsity_level(sparsity_level), .x_loc(9), .y_loc(4),
				 .accumulate_out(accumulate_out9_4), .valid_out(valid_out9_4));

SA_4x4 TS_9_5 (.clk(clk), .reset(reset), .a_data(A_out8_5_in9_5), .b_data(B_out9_4_in9_5),
				 .a_data_out(), .b_data_out(B_out9_5_in9_6), .c_data(C9_5_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out9_4), .sparsity_level(sparsity_level), .x_loc(9), .y_loc(5),
				 .accumulate_out(accumulate_out9_5), .valid_out(valid_out9_5));

SA_4x4 TS_9_6 (.clk(clk), .reset(reset), .a_data(A_out8_6_in9_6), .b_data(B_out9_5_in9_6),
				 .a_data_out(), .b_data_out(B_out9_6_in9_7), .c_data(C9_6_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out9_5), .sparsity_level(sparsity_level), .x_loc(9), .y_loc(6),
				 .accumulate_out(accumulate_out9_6), .valid_out(valid_out9_6));

SA_4x4 TS_9_7 (.clk(clk), .reset(reset), .a_data(A_out8_7_in9_7), .b_data(B_out9_6_in9_7),
				 .a_data_out(), .b_data_out(B_out9_7_in9_8), .c_data(C9_7_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out9_6), .sparsity_level(sparsity_level), .x_loc(9), .y_loc(7),
				 .accumulate_out(accumulate_out9_7), .valid_out(valid_out9_7));

SA_4x4 TS_9_8 (.clk(clk), .reset(reset), .a_data(A_out8_8_in9_8), .b_data(B_out9_7_in9_8),
				 .a_data_out(), .b_data_out(B_out9_8_in9_9), .c_data(C9_8_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out9_7), .sparsity_level(sparsity_level), .x_loc(9), .y_loc(8),
				 .accumulate_out(accumulate_out9_8), .valid_out(valid_out9_8));

SA_4x4 TS_9_9 (.clk(clk), .reset(reset), .a_data(A_out8_9_in9_9), .b_data(B_out9_8_in9_9),
				 .a_data_out(), .b_data_out(), .c_data(C9_9_data),
				 .K_size(`K), .enable(enable), .accumulate(accumulate_out9_8), .sparsity_level(sparsity_level), .x_loc(9), .y_loc(9),
				 .accumulate_out(), .valid_out(valid_out9_9));


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
    
