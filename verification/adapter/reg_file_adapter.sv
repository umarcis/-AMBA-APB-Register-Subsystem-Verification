class reg_file_adapter extends uvm_reg_adapter;
  `uvm_object_utils(reg_file_adapter)  // Use uvm_object_utils for uvm_reg_adapter


  function new(string name = "reg_file_adapter");
    super.new(name);
  endfunction

  // Convert register operation to bus transaction
  virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
    reg_file_sequence_item item;
    item = reg_file_sequence_item::type_id::create("item");
    item.addr = rw.addr;
    item.data = rw.data;
    item.is_write = (rw.kind == UVM_WRITE);
    `uvm_info("Adapter" , $sformatf("reg2bus addr=%0h data=%0h kind=%s \n",item.addr,item.data,rw.kind.name),UVM_DEBUG)
    return item;
  endfunction

  // Convert bus transaction to register operation
  virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
    reg_file_sequence_item item;
    if (!$cast(item, bus_item))
      `uvm_fatal("CAST", "Cannot cast bus_item to reg_file_sequence_item");
    rw.addr = item.addr;
    rw.data = item.data;
    rw.kind = item.is_write ? UVM_WRITE : UVM_READ;
    rw.status = item.status;
    `uvm_info("Adapter" , $sformatf("bus2reg addr=%0h data=%0h kind=%s status=%s",item.addr,item.data,rw.kind.name(),rw.status.name()),UVM_DEBUG)
  endfunction

endclass



