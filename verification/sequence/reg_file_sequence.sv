class reg_file_sequence extends uvm_reg_sequence;
  `uvm_object_utils(reg_file_sequence)

  function new(string name = "reg_file_sequence");
    super.new(name);
  endfunction

  uvm_testbench::expanded_regfile reg_blk;

  virtual task body();
    bit [31:0] read_data;
    uvm_status_e status;
    bit [31:0] random_data;



    $display("-----------------------------------------------------------------------------------------------------------------");
    $display("                      Sequence of Read/Write for `init_control_status` register fields");
    $display("-----------------------------------------------------------------------------------------------------------------");



    random_data = $urandom_range(0,15);
    reg_blk.init_control_status.control.write(status, random_data, UVM_BACKDOOR);
    `uvm_info(get_type_name(), $sformatf("Wrote init_control: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field control read
    reg_blk.init_control_status.control.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read init_control: %0h, status: %s\n", read_data, status.name()), UVM_NONE)


    // Field status write
    random_data = $urandom_range(0, 15);
    reg_blk.init_control_status.status.write(status,random_data);
    `uvm_info(get_type_name(), $sformatf("Wrote init_status: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field status read
    reg_blk.init_control_status.status.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read init_status: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    random_data = $urandom_range(0, 255);
    reg_blk.init_control_status.data.set(random_data);
    reg_blk.init_control_status.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote init_data: %0h, status: %s\n", random_data, status.name()), UVM_NONE)



    reg_blk.init_control_status.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read init_data: %0h, Read init_status: %0h, Read init_control: %0h,  status: %s\n", read_data[15:8],read_data[7:4],read_data[3:0], status.name()), UVM_NONE)

    reg_blk.init_control_status.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read init_data: %0h, Read init_status: %0h, Read init_control: %0h,  status: %s\n", read_data[15:8],read_data[7:4],read_data[3:0], status.name()), UVM_NONE)



    $display("-----------------------------------------------------------------------------------------------------------------");
    $display("                      Sequence of Read/Write for `mode_control_status` register fields");
    $display("-----------------------------------------------------------------------------------------------------------------");


    random_data = $urandom_range(0, 65535);
    reg_blk.mode_control_status.write(status, random_data);
    `uvm_info(get_type_name(), $sformatf("Wrote mode_control register: %0h, status: %s\n", random_data, status.name()), UVM_NONE)
    
    reg_blk.mode_control_status.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read mode_data: %0h, Read mode_status: %0h, Read mode_control: %0h,  status: %s\n", read_data[15:8],read_data[7:4],read_data[3:0], status.name()), UVM_NONE)

    reg_blk.mode_control_status.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read mode_data: %0h, Read mode_status: %0h, Read mode_control: %0h,  status: %s\n", read_data[15:8],read_data[7:4],read_data[3:0], status.name()), UVM_NONE)



    $display("-----------------------------------------------------------------------------------------------------------------");
    $display("                      Sequence of Read/Write for `interrupt_control` register fields");
    $display("-----------------------------------------------------------------------------------------------------------------");

    // Field int_enable_ctrl set and update
    random_data = $urandom_range(0, 15);
    reg_blk.interrupt_control.control.set(random_data);
    reg_blk.interrupt_control.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote int_enable_ctrl: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field int_enable_ctrl read
    reg_blk.interrupt_control.control.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read int_enable_ctrl: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field int_status set and update
    random_data = $urandom_range(0, 15);
    reg_blk.interrupt_control.status.set(random_data);
    reg_blk.interrupt_control.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote int_status: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field int_status read
    reg_blk.interrupt_control.status.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read int_status: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field int_data set and update
    random_data = 5;
    reg_blk.interrupt_control.data.set(random_data);
    reg_blk.interrupt_control.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote int_data: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field int_data read
    reg_blk.interrupt_control.data.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read int_data: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    reg_blk.interrupt_control.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read int_enable_ctrl: %0h, Read int_status: %0h, Read int_data: %0h,  status: %s\n", read_data[3:0],read_data[7:4],read_data[15:8], status.name()), UVM_NONE)


    reg_blk.interrupt_control.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read int_enable_ctrl: %0h, Read int_status: %0h, Read int_data: %0h,  status: %s\n", read_data[3:0],read_data[7:4],read_data[15:8], status.name()), UVM_NONE)

    reg_blk.interrupt_control.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read int_enable_ctrl: %0h, Read int_status: %0h, Read int_data: %0h,  status: %s\n", read_data[3:0],read_data[7:4],read_data[15:8], status.name()), UVM_NONE)

    reg_blk.interrupt_control.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read int_enable_ctrl: %0h, Read int_status: %0h, Read int_data: %0h,  status: %s\n", read_data[3:0],read_data[7:4],read_data[15:8], status.name()), UVM_NONE)


    reg_blk.interrupt_control.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read int_enable_ctrl: %0h, Read int_status: %0h, Read int_data: %0h,  status: %s\n", read_data[3:0],read_data[7:4],read_data[15:8], status.name()), UVM_NONE)

    reg_blk.interrupt_control.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read int_enable_ctrl: %0h, Read int_status: %0h, Read int_data: %0h,  status: %s\n", read_data[3:0],read_data[7:4],read_data[15:8], status.name()), UVM_NONE)

    reg_blk.interrupt_control.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read int_enable_ctrl: %0h, Read int_status: %0h, Read int_data: %0h,  status: %s\n", read_data[3:0],read_data[7:4],read_data[15:8], status.name()), UVM_NONE)

    $display("-----------------------------------------------------------------------------------------------------------------");
    $display("                      Sequence of Read/Write for `power_control_status` register fields");
    $display("-----------------------------------------------------------------------------------------------------------------");

    

    // Field power_ctrl read
    reg_blk.power_control_status.control.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read power_ctrl: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field power_ctrl set and update
    random_data = 4'hF;
    reg_blk.power_control_status.control.write(status, random_data);
    `uvm_info(get_type_name(), $sformatf("Wrote power_ctrl: %0b, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field power_ctrl read
    reg_blk.power_control_status.control.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read power_ctrl: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field power_status set and update
    random_data = 1;
    reg_blk.power_control_status.status.write(status,random_data);
    `uvm_info(get_type_name(), $sformatf("Wrote power_status: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field power_status read
    reg_blk.power_control_status.status.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read power_status: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field power_data set and update
    random_data = $urandom_range(0, 127);
    reg_blk.power_control_status.data.write(status, random_data);
    `uvm_info(get_type_name(), $sformatf("Wrote power_data: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field power_data read
    reg_blk.power_control_status.data.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read power_data: %0h, status: %s\n", read_data, status.name()), UVM_NONE)



    reg_blk.power_control_status.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read power_ctrl: %0h, Read power_status: %0h, Read power_data: %0h, Read Counter: %0h,  status: %s\n", read_data[3:0],read_data[4:4],read_data[15:9],read_data[8:5], status.name()), UVM_NONE)




    $display("-----------------------------------------------------------------------------------------------------------------");
    $display("                      Sequence of Read/Write for `reset_control_status` register fields");
    $display("-----------------------------------------------------------------------------------------------------------------");


    // Field reset_ctrl read the reset or default value
    reg_blk.reset_control_status.control.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read reset_ctrl: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field reset_ctrl write all zeroes to clear the register data 
    random_data = 0;
    reg_blk.reset_control_status.control.write(status,random_data);
    `uvm_info(get_type_name(), $sformatf("Wrote reset_ctrl: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field reset_ctrl read
    reg_blk.reset_control_status.control.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read reset_ctrl: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field reset_status set and update
    random_data = $urandom_range(0, 15);
    reg_blk.reset_control_status.status.set(random_data);
    reg_blk.reset_control_status.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote reset_status: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field reset_status read
    reg_blk.reset_control_status.status.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read reset_status: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field reset_data set and update
    random_data = $urandom_range(0, 255);
    reg_blk.reset_control_status.data.set(random_data);
    reg_blk.reset_control_status.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote reset_data: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field reset_data read
    reg_blk.reset_control_status.data.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read reset_data: %0h, status: %s\n", read_data, status.name()), UVM_NONE)


    reg_blk.reset_control_status.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read reset_ctrl: %0h, Read reset_status: %0h, Read reset_data: %0h,  status: %s\n", read_data[3:0],read_data[7:4],read_data[15:8], status.name()), UVM_NONE)



    $display("-----------------------------------------------------------------------------------------------------------------");
    $display("                      Sequence of Read/Write for `transmit_control_status` register fields");
    $display("-----------------------------------------------------------------------------------------------------------------");

    // Field tx_ctrl set and update
    random_data = $urandom_range(0, 15);
    reg_blk.transmit_control_status.control.set(random_data);
    reg_blk.transmit_control_status.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote tx_ctrl: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field tx_ctrl read
    reg_blk.transmit_control_status.control.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read tx_ctrl: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field tx_status set and update
    random_data = $urandom_range(0, 15);
    reg_blk.transmit_control_status.status.set(random_data);
    reg_blk.transmit_control_status.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote tx_status: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field tx_status read
    reg_blk.transmit_control_status.status.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read tx_status: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field tx_data set and update
    random_data = $urandom_range(0, 255);
    reg_blk.transmit_control_status.data.set(random_data);
    reg_blk.transmit_control_status.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote tx_data: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field tx_data read
    reg_blk.transmit_control_status.data.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read tx_data: %0h, status: %s\n", read_data, status.name()), UVM_NONE)



    reg_blk.transmit_control_status.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read tx_ctrl: %0h, Read tx_status: %0h, Read tx_data: %0h,  status: %s\n", read_data[3:0],read_data[7:4],read_data[15:8], status.name()), UVM_NONE)





    $display("-----------------------------------------------------------------------------------------------------------------");
    $display("                      Sequence of Read/Write for `csr_reg` register fields");
    $display("-----------------------------------------------------------------------------------------------------------------");

    // Field csr_control set and update
    random_data = $urandom_range(0, 15);
    reg_blk.csr_reg.control.set(random_data);
    reg_blk.csr_reg.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote csr_control: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field csr_control read
    reg_blk.csr_reg.control.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read csr_control: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field csr_status set and update
    random_data = $urandom_range(0, 15);
    reg_blk.csr_reg.status.set(random_data);
    reg_blk.csr_reg.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote csr_status: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field csr_status read
    reg_blk.csr_reg.status.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read csr_status: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field csr_data set and update
    random_data = $urandom_range(0, 255);
    reg_blk.csr_reg.data.set(random_data);
    reg_blk.csr_reg.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote csr_data: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field csr_data read
    reg_blk.csr_reg.data.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read csr_data: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    reg_blk.csr_reg.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read csr_control: %0h, Read csr_status: %0h, Read csr_data: %0h,  status: %s\n", read_data[3:0],read_data[7:4],read_data[15:8], status.name()), UVM_NONE)




    $display("-----------------------------------------------------------------------------------------------------------------");
    $display("                      Sequence of Read/Write for `conf_reg` register fields");
    $display("-----------------------------------------------------------------------------------------------------------------");

    // Field conf_enable set and update
    random_data = $urandom_range(0, 15);
    reg_blk.conf_reg.control.set(random_data);
    reg_blk.conf_reg.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote conf_control: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field conf_control read
    reg_blk.conf_reg.control.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read conf_control: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field conf_status set and update
    random_data = $urandom_range(0, 15);
    reg_blk.conf_reg.status.set(random_data);
    reg_blk.conf_reg.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote conf_status: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field conf_status read
    reg_blk.conf_reg.status.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read conf_status: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field conf_data set and update
    random_data = $urandom_range(0, 255);
    reg_blk.conf_reg.data.set(random_data);
    reg_blk.conf_reg.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote conf_data: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field conf_data read
    reg_blk.conf_reg.data.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read conf_data: %0h, status: %s\n", read_data, status.name()), UVM_NONE)



    reg_blk.conf_reg.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read conf_control: %0h, Read conf_status: %0h, Read conf_data: %0h,  status: %s\n", read_data[3:0],read_data[7:4],read_data[15:8], status.name()), UVM_NONE)


    $display("-----------------------------------------------------------------------------------------------------------------");
    $display("                      Sequence of Read/Write for `sys_stat_reg` register fields");
    $display("-----------------------------------------------------------------------------------------------------------------");

    // Field sys_stat_status set and update
    random_data = $urandom_range(0, 15);
    reg_blk.sys_stat_reg.control.set(random_data);
    reg_blk.sys_stat_reg.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote sys_stat_control: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field sys_stat_control read
    reg_blk.sys_stat_reg.control.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read sys_stat_control: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field sys_stat_status set and update
    random_data = $urandom_range(0, 15);
    reg_blk.sys_stat_reg.status.set(random_data);
    reg_blk.sys_stat_reg.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote sys_stat_status: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field sys_stat_status read
    reg_blk.sys_stat_reg.status.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read sys_stat_status: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field sys_stat_data set and update
    random_data = $urandom_range(0, 255);
    reg_blk.sys_stat_reg.data.set(random_data);
    reg_blk.sys_stat_reg.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote sys_stat_data: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field sys_stat_data read
    reg_blk.sys_stat_reg.data.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read sys_stat_data: %0h, status: %s\n", read_data, status.name()), UVM_NONE)



    reg_blk.sys_stat_reg.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read sys_stat_control: %0h, Read sys_stat_status: %0h, Read sys_stat_data: %0h,  status: %s\n", read_data[3:0],read_data[7:4],read_data[15:8], status.name()), UVM_NONE)




    $display("-----------------------------------------------------------------------------------------------------------------");
    $display("                      Sequence of Read/Write for `int_reg` register fields");
    $display("-----------------------------------------------------------------------------------------------------------------");

    // Field int_mode set and update
    random_data = $urandom_range(0, 15);
    reg_blk.int_reg.control.set(random_data);
    reg_blk.int_reg.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote int_control: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field int_control read
    reg_blk.int_reg.control.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read int_control: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field int_status set and update
    random_data = $urandom_range(0, 15);
    reg_blk.int_reg.status.set(random_data);
    reg_blk.int_reg.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote int_status: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field int_status read
    reg_blk.int_reg.status.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read int_status: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field int_data set and update
    random_data = $urandom_range(0, 255);
    reg_blk.int_reg.data.set(random_data);
    reg_blk.int_reg.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote int_data: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field int_data read
    reg_blk.int_reg.data.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read int_data: %0h, status: %s\n", read_data, status.name()), UVM_NONE)


    reg_blk.int_reg.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read int_control: %0h, Read int_status: %0h, Read int_data: %0h,  status: %s\n", read_data[3:0],read_data[7:4],read_data[15:8], status.name()), UVM_NONE)



    $display("-----------------------------------------------------------------------------------------------------------------");
    $display("                      Sequence of Read/Write for `cntrl_reg` register fields");
    $display("-----------------------------------------------------------------------------------------------------------------");

    // Field cntrl_control set and update
    random_data = $urandom_range(0, 15);
    reg_blk.cntrl_reg.control.set(random_data);
    reg_blk.cntrl_reg.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote cntrl_control: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field cntrl_control read
    reg_blk.cntrl_reg.control.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read cntrl_control: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field cntrl_status set and update
    random_data = $urandom_range(0, 15);
    reg_blk.cntrl_reg.status.set(random_data);
    reg_blk.cntrl_reg.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote cntrl_status: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field cntrl_status read
    reg_blk.cntrl_reg.status.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read cntrl_status: %0h, status: %s\n", read_data, status.name()), UVM_NONE)


    // Field cntrl_data set and update
    random_data = $urandom_range(0, 255);
    reg_blk.cntrl_reg.data.set(random_data);
    reg_blk.cntrl_reg.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote cntrl_data: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field cntrl_data read
    reg_blk.cntrl_reg.data.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read cntrl_data: %0h, status: %s\n", read_data, status.name()), UVM_NONE)


    reg_blk.cntrl_reg.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read cntrl_control: %0h, Read cntrl_status: %0h, Read cntrl_data: %0h,  status: %s\n", read_data[3:0],read_data[7:4],read_data[15:8], status.name()), UVM_NONE)



    $display("-----------------------------------------------------------------------------------------------------------------");
    $display("                      Sequence of Read/Write for `perf_reg` register fields");
    $display("-----------------------------------------------------------------------------------------------------------------");

    // Field perf_control set and update
    random_data = $urandom_range(0, 15);
    reg_blk.perf_reg.control.set(random_data);
    reg_blk.perf_reg.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote perf_control: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field perf_control read
    reg_blk.perf_reg.control.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read perf_control: %0h, status: %s\n", read_data, status.name()), UVM_NONE)


    // Field perf_status set and update
    random_data = $urandom_range(0, 15);
    reg_blk.perf_reg.status.set(random_data);
    reg_blk.perf_reg.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote perf_status: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field perf_status read
    reg_blk.perf_reg.status.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read perf_status: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field perf_data set and update
    random_data = $urandom_range(0, 255);
    reg_blk.perf_reg.data.set(random_data);
    reg_blk.perf_reg.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote perf_data: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field perf_data read
    reg_blk.perf_reg.data.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read perf_data: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    reg_blk.perf_reg.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read perf_control: %0h, Read perf_status: %0h, Read perf_data: %0h, status: %s\n", read_data[3:0], read_data[7:4], read_data[15:8], status.name()), UVM_NONE)



    $display("-----------------------------------------------------------------------------------------------------------------");
    $display("                      Sequence of Read/Write for `pm_reg` register fields");
    $display("-----------------------------------------------------------------------------------------------------------------");

    // Field pm_control set and update
    random_data = $urandom_range(0, 15);
    reg_blk.pm_reg.control.set(random_data);
    reg_blk.pm_reg.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote pm_control: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field pm_control read
    reg_blk.pm_reg.control.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read pm_control: %0h, status: %s\n", read_data, status.name()), UVM_NONE)


    // Field perf_status set and update
    random_data = $urandom_range(0, 15);
    reg_blk.pm_reg.status.set(random_data);
    reg_blk.pm_reg.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote pm_status: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field pm_status read
    reg_blk.pm_reg.status.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read pm_status: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field pm_data set and update
    random_data = $urandom_range(0, 255);
    reg_blk.pm_reg.data.set(random_data);
    reg_blk.pm_reg.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote pm_data: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field pm_data read
    reg_blk.pm_reg.data.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read pm_data: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    reg_blk.pm_reg.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read pm_control: %0h, Read pm_status: %0h, Read pm_data: %0h, status: %s\n", read_data[3:0], read_data[7:4], read_data[15:8], status.name()), UVM_NONE)



    $display("-----------------------------------------------------------------------------------------------------------------");
    $display("                      Sequence of Read/Write for `dbg_reg` register fields");
    $display("-----------------------------------------------------------------------------------------------------------------");

    // Field dbg_control set and update
    random_data = $urandom_range(0, 15);
    reg_blk.dbg_reg.control.set(random_data);
    reg_blk.dbg_reg.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote dbg_control: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field dbg_control read
    reg_blk.dbg_reg.control.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read dbg_control: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field dbg_status read
    reg_blk.dbg_reg.status.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read dbg_status: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field dbg_data set and update
    random_data = $urandom_range(0, 255);
    reg_blk.dbg_reg.data.set(random_data);
    reg_blk.dbg_reg.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote dbg_data: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field dbg_data read
    reg_blk.dbg_reg.data.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read dbg_data: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    reg_blk.dbg_reg.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read dbg_control: %0h, Read dbg_status: %0h, Read dbg_data: %0h, status: %s\n", read_data[3:0], read_data[7:4], read_data[15:8], status.name()), UVM_NONE)




    $display("-----------------------------------------------------------------------------------------------------------------");
    $display("                      Sequence of Read/Write for `err_reg` register fields");
    $display("-----------------------------------------------------------------------------------------------------------------");

    // Field err_control set and update
    random_data = $urandom_range(0, 15);
    reg_blk.err_reg.control.set(random_data);
    reg_blk.err_reg.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote err_control: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field err_control read
    reg_blk.err_reg.control.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read err_control: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field err_status read
    reg_blk.err_reg.status.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read err_status: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field err_data set and update
    random_data = $urandom_range(0, 255);
    reg_blk.err_reg.data.set(random_data);
    reg_blk.err_reg.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote err_data: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field err_data read
    reg_blk.err_reg.data.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read err_data: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    reg_blk.err_reg.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read err_control: %0h, Read err_status: %0h, Read err_data: %0h, status: %s\n", read_data[3:0], read_data[7:4], read_data[15:8], status.name()), UVM_NONE)


    $display("-----------------------------------------------------------------------------------------------------------------");
    $display("                      Sequence of Read/Write for `fifostatus` register fields");
    $display("-----------------------------------------------------------------------------------------------------------------");


    // Field empty_flag read
    reg_blk.fifostatus.empty.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read empty_flag: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field full_flag read
    reg_blk.fifostatus.full.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read full_flag: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field valid_data_flag read
    reg_blk.fifostatus.valid_data.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read valid_data_flag: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field fifo_data set and update
    random_data = $urandom_range(0, 8191); // Setting a random 13-bit value for fifo_data
    reg_blk.fifostatus.data.set(random_data);
    reg_blk.fifostatus.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote fifo_data: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field fifo_data read
    reg_blk.fifostatus.data.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read fifo_data: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Field reserved set and update
    random_data = $urandom_range(0, 65535); // Setting a random 16-bit value for reserved
    reg_blk.fifostatus.reserved.set(random_data);
    reg_blk.fifostatus.update(status);
    `uvm_info(get_type_name(), $sformatf("Wrote reserved: %0h, status: %s\n", random_data, status.name()), UVM_NONE)

    // Field reserved read
    reg_blk.fifostatus.reserved.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read reserved: %0h, status: %s\n", read_data, status.name()), UVM_NONE)

    // Reading all fields of fifostatus register in one go
    reg_blk.fifostatus.read(status, read_data);
    `uvm_info(get_type_name(), $sformatf("Read empty_flag: %0h, Read full_flag: %0h, Read valid_data_flag: %0h, Read fifo_data: %0h, Read reserved: %0h, status: %s\n",
        read_data[0], read_data[1], read_data[2], read_data[15:3], read_data[31:16], status.name()), UVM_NONE)


  endtask
endclass
