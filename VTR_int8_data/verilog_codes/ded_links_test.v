// `define DWIDTH 36

// module my_multiplier_top(
//         clk,
//         reset,
//         a_00,
//         a_01,
//         a_02,
//         a_03,
//         a_04,
//         b_00,
//         b_10,
//         b_20,
//         out_24);
        

// input clk, reset;
// input [4-1:0] a_00, a_01, a_02, a_03, a_04;
// input [4-1:0] b_00, b_10, b_20;

// output [4-1:0] out_24;



// // dedicated links
// wire [10-1:0] init_ded_00;
// wire [10-1:0] ded_00_to_01;
// wire [10-1:0] ded_01_to_02;
// wire [10-1:0] ded_02_to_03;
// wire [10-1:0] ded_03_to_04;


// wire [10-1:0] init_ded_10;
// wire [10-1:0] ded_10_to_11;
// wire [10-1:0] ded_11_to_12;
// wire [10-1:0] ded_12_to_13;
// wire [10-1:0] ded_13_to_14;

// wire [10-1:0] init_ded_20;
// wire [10-1:0] ded_20_to_21;
// wire [10-1:0] ded_21_to_22;
// wire [10-1:0] ded_22_to_23;
// wire [10-1:0] ded_23_to_24;


// // horizontal connections
// wire [40-1:0] horizontal_00_to_10;
// wire [40-1:0] horizontal_01_to_11;
// wire [40-1:0] horizontal_02_to_12;
// wire [40-1:0] horizontal_03_to_13;
// wire [40-1:0] horizontal_04_to_14;

// wire [40-1:0] horizontal_10_to_20;
// wire [40-1:0] horizontal_11_to_21;
// wire [40-1:0] horizontal_12_to_22;
// wire [40-1:0] horizontal_13_to_23;
// wire [40-1:0] horizontal_14_to_24;




// hard_model_initial u_hard_model_init_00 (.clk(clk), .reset(reset), .a(), .b(b_00), 
//                                          .out(), .out_ded(init_ded_00));

// hard_model_rest u_hard_model_00 (.clk(clk), .reset(reset), .a(a_00), .b(), .ab_ded(init_ded_00), 
//                                  .out(horizontal_00_to_10), .out_ded(ded_00_to_01));

// hard_model_rest u_hard_model_01 (.clk(clk), .reset(reset), .a(a_01), .b(), .ab_ded(ded_00_to_01), 
//                                  .out(horizontal_01_to_11), .out_ded(ded_01_to_02));

// hard_model_rest u_hard_model_02 (.clk(clk), .reset(reset), .a(a_02), .b(), .ab_ded(ded_01_to_02), 
//                                  .out(horizontal_02_to_12), .out_ded(ded_02_to_03));

// hard_model_rest u_hard_model_03 (.clk(clk), .reset(reset), .a(a_03), .b(), .ab_ded(ded_02_to_03), 
//                                  .out(horizontal_03_to_13), .out_ded(ded_03_to_04));

// hard_model_last u_hard_model_04 (.clk(clk), .reset(reset), .a(a_04), .b(), 
//                                  .ab_ded(ded_03_to_04), .out(horizontal_04_to_14));




// hard_model_initial u_hard_model_init_10 (.clk(clk), .reset(reset), .a(), .b(b_10), 
//                                          .out(), .out_ded(init_ded_10));

// hard_model_rest u_hard_model_10 (.clk(clk), .reset(reset), .a(horizontal_00_to_10), .b(), .ab_ded(init_ded_10), 
//                                  .out(horizontal_10_to_20), .out_ded(ded_10_to_11));

// hard_model_rest u_hard_model_11 (.clk(clk), .reset(reset), .a(horizontal_01_to_11), .b(), .ab_ded(ded_10_to_11), 
//                                  .out(horizontal_11_to_21), .out_ded(ded_11_to_12));

// hard_model_rest u_hard_model_12 (.clk(clk), .reset(reset), .a(horizontal_02_to_12), .b(), .ab_ded(ded_11_to_12), 
//                                  .out(horizontal_12_to_22), .out_ded(ded_12_to_13));

