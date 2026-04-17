import math




def gen_verilog_dense_gemm_Aman_like_4_BRAM_per_col(X, Y, K, U, V):

    print("# of Tensor Slices:", Y*X)
    print("# of BRAMs:", Y*X*4 + Y + 4*X)

    with open("dense_gemm_Aman_like_4_BRAM_per_col.v", "w") as f:

        print("""
// `define DWIDTH 8
// `define ACCWIDTH 32
`define DENSE 0""", file=f)


        print("`define K " + str(K), file=f)
        print("`define U " + str(U), file=f)
        print("`define V " + str(V), file=f)

        print("`define A_cnt_width " + str(math.ceil(math.log2(K*U))), file=f)
        print("`define B_cnt_width " + str(math.ceil(math.log2(K*V))), file=f)
        print("`define C_cnt_width " + str(math.ceil(math.log2(4*U*V))), file=f)

        print("`define U_bits " + str(math.ceil(math.log2(U))), file=f)
        print("`define V_bits " + str(math.ceil(math.log2(V))), file=f)

        
        print(""" 
module sparse_dense_gemm(
    clk,
    reset,
    enable,
    cout_data);
        
input clk, reset, enable;""", file=f)


        print("output [" + str(4*X*Y-1) + ":0] cout_data;\n", file=f)


        print("// Ay wires", file=f)

        for i in range(0, Y):
            print("wire [32-1:0] A" + str(i) + "_data;", file=f)


        print("\n", file=f)
        print("// Bx wires", file=f)

        for i in range(0, X):
            print("wire [32-1:0] B" + str(i) + "_data;", file=f)


        print("\n", file=f)
        print("// valid_out_x_y signals", file=f)

        for x in range(0, X):
            for y in range(0, Y):
                print("wire valid_out" + str(x) + "_" + str(y) + ";", file=f)


        print("\n", file=f)
        print("// Cx_y signals", file=f)

        for x in range(0, X):
            for y in range(0, Y):
                print("wire [128-1:0] C" + str(x) + "_" + str(y) + "_data;", file=f)


        print("\n", file=f)

        for x in range(0, X):
            for y in range(0, Y):
                print("wire [128-1:0] C" + str(x) + "_" + str(y) + "_data_out_mem;", file=f)


        print("\n", file=f)
        print("// horizontal connections", file=f)

        for y in range(0, Y):
            for x in range(0, X-1):
                print("wire [32-1:0] A_out" + str(x) + "_" + str(y) + "_in" + str(x+1) + "_" + str(y) + ";", file=f)


        print("\n", file=f)
        print("// vertical connections", file=f)

        for x in range(0, X):
            for y in range(0, Y-1):
                print("wire [32-1:0] B_out" + str(x) + "_" + str(y) + "_in" + str(x) + "_" + str(y+1) + ";", file=f)


        print("\n", file=f)
        print("// a_data_in unconnected", file=f)

        for y in range(0, Y):
            print("wire a_data_in0_" + str(y) + ";", file=f)


        print("\n", file=f)
        print("// b_data_in unconnected", file=f)

        for x in range(0, X):
            print("wire b_data_in" + str(x) + "_0;", file=f)


        print("\n", file=f)
        print("// a_data unconnected", file=f)

        for x in range(1, X):
            for y in range(0, Y):
                print("wire a_data" + str(x) + "_" + str(y) + ";", file=f)


        print("\n", file=f)
        print("// b_data unconnected", file=f)

        for x in range(0, X):
            for y in range(1, Y):
                print("wire b_data" + str(x) + "_" + str(y) + ";", file=f)

        
        print("\n", file=f)
        print("// accumulate signal for tiling (generated from control logic)", file=f)
        print("wire acc_in;", file=f)


        print("\n", file=f)
        print("// accumulate_out connections", file=f)

        for x in range(0, X):
            for y in range(0, Y-1):
                print("wire accumulate_out" + str(x) + "_" + str(y) + ";", file=f)


        print("\n", file=f)
        print("// Ay", file=f)
        print("A0_input_mem_control_logic #(.mwidth(32), .addr_width(`A_cnt_width), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))", file=f)
        print("\t\t\t\t\t A0 (.clk(clk), .reset(reset), .enable(enable), .data_out(A0_data), .accumulate_out(acc_in));\n", file=f)
        
        for y in range(1, Y):
            print("Ay_input_mem_control_logic #(.mwidth(32), .addr_width(`A_cnt_width), .start_cnt_bits(" + str(math.ceil(math.log2(y*4))) + "), .start_val(" + str(y*4-1) + "), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))", file=f)
            print("\t\t\t\t\t A" + str(y) + " (.clk(clk), .reset(reset), .enable(enable), .data_out(A" + str(y) + "_data));\n", file=f)


        print("// Bx", file=f)
        print("B0_input_mem_control_logic #(.mwidth(32), .addr_width(`B_cnt_width), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits)) ", file=f)
        print("\t\t\t\t\t B0 (.clk(clk), .reset(reset), .enable(enable), .data_out(B0_data));\n", file=f)

        for x in range(1, X):
            print("Bx_input_mem_control_logic #(.mwidth(32), .addr_width(`B_cnt_width), .start_cnt_bits(" + str(math.ceil(math.log2(x*4))) + "), .start_val(" + str(x*4-1) + "), .K_const(`K), .U_const(`U), .V_const(`V), .U_bits(`U_bits), .V_bits(`V_bits))", file=f)
            print("\t\t\t\t\t B" + str(x) + " (.clk(clk), .reset(reset), .enable(enable), .data_out(B" + str(x) + "_data));\n", file=f)




        print("\n// TS_xy", file=f)
        for x in range(0, X):
            for y in range(0, Y):
                

                # x == 0 => A loading from buffers
                if (x == 0):
                    a_data = "A" + str(y) + "_data"
                    a_data_in = "a_data_in0_" + str(y)

                    if (y == 0):
                        b_data = "B" + str(x) + "_data"
                        b_data_in = "b_data_in" + str(x) + "_0"
                        a_data_out = "A_out" + str(x) + "_" + str(y) + "_in" + str(x+1) + "_" + str(y)
                        b_data_out = "B_out" + str(x) + "_" + str(y) + "_in" + str(x) + "_" + str(y+1)
                        accumulate = "acc_in"
                        accumulate_out = "accumulate_out" + str(x) + "_" + str(y)

                    elif (y == Y - 1):
                        b_data = "b_data" + str(x) + "_" + str(y)
                        b_data_in = "B_out" + str(x) + "_" + str(y-1) + "_in" + str(x) + "_" + str(y)
                        a_data_out = "A_out" + str(x) + "_" + str(y) + "_in" + str(x+1) + "_" + str(y)
                        b_data_out = ""
                        accumulate = "accumulate_out" + str(x) + "_" + str(y-1)
                        accumulate_out = ""
                    
                    else:
                        b_data = "b_data" + str(x) + "_" + str(y)
                        b_data_in = "B_out" + str(x) + "_" + str(y-1) + "_in" + str(x) + "_" + str(y)
                        a_data_out = "A_out" + str(x) + "_" + str(y) + "_in" + str(x+1) + "_" + str(y)
                        b_data_out = "B_out" + str(x) + "_" + str(y) + "_in" + str(x) + "_" + str(y+1)
                        accumulate = "accumulate_out" + str(x) + "_" + str(y-1)
                        accumulate_out = "accumulate_out" + str(x) + "_" + str(y)


                # y == 0 => B loading from buffers
                elif (y == 0):
                    b_data = "B" + str(x) + "_data"
                    b_data_in = "b_data_in" + str(x) + "_0"

                    a_data = "a_data" + str(x) + "_" + str(y)
                    a_data_in = "A_out" + str(x-1) + "_" + str(y) + "_in" + str(x) + "_" + str(y)
                    b_data_out = "B_out" + str(x) + "_" + str(y) + "_in" + str(x) + "_" + str(y+1)
                    accumulate = "accumulate_out" + str(x-1) + "_" + str(y)
                    accumulate_out = "accumulate_out" + str(x) + "_" + str(y)

                    if (x == X - 1):    
                        a_data_out = ""
                    else:
                        a_data_out = "A_out" + str(x) + "_" + str(y) + "_in" + str(x+1) + "_" + str(y)
                        
                

                elif (x == X - 1):

                    a_data = "a_data" + str(x) + "_" + str(y)
                    a_data_in = "A_out" + str(x-1) + "_" + str(y) + "_in" + str(x) + "_" + str(y)
                    b_data = "b_data" + str(x) + "_" + str(y)
                    b_data_in = "B_out" + str(x) + "_" + str(y-1) + "_in" + str(x) + "_" + str(y)
                    a_data_out = ""
                    accumulate = "accumulate_out" + str(x) + "_" + str(y-1)
                    

                    if (y == Y - 1):
                        b_data_out = ""
                        accumulate_out = ""
                    else:
                        b_data_out = "B_out" + str(x) + "_" + str(y) + "_in" + str(x) + "_" + str(y+1)
                        accumulate_out = "accumulate_out" + str(x) + "_" + str(y)


                elif (y == Y - 1):

                    a_data = "a_data" + str(x) + "_" + str(y)
                    a_data_in = "A_out" + str(x-1) + "_" + str(y) + "_in" + str(x) + "_" + str(y)
                    b_data = "b_data" + str(x) + "_" + str(y)
                    b_data_in = "B_out" + str(x) + "_" + str(y-1) + "_in" + str(x) + "_" + str(y)
                    a_data_out = "A_out" + str(x) + "_" + str(y) + "_in" + str(x+1) + "_" + str(y)
                    b_data_out = ""
                    accumulate = "accumulate_out" + str(x) + "_" + str(y-1)
                    accumulate_out = ""

                # all other cases are internal (normal connections)
                else:
                    a_data = "a_data" + str(x) + "_" + str(y)
                    a_data_in = "A_out" + str(x-1) + "_" + str(y) + "_in" + str(x) + "_" + str(y)
                    b_data = "b_data" + str(x) + "_" + str(y)
                    b_data_in = "B_out" + str(x) + "_" + str(y-1) + "_in" + str(x) + "_" + str(y)
                    a_data_out = "A_out" + str(x) + "_" + str(y) + "_in" + str(x+1) + "_" + str(y)
                    b_data_out = "B_out" + str(x) + "_" + str(y) + "_in" + str(x) + "_" + str(y+1)
                    accumulate = "accumulate_out" + str(x) + "_" + str(y-1)
                    accumulate_out = "accumulate_out" + str(x) + "_" + str(y)


                # not specific case
                c_data = "C" + str(x) + "_" + str(y) + "_data"
                valid_out = "valid_out" + str(x) + "_" + str(y)


                print("dense_tensor_slice TS_" + str(x) + "_" + str(y) + " (.clk(clk), .reset(reset), .a_data(" + a_data + "), .a_data_in(" + a_data_in + "), .b_data(" + b_data + "),", file=f)
                print("\t\t\t\t\t\t .b_data_in(" + b_data_in + "), .a_data_out(" + a_data_out + "), .b_data_out(" + b_data_out + "), .c_data(" + c_data + "),", file=f)
                print("\t\t\t\t\t\t .K_size(`K), .enable(enable), .accumulate(" + accumulate + "),", file=f)
                print("\t\t\t\t\t\t .accumulate_out(" + accumulate_out + "), .valid_out(" + valid_out + "));\n", file=f)




        print("\n// Cxy", file=f)
        for x in range(0, X):
            for y in range(0, Y):

                print("output_mem_Cxy_control_logic #(.mwidth(32), .addr_width(`C_cnt_width), .U_const(`U), .V_const(`V))", file=f)
                print("\t\t\t\t\t\t C" + str(x) + "_" + str(y) + " (.clk(clk), .reset(reset), .enable(enable), .valid_in(valid_out" + str(x) + "_" + str(y) + "),", file=f)
                print("\t\t\t\t\t\t .data_in_0(C" + str(x) + "_" + str(y) + "_data[31:0]), .data_in_1(C" + str(x) + "_" + str(y) + "_data[63:32]), .data_in_2(C" + str(x) + "_" + str(y) + "_data[95:64]), .data_in_3(C" + str(x) + "_" + str(y) + "_data[127:96]),", file=f)
                print("\t\t\t\t\t\t .data_out_0(C" + str(x) + "_" + str(y) + "_data_out_mem[31:0]), .data_out_1(C" + str(x) + "_" + str(y) + "_data_out_mem[63:32]), .data_out_2(C" + str(x) + "_" + str(y) + "_data_out_mem[95:64]), .data_out_3(C" + str(x) + "_" + str(y) + "_data_out_mem[127:96]));\n", file=f)



        print("// perform reduction operation so Cxy memories don't get optimized out", file=f)
        for x in range(0, X):
            for y in range(0, Y):
                print("assign cout_data[" + str(x*Y*4 + y*4 + 0) + "] = &C" +  str(x) + "_" + str(y) + "_data_out_mem[31:0];", file=f)
                print("assign cout_data[" + str(x*Y*4 + y*4 + 1) + "] = &C" +  str(x) + "_" + str(y) + "_data_out_mem[63:32];", file=f)
                print("assign cout_data[" + str(x*Y*4 + y*4 + 2) + "] = &C" +  str(x) + "_" + str(y) + "_data_out_mem[95:64];", file=f)
                print("assign cout_data[" + str(x*Y*4 + y*4 + 3) + "] = &C" +  str(x) + "_" + str(y) + "_data_out_mem[127:96];\n", file=f)




        print("endmodule\n\n", file=f)
                


        print("""
 
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
    reg [1:0] sel_cnt;
     
    wire [mwidth-1:0] mem_out_0, mem_out_1, mem_out_2, mem_out_3;
    wire [mwidth-1:0] mux_out;


    always @ (posedge clk) 
    begin
        if (reset) begin
            addr_counter <= 0;
            u_counter <= 0;
            v_counter <= 0;
            sel_cnt <= 0;
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

                        sel_cnt <= sel_cnt + 1;

                        // increase address counter when all 4 memories have been read once
                        if (sel_cnt == 3) begin
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
    assign data_out = mux_out;

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

    wire [mwidth-1:0] mem_out_0, mem_out_1, mem_out_2, mem_out_3;
    wire [mwidth-1:0] mux_out;

    reg [1:0] sel_cnt;


    always @ (posedge clk) 
    begin
        if (reset) begin
            start_counter <= 0;
            addr_counter <= 0;
            u_counter <= 0;
            v_counter <= 0;
            sel_cnt <= 0;
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

                            sel_cnt <= sel_cnt + 1;

                            // increase address counter when all 4 memories have been read once (every 4 cycles)
                            if (sel_cnt == 3) begin
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
    assign data_out = mux_out;


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

    endmodule""", file=f)



# # Y corresponds to A (Y>=3)
# Y = 3

# # X corresponds to B (X>=3)
# X = 3

# K = 64
# U = 8
# V = 8

# gen_verilog_dense_gemm_Aman_like_4_BRAM_per_col(X, Y, K, U, V)