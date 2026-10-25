class reg_file_agent extends uvm_agent;
  `uvm_component_utils(reg_file_agent)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  reg_file_driver  m_driver ;
  reg_file_monitor m_monitor;
  uvm_sequencer#(reg_file_sequence_item) m_sequencer;


  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_driver = reg_file_driver::type_id::create("m_driver", this);
    m_monitor = reg_file_monitor::type_id::create("m_monitor", this);
    m_sequencer = uvm_sequencer#(reg_file_sequence_item)::type_id::create("m_sequencer", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
  endfunction
endclass



