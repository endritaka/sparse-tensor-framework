`define DWIDTH 16
`define ACCWIDTH 32
`define MAC_PIPE_STAGES 3
`define INT8 0
`define BF16 1


module dense_tensor_slice_Aman_like(
    clk, 
    reset, 
    a_data,
    a_data_in,
    a_data_out,
    b_data,
    b_data_in,
    b_data_out,
    c_data, 
    enable,
    accumulate,
    K_size,
    d_type,
    x_loc,
    y_loc,
    accumulate_out,
    valid_out);



//a0 = a_data[`DWIDTH-1:0], a1 = a_data[2*`DWIDTH-1:`DWIDTH]
//a2 = a_data[3*`DWIDTH-1:2*`DWIDTH], a3 = a_data[4*`DWIDTH-1:3*`DWIDTH]

input clk, reset;
input d_type;
input [4*`DWIDTH-1:0] a_data, a_data_in, b_data, b_data_in;
output [4*`DWIDTH-1:0] a_data_out, b_data_out;
input [11:0] K_size;
input [4:0] x_loc, y_loc;
output reg [4*`ACCWIDTH-1:0] c_data;
input enable, accumulate;
output reg valid_out;
output accumulate_out;

integer i;

// horizontal connections
wire [`DWIDTH-1:0] out_a00_in_a01;
wire [`DWIDTH-1:0] out_a01_in_a02;
wire [`DWIDTH-1:0] out_a02_in_a03;

wire [`DWIDTH-1:0] out_a10_in_a11;
wire [`DWIDTH-1:0] out_a11_in_a12;
wire [`DWIDTH-1:0] out_a12_in_a13;

wire [`DWIDTH-1:0] out_a20_in_a21;
wire [`DWIDTH-1:0] out_a21_in_a22;
wire [`DWIDTH-1:0] out_a22_in_a23;

wire [`DWIDTH-1:0] out_a30_in_a31;
wire [`DWIDTH-1:0] out_a31_in_a32;
wire [`DWIDTH-1:0] out_a32_in_a33;

// vertical connections
wire [`DWIDTH-1:0] out_b00_in_b10;
wire [`DWIDTH-1:0] out_b10_in_b20;
wire [`DWIDTH-1:0] out_b20_in_b30;

wire [`DWIDTH-1:0] out_b01_in_b11;
wire [`DWIDTH-1:0] out_b11_in_b21;
wire [`DWIDTH-1:0] out_b21_in_b31;

wire [`DWIDTH-1:0] out_b02_in_b12;
wire [`DWIDTH-1:0] out_b12_in_b22;
wire [`DWIDTH-1:0] out_b22_in_b32;

wire [`DWIDTH-1:0] out_b03_in_b13;
wire [`DWIDTH-1:0] out_b13_in_b23;
wire [`DWIDTH-1:0] out_b23_in_b33;


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

// register to hold if the SA is in steady state
reg steady_state;

// input setup, each d denotes one cc delay
wire [`DWIDTH-1:0] a1_d, b1_d;
wire [`DWIDTH-1:0] a2_d, a2_dd, b2_d, b2_dd;
wire [`DWIDTH-1:0] a3_d, a3_dd, a3_ddd, b3_d, b3_dd, b3_ddd;

// assign wires for instantiation
wire [`DWIDTH-1:0] wire_a0, wire_b0, wire_a1, wire_b1, wire_a2, wire_b2, wire_a3, wire_b3;


assign wire_a0 = (x_loc == 0) ? a_data[`DWIDTH-1:0] : a_data_in[`DWIDTH-1:0];
assign wire_b0 = (y_loc == 0) ? b_data[`DWIDTH-1:0] : b_data_in[`DWIDTH-1:0];

assign wire_a1 = (x_loc == 0) ? a1_d : a_data_in[2*`DWIDTH-1:`DWIDTH];
assign wire_b1 = (y_loc == 0) ? b1_d : b_data_in[2*`DWIDTH-1:`DWIDTH];

assign wire_a2 = (x_loc == 0) ? a2_dd : a_data_in[3*`DWIDTH-1:2*`DWIDTH];
assign wire_b2 = (y_loc == 0) ? b2_dd : b_data_in[3*`DWIDTH-1:2*`DWIDTH];

assign wire_a3 = (x_loc == 0) ? a3_ddd : a_data_in[4*`DWIDTH-1:3*`DWIDTH];
assign wire_b3 = (y_loc == 0) ? b3_ddd : b_data_in[4*`DWIDTH-1:3*`DWIDTH];


// initial_counter => same bits are K_size
// for control_counter 5-bits are enough
reg [4:0] control_counter;
reg [11:0] initial_counter;


// output MAC wires
wire [`ACCWIDTH-1:0] out_mac_00,out_mac_01,out_mac_10,out_mac_02,out_mac_20,out_mac_11,
					 out_mac_03,out_mac_30,out_mac_21,out_mac_12,out_mac_13,out_mac_31,
					 out_mac_22,out_mac_23,out_mac_32,out_mac_33;


