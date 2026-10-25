class force_pready_down extends reg_file_test;
  `uvm_component_utils(force_pready_down)

  function new(string name = "force_pready_down", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
  endtask
endclass

