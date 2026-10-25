class reg_file_monitor extends uvm_monitor;
  `uvm_component_utils(reg_file_monitor)

  // Analysis port to connect to the scoreboard or predictor
  uvm_analysis_port #(reg_file_sequence_item) analysis_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    analysis_port = new("analysis_port", this);
  endfunction

  virtual apb3_intf vif;


  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db #(virtual apb3_intf)::get(this, "", "vif", vif))
      `uvm_fatal("MONITOR", "Virtual interface not found")
  endfunction


  virtual task run_phase(uvm_phase phase);
    forever begin
      // Wait for APB transaction (PSEL and PENABLE both asserted and PRESETn de-asserted)
      @(posedge vif.PCLK);
      if (vif.PSEL && vif.PENABLE && ~vif.PRESETn) begin
        // Create a sequence item to store the transaction details
        reg_file_sequence_item item;
        item = reg_file_sequence_item::type_id::create("item", this);

        // Capture the APB transaction details
        item.addr = vif.PADDR;
        item.is_write = vif.PWRITE;

        if (vif.PWRITE) begin
          // For write, wait for the PREADY signal to ensure write completion
          wait(vif.PREADY);
          item.data = vif.PWDATA;
        end else begin
          // For read, wait for the PREADY signal to capture PRDATA
          wait(vif.PREADY);
          item.data = vif.PRDATA;
        end
        `uvm_info("Monitor" , $sformatf(" addr=%0h data=%0h kind=%0h",item.addr,item.data,item.is_write),UVM_DEBUG)

        // Send the captured transaction to the analysis port
        analysis_port.write(item);
      end
    end
  endtask
endclass