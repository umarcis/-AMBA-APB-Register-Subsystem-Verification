class reg_file_sequence_item extends uvm_sequence_item;
  `uvm_object_utils(reg_file_sequence_item)


  bit [31:0] addr    ;
  bit [31:0] data    ;
  bit        is_write;

  uvm_status_e status; 

  function new(string name = "reg_file_sequence_item");
    super.new(name);
  endfunction

endclass

