// `define DWIDTH 8
// `define ACCWIDTH 32
`define DENSE 0
`define SPARSE_2_4 1
`define SPARSE_1_4 2

module sparse_dense_gemm(
    clk,
    reset,
    enable,
    K_size,
    cout_data,
    acc_in);
    
input clk, reset, enable, acc_in;
input [6:0] K_size;
output [8:0] cout_data;


// Ay wires
wire [32-1:0] A0_data;
wire [32-1:0] A1_data;
wire [32-1:0] A2_data;

wire [40-1:0] A_in00;
wire [40-1:0] A_in01;
wire [40-1:0] A_in02;

assign A_in00 = {2'b00, A0_data};
assign A_in01 = {2'b00, A1_data};
assign A_in02 = {2'b00, A2_data};


// Bx wires
wire [32-1:0] B0_data;
wire [32-1:0] B1_data;
wire [32-1:0] B2_data;

wire [128-1:0] B_in00;
wire [128-1:0] B_in10;
wire [128-1:0] B_in20;

wire [96-1:0] uncon_b00;
wire [96-1:0] uncon_b10;
wire [96-1:0] uncon_b20;

assign B_in00 = {uncon_b00, B0_data};
assign B_in10 = {uncon_b10, B1_data};
assign B_in20 = {uncon_b20, B2_data};


// valid_out_xy signals
wire valid_out00;
wire valid_out01;
wire valid_out02;
wire valid_out10;
wire valid_out11;
wire valid_out12;
wire valid_out20;
wire valid_out21;
wire valid_out22;


// Cxy signals
wire [128-1:0] C00_data;
wire [128-1:0] C01_data;
wire [128-1:0] C02_data;
wire [128-1:0] C10_data;
wire [128-1:0] C11_data;
wire [128-1:0] C12_data;
wire [128-1:0] C20_data;
wire [128-1:0] C21_data;
wire [128-1:0] C22_data;


wire [128-1:0] C00_data_out_mem;
wire [128-1:0] C01_data_out_mem;
wire [128-1:0] C02_data_out_mem;
wire [128-1:0] C10_data_out_mem;
wire [128-1:0] C11_data_out_mem;
wire [128-1:0] C12_data_out_mem;
wire [128-1:0] C20_data_out_mem;
wire [128-1:0] C21_data_out_mem;
wire [128-1:0] C22_data_out_mem;


// horizontal connections
wire [40-1:0] A_out00_in10;
wire [40-1:0] A_out10_in20;
wire [40-1:0] A_out01_in11;
wire [40-1:0] A_out11_in21;
wire [40-1:0] A_out02_in12;
wire [40-1:0] A_out12_in22;


// vertical connections
wire [10-1:0] B_out00_in01;
wire [10-1:0] B_out01_in02;
wire [10-1:0] B_out10_in11;
wire [10-1:0] B_out11_in12;
wire [10-1:0] B_out20_in21;
wire [10-1:0] B_out21_in22;


// accumulate_in (unconnected)
wire acc_in01;
wire acc_in02;
wire acc_in11;
wire acc_in12;
wire acc_in21;
wire acc_in22;

// accumulate_out connections (row-wise, x-direction)
wire acc_out00_acc_in10;
wire acc_out10_acc_in20;


// Ay
input_mem0_control_logic #(.mwidth(32), .depth(512), .addr_width(9)) A0 (.clk(clk), .reset(reset), .K_size(K_size),
																		 .enable(enable), .data_out(A0_data));

input_mem_control_logic #(.mwidth(32), .depth(512), .addr_width(9), .start_cnt_bits(2)) A1 (.clk(clk), .reset(reset), .K_size(K_size),
																		 .enable(enable), .data_out(A1_data));

input_mem_control_logic #(.mwidth(32), .depth(512), .addr_width(9), .start_cnt_bits(3)) A2 (.clk(clk), .reset(reset), .K_size(K_size),
																		 .enable(enable), .data_out(A2_data));

// Bx
input_mem0_control_logic #(.mwidth(32), .depth(512), .addr_width(9)) B0 (.clk(clk), .reset(reset), .K_size(K_size),
																		 .enable(enable), .data_out(B0_data));

input_mem_control_logic #(.mwidth(32), .depth(512), .addr_width(9), .start_cnt_bits(2)) B1 (.clk(clk), .reset(reset), .K_size(K_size),
																		 .enable(enable), .data_out(B1_data));

input_mem_control_logic #(.mwidth(32), .depth(512), .addr_width(9), .start_cnt_bits(3)) B2 (.clk(clk), .reset(reset), .K_size(K_size),
																		 .enable(enable), .data_out(B2_data));




sparse_dense_init TS_00 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in), .K_size(K_size), .sparsity_level(`DENSE),
                         .a_data(A_in00), .b_data(B_in00), .a_data_out(A_out00_in10), .c_data(C00_data), 
                         .accumulate_out(acc_out00_acc_in10), .valid_out(valid_out00), .b_ded_out(B_out00_in01));

