// `define DWIDTH 8
// `define ACCWIDTH 32

module dense_ts_Aman_like(
    clk,
    reset,
    enable,
    K_size,
    cout_data);
    
input clk, reset, enable;
input [5:0] K_size;
output [15:0] cout_data;


// Ay wires
wire [32-1:0] A0_data;
wire [32-1:0] A1_data;
wire [32-1:0] A2_data;
wire [32-1:0] A3_data;

// Bx wires
wire [32-1:0] B0_data;
wire [32-1:0] B1_data;
wire [32-1:0] B2_data;
wire [32-1:0] B3_data;

// valid_out_xy signals
wire valid_out_00;
wire valid_out_01;
wire valid_out_02;
wire valid_out_03;
wire valid_out_10;
wire valid_out_11;
wire valid_out_12;
wire valid_out_13;
wire valid_out_20;
wire valid_out_21;
wire valid_out_22;
wire valid_out_23;
wire valid_out_30;
wire valid_out_31;
wire valid_out_32;
wire valid_out_33;


// Cxy signals
wire [128-1:0] C00_data;
wire [128-1:0] C01_data;
wire [128-1:0] C02_data;
wire [128-1:0] C03_data;
wire [128-1:0] C10_data;
wire [128-1:0] C11_data;
wire [128-1:0] C12_data;
wire [128-1:0] C13_data;
wire [128-1:0] C20_data;
wire [128-1:0] C21_data;
wire [128-1:0] C22_data;
wire [128-1:0] C23_data;
wire [128-1:0] C30_data;
wire [128-1:0] C31_data;
wire [128-1:0] C32_data;
wire [128-1:0] C33_data;

wire [128-1:0] C00_data_out_mem;
wire [128-1:0] C01_data_out_mem;
wire [128-1:0] C02_data_out_mem;
wire [128-1:0] C03_data_out_mem;
wire [128-1:0] C10_data_out_mem;
wire [128-1:0] C11_data_out_mem;
wire [128-1:0] C12_data_out_mem;
wire [128-1:0] C13_data_out_mem;
wire [128-1:0] C20_data_out_mem;
wire [128-1:0] C21_data_out_mem;
wire [128-1:0] C22_data_out_mem;
wire [128-1:0] C23_data_out_mem;
wire [128-1:0] C30_data_out_mem;
wire [128-1:0] C31_data_out_mem;
wire [128-1:0] C32_data_out_mem;
wire [128-1:0] C33_data_out_mem;


// vertical connections
wire [32-1:0] B_out_TS00_in_TS01;
wire [32-1:0] B_out_TS01_in_TS02;
wire [32-1:0] B_out_TS02_in_TS03;
wire [32-1:0] B_out_TS10_in_TS11;
wire [32-1:0] B_out_TS11_in_TS12;
wire [32-1:0] B_out_TS12_in_TS13;
wire [32-1:0] B_out_TS20_in_TS21;
wire [32-1:0] B_out_TS21_in_TS22;
wire [32-1:0] B_out_TS22_in_TS23;
wire [32-1:0] B_out_TS30_in_TS31;
wire [32-1:0] B_out_TS31_in_TS32;
wire [32-1:0] B_out_TS32_in_TS33;


// horizontal connections
wire [32-1:0] A_out_TS00_in_TS10;
wire [32-1:0] A_out_TS10_in_TS20;
wire [32-1:0] A_out_TS20_in_TS30;
wire [32-1:0] A_out_TS01_in_TS11;
wire [32-1:0] A_out_TS11_in_TS21;
wire [32-1:0] A_out_TS21_in_TS31;
wire [32-1:0] A_out_TS02_in_TS12;
wire [32-1:0] A_out_TS12_in_TS22;
wire [32-1:0] A_out_TS22_in_TS32;
wire [32-1:0] A_out_TS03_in_TS13;
wire [32-1:0] A_out_TS13_in_TS23;
wire [32-1:0] A_out_TS23_in_TS33;

// accumulate_out connections
wire accumulate_TS00;
wire accumulate_TS01;
wire accumulate_TS02;
wire accumulate_TS10;
wire accumulate_TS11;
wire accumulate_TS12;
wire accumulate_TS20;
wire accumulate_TS21;
wire accumulate_TS22;
wire accumulate_TS30;
wire accumulate_TS31;
wire accumulate_TS32;




// Ay 
input_mem0_control_logic #(.mwidth(32), .depth(512), .addr_width(9)) A0 (.clk(clk), .reset(reset), .K_size(K_size),
                                                                            .enable(enable), .data_out(A0_data));
                                                                                 
