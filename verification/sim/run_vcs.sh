#!/usr/bin/env bash
set -euo pipefail

# Compile and elaborate.
vcs -full64 \
    -sverilog \
    -ntb_opts uvm-1.2 \
    -debug_access+all \
    -kdb \
    -f file_list.f \
    -top tb_top \
    -o simv \
    -l compile.log

# Run the UVM test.
./simv \
    +UVM_TESTNAME=reg_file_test \
    +UVM_VERBOSITY=UVM_NONE \
    -l simulation.log