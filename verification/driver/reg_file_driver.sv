class reg_file_driver extends uvm_driver #(reg_file_sequence_item);
  `uvm_component_utils(reg_file_driver)

  // Timeout parameter (number of clock cycles to wait before timeout)
  localparam   timeout_cycle   = `TIMEOUT_CYCLES;
  int unsigned timeout_counter = 0              ;


  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual apb3_intf vif;
  reg_file_sequence_item item;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(virtual apb3_intf)::get(this, "", "vif", vif))
      `uvm_fatal("DRIVER", "Virtual interface not found")
  endfunction

  virtual task run_phase(uvm_phase phase);
    // IDLE Phase - initial values at interface
    vif.PSEL <= 0;
    vif.PENABLE <= 0;
    vif.PWRITE <= 0;
    vif.PADDR <= 0;
    vif.PWDATA <= 0;

    forever begin
      @(posedge vif.PCLK);
      seq_item_port.get_next_item(item);
      drive_apb_transaction(item);
      seq_item_port.item_done();
    end
  endtask

  task drive_apb_transaction(reg_file_sequence_item item);
    // Wait for reset to be deasserted before starting the transaction
    while (vif.PRESETn) begin
      @(posedge vif.PCLK);
    end

    // Reset the timeout counter at the start of the transaction
    timeout_counter = 0;

    // Initiate the transaction according to APB Spec
    // Setup Phase will occur here
    vif.PSEL <= 1;
    vif.PADDR <= item.addr;
    vif.PWRITE <= item.is_write;
    vif.PWDATA <= item.data;
    vif.PENABLE <= 0;
    @(posedge vif.PCLK);

    // Access State - Start the transfer
    vif.PENABLE <= 1;


    while (!vif.PREADY && timeout_counter < timeout_cycle) begin
      @(posedge vif.PCLK);
      `uvm_info("Driver" , $sformatf("[Waiting for PREADY] Timeout_Counter_Value = %0d",timeout_counter),UVM_DEBUG)
      timeout_counter <= timeout_counter + 1;
    end

    // Check if timeout occurred
    if (!vif.PREADY && timeout_counter >= timeout_cycle) begin
      `uvm_error("TIMEOUT", $sformatf("APB transaction timed out after %0d cycles\n", timeout_cycle))
      vif.PSEL <= 0;
      vif.PENABLE <= 0;
      item.status = UVM_NOT_OK;  // Set the status to UVM_NOT_OK if timeout occurs
      return;
    end else begin
      item.status = UVM_IS_OK;  // Set the status to UVM_IS_OK if no timeout
    end

    // Complete the transaction
    if (item.is_write) begin
      // Write transaction complete
      vif.PSEL <= 0;
      vif.PENABLE <= 0;
    end else begin
      item.data = vif.PRDATA;
      vif.PSEL <= 0;
      vif.PENABLE <= 0;
    end
  endtask
endclass
