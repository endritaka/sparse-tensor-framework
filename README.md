# Systolic Sparse Tensor Slices

This repository contains code and automation flow for the work "Systolic Sparse Tensor Slices: FPGA Building Blocks for Sparse and Dense AI Acceleration" which was accepted at ISFPGA 2025 (https://dl.acm.org/doi/abs/10.1145/3706628.3708867).


# Sparse Tensor Framework

This repository contains the FPGA architecture files, VTR run scripts, timing constraints, and Verilog automation used to evaluate dense and sparse tensor and GEMM designs.

## Repository structure

- `arch_files/`
  Contains the FPGA architecture XML files used by VTR. These files define the target architecture for experiments, including variants for dense tensor slice, sparse tensor slice, and DSP-oriented mappings.

- `bash_scripts/`
  Contains Bash scripts that launch VTR flows for the different generated designs. These scripts are used to automate experiments such as dense GEMM, sparse GEMM, and graphics-enabled runs in VTR.

- `constraints_dir/`
  Contains the SDC timing constraints used by VTR. These constraints are set up to help maximize operating frequency during synthesis, and placement and routing.

- `automatic_generation_and_running/`
  Contains the automation flow for Verilog generation and execution. This folder includes:
  - Verilog code generator scripts for dense and sparse GEMM designs
  - Python scripts to run repeated experiments
  - Parsing scripts to collect or post-process results
  - Generated Verilog design files used as VTR inputs

## Typical workflow

1. Generate or update a Verilog design in `automatic_generation_and_running/`.
2. Select the target FPGA architecture file from `arch_files/`.
3. Apply the timing constraints from `constraints_dir/`.
4. Run the corresponding VTR automation script from `bash_scripts/`.