// hard_model_rest u_hard_model_13 (.clk(clk), .reset(reset), .a(horizontal_03_to_13), .b(), .ab_ded(ded_12_to_13), 
//                                  .out(horizontal_13_to_23), .out_ded(ded_13_to_14));

// hard_model_last u_hard_model_14 (.clk(clk), .reset(reset), .a(horizontal_04_to_14), .b(), 
//                                  .ab_ded(ded_13_to_14), .out(horizontal_14_to_24));



// hard_model_initial u_hard_model_init_20 (.clk(clk), .reset(reset), .a(), .b(b_20), 
//                                          .out(), .out_ded(init_ded_20));

// hard_model_rest u_hard_model_20 (.clk(clk), .reset(reset), .a(horizontal_10_to_20), .b(), .ab_ded(init_ded_20), 
//                                  .out(), .out_ded(ded_20_to_21));

// hard_model_rest u_hard_model_21 (.clk(clk), .reset(reset), .a(horizontal_11_to_21), .b(), .ab_ded(ded_20_to_21), 
//                                  .out(), .out_ded(ded_21_to_22));

// hard_model_rest u_hard_model_22 (.clk(clk), .reset(reset), .a(horizontal_12_to_22), .b(), .ab_ded(ded_21_to_22), 
//                                  .out(), .out_ded(ded_22_to_23));

// hard_model_rest u_hard_model_23 (.clk(clk), .reset(reset), .a(horizontal_13_to_23), .b(), .ab_ded(ded_22_to_23), 
//                                  .out(), .out_ded(ded_23_to_24));

// hard_model_last u_hard_model_24 (.clk(clk), .reset(reset), .a(horizontal_14_to_24), .b(), 
//                                  .ab_ded(ded_23_to_24), .out(out_24));



// endmodule





   
    


module my_ded_links(
        clk,
        reset,
        enable,
        K_size,
        cout_data);
        

input clk, reset, enable;
input [5:0] K_size;
output [8:0] cout_data;




// Ay wires
wire [32-1:0] A0_data;
wire [32-1:0] A1_data;
wire [32-1:0] A2_data;


// Bx wires
wire [32-1:0] B0_data;
wire [32-1:0] B1_data;
wire [32-1:0] B2_data;


// valid_out_xy signals
wire valid_out_00;
wire valid_out_01;
wire valid_out_02;
wire valid_out_10;
wire valid_out_11;
wire valid_out_12;
wire valid_out_20;
wire valid_out_21;
wire valid_out_22;


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


// vertical connections
wire [10-1:0] B_loading_TS00;
wire [10-1:0] B_out_TS00_in_TS01;
wire [10-1:0] B_out_TS01_in_TS02;

wire [10-1:0] B_loading_TS10;
wire [10-1:0] B_out_TS10_in_TS11;
wire [10-1:0] B_out_TS11_in_TS12;

wire [10-1:0] B_loading_TS20;
wire [10-1:0] B_out_TS20_in_TS21;
wire [10-1:0] B_out_TS21_in_TS22;


// horizontal connections
wire [32-1:0] A_out_TS00_in_TS10;
wire [32-1:0] A_out_TS01_in_TS11;
wire [32-1:0] A_out_TS02_in_TS12;
wire [32-1:0] A_out_TS10_in_TS20;
wire [32-1:0] A_out_TS11_in_TS21;
wire [32-1:0] A_out_TS12_in_TS22;

wire [64-1:0] dummy_wire;

wire [170-1:0] dummy_out_wire;

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


hard_model_initial TS_loading_00 (.clk(clk), .reset(reset), .a(dummy_wire), .b(B0_data), 
                                  .out(dummy_out_wire), .out_ded(B_loading_TS00));

hard_model_rest TS_compute_00 (.clk(clk), .reset(reset), .a(A0_data), .b(dummy_wire), .ab_ded(B_loading_TS00), 
                               .out({A_out_TS00_in_TS10, valid_out_00, C00_data}), .out_ded(B_out_TS00_in_TS01));

