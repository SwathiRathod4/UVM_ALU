class alu_test extends uvm_test;
  alu_environment environment;

  `uvm_component_utils(alu_test)

  function new(string name="alu_test",uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    environment=alu_environment::type_id::create("alu_environment",this);
    `uvm_info(get_type_name(), $sformatf("Environment created: %0p", environment), UVM_LOW)
  endfunction


   virtual task run_phase(uvm_phase phase);
    alu_sequence seq_h;

    phase.raise_objection(this, "alu_test_running");
    `uvm_info(get_type_name(), "Raised objection and starting sequence", UVM_LOW);


    seq_h = alu_sequence::type_id::create("alu_seq_h");
    `uvm_info(get_type_name(), $sformatf("Starting sequence on sequencer: %0p", environment.agent.sequencer), UVM_LOW);


    seq_h.start(environment.agent.sequencer);

    `uvm_info(get_type_name(), "Sequence finished, dropping objection", UVM_LOW);

    #100ns;
    phase.drop_objection(this, "alu_test_running");
  endtask


  virtual function void end_of_elaboration();
    print();
  endfunction

endclass
