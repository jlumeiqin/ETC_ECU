############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 2014 Xilinx Inc. All rights reserved.
############################################################
open_project mpc_pso
set_top Compult
add_files mpc.cpp
add_files -tb mpc_test.cpp
open_solution "solution1"
set_part {xc7z010clg400-1}
create_clock -period 8 -name default
source "./mpc_pso/solution1/directives.tcl"
csim_design -clean -setup
csynth_design
cosim_design -tool xsim
export_design -format ip_catalog
