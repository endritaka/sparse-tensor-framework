import subprocess
import random
from verilog_auto_code_gemm_all_sparsity_levels_mapped_to_DSPs import gen_verilog_gemm_all_sparsity_levels_mapped_to_DSPs


# seeds
num_runs = 2

arch_file="k6FracN10LB_mem20K_complexDSP_customSB_for_DSP_mapping_Fcin0.15_Fcout0.10_7nm_COFFE_arch.xml"
verilog_file = "sparse_gemm_all_levels_mapped_to_DSPs.v"

#specify the parent dir
parent_dir = "mult_seeds_sparse_gemm_all_levels_mapped_to_DSPs"


VTR_ROOT="/home/et23644@austin.utexas.edu/Desktop/VTR_dir/vtr-verilog-to-routing_april2024"
vtr_flow_path = VTR_ROOT + "/vtr_flow/scripts/run_vtr_flow.py"
verilog_path = VTR_ROOT + "/vtr_work/verilog_files/" + verilog_file
arch_path = VTR_ROOT + "/vtr_work/arch_files_xml/" + arch_file 
sdc_file_path = VTR_ROOT + "/vtr_work/constraints_dir/cut_IO_maximize_freq.sdc"


#multiple configurations
for x_y in range(3, 11):

    #multiple seeds
    for i in range(num_runs):

        seed = random.randrange(10000)

        #output directory
        temp_dir_path = VTR_ROOT + "/vtr_work/out_dir/" + parent_dir + "/X_" + str(x_y) + "Y_" + str(x_y) + "/" + str(i) + "_" + str(seed)

        K = 64
        U = 8
        V = 8


        X = x_y
        Y = x_y
        # generate verilog code
        gen_verilog_gemm_all_sparsity_levels_mapped_to_DSPs(X, Y, K, U, V)



        # run VTR flow
        subprocess.run([vtr_flow_path + " " + verilog_path + " " + arch_path +  " -temp_dir " + temp_dir_path + 
                        " --route_chan_width 300 --seed " + str(seed) + " --sdc_file " + sdc_file_path], shell=True)