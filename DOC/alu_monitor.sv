class alu_monitor extends uvm_monitor;

  virtual alu_interface vif;
    alu_sequence_item q[$];

  `uvm_component_utils(alu_monitor)

  uvm_analysis_port #(alu_sequence_item) mon_port;
  alu_sequence_item seq;

  function new(string name="alu_monitor",uvm_component parent);
    super.new(name,parent);
    mon_port = new("mon_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual alu_interface)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
  endfunction

  virtual task run_phase(uvm_phase phase);
    `uvm_info("MON", $sformatf("[%0t] Entered monitor run_phase", $time), UVM_LOW);



    repeat(3) @(posedge vif.mon_cb);

    `uvm_info("MON", $sformatf("[%0t] Monitor starting after reset deassert", $time), UVM_LOW);


    for (int i = 0; i < `no_of_transactions; i++) begin
      if(vif.mon_cb.MODE==1 && (vif.mon_cb.CMD==9 || vif.mon_cb.CMD==10))begin
        seq = alu_sequence_item::type_id::create($sformatf("seq-%0d", i), this);
      seq.CMD       = vif.mon_cb.CMD;
      seq.MODE      = vif.mon_cb.MODE;
      seq.OPA       = vif.mon_cb.OPA;
      seq.OPB       = vif.mon_cb.OPB;

        repeat(2)@(posedge vif.mon_cb);
      //  seq = alu_sequence_item::type_id::create($sformatf("seq-%0d", i), this);


      seq.ERR       = vif.mon_cb.ERR;
      seq.COUT      = vif.mon_cb.COUT;
      seq.OFLOW     = vif.mon_cb.OFLOW;
      seq.E         = vif.mon_cb.E;
      seq.G         = vif.mon_cb.G;
      seq.L         = vif.mon_cb.L;
      seq.RES       = vif.mon_cb.RES;

      seq.INP_VALID = vif.mon_cb.INP_VALID;
      seq.CIN       = vif.mon_cb.CIN;
      seq.CE        = vif.mon_cb.CE;
      /*seq.CMD       = vif.mon_cb.CMD;
      seq.MODE      = vif.mon_cb.MODE;
      seq.OPA       = vif.mon_cb.OPA;
      seq.OPB       = vif.mon_cb.OPB;*/

      `uvm_info("MON", $sformatf(" MON -> SCORE, INP_VALID=%0b MODE=%0b OPA=%0d OPB=%0d RES=%d", seq.INP_VALID, seq.MODE, seq.OPA, seq.OPB,seq.RES), UVM_LOW);
      end
         else begin

      repeat(1)@(posedge vif.mon_cb);


      seq = alu_sequence_item::type_id::create($sformatf("seq-%0d", i), this);


      seq.ERR       = vif.mon_cb.ERR;
      seq.COUT      = vif.mon_cb.COUT;
      seq.OFLOW     = vif.mon_cb.OFLOW;
      seq.E         = vif.mon_cb.E;
      seq.G         = vif.mon_cb.G;
      seq.L         = vif.mon_cb.L;
      seq.RES       = vif.mon_cb.RES;

      seq.INP_VALID = vif.mon_cb.INP_VALID;
      seq.CIN       = vif.mon_cb.CIN;
      seq.CE        = vif.mon_cb.CE;
      seq.CMD       = vif.mon_cb.CMD;
      seq.MODE      = vif.mon_cb.MODE;
      seq.OPA       = vif.mon_cb.OPA;
      seq.OPB       = vif.mon_cb.OPB;

      `uvm_info("MON", $sformatf(" MON -> SCORE, INP_VALID=%0b MODE=%0b OPA=%0d OPB=%0d RES=%d", seq.INP_VALID, seq.MODE, seq.OPA, seq.OPB,seq.RES), UVM_LOW);
         end
      seq.print();

    //repeat(1)@(posedge vif.mon_cb);
      mon_port.write(seq);
        repeat(1)@(posedge vif.mon_cb);
    end
  endtask

endclass
