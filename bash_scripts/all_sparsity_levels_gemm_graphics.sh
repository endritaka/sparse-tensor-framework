#!/bin/bash


VTR_ROOT=/home/et23644@austin.utexas.edu/Desktop/VTR_dir/vtr-verilog-to-routing_april2024


# Visualize circuit VPR


arch_file="k6FracN10LB_mem20K_complexDSP_customSB_sparse_dense_ded_links_Fcin0.15_Fcout0.10_7nm_COFFE_arch.xml"

$VTR_ROOT/vpr/vpr $VTR_ROOT/vtr_work/arch_files_xml/$arch_file \
$VTR_ROOT/vtr_work/out_dir/all_sparsity_levels_gemm_sparse_TS/all_sparsity_levels_gemm_sparse_TS \
--circuit_file $VTR_ROOT/vtr_work/out_dir/all_sparsity_levels_gemm_sparse_TS/all_sparsity_levels_gemm_sparse_TS.pre-vpr.blif \
--route_chan_width 300 --device fixed_layout_custom  --analysis --disp on --sdc_file $VTR_ROOT/vtr_work/constraints_dir/cut_IO_maximize_freq.sdc

