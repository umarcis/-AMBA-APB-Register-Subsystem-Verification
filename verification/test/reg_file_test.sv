class reg_file_test extends uvm_test;
  `uvm_component_utils(reg_file_test)

  function new(string name = "reg_file_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  reg_file_env      m_env     ;
  reg_file_sequence m_sequence;


  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Instantiate the environment
    m_env = reg_file_env::type_id::create("m_env", this);
    m_sequence = reg_file_sequence::type_id::create("m_sequence", this);

  endfunction

  virtual task run_phase(uvm_phase phase);

    // Set the register block reference in the sequence
    m_sequence.reg_blk = m_env.reg_blk;  // Assuming reg_blk is part of the environment

    phase.raise_objection(this);

    // Start the sequence on the sequencer
    m_sequence.start(null);

    phase.drop_objection(this);  // Drop objection after tasks are done

  endtask
endclass