input_mem_control_logic #(.mwidth(32), .depth(512), .addr_width(9), .start_cnt_bits(2)) A1 (.clk(clk), .reset(reset), .K_size(K_size),
                                                                            .enable(enable), .data_out(A1_data));

input_mem_control_logic #(.mwidth(32), .depth(512), .addr_width(9), .start_cnt_bits(3)) A2 (.clk(clk), .reset(reset), .K_size(K_size),
                                                                            .enable(enable), .data_out(A2_data));

input_mem_control_logic #(.mwidth(32), .depth(512), .addr_width(9), .start_cnt_bits(4)) A3 (.clk(clk), .reset(reset), .K_size(K_size),
                                                                            .enable(enable), .data_out(A3_data));


// Bx
input_mem0_control_logic #(.mwidth(32), .depth(512), .addr_width(9)) B0 (.clk(clk), .reset(reset), .K_size(K_size),
                                                                            .enable(enable), .data_out(B0_data));

input_mem_control_logic #(.mwidth(32), .depth(512), .addr_width(9), .start_cnt_bits(2)) B1 (.clk(clk), .reset(reset), .K_size(K_size),
                                                                            .enable(enable), .data_out(B1_data));

input_mem_control_logic #(.mwidth(32), .depth(512), .addr_width(9), .start_cnt_bits(3)) B2 (.clk(clk), .reset(reset), .K_size(K_size),
                                                                            .enable(enable), .data_out(B2_data));

input_mem_control_logic #(.mwidth(32), .depth(512), .addr_width(9), .start_cnt_bits(4)) B3 (.clk(clk), .reset(reset), .K_size(K_size),
                                                                            .enable(enable), .data_out(B3_data));

// TS_xy
dense_tensor_slice TS_00 (.clk(clk), .reset(reset), .a_data(A0_data), .a_data_in(), .b_data(B0_data), 
                          .b_data_in(), .a_data_out(A_out_TS00_in_TS10), .b_data_out(B_out_TS00_in_TS01), .c_data(C00_data), 
                          .K_size(K_size), .enable(enable), .accumulate(1), 
                          .accumulate_out(accumulate_TS00), .valid_out(valid_out_00));

dense_tensor_slice TS_01 (.clk(clk), .reset(reset), .a_data(A1_data), .a_data_in(), .b_data(), 
                          .b_data_in(B_out_TS00_in_TS01), .a_data_out(A_out_TS01_in_TS11), .b_data_out(B_out_TS01_in_TS02), .c_data(C01_data), 
                          .K_size(K_size), .enable(enable), .accumulate(accumulate_TS00), 
                          .accumulate_out(accumulate_TS01), .valid_out(valid_out_01));


dense_tensor_slice TS_02 (.clk(clk), .reset(reset), .a_data(A2_data), .a_data_in(), .b_data(), 
                          .b_data_in(B_out_TS01_in_TS02), .a_data_out(A_out_TS02_in_TS12), .b_data_out(B_out_TS02_in_TS03), .c_data(C02_data), 
                          .K_size(K_size), .enable(enable), .accumulate(accumulate_TS01), 
                          .accumulate_out(accumulate_TS02), .valid_out(valid_out_02));

dense_tensor_slice TS_03 (.clk(clk), .reset(reset), .a_data(A3_data), .a_data_in(), .b_data(), 
                          .b_data_in(B_out_TS02_in_TS03), .a_data_out(A_out_TS03_in_TS13), .b_data_out(), .c_data(C03_data), 
                          .K_size(K_size), .enable(enable), .accumulate(accumulate_TS02), 
                          .accumulate_out(), .valid_out(valid_out_03));



dense_tensor_slice TS_10 (.clk(clk), .reset(reset), .a_data(), .a_data_in(A_out_TS00_in_TS10), .b_data(B1_data), 
                          .b_data_in(), .a_data_out(A_out_TS10_in_TS20), .b_data_out(B_out_TS10_in_TS11), .c_data(C10_data), 
                          .K_size(K_size), .enable(enable), .accumulate(accumulate_TS00), 
                          .accumulate_out(accumulate_TS10), .valid_out(valid_out_10));

dense_tensor_slice TS_11 (.clk(clk), .reset(reset), .a_data(), .a_data_in(A_out_TS01_in_TS11), .b_data(), 
                          .b_data_in(B_out_TS10_in_TS11), .a_data_out(A_out_TS11_in_TS21), .b_data_out(B_out_TS11_in_TS12), .c_data(C11_data), 
                          .K_size(K_size), .enable(enable), .accumulate(accumulate_TS10), 
                          .accumulate_out(accumulate_TS11), .valid_out(valid_out_11));

