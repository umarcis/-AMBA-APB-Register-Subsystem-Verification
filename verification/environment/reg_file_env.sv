class reg_file_env extends uvm_env;
  `uvm_component_utils(reg_file_env)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  reg_file_agent m_agent     ;
  scoreboard     m_scoreboard;
  uvm_reg_predictor #(reg_file_sequence_item) m_predictor; // Use default UVM predictor
  reg_file_adapter m_adapter;
  virtual apb3_intf vif;
  uvm_testbench::expanded_regfile reg_blk; // Reference to the register model


  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create instances of the components
    m_agent = reg_file_agent::type_id::create("m_agent", this);
    m_scoreboard = scoreboard::type_id::create("m_scoreboard", this);
    m_predictor = uvm_reg_predictor#(reg_file_sequence_item)::type_id::create("m_predictor", this);
    m_adapter = reg_file_adapter::type_id::create("m_adapter", this);
    reg_blk = uvm_testbench::expanded_regfile::type_id::create("reg_blk", this);

    // Retrieve the virtual interface from the configuration database
    if (!uvm_config_db #(virtual apb3_intf)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual interface not found")



    reg_blk.build();
    reg_blk.lock_model();
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);


    // Instantiate and configure the register block
    reg_blk.default_map.set_sequencer(m_agent.m_sequencer, m_adapter); // Set the sequencer and adapter for the register block

    // Connect the monitor analysis port to the predictor input port which is pre-defined
    m_agent.m_monitor.analysis_port.connect(m_predictor.bus_in);

    // Connect the monitor's analysis port to the scoreboard's analysis export
    m_agent.m_monitor.analysis_port.connect(m_scoreboard.imp);

    // Predictor has been mapped to register model address map
    m_predictor.map = reg_blk.default_map;

    // the adapter in default predictor will get our custom adapter
    m_predictor.adapter   = m_adapter;

    m_scoreboard.reg_blk = reg_blk;

  endfunction
endclass
