#!/bin/bash


VTR_ROOT=/home/et23644@austin.utexas.edu/Desktop/VTR_dir/vtr-verilog-to-routing_april2024


# run VTR flow

$VTR_ROOT/vtr_flow/scripts/run_vtr_flow.py  $VTR_ROOT/doc/src/quickstart/blink.v \
 $VTR_ROOT/vtr_flow/arch/timing/EArch.xml \
 -temp_dir $VTR_ROOT/vtr_work/quickstart/blink_run_flow  \
 --route_chan_width 100