dense_tensor_slice TS_12 (.clk(clk), .reset(reset), .a_data(), .a_data_in(A_out_TS02_in_TS12), .b_data(), 
                          .b_data_in(B_out_TS11_in_TS12), .a_data_out(A_out_TS12_in_TS22), .b_data_out(B_out_TS12_in_TS13), .c_data(C12_data), 
                          .K_size(K_size), .enable(enable), .accumulate(accumulate_TS11), 
                          .accumulate_out(accumulate_TS12), .valid_out(valid_out_12));

dense_tensor_slice TS_13 (.clk(clk), .reset(reset), .a_data(), .a_data_in(A_out_TS03_in_TS13), .b_data(), 
                          .b_data_in(B_out_TS12_in_TS13), .a_data_out(A_out_TS13_in_TS23), .b_data_out(), .c_data(C13_data), 
                          .K_size(K_size), .enable(enable), .accumulate(accumulate_TS12), 
                          .accumulate_out(), .valid_out(valid_out_13));


dense_tensor_slice TS_20 (.clk(clk), .reset(reset), .a_data(), .a_data_in(A_out_TS10_in_TS20), .b_data(B2_data), 
                          .b_data_in(), .a_data_out(A_out_TS20_in_TS30), .b_data_out(B_out_TS20_in_TS21), .c_data(C20_data), 
                          .K_size(K_size), .enable(enable), .accumulate(accumulate_TS10), 
                          .accumulate_out(accumulate_TS20), .valid_out(valid_out_20));

dense_tensor_slice TS_21 (.clk(clk), .reset(reset), .a_data(), .a_data_in(A_out_TS11_in_TS21), .b_data(), 
                          .b_data_in(B_out_TS20_in_TS21), .a_data_out(A_out_TS21_in_TS31), .b_data_out(B_out_TS21_in_TS22), .c_data(C21_data), 
                          .K_size(K_size), .enable(enable), .accumulate(accumulate_TS20), 
                          .accumulate_out(accumulate_TS21), .valid_out(valid_out_21));

dense_tensor_slice TS_22 (.clk(clk), .reset(reset), .a_data(), .a_data_in(A_out_TS12_in_TS22), .b_data(), 
                          .b_data_in(B_out_TS21_in_TS22), .a_data_out(A_out_TS22_in_TS32), .b_data_out(B_out_TS22_in_TS23), .c_data(C22_data), 
                          .K_size(K_size), .enable(enable), .accumulate(accumulate_TS21), 
                          .accumulate_out(accumulate_TS22), .valid_out(valid_out_22));

dense_tensor_slice TS_23 (.clk(clk), .reset(reset), .a_data(), .a_data_in(A_out_TS13_in_TS23), .b_data(), 
                          .b_data_in(B_out_TS22_in_TS23), .a_data_out(A_out_TS23_in_TS33), .b_data_out(), .c_data(C23_data), 
                          .K_size(K_size), .enable(enable), .accumulate(accumulate_TS22), 
                          .accumulate_out(), .valid_out(valid_out_23));


dense_tensor_slice TS_30 (.clk(clk), .reset(reset), .a_data(), .a_data_in(A_out_TS20_in_TS30), .b_data(B3_data), 
                          .b_data_in(), .a_data_out(), .b_data_out(B_out_TS30_in_TS31), .c_data(C30_data), 
                          .K_size(K_size), .enable(enable), .accumulate(accumulate_TS20), 
                          .accumulate_out(accumulate_TS30), .valid_out(valid_out_30));

dense_tensor_slice TS_31 (.clk(clk), .reset(reset), .a_data(), .a_data_in(A_out_TS21_in_TS31), .b_data(), 
                          .b_data_in(B_out_TS30_in_TS31), .a_data_out(), .b_data_out(B_out_TS31_in_TS32), .c_data(C31_data), 
                          .K_size(K_size), .enable(enable), .accumulate(accumulate_TS30), 
                          .accumulate_out(accumulate_TS31), .valid_out(valid_out_31));

dense_tensor_slice TS_32 (.clk(clk), .reset(reset), .a_data(), .a_data_in(A_out_TS22_in_TS32), .b_data(), 
                          .b_data_in(B_out_TS31_in_TS32), .a_data_out(), .b_data_out(B_out_TS32_in_TS33), .c_data(C32_data), 
                          .K_size(K_size), .enable(enable), .accumulate(accumulate_TS31), 
                          .accumulate_out(accumulate_TS32), .valid_out(valid_out_32));