// 10 element output register to extract data without penalty on latency. 
// With this approach you can extract N^2 data over N cc (maximum possible with N^2 PEs)
// Then 10 element register increase area should be a good trade-off for latency,
// given also the fact that otherwise diagonal irregularity will make the next layer logic (typically in CLB) complex
reg [`ACCWIDTH-1:0] mac_out_reg [9:0];


// used to control when tensor slice should start operation due to location (x_loc, y_loc)
// 8-bits are enough for 5-bits x_loc and y_loc (31+31)*4 = 248 < 2^8 - 1 = 255
reg [7:0] location_counter;

// enable tensor operation based on location
reg loc_tensor_load_en;

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
		if (location_counter == (((x_loc + y_loc)<<2))) begin
			loc_tensor_load_en = 1;
		end
		else begin
			loc_tensor_load_en = 0;
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

	end else begin
		
		if (enable) begin

			if (location_counter < (((x_loc + y_loc)<<2))) begin
				location_counter <= location_counter + 1;
			end

			// start tensor operation only when it should based on location (x_loc, y_loc)
			if (loc_tensor_load_en == 1) begin

				if (initial_counter < (K_size - 1)) begin
					initial_counter <= initial_counter + 1;
				end	

				else if (initial_counter == (K_size - 1)) begin
					control_counter <= 1;
					steady_state <= 1;
					initial_counter <= 0;
				end
			

				if (steady_state == 1) begin	// steady state

					if (control_counter == (2 + `MAC_PIPE_STAGES)) begin
						valid_out <= 1;
						control_counter <= control_counter + 1;
					end
					else if (control_counter == (6 + `MAC_PIPE_STAGES)) begin
						valid_out <= 0;

						// this may happen when there is overlap between the initial counter and the control counter
						// assures correct operation of SA
						if (initial_counter == (K_size - 1)) begin
							control_counter <= 1;
							steady_state <= 1;
							initial_counter <= 0;
						end
						else begin
							control_counter <= 0;
							steady_state <= 0;
						end	
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

		for (i = 0; i < 10; i = i + 1) begin
			mac_out_reg[i] <= 0;
		end		
	end
	else begin
		if (enable) begin

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
	end	
end	



// input logic FFs instantiation
FF_enable FF_a1_d (.clk(clk), .reset(reset), .data_in(a_data[2*`DWIDTH-1:`DWIDTH]), .data_out(a1_d), .enable(enable & loc_tensor_load_en));
FF_enable FF_a2_d (.clk(clk), .reset(reset), .data_in(a_data[3*`DWIDTH-1:2*`DWIDTH]), .data_out(a2_d), .enable(enable & loc_tensor_load_en));
FF_enable FF_a3_d (.clk(clk), .reset(reset), .data_in(a_data[4*`DWIDTH-1:3*`DWIDTH]), .data_out(a3_d), .enable(enable & loc_tensor_load_en));

FF_enable FF_b1_d (.clk(clk), .reset(reset), .data_in(b_data[2*`DWIDTH-1:`DWIDTH]), .data_out(b1_d), .enable(enable & loc_tensor_load_en));
FF_enable FF_b2_d (.clk(clk), .reset(reset), .data_in(b_data[3*`DWIDTH-1:2*`DWIDTH]), .data_out(b2_d), .enable(enable & loc_tensor_load_en));
FF_enable FF_b3_d (.clk(clk), .reset(reset), .data_in(b_data[4*`DWIDTH-1:3*`DWIDTH]), .data_out(b3_d), .enable(enable & loc_tensor_load_en));


FF_enable FF_a2_dd (.clk(clk), .reset(reset), .data_in(a2_d), .data_out(a2_dd), .enable(enable & loc_tensor_load_en));
FF_enable FF_a3_dd (.clk(clk), .reset(reset), .data_in(a3_d), .data_out(a3_dd), .enable(enable & loc_tensor_load_en));

FF_enable FF_b2_dd (.clk(clk), .reset(reset), .data_in(b2_d), .data_out(b2_dd), .enable(enable & loc_tensor_load_en));
FF_enable FF_b3_dd (.clk(clk), .reset(reset), .data_in(b3_d), .data_out(b3_dd), .enable(enable & loc_tensor_load_en));


FF_enable FF_a3_ddd (.clk(clk), .reset(reset), .data_in(a3_dd), .data_out(a3_ddd), .enable(enable & loc_tensor_load_en));
FF_enable FF_b3_ddd (.clk(clk), .reset(reset), .data_in(b3_dd), .data_out(b3_ddd), .enable(enable & loc_tensor_load_en));



// PEs instantiation
PE PE_00(.clk(clk), .reset(reset), .accumulate(accumulate_1_00), .accumulate_out(accumulate_2_01_10), .IN_A(wire_a0), .IN_B(wire_b0), .OUT_A(out_a00_in_a01), .OUT_B(out_b00_in_b10), .OUT_MAC(out_mac_00), .enable(enable & loc_tensor_load_en), .d_type(d_type));

PE PE_01(.clk(clk), .reset(reset), .accumulate(accumulate_2_01_10), .accumulate_out(accumulate_3_02_20_11), .IN_A(out_a00_in_a01), .IN_B(wire_b1), .OUT_A(out_a01_in_a02), .OUT_B(out_b01_in_b11), .OUT_MAC(out_mac_01), .enable(enable & loc_tensor_load_en), .d_type(d_type));
PE PE_10(.clk(clk), .reset(reset), .accumulate(accumulate_2_01_10), .accumulate_out(accumulate_3_02_20_11), .IN_A(wire_a1), .IN_B(out_b00_in_b10), .OUT_A(out_a10_in_a11), .OUT_B(out_b10_in_b20), .OUT_MAC(out_mac_10), .enable(enable & loc_tensor_load_en), .d_type(d_type));

PE PE_02(.clk(clk), .reset(reset), .accumulate(accumulate_3_02_20_11), .accumulate_out(accumulate_4_03_30_21_12), .IN_A(out_a01_in_a02), .IN_B(wire_b2), .OUT_A(out_a02_in_a03), .OUT_B(out_b02_in_b12), .OUT_MAC(out_mac_02), .enable(enable & loc_tensor_load_en), .d_type(d_type));
PE PE_20(.clk(clk), .reset(reset), .accumulate(accumulate_3_02_20_11), .accumulate_out(accumulate_4_03_30_21_12), .IN_A(wire_a2), .IN_B(out_b10_in_b20), .OUT_A(out_a20_in_a21), .OUT_B(out_b20_in_b30), .OUT_MAC(out_mac_20), .enable(enable & loc_tensor_load_en), .d_type(d_type));
PE PE_11(.clk(clk), .reset(reset), .accumulate(accumulate_3_02_20_11), .accumulate_out(accumulate_4_03_30_21_12), .IN_A(out_a10_in_a11), .IN_B(out_b01_in_b11), .OUT_A(out_a11_in_a12), .OUT_B(out_b11_in_b21), .OUT_MAC(out_mac_11), .enable(enable & loc_tensor_load_en), .d_type(d_type));

PE PE_03(.clk(clk), .reset(reset), .accumulate(accumulate_4_03_30_21_12), .accumulate_out(accumulate_5_13_31_22), .IN_A(out_a02_in_a03), .IN_B(wire_b3), .OUT_A(a_data_out[`DWIDTH-1:0]), .OUT_B(out_b03_in_b13), .OUT_MAC(out_mac_03), .enable(enable & loc_tensor_load_en), .d_type(d_type));
PE PE_30(.clk(clk), .reset(reset), .accumulate(accumulate_4_03_30_21_12), .accumulate_out(accumulate_5_13_31_22), .IN_A(wire_a3), .IN_B(out_b20_in_b30), .OUT_A(out_a30_in_a31), .OUT_B(b_data_out[`DWIDTH-1:0]), .OUT_MAC(out_mac_30), .enable(enable & loc_tensor_load_en), .d_type(d_type));
PE PE_21(.clk(clk), .reset(reset), .accumulate(accumulate_4_03_30_21_12), .accumulate_out(accumulate_5_13_31_22), .IN_A(out_a20_in_a21), .IN_B(out_b11_in_b21), .OUT_A(out_a21_in_a22), .OUT_B(out_b21_in_b31), .OUT_MAC(out_mac_21), .enable(enable & loc_tensor_load_en), .d_type(d_type));
PE PE_12(.clk(clk), .reset(reset), .accumulate(accumulate_4_03_30_21_12), .accumulate_out(accumulate_5_13_31_22), .IN_A(out_a11_in_a12), .IN_B(out_b02_in_b12), .OUT_A(out_a12_in_a13), .OUT_B(out_b12_in_b22), .OUT_MAC(out_mac_12), .enable(enable & loc_tensor_load_en), .d_type(d_type));

PE PE_13(.clk(clk), .reset(reset), .accumulate(accumulate_5_13_31_22), .accumulate_out(accumulate_6_23_32), .IN_A(out_a12_in_a13), .IN_B(out_b03_in_b13), .OUT_A(a_data_out[2*`DWIDTH-1:`DWIDTH]), .OUT_B(out_b13_in_b23), .OUT_MAC(out_mac_13), .enable(enable & loc_tensor_load_en), .d_type(d_type));
PE PE_31(.clk(clk), .reset(reset), .accumulate(accumulate_5_13_31_22), .accumulate_out(accumulate_6_23_32), .IN_A(out_a30_in_a31), .IN_B(out_b21_in_b31), .OUT_A(out_a31_in_a32), .OUT_B(b_data_out[2*`DWIDTH-1:`DWIDTH]), .OUT_MAC(out_mac_31), .enable(enable & loc_tensor_load_en), .d_type(d_type));
PE PE_22(.clk(clk), .reset(reset), .accumulate(accumulate_5_13_31_22), .accumulate_out(accumulate_6_23_32), .IN_A(out_a21_in_a22), .IN_B(out_b12_in_b22), .OUT_A(out_a22_in_a23), .OUT_B(out_b22_in_b32), .OUT_MAC(out_mac_22), .enable(enable & loc_tensor_load_en), .d_type(d_type));

PE PE_23(.clk(clk), .reset(reset), .accumulate(accumulate_6_23_32), .accumulate_out(accumulate_7_33), .IN_A(out_a22_in_a23), .IN_B(out_b13_in_b23), .OUT_A(a_data_out[3*`DWIDTH-1:2*`DWIDTH]), .OUT_B(out_b23_in_b33), .OUT_MAC(out_mac_23), .enable(enable & loc_tensor_load_en), .d_type(d_type));
PE PE_32(.clk(clk), .reset(reset), .accumulate(accumulate_6_23_32), .accumulate_out(accumulate_7_33), .IN_A(out_a31_in_a32), .IN_B(out_b22_in_b32), .OUT_A(out_a32_in_a33), .OUT_B(b_data_out[3*`DWIDTH-1:2*`DWIDTH]), .OUT_MAC(out_mac_32), .enable(enable & loc_tensor_load_en), .d_type(d_type));

PE PE_33(.clk(clk), .reset(reset), .accumulate(accumulate_7_33), .accumulate_out(), .IN_A(out_a32_in_a33), .IN_B(out_b23_in_b33), .OUT_A(a_data_out[4*`DWIDTH-1:3*`DWIDTH]), .OUT_B(b_data_out[4*`DWIDTH-1:3*`DWIDTH]), .OUT_MAC(out_mac_33), .enable(enable & loc_tensor_load_en), .d_type(d_type));



// data extraction combinational logic in column format
// always the last data is coming from the SA array itself, while the others from the mac out register
always @(*)
begin

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


endmodule



//////// PE ///////////////////////////////////
///////////////////////////////////////////////
module PE(clk, reset, accumulate, accumulate_out, IN_A, IN_B, OUT_A, OUT_B, OUT_MAC, enable, d_type);

input accumulate, enable, d_type;
input clk, reset;
input [`DWIDTH-1:0] IN_A, IN_B;
output reg accumulate_out;
output reg [`DWIDTH-1:0] OUT_A, OUT_B;
output [`ACCWIDTH-1:0] OUT_MAC;


MAC_unit_3stages MAC_inst (.clk(clk), .reset(reset), .accumulate(accumulate), .IN_A(IN_A), .IN_B(IN_B), .OUT_C(OUT_MAC), .enable(enable), .d_type(d_type));



always @(posedge clk)
begin
	if (reset) begin
		OUT_A <= 0;
		OUT_B <= 0;
		accumulate_out <= 0;
	end else begin


		if (enable) begin
			
			accumulate_out <= accumulate;

			OUT_A <= IN_A;
			OUT_B <= IN_B;	

		end	
	end
end


endmodule



//////// MAC unit /////////////////////////////
///////////////////////////////////////////////
module MAC_unit_3stages(clk, reset, accumulate, IN_A, IN_B, OUT_C, enable, d_type);


// accumulate signal to select either accumulation or '0'
input accumulate, enable, d_type;
input clk, reset;
input [`DWIDTH-1:0] IN_A, IN_B;
output reg [`ACCWIDTH-1:0] OUT_C;

reg [`DWIDTH-1:0] IN_A_d, IN_B_d;
reg accumulate_d, accumulate_dd;
reg d_type_d, d_type_dd;

wire [`DWIDTH-1:0] mult_out_int8;
wire [`DWIDTH-1:0] mult_out_bf16;
wire [`DWIDTH-1:0] mux_mult;
reg [`DWIDTH-1:0] mux_mult_reg;

wire [`ACCWIDTH-1:0] add_out_int32;
wire [`ACCWIDTH-1:0] add_out_fp32;

wire [`ACCWIDTH-1:0] mult_bf16_to_fp32;

wire [`ACCWIDTH-1:0] mux_adder;

// assing a feedback signal for port mapping with the adder
wire [`ACCWIDTH-1:0] add_feedback;



// int8 mult, mapped to lower 8-bits
int8_mult int8_mult_inst(.A(IN_A_d[7:0]), .B(IN_B_d[7:0]), .C(mult_out_int8));

// bf16 mult, mapped to all 16-bits
BF16_Mult BF16_Mult_inst(.a(IN_A_d), .b(IN_B_d), .result(mult_out_bf16), .flags());


// mux to select the multiplier based on d_type_d
assign mux_mult = (d_type_d == `INT8) ? mult_out_int8 : mult_out_bf16;


// int32 adder
int32_adder int32_adder_inst(.A(mux_mult_reg), .B(add_feedback), .C(add_out_int32));

// convert bf16 mult out to fp32
bf16_to_fp32 bf16_to_fp32_inst(.a(mux_mult_reg) , .b(mult_bf16_to_fp32));

// fp32 adder, operation 0 for addition
FPAddSub FPAddSub_inst(.a(mult_bf16_to_fp32), .b(add_feedback), .operation(1'b0), .result(add_out_fp32), .flags());

// mux to select adder based on d_type_dd
assign mux_adder = (d_type_dd == `INT8) ? add_out_int32 : add_out_fp32;

// multiplexer to select either accumulation or '0'
assign add_feedback = (accumulate_dd == 1) ? OUT_C : (`ACCWIDTH'd0);


always @(posedge clk)
begin
	if (reset) begin
		IN_A_d <= 0;
		IN_B_d <= 0;
		accumulate_d <= 0;
		accumulate_dd <= 0;
        d_type_d <=0;
        d_type_dd <= 0;
        mux_mult_reg <=0;
        OUT_C <= 0;
	end
	else begin
		if (enable) begin

			accumulate_d <= accumulate;
			accumulate_dd <= accumulate_d;

            d_type_d <= d_type;
            d_type_dd <= d_type_d;

			IN_A_d <= IN_A;
			IN_B_d <= IN_B;

            mux_mult_reg <= mux_mult;

            OUT_C <= mux_adder;
			
		end	
	end
end


endmodule


//////// Multiplier int8 ////////////////////////
/////////////////////////////////////////////////
module int8_mult(A, B, C);

input [8-1:0] A, B;
output [16-1:0] C;

assign C = A * B;

endmodule


//////// Adder int32 ////////////////////////////
/////////////////////////////////////////////////
module int32_adder(A, B, C);

// get input A as the output from the multiplier (16-bit)
input [16-1:0] A; 

// get input B as the output of accumulator (32-bit)
input [32-1:0] B;

output [32-1:0] C;

assign C = A + B;

endmodule





//////// FF with enable logic ///////////////////
/////////////////////////////////////////////////
module FF_enable(clk, reset, data_in, data_out, enable);

input clk, reset, enable;
input [`DWIDTH-1:0] data_in;

output reg [`DWIDTH-1:0] data_out;


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



//////// BF 16 multiplier ///////////////////////
/////////////////////////////////////////////////
module BF16_Mult(
		a,
		b,
		result,
		flags
    );
	
	input [16-1:0] a;					// Input A, a 32-bit floating point number
	input [16-1:0] b;					// Input B, a 32-bit floating point number
	
	// Output ports
	output [16-1:0] result ;					// Product, result of the operation, 32-bit FP number
	output [4:0] flags ;				// Flags indicating exceptions according to IEEE754
	
	// Internal signals
	wire [31:0] Z_int ;				// Product, result of the operation, 32-bit FP number
	wire [4:0] Flags_int ;			// Flags indicating exceptions according to IEEE754
	
	wire Sa ;							// A's sign
	wire Sb ;							// B's sign
	wire Sp ;							// Product sign
	wire [8-1:0] Ea ;					// A's exponent
	wire [8-1:0] Eb ;					// B's exponent
	wire [2*7+1:0] Mp ;					// Product mantissa
	wire [4:0] InputExc ;			// Exceptions in inputs
	wire [7-1:0] NormM ;				// Normalized mantissa
	wire [8:0] NormE ;				// Normalized exponent
	wire [7:0] RoundM ;				// Normalized mantissa
	wire [8:0] RoundE ;				// Normalized exponent
	wire [7:0] RoundMP ;				// Normalized mantissa
	wire [8:0] RoundEP ;				// Normalized exponent
	wire GRS ;

	//reg [63:0] pipe_0;			// Pipeline register Input->Prep
	reg [2*16-1:0] pipe_0;			// Pipeline register Input->Prep

	//reg [92:0] pipe_1;			// Pipeline register Prep->Execute
	reg [3*7+2*8+7:0] pipe_1;			// Pipeline register Prep->Execute

	//reg [38:0] pipe_2;			// Pipeline register Execute->Normalize
	reg [7+8+7:0] pipe_2;			// Pipeline register Execute->Normalize
	
	//reg [72:0] pipe_3;			// Pipeline register Normalize->Round
	reg [2*7+2*8+10:0] pipe_3;			// Pipeline register Normalize->Round

	//reg [36:0] pipe_4;			// Pipeline register Round->Output
	reg [16+4:0] pipe_4;			// Pipeline register Round->Output
	
	assign result = pipe_4[16+4:5] ;
	assign flags = pipe_4[4:0] ;
	
	// Prepare the operands for alignment and check for exceptions
	BF16_Mult_PrepModule PrepModule(pipe_0[2*16-1:16], pipe_0[16-1:0], Sa, Sb, Ea[8-1:0], Eb[8-1:0], Mp[2*7+1:0], InputExc[4:0]) ;

	// Perform (unsigned) mantissa multiplication
	BF16_Mult_ExecuteModule ExecuteModule(pipe_1[3*7+8*2+7:2*7+2*8+8], pipe_1[2*7+2*8+7:2*7+7], pipe_1[2*7+6:5], pipe_1[2*7+2*8+6:2*7+8+7], pipe_1[2*7+8+6:2*7+7], pipe_1[2*7+2*8+8], pipe_1[2*7+2*8+7], Sp, NormE[8:0], NormM[7-1:0], GRS) ;

	// Round result and if necessary, perform a second (post-rounding) normalization step
	BF16_Mult_NormalizeModule NormalizeModule(pipe_2[7-1:0], pipe_2[7+8:7], RoundE[8:0], RoundEP[8:0], RoundM[7:0], RoundMP[7:0]) ;		

	// Round result and if necessary, perform a second (post-rounding) normalization step
	BF16_Mult_RoundModule RoundModule(pipe_3[2*7+1:7+1], pipe_3[7:0], pipe_3[2*7+2*8+3:2*7+8+3], pipe_3[2*7+8+2:2*7+2], pipe_3[2*7+2*8+4], pipe_3[2*7+2*8+5], pipe_3[2*7+2*8+10:2*7+2*8+6], Z_int[16-1:0], Flags_int[4:0]) ;		

	always @ (*) begin		
			/* PIPE 0
				[63:32] A
				[31:0] B
			*/
            pipe_0 = {a, b} ;

			/* PIPE 1
				[70] Sa
				[69] Sb
				[68:61] Ea
				[60:53] Eb
				[52:5] Mp
				[4:0] InputExc
			*/
			pipe_1 = {pipe_0[16+7-1:16], pipe_0[8:0], Sa, Sb, Ea[8-1:0], Eb[8-1:0], Mp[2*7+1:0], InputExc[4:0]} ;
			/* PIPE 2
				[38:34] InputExc
				[33] GRS
				[32] Sp
				[31:23] NormE
				[22:0] NormM
			*/
			pipe_2 = {pipe_1[4:0], GRS, Sp, NormE[8:0], NormM[7-1:0]} ;
			/* PIPE 3
				[72:68] InputExc
				[67] GRS
				[66] Sp	
				[65:57] RoundE
				[56:48] RoundEP
				[47:24] RoundM
				[23:0] RoundMP
			*/
			pipe_3 = {pipe_2[8+7+7:8+7+1], RoundE[8:0], RoundEP[8:0], RoundM[7:0], RoundMP[7:0]} ;
			/* PIPE 4
				[36:5] Z
				[4:0] Flags
			*/				
			pipe_4 = {Z_int[16-1:0], Flags_int[4:0]} ;
    end
		
endmodule


module BF16_Mult_PrepModule (
		a,
		b,
		Sa,
		Sb,
		Ea,
		Eb,
		Mp,
		InputExc
	);
	
	// Input ports
	input [16-1:0] a ;								// Input A, a 32-bit floating point number
	input [16-1:0] b ;								// Input B, a 32-bit floating point number
	
	// Output ports
	output Sa ;										// A's sign
	output Sb ;										// B's sign
	output [8-1:0] Ea ;								// A's exponent
	output [8-1:0] Eb ;								// B's exponent
	output [2*7+1:0] Mp ;							// Mantissa product
	output [4:0] InputExc ;						// Input numbers are exceptions
	
	// Internal signals							// If signal is high...
	wire ANaN ;										// A is a signalling NaN
	wire BNaN ;										// B is a signalling NaN
	wire AInf ;										// A is infinity
	wire BInf ;										// B is infinity
    wire [7-1:0] Ma;
    wire [7-1:0] Mb;
	
	assign ANaN = &(a[16-2:7]) &  |(a[16-2:7]) ;			// All one exponent and not all zero mantissa - NaN
	assign BNaN = &(b[16-2:7]) &  |(b[7-1:0]);			// All one exponent and not all zero mantissa - NaN
	assign AInf = &(a[16-2:7]) & ~|(a[16-2:7]) ;		// All one exponent and all zero mantissa - Infinity
	assign BInf = &(b[16-2:7]) & ~|(b[16-2:7]) ;		// All one exponent and all zero mantissa - Infinity
	
	// Check for any exceptions and put all flags into exception vector
	assign InputExc = {(ANaN | BNaN | AInf | BInf), ANaN, BNaN, AInf, BInf} ;
	//assign InputExc = {(ANaN | ANaN | BNaN |BNaN), ANaN, ANaN, BNaN,BNaN} ;
	
	// Take input numbers apart
	assign Sa = a[16-1] ;							// A's sign
	assign Sb = b[16-1] ;							// B's sign
	assign Ea = a[16-2:7];						// Store A's exponent in Ea, unless A is an exception
	assign Eb = b[16-2:7];						// Store B's exponent in Eb, unless B is an exception	
	

	assign Mp = ({1'b1,a[7-1:0]}*{1'b1, b[7-1:0]}) ;

	
endmodule


module BF16_Mult_ExecuteModule(
		a,
		b,
		MpC,
		Ea,
		Eb,
		Sa,
		Sb,
		Sp,
		NormE,
		NormM,
		GRS
    );

	// Input ports
	input [7-1:0] a ;
	input [2*8:0] b ;
	input [2*7+1:0] MpC ;
	input [8-1:0] Ea ;						// A's exponent
	input [8-1:0] Eb ;						// B's exponent
	input Sa ;								// A's sign
	input Sb ;								// B's sign
	
	// Output ports
	output Sp ;								// Product sign
	output [8:0] NormE ;													// Normalized exponent
	output [7-1:0] NormM ;												// Normalized mantissa
	output GRS ;
	
	wire [2*7+1:0] Mp ;
	
	assign Sp = (Sa ^ Sb) ;												// Equal signs give a positive product
	
	assign Mp = MpC;


	assign NormM = (Mp[2*7+1] ? Mp[2*7:7+1] : Mp[2*7-1:7]); 	// Check for overflow
	assign NormE = (Ea + Eb + Mp[2*7+1]);								// If so, increment exponent
	
	assign GRS = ((Mp[7]&(Mp[7+1]))|(|Mp[7-1:0])) ;
	
endmodule

module BF16_Mult_NormalizeModule(
		NormM,
		NormE,
		RoundE,
		RoundEP,
		RoundM,
		RoundMP
    );

	// Input Ports
	input [7-1:0] NormM ;									// Normalized mantissa
	input [8:0] NormE ;									// Normalized exponent

	// Output Ports
	output [8:0] RoundE ;
	output [8:0] RoundEP ;
	output [7:0] RoundM ;
	output [7:0] RoundMP ; 
	
	assign RoundE = NormE - 15 ;
	assign RoundEP = NormE - 14 ;
	assign RoundM = NormM ;
	assign RoundMP = NormM ;

endmodule

module BF16_Mult_RoundModule(
		RoundM,
		RoundMP,
		RoundE,
		RoundEP,
		Sp,
		GRS,
		InputExc,
		Z,
		Flags
    );

	// Input Ports
	input [7:0] RoundM ;									// Normalized mantissa
	input [7:0] RoundMP ;									// Normalized exponent
	input [8:0] RoundE ;									// Normalized mantissa + 1
	input [8:0] RoundEP ;									// Normalized exponent + 1
	input Sp ;												// Product sign
	input GRS ;
	input [4:0] InputExc ;
	
	// Output Ports
	output [16-1:0] Z ;										// Final product
	output [4:0] Flags ;
	
	// Internal Signals
	wire [8:0] FinalE ;									// Rounded exponent
	wire [7:0] FinalM;
	wire [7:0] PreShiftM;
	
	assign PreShiftM = GRS ? RoundMP : RoundM ;	// Round up if R and (G or S)
	
	// Post rounding normalization (potential one bit shift> use shifted mantissa if there is overflow)
	assign FinalM = (PreShiftM[7] ? {1'b0, PreShiftM[7:1]} : PreShiftM[7:0]) ;
	
	assign FinalE = (PreShiftM[7] ? RoundEP : RoundE) ; // Increment exponent if a shift was done
	
	assign Z = {Sp, FinalE[8-1:0], FinalM[7-1:0]} ;   // Putting the pieces together
	assign Flags = InputExc[4:0];

endmodule


//////// FP 32 adder ////////////////////////////
/////////////////////////////////////////////////
module FPAddSub(
		a,
		b,
		operation,
		result,
		flags
	);

	
	// Input ports
	input [31:0] a ;								// Input A, a 32-bit floating point number
	input [31:0] b ;								// Input B, a 32-bit floating point number
	input operation ;								// Operation select signal (0/Add, 1/Sub)
	
	// Output ports
	output [31:0] result ;						// Result of the operation
	output [4:0] flags ;							// Flags indicating exceptions according to IEEE754

	wire [68:0]pipe_1;
	wire [54:0]pipe_2;
	wire [45:0]pipe_3;


//internal module wires

//output ports
	wire Opout;
	wire Sa;
	wire Sb;
	wire MaxAB;
	wire [7:0] CExp;
	wire [4:0] Shift;
	wire [22:0] Mmax;
	wire [4:0] InputExc;
	wire [23:0] Mmin_3;

	wire [32:0] SumS_5 ;
	wire [4:0] Shift_1;							
	wire PSgn ;							
	wire Opr ;	
	
	wire [22:0] NormM ;				// Normalized mantissa
	wire [8:0] NormE ;					// Adjusted exponent
	wire ZeroSum ;						// Zero flag
	wire NegE ;							// Flag indicating negative exponent
	wire R ;								// Round bit
	wire S ;								// Final sticky bit
	wire FG ;

FPAddSub_a M1(a,b,operation,Opout,Sa,Sb,MaxAB,CExp,Shift,Mmax,InputExc,Mmin_3);

FpAddSub_b M2(pipe_1[51:29],pipe_1[23:0],pipe_1[67],pipe_1[66],pipe_1[65],pipe_1[68],SumS_5,Shift_1,PSgn,Opr);

FPAddSub_c M3(pipe_2[54:22],pipe_2[21:17],pipe_2[16:9],NormM,NormE,ZeroSum,NegE,R,S,FG);

FPAddSub_d M4(pipe_3[13],pipe_3[22:14],pipe_3[45:23],pipe_3[11],pipe_3[10],pipe_3[9],pipe_3[8],pipe_3[7],pipe_3[6],pipe_3[5],pipe_3[12],pipe_3[4:0],result,flags );


/*
pipe_1:
	[68] Opout;
	[67] Sa;
	[66] Sb;
	[65] MaxAB;
	[64:57] CExp;
	[56:52] Shift;
	[51:29] Mmax;
	[28:24] InputExc;
	[23:0] Mmin_3;	

*/

assign pipe_1 = {Opout,Sa,Sb,MaxAB,CExp,Shift,Mmax,InputExc,Mmin_3};

/*
pipe_2:
	[54:22]SumS_5;
	[21:17]Shift;
	[16:9]CExp;	
	[8]Sa;
	[7]Sb;
	[6]operation;
	[5]MaxAB;	
	[4:0]InputExc
*/

assign pipe_2 = {SumS_5,Shift_1,pipe_1[64:57], pipe_1[67], pipe_1[66], pipe_1[68], pipe_1[65], pipe_1[28:24] };

/*
pipe_3:
	[45:23] NormM ;				
	[22:14] NormE ;					
	[13]ZeroSum ;						
	[12]NegE ;							
	[11]R ;								
	[10]S ;								
	[9]FG ;
	[8]Sa;
	[7]Sb;
	[6]operation;
	[5]MaxAB;	
	[4:0]InputExc
*/

assign pipe_3 = {NormM,NormE,ZeroSum,NegE,R,S,FG, pipe_2[8], pipe_2[7], pipe_2[6], pipe_2[5], pipe_2[4:0] };


endmodule



// Prealign + Align + Shift 1 + Shift 2
module FPAddSub_a(
		A,
		B,
		operation,
		Opout,
		Sa,
		Sb,
		MaxAB,
		CExp,
		Shift,
		Mmax,
		InputExc,
		Mmin_3
		
		
	);
	
	// Input ports
	input [31:0] A ;										// Input A, a 32-bit floating point number
	input [31:0] B ;										// Input B, a 32-bit floating point number
	input operation ;
	
	//output ports
	output Opout;
	output Sa;
	output Sb;
	output MaxAB;
	output [7:0] CExp;
	output [4:0] Shift;
	output [22:0] Mmax;
	output [4:0] InputExc;
	output [23:0] Mmin_3;	
							
	wire [9:0] ShiftDet ;							
	wire [30:0] Aout ;
	wire [30:0] Bout ;
	

	// Internal signals									// If signal is high...
	wire ANaN ;												// A is a NaN (Not-a-Number)
	wire BNaN ;												// B is a NaN
	wire AInf ;												// A is infinity
	wire BInf ;												// B is infinity
	wire [7:0] DAB ;										// ExpA - ExpB					
	wire [7:0] DBA ;										// ExpB - ExpA	
	
	assign ANaN = &(A[30:23]) & |(A[22:0]) ;		// All one exponent and not all zero mantissa - NaN
	assign BNaN = &(B[30:23]) & |(B[22:0]);		// All one exponent and not all zero mantissa - NaN
	assign AInf = &(A[30:23]) & ~|(A[22:0]) ;	// All one exponent and all zero mantissa - Infinity
	assign BInf = &(B[30:23]) & ~|(B[22:0]) ;	// All one exponent and all zero mantissa - Infinity
	
	// Put all flags into exception vector
	assign InputExc = {(ANaN | BNaN | AInf | BInf), ANaN, BNaN, AInf, BInf} ;
	
	//assign DAB = (A[30:23] - B[30:23]) ;
	//assign DBA = (B[30:23] - A[30:23]) ;
    assign DAB = (A[30:23] + ~(B[30:23]) + 1) ;
    assign DBA = (B[30:23] + ~(A[30:23]) + 1) ;


	assign Sa = A[31] ;									// A's sign bit
	assign Sb = B[31] ;									// B's sign	bit
	assign ShiftDet = {DBA[4:0], DAB[4:0]} ;		// Shift data
	assign Opout = operation ;
	assign Aout = A[30:0] ;
	assign Bout = B[30:0] ;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// Output ports
													// Number of steps to smaller mantissa shift right
	wire [22:0] Mmin_1 ;							// Smaller mantissa 
	
	// Internal signals
	//wire BOF ;										// Check for shifting overflow if B is larger
	//wire AOF ;										// Check for shifting overflow if A is larger
	
	assign MaxAB = (Aout[30:0] < Bout[30:0]) ;	
	//assign BOF = ShiftDet[9:5] < 25 ;		// Cannot shift more than 25 bits
	//assign AOF = ShiftDet[4:0] < 25 ;		// Cannot shift more than 25 bits
	
	// Determine final shift value
	//assign Shift = MaxAB ? (BOF ? ShiftDet[9:5] : 5'b11001) : (AOF ? ShiftDet[4:0] : 5'b11001) ;
	
	assign Shift = MaxAB ? ShiftDet[9:5] : ShiftDet[4:0] ;
	
	// Take out smaller mantissa and append shift space
	assign Mmin_1 = MaxAB ? Aout[22:0] : Bout[22:0] ; 
	
	// Take out larger mantissa	
	assign Mmax = MaxAB ? Bout[22:0]: Aout[22:0] ;	
	
	// Common exponent
	assign CExp = (MaxAB ? Bout[30:23] : Aout[30:23]) ;	

// Input ports
					// Smaller mantissa after 16|12|8|4 shift
	wire [2:0] Shift_1 ;						// Shift amount
	
	assign Shift_1 = Shift [4:2];

	wire [23:0] Mmin_2 ;						// The smaller mantissa
	
	// Internal signals
	reg	  [23:0]		Lvl1;
	reg	  [23:0]		Lvl2;
	wire    [47:0]    Stage1;	
	integer           i;                // Loop variable
	
	always @(*) begin						
		// Rotate by 16?
		Lvl1 <= Shift_1[2] ? {17'b00000000000000001, Mmin_1[22:16]} : {1'b1, Mmin_1}; 
	end
	
	assign Stage1 = {Lvl1, Lvl1};
	
	always @(*) begin    					// Rotate {0 | 4 | 8 | 12} bits
	  case (Shift_1[1:0])
			// Rotate by 0	
			2'b00:  Lvl2 <= Stage1[23:0];       			
			// Rotate by 4	
			2'b01:  begin for (i=0; i<=23; i=i+1) begin Lvl2[i] <= Stage1[i+4]; end Lvl2[23:19] <= 0; end
			// Rotate by 8
			2'b10:  begin for (i=0; i<=23; i=i+1) begin Lvl2[i] <= Stage1[i+8]; end Lvl2[23:15] <= 0; end
			// Rotate by 12	
			2'b11:  begin for (i=0; i<=23; i=i+1) begin Lvl2[i] <= Stage1[i+12]; end Lvl2[23:11] <= 0; end
	  endcase
	end
	
	// Assign output to next shift stage
	assign Mmin_2 = Lvl2;
								// Smaller mantissa after 16|12|8|4 shift
	wire [1:0] Shift_2 ;						// Shift amount
	
	assign Shift_2 =Shift  [1:0] ;
					// The smaller mantissa
	
	// Internal Signal
	reg	  [23:0]		Lvl3;
	wire    [47:0]    Stage2;	
	integer           j;               // Loop variable
	
	assign Stage2 = {Mmin_2, Mmin_2};

	always @(*) begin    // Rotate {0 | 1 | 2 | 3} bits
	  case (Shift_2[1:0])
			// Rotate by 0
			2'b00:  Lvl3 <= Stage2[23:0];   
			// Rotate by 1
			2'b01:  begin for (j=0; j<=23; j=j+1)  begin Lvl3[j] <= Stage2[j+1]; end Lvl3[23] <= 0; end 
			// Rotate by 2
			2'b10:  begin for (j=0; j<=23; j=j+1)  begin Lvl3[j] <= Stage2[j+2]; end Lvl3[23:22] <= 0; end 
			// Rotate by 3
			2'b11:  begin for (j=0; j<=23; j=j+1)  begin Lvl3[j] <= Stage2[j+3]; end Lvl3[23:21] <= 0; end 	  
	  endcase
	end
	
	// Assign output
	assign Mmin_3 = Lvl3;	

	
endmodule



module FpAddSub_b(
		Mmax,
		Mmin,
		Sa,
		Sb,
		MaxAB,
		OpMode,
		SumS_5,
		Shift,
		PSgn,
		Opr
);
	input [22:0] Mmax ;					// The larger mantissa
	input [23:0] Mmin ;					// The smaller mantissa
	input Sa ;								// Sign bit of larger number
	input Sb ;								// Sign bit of smaller number
	input MaxAB ;							// Indicates the larger number (0/A, 1/B)
	input OpMode ;							// Operation to be performed (0/Add, 1/Sub)
	
	// Output ports
	wire [32:0] Sum ;	
						// Output ports
	output [32:0] SumS_5 ;					// Mantissa after 16|0 shift
	output [4:0] Shift ;					// Shift amount				// The result of the operation
	output PSgn ;							// The sign for the result
	output Opr ;							// The effective (performed) operation

	assign Opr = (OpMode^Sa^Sb); 		// Resolve sign to determine operation

	// Perform effective operation
  
	assign Sum = (OpMode^Sa^Sb) ? ({1'b1, Mmax, 8'b00000000} - {Mmin, 8'b00000000}) : ({1'b1, Mmax, 8'b00000000} + {Mmin, 8'b00000000}) ;
	
  	// Assign result sign
	assign PSgn = (MaxAB ? Sb : Sa) ;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		// Determine normalization shift amount by finding leading nought
	assign Shift =  ( 
		Sum[32] ? 5'b00000 :	 
		Sum[31] ? 5'b00001 : 
		Sum[30] ? 5'b00010 : 
		Sum[29] ? 5'b00011 : 
		Sum[28] ? 5'b00100 : 
		Sum[27] ? 5'b00101 : 
		Sum[26] ? 5'b00110 : 
		Sum[25] ? 5'b00111 :
		Sum[24] ? 5'b01000 :
		Sum[23] ? 5'b01001 :
		Sum[22] ? 5'b01010 :
		Sum[21] ? 5'b01011 :
		Sum[20] ? 5'b01100 :
		Sum[19] ? 5'b01101 :
		Sum[18] ? 5'b01110 :
		Sum[17] ? 5'b01111 :
		Sum[16] ? 5'b10000 :
		Sum[15] ? 5'b10001 :
		Sum[14] ? 5'b10010 :
		Sum[13] ? 5'b10011 :
		Sum[12] ? 5'b10100 :
		Sum[11] ? 5'b10101 :
		Sum[10] ? 5'b10110 :
		Sum[9] ? 5'b10111 :
		Sum[8] ? 5'b11000 :
		Sum[7] ? 5'b11001 : 5'b11010
	);
	
	reg	  [32:0]		Lvl1;
	
	always @(*) begin
		// Rotate by 16?
		Lvl1 <= Shift[4] ? {Sum[16:0], 16'b0000000000000000} : Sum; 
	end
	
	// Assign outputs
	assign SumS_5 = Lvl1;	

endmodule




module FPAddSub_c(
		SumS_5,
		Shift,
		CExp,
		NormM,
		NormE,
		ZeroSum,
		NegE,
		R,
		S,
		FG
	);
	
	// Input ports
	input [32:0] SumS_5 ;						// Smaller mantissa after 16|12|8|4 shift
	
	input [4:0] Shift ;						// Shift amount
	
// Input ports
	
	input [7:0] CExp ;
	

	// Output ports
	output [22:0] NormM ;				// Normalized mantissa
	output [8:0] NormE ;					// Adjusted exponent
	output ZeroSum ;						// Zero flag
	output NegE ;							// Flag indicating negative exponent
	output R ;								// Round bit
	output S ;								// Final sticky bit
	output FG ;


	wire [3:0]Shift_1;
	assign Shift_1 = Shift [3:0];
	// Output ports
	wire [32:0] SumS_7 ;						// The smaller mantissa
	
	reg	  [32:0]		Lvl2;
	wire    [65:0]    Stage1;	
	reg	  [32:0]		Lvl3;
	wire    [65:0]    Stage2;	
	integer           i;               	// Loop variable
	
	assign Stage1 = {SumS_5, SumS_5};

	always @(*) begin    					// Rotate {0 | 4 | 8 | 12} bits
	  case (Shift[3:2])
			// Rotate by 0
			2'b00: Lvl2 <= Stage1[32:0];       		
			// Rotate by 4
			2'b01: begin for (i=65; i>=33; i=i-1) begin Lvl2[i-33] <= Stage1[i-4]; end Lvl2[3:0] <= 0; end
			// Rotate by 8
			2'b10: begin for (i=65; i>=33; i=i-1) begin Lvl2[i-33] <= Stage1[i-8]; end Lvl2[7:0] <= 0; end
			// Rotate by 12
			2'b11: begin for (i=65; i>=33; i=i-1) begin Lvl2[i-33] <= Stage1[i-12]; end Lvl2[11:0] <= 0; end
	  endcase
	end
	
	assign Stage2 = {Lvl2, Lvl2};

	always @(*) begin   				 		// Rotate {0 | 1 | 2 | 3} bits
	  case (Shift_1[1:0])
			// Rotate by 0
			2'b00:  Lvl3 <= Stage2[32:0];
			// Rotate by 1
			2'b01: begin for (i=65; i>=33; i=i-1) begin Lvl3[i-33] <= Stage2[i-1]; end Lvl3[0] <= 0; end 
			// Rotate by 2
			2'b10: begin for (i=65; i>=33; i=i-1) begin Lvl3[i-33] <= Stage2[i-2]; end Lvl3[1:0] <= 0; end
			// Rotate by 3
			2'b11: begin for (i=65; i>=33; i=i-1) begin Lvl3[i-33] <= Stage2[i-3]; end Lvl3[2:0] <= 0; end
	  endcase
	end
	
	// Assign outputs
	assign SumS_7 = Lvl3;						// Take out smaller mantissa



	
	// Internal signals
	wire MSBShift ;						// Flag indicating that a second shift is needed
	wire [8:0] ExpOF ;					// MSB set in sum indicates overflow
	wire [8:0] ExpOK ;					// MSB not set, no adjustment
	
	// Calculate normalized exponent and mantissa, check for all-zero sum
	assign MSBShift = SumS_7[32] ;		// Check MSB in unnormalized sum
	assign ZeroSum = ~|SumS_7 ;			// Check for all zero sum
 
	assign ExpOK = CExp - Shift ;		// Adjust exponent for new normalized mantissa
 	assign NegE = ExpOK[8] ;			// Check for exponent overflow
 
	assign ExpOF = CExp - Shift + 1'b1 ;		// If MSB set, add one to exponent(x2)
 
 	assign NormE = MSBShift ? ExpOF : ExpOK ;			// Check for exponent overflow
	assign NormM = SumS_7[31:9] ;		// The new, normalized mantissa
	
	// Also need to compute sticky and round bits for the rounding stage
	assign FG = SumS_7[8] ; 
	assign R = SumS_7[7] ;
	assign S = |SumS_7[6:0] ;		
	
endmodule



module FPAddSub_d(
		ZeroSum,
		NormE,
		NormM,
		R,
		S,
		G,
		Sa,
		Sb,
		Ctrl,
		MaxAB,
		NegE,
		InputExc,
		P,
		Flags 
    );

	// Input ports
	input ZeroSum ;					// Sum is zero
	input [8:0] NormE ;				// Normalized exponent
	input [22:0] NormM ;				// Normalized mantissa
	input R ;							// Round bit
	input S ;							// Sticky bit
	input G ;
	input Sa ;							// A's sign bit
	input Sb ;							// B's sign bit
	input Ctrl ;						// Control bit (operation)
	input MaxAB ;
	

	input NegE ;						// Negative exponent?
	input [4:0] InputExc ;					// Exceptions in inputs A and B

	// Output ports
	output [31:0] P ;					// Final result
	output [4:0] Flags ;				// Exception flags
	
	// 
	wire [31:0] Z ;					// Final result
	wire EOF ;
	
	// Internal signals
	wire [23:0] RoundUpM ;			// Rounded up sum with room for overflow
	wire [22:0] RoundM ;				// The final rounded sum
	wire [8:0] RoundE ;				// Rounded exponent (note extra bit due to poential overflow	)
	wire RoundUp ;						// Flag indicating that the sum should be rounded up
	wire ExpAdd ;						// May have to add 1 to compensate for overflow 
	wire RoundOF ;						// Rounding overflow
	wire FSgn;
	// The cases where we need to round upwards (= adding one) in Round to nearest, tie to even
	assign RoundUp = (G & ((R | S) | NormM[0])) ;
	
	// Note that in the other cases (rounding down), the sum is already 'rounded'
	assign RoundUpM = (NormM + 1) ;								// The sum, rounded up by 1
	assign RoundM = (RoundUp ? RoundUpM[22:0] : NormM) ; 	// Compute final mantissa	
	assign RoundOF = RoundUp & RoundUpM[23] ; 				// Check for overflow when rounding up

	// Calculate post-rounding exponent
	assign ExpAdd = (RoundOF ? 1'b1 : 1'b0) ; 				// Add 1 to exponent to compensate for overflow
	assign RoundE = ZeroSum ? 8'b00000000 : (NormE + ExpAdd) ; 							// Final exponent

	// If zero, need to determine sign according to rounding
	assign FSgn = (ZeroSum & (Sa ^ Sb)) | (ZeroSum ? (Sa & Sb & ~Ctrl) : ((~MaxAB & Sa) | ((Ctrl ^ Sb) & (MaxAB | Sa)))) ;

	// Assign final result
	assign Z = {FSgn, RoundE[7:0], RoundM[22:0]} ;
	
	// Indicate exponent overflow
	assign EOF = RoundE[8];

/////////////////////////////////////////////////////////////////////////////////////////////////////////



	
	// Internal signals
	wire Overflow ;					// Overflow flag
	wire Underflow ;					// Underflow flag
	wire DivideByZero ;				// Divide-by-Zero flag (always 0 in Add/Sub)
	wire Invalid ;						// Invalid inputs or result
	wire Inexact ;						// Result is inexact because of rounding
	
	// Exception flags
	
	// Result is too big to be represented
	assign Overflow = EOF | InputExc[1] | InputExc[0] ;
	
	// Result is too small to be represented
	assign Underflow = NegE & (R | S);
	
	// Infinite result computed exactly from finite operands
	assign DivideByZero = &(Z[30:23]) & ~|(Z[30:23]) & ~InputExc[1] & ~InputExc[0];
	
	// Invalid inputs or operation
	assign Invalid = |(InputExc[4:2]) ;
	
	// Inexact answer due to rounding, overflow or underflow
	assign Inexact = (R | S) | Overflow | Underflow;
	
	// Put pieces together to form final result
	assign P = Z ;
	
	// Collect exception flags	
	assign Flags = {Overflow, Underflow, DivideByZero, Invalid, Inexact} ; 	
	
endmodule


/////////////////////////////////////////
// Converter for bf16 to fp32 
/////////////////////////////////////////
module bf16_to_fp32 (input [15:0] a , output [31:0] b);

reg [31:0]b_temp;
reg [3:0] j;
reg [3:0] k;
reg [3:0] k_temp;

always @ (*) begin

if ( a [14: 0] == 15'b0 ) begin //signed zero
    b_temp [31] = a[15]; //sign bit
    b_temp[30:0] = 31'b0;
end

else begin

    if ( a[14 : 7] == 8'b0 ) begin //denormalized (covert to normalized)
        
        for (j=0; j<=6; j=j+1) begin
            if (a[j] == 1'b1) begin 
                k_temp = j; 
            end
        end
    k = 6 - k_temp;

    b_temp [22:0] = ( (a [6:0] << (k+1'b1)) & 7'h7F ) << 16; 
    b_temp [30:23] =  7'd127 - 7'd127 - k;
    b_temp [31] = a[15];
    end

    else if ( a[14 : 7] == 8'b11111111 ) begin //Infinity/ NAN
    b_temp [22:0] = a [6:0] << 16;
    b_temp [30:23] = 8'hFF;
    b_temp [31] = a[15];
    end

    else begin //Normalized Number
    b_temp [22:0] = a [6:0] << 16;
    b_temp [30:23] =  7'd127 - 7'd127 + a[14:7];
    b_temp [31] = a[15];
    end
end
end

assign b = b_temp;
endmodule