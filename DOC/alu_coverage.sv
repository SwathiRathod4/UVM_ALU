`uvm_analysis_imp_decl(_mon_cg)
`uvm_analysis_imp_decl(_drv_cg)

class alu_coverage extends uvm_component;
  alu_sequence_item t1,t2;
  real drv1_cov,mon1_cov;
  `uvm_component_utils(alu_coverage)

  uvm_analysis_imp_mon_cg #(alu_sequence_item, alu_coverage) cov_mon;
  uvm_analysis_imp_drv_cg #(alu_sequence_item, alu_coverage) cov_dri;



  covergroup driver_cov;
    INP_VALID :coverpoint t1.INP_VALID { bins inp_valid[]={0,1,2,3};}
    CMD       :coverpoint t1.CMD { bins cmd[]={[0:13]};}
    CE        :coverpoint t1.CE {bins ce[]={0,1};}
    CIN       :coverpoint t1.CIN {bins cin[]={0,1};}
    MODE      :coverpoint t1.MODE {bins mode[]={0,1};}
    OPA       :coverpoint t1.OPA {bins opa[]={[0:(1<<`N)-1]};}
    OPB       :coverpoint t1.OPB {bins opb[]={[0:(1<<`N)-1]};}
  endgroup

  covergroup monitor_cov;
    ERR      : coverpoint t2.ERR {bins err[]={0,1};}
    COUT     : coverpoint t2.COUT {bins cout[]={0,1};}
    OFLOW    : coverpoint t2.OFLOW {bins oflow[]={0,1};}
    E        : coverpoint t2.E {bins e[]={0,1};}
    G        : coverpoint t2.G {bins g[]={0,1};}
    L        : coverpoint t2.L {bins l[]={0,1};}
    RES      : coverpoint t2.RES {bins res[]={[0:(1<<(`N+1))-1]};}

  endgroup

   function new(string name="alu_coverage",uvm_component parent);
    super.new(name,parent);
    cov_mon=new("cov_mon",this);
    cov_dri=new("cov_dri",this);
    driver_cov=new;
    monitor_cov=new;
  endfunction

   function void write_drv_cg(alu_sequence_item t);
    t1 = t;
    driver_cov.sample();
     `uvm_info(get_type_name(),$sformatf("DATA RECEIVED FROM DRIVER IN COV,INP_VALID =%b,CMD=%b,CE=%b,CIN=%b,MODE=%b,OPA=%d,OPB=%d",t1.INP_VALID,t1.CMD,t1.CE,t1.CIN,t1.MODE,t1.OPA,t1.OPB),UVM_NONE);
  endfunction


   function void write_mon_cg(alu_sequence_item t);
    t2 = t;
    monitor_cov.sample();
     `uvm_info(get_type_name(),$sformatf("DATA RECEIVED FROM MONITOR IN COV,ERR=%d,OFLOW=%d,COUT=%d,E=%d,G=%d,L=%d,RES=%d",t2.ERR,t2.OFLOW,t2.COUT,t2.E,t2.G,t2.L,t2.RES),UVM_NONE);
  endfunction

   function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    drv1_cov = driver_cov.get_coverage();
    mon1_cov = monitor_cov.get_coverage();
  endfunction

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name, $sformatf("[DRIVER] Coverage ------> %0.2f%%,", drv1_cov), UVM_MEDIUM);
    `uvm_info(get_type_name, $sformatf("[MONITOR] Coverage ------> %0.2f%%", mon1_cov), UVM_MEDIUM);
  endfunction

endclass
