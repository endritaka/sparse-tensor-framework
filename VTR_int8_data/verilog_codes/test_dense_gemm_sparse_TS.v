
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
output [35:0] cout_data;

// Ay wires
wire [32-1:0] A0_data;
wire [32-1:0] A1_data;
wire [32-1:0] A2_data;

wire [40-1:0] A_in0_0;
wire [40-1:0] A_in0_1;
wire [40-1:0] A_in0_2;

wire [8-1:0] uncon_a0_0;
wire [8-1:0] uncon_a0_1;
wire [8-1:0] uncon_a0_2;

assign A_in0_0 = {uncon_a0_0, A0_data};
assign A_in0_1 = {uncon_a0_1, A1_data};
assign A_in0_2 = {uncon_a0_2, A2_data};

// Bx wires
wire [32-1:0] B0_data;
wire [32-1:0] B1_data;
wire [32-1:0] B2_data;

wire [128-1:0] B_in0_0;
wire [128-1:0] B_in1_0;
wire [128-1:0] B_in2_0;

wire [96-1:0] uncon_b0_0;
wire [96-1:0] uncon_b1_0;
wire [96-1:0] uncon_b2_0;

assign B_in0_0 = {uncon_b0_0, B0_data};
assign B_in1_0 = {uncon_b1_0, B1_data};
assign B_in2_0 = {uncon_b2_0, B2_data};


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
wire [40-1:0] A_out0_0;
wire [40-1:0] A_out1_0;
wire [40-1:0] A_out0_1;
wire [40-1:0] A_out1_1;
wire [40-1:0] A_out0_2;
wire [40-1:0] A_out1_2;

wire [40-1:0] A_in1_0;
wire [40-1:0] A_in2_0;
wire [40-1:0] A_in1_1;
wire [40-1:0] A_in2_1;
wire [40-1:0] A_in1_2;
wire [40-1:0] A_in2_2;

wire [8-1:0] uncon_in1_0;
wire [8-1:0] uncon_in2_0;
wire [8-1:0] uncon_in1_1;
wire [8-1:0] uncon_in2_1;
wire [8-1:0] uncon_in1_2;
wire [8-1:0] uncon_in2_2;

assign A_in1_0 = {uncon_in1_0, A_out0_0[31:0]};
assign A_in2_0 = {uncon_in2_0, A_out1_0[31:0]};
assign A_in1_1 = {uncon_in1_1, A_out0_1[31:0]};
assign A_in2_1 = {uncon_in2_1, A_out1_1[31:0]};
assign A_in1_2 = {uncon_in1_2, A_out0_2[31:0]};
assign A_in2_2 = {uncon_in2_2, A_out1_2[31:0]};


// vertical connections
wire [10-1:0] B_out0_0_in0_1;
wire [10-1:0] B_out0_1_in0_2;
wire [10-1:0] B_out1_0_in1_1;
wire [10-1:0] B_out1_1_in1_2;
wire [10-1:0] B_out2_0_in2_1;
wire [10-1:0] B_out2_1_in2_2;


// accumulate signal for tiling (generated from control logic)
wire acc_in;


// accumulate_in (unconnected)
wire acc_in0_1;
wire acc_in0_2;
wire acc_in1_1;
wire acc_in1_2;
wire acc_in2_1;
wire acc_in2_2;


// accumulate_out connections (row-wise, x-direction)
wire acc_out0_0_acc_in1_0;
wire acc_out1_0_acc_in2_0;


// Ay
A0_input_mem_control_logic #(.mwidth(32), .addr_width(`A_cnt_width), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 A0 (.clk(clk), .reset(reset), .enable(enable), .data_out(A0_data), .accumulate_out(acc_in));

Ay_input_mem_control_logic #(.mwidth(32), .addr_width(`A_cnt_width), .start_cnt_bits(2), .start_val(3), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 A1 (.clk(clk), .reset(reset), .enable(enable), .data_out(A1_data));

Ay_input_mem_control_logic #(.mwidth(32), .addr_width(`A_cnt_width), .start_cnt_bits(3), .start_val(7), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 A2 (.clk(clk), .reset(reset), .enable(enable), .data_out(A2_data));

// Bx
B0_input_mem_control_logic #(.mwidth(32), .addr_width(`B_cnt_width), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits)) 
					 B0 (.clk(clk), .reset(reset), .enable(enable), .data_out(B0_data));

Bx_input_mem_control_logic #(.mwidth(32), .addr_width(`B_cnt_width), .start_cnt_bits(2), .start_val(3), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 B1 (.clk(clk), .reset(reset), .enable(enable), .data_out(B1_data));

Bx_input_mem_control_logic #(.mwidth(32), .addr_width(`B_cnt_width), .start_cnt_bits(3), .start_val(7), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))
					 B2 (.clk(clk), .reset(reset), .enable(enable), .data_out(B2_data));


// TS_xy
sparse_dense_init TS_0_0 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in0_0), .b_data(B_in0_0), .a_data_out(A_out0_0), .c_data(C0_0_data),
						 .accumulate_out(acc_out0_0_acc_in1_0), .valid_out(valid_out0_0), .b_ded_out(B_out0_0_in0_1));

sparse_dense_middle TS_0_1 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in0_1), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in0_1), .a_data_out(A_out0_1), .c_data(C0_1_data), .accumulate_out(), .valid_out(valid_out0_1),
						 .b_ded_in(B_out0_0_in0_1), .b_ded_out(B_out0_1_in0_2));

sparse_dense_last TS_0_2 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in0_2), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in0_2), .a_data_out(A_out0_2), .c_data(C0_2_data), .accumulate_out(),
						 .valid_out(valid_out0_2), .b_ded_in(B_out0_1_in0_2));

sparse_dense_init TS_1_0 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_out0_0_acc_in1_0), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in1_0), .b_data(B_in1_0), .a_data_out(A_out1_0), .c_data(C1_0_data),
						 .accumulate_out(acc_out1_0_acc_in2_0), .valid_out(valid_out1_0), .b_ded_out(B_out1_0_in1_1));

sparse_dense_middle TS_1_1 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in1_1), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in1_1), .a_data_out(A_out1_1), .c_data(C1_1_data), .accumulate_out(), .valid_out(valid_out1_1),
						 .b_ded_in(B_out1_0_in1_1), .b_ded_out(B_out1_1_in1_2));

sparse_dense_last TS_1_2 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in1_2), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in1_2), .a_data_out(A_out1_2), .c_data(C1_2_data), .accumulate_out(),
						 .valid_out(valid_out1_2), .b_ded_in(B_out1_1_in1_2));

sparse_dense_init TS_2_0 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_out1_0_acc_in2_0), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in2_0), .b_data(B_in2_0), .a_data_out(), .c_data(C2_0_data),
						 .accumulate_out(), .valid_out(valid_out2_0), .b_ded_out(B_out2_0_in2_1));

sparse_dense_middle TS_2_1 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in2_1), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in2_1), .a_data_out(), .c_data(C2_1_data), .accumulate_out(), .valid_out(valid_out2_1),
						 .b_ded_in(B_out2_0_in2_1), .b_ded_out(B_out2_1_in2_2));

sparse_dense_last TS_2_2 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in2_2), .K_size(`K), .sparsity_level(`DENSE),
						 .a_data(A_in2_2), .a_data_out(), .c_data(C2_2_data), .accumulate_out(),
						 .valid_out(valid_out2_2), .b_ded_in(B_out2_1_in2_2));


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
