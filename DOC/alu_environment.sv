class alu_environment extends uvm_env;
  alu_agent agent;
  alu_scoreboard scoreboard;
  alu_coverage coverage;

  `uvm_component_utils(alu_environment)

  function new(string name="alu_environment",uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent=alu_agent::type_id::create("alu_agent",this);
    scoreboard=alu_scoreboard::type_id::create("alu_scoreboard",this);
    coverage=alu_coverage::type_id::create("alu_coverage",this);

  endfunction

  virtual function void connect_phase(uvm_phase phase);

    agent.monitor.mon_port.connect(scoreboard.sco_port);
    agent.monitor.mon_port.connect(coverage.cov_mon);
    agent.driver.dri_cov_port.connect(coverage.cov_dri);


      endfunction

      endclass
