#!/bin/bash


VTR_ROOT=/home/et23644@austin.utexas.edu/Desktop/VTR_dir/vtr-verilog-to-routing_april2024


# run VTR flow


arch_file="k6FracN10LB_mem20K_complexDSP_customSB_dense_TS_Aman_like_Fcin0.15_Fcout0.10_7nm_COFFE_arch.xml"

$VTR_ROOT/vtr_flow/scripts/run_vtr_flow.py  $VTR_ROOT/vtr_work/verilog_files/dense_tensor_slice_Aman_like.v \
$VTR_ROOT/vtr_work/arch_files_xml/$arch_file \
-temp_dir $VTR_ROOT/vtr_work/out_dir/dense_Aman_like  \
--route_chan_width 300 --sdc_file $VTR_ROOT/vtr_work/constraints_dir/cut_IO_maximize_freq.sdc