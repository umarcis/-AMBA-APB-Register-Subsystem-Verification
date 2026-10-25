class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  uvm_testbench::expanded_regfile reg_blk;  // Reference to the register block

  // Analysis port for APB transactions
  uvm_analysis_imp #(reg_file_sequence_item, scoreboard) imp;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    imp = new("imp", this);
    reg_blk = uvm_testbench::expanded_regfile::type_id::create("reg_blk", this);
  endfunction


  virtual function void write(reg_file_sequence_item txn);
    uvm_reg_data_t expected_data;
    uvm_reg_data_t actual_data;
    uvm_status_e status;

    case (txn.addr)
      'h0: begin
        if (~txn.is_write) begin
          // Read transaction: Verify that the data read from the register matches expected data
          expected_data = reg_blk.init_control_status.get_mirrored_value();
          if ((txn.data[3:0] == expected_data[3:0] && (txn.data[15:8] == expected_data[15:8]))) begin
            `uvm_info("REGISTER_READ_MATCH", $sformatf("[MATCH] Address: %0h, Expected Data Field [Control]: %0h, Read Data Field [Control]: %0h ,Expected Data Field [Data]: %0h, Read Data Field [Data]: %0h \n", 
              txn.addr, expected_data[3:0],txn.data[3:0],expected_data[15:8],  txn.data[15:8]), UVM_DEBUG)
          end else begin
            `uvm_error("REGISTER_READ_MISMATCH", $sformatf("[MISMATCH] Address: %0h, Expected Data Field [Control]: %0h, Read Data Field [Control]: %0h ,Expected Data Field [Data]: %0h, Read Data Field [Data]: %0h \n",
             txn.addr, expected_data[3:0],txn.data[3:0],expected_data[15:8],  txn.data[15:8]))
          end
        end
      end
      'h4: begin
        if (~txn.is_write) begin
          // Read fields and compare from register "mode_control_status"
          expected_data = reg_blk.mode_control_status.get_mirrored_value();
          if (txn.data[3:0] == expected_data[3:0]) begin  // status and data field would be zero because access type is (hw  = w)
            `uvm_info("REGISTER_READ_MATCH", $sformatf("[MATCH] Address: %0h, Expected Data Field [Control]: %0h, Read Data Field [Control]: %0h ,Expected Data Field [Data]: %0h, Read Data Field [Data]: %0h \n", 
              txn.addr, expected_data[3:0],txn.data[3:0],expected_data[15:8],  txn.data[15:8]), UVM_DEBUG)
          end else begin
            // `uvm_error("REGISTER_READ_MISMATCH", $sformatf("[MISMATCH] Address: %0h, Expected Data Field [Control]: %0h, Read Data Field [Control]: %0h ,Expected Data Field [Data]: %0h, Read Data Field [Data]: %0h \n",
             // txn.addr, expected_data[3:0],txn.data[3:0],expected_data[15:8],  txn.data[15:8]))
          end
        end
      end
      'h8: begin
        if (~txn.is_write) begin
          // Read fields and compare from register "interrupt_control"
          expected_data = reg_blk.interrupt_control.get_mirrored_value();
          if (txn.data[3:0] == expected_data[3:0]) begin  // status and data field would be zero because access type is (hw  = w)
            `uvm_info("REGISTER_READ_MATCH", $sformatf("[MATCH] Address: %0h, Expected Data Field [Control]: %0h, Read Data Field [Control]: %0h ,Expected Data Field [Data]: %0h, Read Data Field [Data]: %0h \n", 
              txn.addr, expected_data[3:0],txn.data[3:0],expected_data[15:8],  txn.data[15:8]), UVM_DEBUG)
          end else begin
            `uvm_error("REGISTER_READ_MISMATCH", $sformatf("[MISMATCH] Address: %0h, Expected Data Field [Control]: %0h, Read Data Field [Control]: %0h ,Expected Data Field [Data]: %0h, Read Data Field [Data]: %0h \n",
             txn.addr, expected_data[3:0],txn.data[3:0],expected_data[15:8],  txn.data[15:8]))
          end
        end
      end
      'hC: begin
        if (~txn.is_write) begin
          // Read fields and compare from register "power_control_status"
          expected_data = reg_blk.power_control_status.control.get_mirrored_value();
          if (txn.data[3:0] == expected_data[3:0]) begin  // status and data field would be zero because access type is (hw  = w)
            `uvm_info("REGISTER_READ_MATCH", $sformatf("[MATCH] Address: %0h, Expected Data Field [Control]: %0h, Read Data Field [Control]: %0h ,Expected Data Field [Data]: %0h, Read Data Field [Data]: %0h \n", 
              txn.addr, expected_data[3:0],txn.data[3:0],expected_data[15:8],  txn.data[15:8]), UVM_DEBUG)
          end else begin
            `uvm_error("REGISTER_READ_MISMATCH", $sformatf("[MISMATCH] Address: %0h, Expected Data Field [Control]: %0h, Read Data Field [Control]: %0h ,Expected Data Field [Data]: %0h, Read Data Field [Data]: %0h \n",
             txn.addr, expected_data[3:0],txn.data[3:0],expected_data[15:8],  txn.data[15:8]))
          end
        end
      end
      default: begin
        //`uvm_error("REGISTER_ADDRESS_ERROR", $sformatf("Address: %0h is not recognized \n", txn.addr))
      end
    endcase
  endfunction
endclass