sparse_dense_middle TS_01 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in01), .K_size(K_size), .sparsity_level(`DENSE),
                         .a_data(A_in01), .a_data_out(A_out01_in11), .c_data(C01_data), .accumulate_out(), .valid_out(valid_out01), 
                         .b_ded_in(B_out00_in01), .b_ded_out(B_out01_in02));

sparse_dense_last TS_02 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in02), .K_size(K_size), .sparsity_level(`DENSE),
                         .a_data(A_in02), .a_data_out(A_out02_in12), .c_data(C02_data), .accumulate_out(), 
                         .valid_out(valid_out02), . b_ded_in(B_out01_in02));


sparse_dense_init TS_10 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_out00_acc_in10), .K_size(K_size), .sparsity_level(`DENSE),
                         .a_data(A_out00_in10), .b_data(B_in10), .a_data_out(A_out10_in20), .c_data(C10_data), 
                         .accumulate_out(acc_out10_acc_in20), .valid_out(valid_out10), .b_ded_out(B_out10_in11));

sparse_dense_middle TS_11 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in11), .K_size(K_size), .sparsity_level(`DENSE),
                         .a_data(A_out01_in11), .a_data_out(A_out11_in21), .c_data(C11_data), .accumulate_out(), .valid_out(valid_out11), 
                         .b_ded_in(B_out10_in11), .b_ded_out(B_out11_in12));

sparse_dense_last TS_12 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in12), .K_size(K_size), .sparsity_level(`DENSE),
                         .a_data(A_out02_in12), .a_data_out(A_out12_in22), .c_data(C12_data), .accumulate_out(), 
                         .valid_out(valid_out12), . b_ded_in(B_out11_in12));


sparse_dense_init TS_20 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_out10_acc_in20), .K_size(K_size), .sparsity_level(`DENSE),
                         .a_data(A_out10_in20), .b_data(B_in20), .a_data_out(), .c_data(C20_data), 
                         .accumulate_out(), .valid_out(valid_out20), .b_ded_out(B_out20_in21));

sparse_dense_middle TS_21 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in21), .K_size(K_size), .sparsity_level(`DENSE),
                         .a_data(A_out11_in21), .a_data_out(), .c_data(C21_data), .accumulate_out(), .valid_out(valid_out21), 
                         .b_ded_in(B_out20_in21), .b_ded_out(B_out21_in22));

sparse_dense_last TS_22 (.clk(clk), .reset(reset), .enable(enable), .accumulate(acc_in22), .K_size(K_size), .sparsity_level(`DENSE),
                         .a_data(A_out12_in22), .a_data_out(), .c_data(C22_data), .accumulate_out(), 
                         .valid_out(valid_out22), . b_ded_in(B_out21_in22));


// Cxy
output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C00 (.clk(clk), .reset(reset), .enable(enable),
																		 .valid_in(valid_out00), .data_in(C00_data),
																		 .data_out(C00_data_out_mem));

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C01 (.clk(clk), .reset(reset), .enable(enable),
																		 .valid_in(valid_out01), .data_in(C01_data),
																		 .data_out(C01_data_out_mem));

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C02 (.clk(clk), .reset(reset), .enable(enable),
																		 .valid_in(valid_out02), .data_in(C02_data),
																		 .data_out(C02_data_out_mem));

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C10 (.clk(clk), .reset(reset), .enable(enable),
																		 .valid_in(valid_out10), .data_in(C10_data),
																		 .data_out(C10_data_out_mem));

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C11 (.clk(clk), .reset(reset), .enable(enable),
																		 .valid_in(valid_out11), .data_in(C11_data),
																		 .data_out(C11_data_out_mem));

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C12 (.clk(clk), .reset(reset), .enable(enable),
																		 .valid_in(valid_out12), .data_in(C12_data),
																		 .data_out(C12_data_out_mem));

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C20 (.clk(clk), .reset(reset), .enable(enable),
																		 .valid_in(valid_out20), .data_in(C20_data),
																		 .data_out(C20_data_out_mem));

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C21 (.clk(clk), .reset(reset), .enable(enable),
																		 .valid_in(valid_out21), .data_in(C21_data),
																		 .data_out(C21_data_out_mem));

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C22 (.clk(clk), .reset(reset), .enable(enable),
																		 .valid_in(valid_out22), .data_in(C22_data),
																		 .data_out(C22_data_out_mem));

