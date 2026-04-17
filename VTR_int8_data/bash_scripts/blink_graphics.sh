#!/bin/bash


VTR_ROOT=/home/et23644@austin.utexas.edu/Desktop/VTR_dir/vtr-verilog-to-routing_april2024


# Visualize circuit VPR


$VTR_ROOT/vpr/vpr $VTR_ROOT/vtr_flow/arch/timing/EArch.xml $VTR_ROOT/vtr_work/quickstart/blink_run_flow/blink \
--circuit_file $VTR_ROOT/vtr_work/quickstart/blink_run_flow/blink.pre-vpr.blif \
--route_chan_width 100 --analysis --disp on