hard_model_rest TS_compute_01 (.clk(clk), .reset(reset), .a(A1_data), .b(dummy_wire), .ab_ded(B_out_TS00_in_TS01), 
                               .out({A_out_TS01_in_TS11, valid_out_01, C01_data}), .out_ded(B_out_TS01_in_TS02));

hard_model_last TS_compute_02 (.clk(clk), .reset(reset), .a(A2_data), .b(dummy_wire), 
                               .ab_ded(B_out_TS01_in_TS02), .out({A_out_TS02_in_TS12, valid_out_02, C02_data}));




hard_model_initial TS_loading_10 (.clk(clk), .reset(reset), .a(dummy_wire), .b(B1_data), 
                                  .out(), .out_ded(B_loading_TS10));

hard_model_rest TS_compute_10 (.clk(clk), .reset(reset), .a(A_out_TS00_in_TS10), .b(dummy_wire), .ab_ded(B_loading_TS10), 
                               .out({A_out_TS10_in_TS20, valid_out_10, C10_data}), .out_ded(B_out_TS10_in_TS11));

hard_model_rest TS_compute_11 (.clk(clk), .reset(reset), .a(A_out_TS01_in_TS11), .b(dummy_wire), .ab_ded(B_out_TS10_in_TS11), 
                               .out({A_out_TS11_in_TS21, valid_out_11, C11_data}), .out_ded(B_out_TS11_in_TS12));

hard_model_last TS_compute_12 (.clk(clk), .reset(reset), .a(A_out_TS02_in_TS12), .b(dummy_wire), 
                               .ab_ded(B_out_TS11_in_TS12), .out({A_out_TS12_in_TS22, valid_out_12, C12_data}));


hard_model_initial TS_loading_20 (.clk(clk), .reset(reset), .a(dummy_wire), .b(B2_data), 
                                  .out(), .out_ded(B_loading_TS20));

hard_model_rest TS_compute_20 (.clk(clk), .reset(reset), .a(A_out_TS10_in_TS20), .b(dummy_wire), .ab_ded(B_loading_TS20), 
                               .out({valid_out_20, C20_data}), .out_ded(B_out_TS20_in_TS21));

hard_model_rest TS_compute_21 (.clk(clk), .reset(reset), .a(A_out_TS11_in_TS21), .b(dummy_wire), .ab_ded(B_out_TS20_in_TS21), 
                               .out({valid_out_21, C21_data}), .out_ded(B_out_TS21_in_TS22));

hard_model_last TS_compute_22 (.clk(clk), .reset(reset), .a(A_out_TS12_in_TS22), .b(dummy_wire), 
                               .ab_ded(B_out_TS21_in_TS22), .out({valid_out_22, C22_data}));


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

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C10 (.clk(clk), .reset(reset), .enable(enable),
									       .valid_in(valid_out_10), .data_in(C10_data),
										 .data_out(C10_data_out_mem));

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C11 (.clk(clk), .reset(reset), .enable(enable),
									       .valid_in(valid_out_11), .data_in(C11_data),
										 .data_out(C11_data_out_mem));

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C12 (.clk(clk), .reset(reset), .enable(enable),
									       .valid_in(valid_out_12), .data_in(C12_data),
										 .data_out(C12_data_out_mem));

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C20 (.clk(clk), .reset(reset), .enable(enable),
									       .valid_in(valid_out_20), .data_in(C20_data),
										 .data_out(C20_data_out_mem));

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C21 (.clk(clk), .reset(reset), .enable(enable),
									       .valid_in(valid_out_21), .data_in(C21_data),
										 .data_out(C21_data_out_mem));

output_mem_Cxy_control_logic #(.mwidth(128), .depth(512), .addr_width(9)) C22 (.clk(clk), .reset(reset), .enable(enable),
									       .valid_in(valid_out_22), .data_in(C22_data),
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