// perform reduction operation so Cxy memories don't get optimized out
assign cout_data[0] = &C00_data_out_mem;
assign cout_data[1] = &C01_data_out_mem;
assign cout_data[2] = &C02_data_out_mem;
assign cout_data[3] = &C10_data_out_mem;
assign cout_data[4] = &C11_data_out_mem;
assign cout_data[5] = &C12_data_out_mem;
assign cout_data[6] = &C20_data_out_mem;
assign cout_data[7] = &C21_data_out_mem;
assign cout_data[8] = &C22_data_out_mem;

endmodule


/*
 * This is the control logic along with 
 * the ram module to feed the first tensor slice (TS_00),
 * for both A and B (use for A0, B0)
 */
module input_mem0_control_logic
      #(parameter mwidth = 32,
        parameter depth = 512,
        parameter addr_width = 9)(
        
        clk, 
        reset, 
        enable,
        K_size,
        data_out);

input clk, reset, enable;
input [addr_width-1:0] K_size;
output [mwidth-1:0] data_out;

reg [addr_width-1:0] addr_counter;

always @ (posedge clk) 
begin
        if (reset) begin
                addr_counter <= 0;
        end
        else begin
                if (enable) begin
                        if (addr_counter < K_size) begin
                                addr_counter <= addr_counter + 1;
                        end
                end
        end
end

ram_module #(.mwidth(mwidth), .num_words(depth), .addr_width(addr_width)) mem_0 (.clk(clk), .wren(0), .addr(addr_counter),
                                                                                 .data(), .out(data_out));
endmodule


/*
 * This is the control logic along with 
 * the ram module to feed the REST tensor slices (EXCEPT TS_00),
 * for both A and B (use for Ay, Bx).
 * 
 * The number of bits for start counter (start_cnt_bits),
 * increases by 1 for every bank, starting with 2-bits for A1, B1.
 * => A1, B1 has 2-bits, A2, B2 has 3-bits, etc.
 */
module input_mem_control_logic
      #(parameter mwidth = 32,
        parameter depth = 512,
        parameter addr_width = 9,
        parameter start_cnt_bits = 2)(
        
        clk, 
        reset, 
        enable,
        K_size,
        data_out);

input clk, reset, enable;
input [addr_width-1:0] K_size;
output [mwidth-1:0] data_out;

reg [addr_width-1:0] addr_counter;

// start counter
reg [start_cnt_bits-1:0] start_counter;

always @ (posedge clk) 
begin
        if (reset) begin
                addr_counter <= 0;
                start_counter <= 0;
        end
        else begin
                if (enable) begin
                        if (start_counter < 2**start_cnt_bits-1) begin
                             start_counter <= start_counter + 1;   
                        end
                        else begin
                                if (addr_counter < K_size) begin
                                        addr_counter <= addr_counter + 1;
                                end
                        end
                end
        end
end

ram_module #(.mwidth(mwidth), .num_words(depth), .addr_width(addr_width)) mem_x_y (.clk(clk), .wren(0), .addr(addr_counter),
                                                                                   .data(), .out(data_out));
endmodule


/*
 * This is the control logic along with 
 * the ram module to save the results in the Cxy buffer,
 * of tensor slice xy (TS_xy)
 */
module output_mem_Cxy_control_logic
      #(parameter mwidth = 128,
        parameter depth = 512,
        parameter addr_width = 9)(
        
        clk, 
        reset, 
        enable,
        valid_in,
        data_in,
        data_out);

input clk, reset, enable, valid_in;

input [mwidth-1:0] data_in;
output [mwidth-1:0] data_out;

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

ram_module #(.mwidth(mwidth), .num_words(depth), .addr_width(addr_width)) mem_xy (.clk(clk), .wren(valid_in), .addr(addr_counter),
                                                                                  .data(data_in), .out(data_out));
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
