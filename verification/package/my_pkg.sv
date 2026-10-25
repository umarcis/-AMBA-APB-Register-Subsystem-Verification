package my_pkg;

  import uvm_pkg::*;
  import uvm_testbench::*;   // Register_Model_Automated_Package
  `include "uvm_macros.svh"


  `include "../defines/delay_define.svh"
  `include "../sequence_item/reg_file_sequence_item.sv"
  `include "../sequence/reg_file_sequence.sv"
  `include "../adapter/reg_file_adapter.sv"
  `include "../driver/reg_file_driver.sv"
  `include "../monitor/reg_file_monitor.sv"
  `include "../agent/reg_file_agent.sv"
  `include "../scoreboard/scoreboard.sv"
  `include "../environment/reg_file_env.sv"
  `include "../test/reg_file_test.sv"
  `include "../test/force_pready_down.sv"
  

endpackage : my_pkg