dense_tensor_slice TS_33 (.clk(clk), .reset(reset), .a_data(), .a_data_in(A_out_TS23_in_TS33), .b_data(), 
                          .b_data_in(B_out_TS32_in_TS33), .a_data_out(), .b_data_out(), .c_data(C33_data), 
                          .K_size(K_size), .enable(enable), .accumulate(accumulate_TS32), 
                          .accumulate_out(), .valid_out(valid_out_33));



// Cxy
output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C00 (.clk(clk), .reset(reset), .enable(enable),
                                                                            .valid_in(valid_out_00), .data_in(C00_data),
                                                                            .data_out(C00_data_out_mem));

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C01 (.clk(clk), .reset(reset), .enable(enable),
                                                                            .valid_in(valid_out_01), .data_in(C01_data),
                                                                            .data_out(C01_data_out_mem));

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C02 (.clk(clk), .reset(reset), .enable(enable),
                                                                            .valid_in(valid_out_02), .data_in(C02_data),
                                                                            .data_out(C02_data_out_mem));

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C03 (.clk(clk), .reset(reset), .enable(enable),
                                                                            .valid_in(valid_out_03), .data_in(C03_data),
                                                                            .data_out(C03_data_out_mem));

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C10 (.clk(clk), .reset(reset), .enable(enable),
                                                                            .valid_in(valid_out_10), .data_in(C10_data),
                                                                            .data_out(C10_data_out_mem));

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C11 (.clk(clk), .reset(reset), .enable(enable),
                                                                            .valid_in(valid_out_11), .data_in(C11_data),
                                                                            .data_out(C11_data_out_mem));

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C12 (.clk(clk), .reset(reset), .enable(enable),
                                                                            .valid_in(valid_out_12), .data_in(C12_data),
                                                                            .data_out(C12_data_out_mem));
                                                                        
output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C13 (.clk(clk), .reset(reset), .enable(enable),
                                                                            .valid_in(valid_out_13), .data_in(C13_data),
                                                                            .data_out(C13_data_out_mem));

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C20 (.clk(clk), .reset(reset), .enable(enable),
                                                                            .valid_in(valid_out_20), .data_in(C20_data),
                                                                            .data_out(C20_data_out_mem));

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C21 (.clk(clk), .reset(reset), .enable(enable),
                                                                            .valid_in(valid_out_21), .data_in(C21_data),
                                                                            .data_out(C21_data_out_mem));

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C22 (.clk(clk), .reset(reset), .enable(enable),
                                                                            .valid_in(valid_out_22), .data_in(C22_data),
                                                                            .data_out(C22_data_out_mem));

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C23 (.clk(clk), .reset(reset), .enable(enable),
                                                                            .valid_in(valid_out_23), .data_in(C23_data),
                                                                            .data_out(C23_data_out_mem));

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C30 (.clk(clk), .reset(reset), .enable(enable),
                                                                            .valid_in(valid_out_30), .data_in(C30_data),
                                                                            .data_out(C30_data_out_mem));

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C31 (.clk(clk), .reset(reset), .enable(enable),
                                                                            .valid_in(valid_out_31), .data_in(C31_data),
                                                                            .data_out(C31_data_out_mem));

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C32 (.clk(clk), .reset(reset), .enable(enable),
                                                                            .valid_in(valid_out_32), .data_in(C32_data),
                                                                            .data_out(C32_data_out_mem));

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C33 (.clk(clk), .reset(reset), .enable(enable),
                                                                            .valid_in(valid_out_33), .data_in(C33_data),
                                                                            .data_out(C33_data_out_mem));


// perform reduction operation so Cxy memories don't get optimized out
assign cout_data[0] = &C00_data_out_mem;
assign cout_data[1] = &C01_data_out_mem;
assign cout_data[2] = &C02_data_out_mem;
assign cout_data[3] = &C03_data_out_mem;

assign cout_data[4] = &C10_data_out_mem;
assign cout_data[5] = &C11_data_out_mem;
assign cout_data[6] = &C12_data_out_mem;
assign cout_data[7] = &C13_data_out_mem;

assign cout_data[8] = &C20_data_out_mem;
assign cout_data[9] = &C21_data_out_mem;
assign cout_data[10] = &C22_data_out_mem;
assign cout_data[11] = &C23_data_out_mem;

assign cout_data[12] = &C30_data_out_mem;
assign cout_data[13] = &C31_data_out_mem;
assign cout_data[14] = &C32_data_out_mem;
assign cout_data[15] = &C33_data_out_mem;

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

ram_module #(.mwidth(mwidth), .num_words(depth), .addr_width(addr_width)) mem_xy (.clk(clk), .wren(1), .addr(addr_counter),
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