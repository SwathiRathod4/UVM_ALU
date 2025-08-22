class alu_coverage extends uvm_component;
  alu_sequence_item t1;
  real mon1_cov,mon2_cov;
  `uvm_component_utils(alu_coverage)
  
  uvm_analysis_imp #(alu_sequence_item, alu_coverage) cov_mon;
  
  covergroup monitor_cov1;
    ERR      : coverpoint t1.ERR {bins err[]={0,1};}
    COUT     : coverpoint t1.COUT {bins cout[]={0,1};}
    OFLOW    : coverpoint t1.OFLOW {bins oflow[]={0,1};}
    E        : coverpoint t1.E {bins e[]={0,1};}
    G        : coverpoint t1.G {bins g[]={0,1};}
    L        : coverpoint t1.L {bins l[]={0,1};}
    RES      : coverpoint t1.RES {bins res[]={[0:(1<<(`N+1))-1]};}
    
  endgroup
  
  covergroup monitor_cov2;
     INP_VALID :coverpoint t1.INP_VALID { bins inp_valid[]={0,1,2,3};}
    CMD       :coverpoint t1.CMD { bins cmd[]={[0:13]};}
    CE        :coverpoint t1.CE {bins ce[]={0,1};}
    CIN       :coverpoint t1.CIN {bins cin[]={0,1};}
    MODE      :coverpoint t1.MODE {bins mode[]={0,1};}
    OPA       :coverpoint t1.OPA {bins opa[]={[0:(1<<`N)-1]};}
    OPB       :coverpoint t1.OPB {bins opb[]={[0:(1<<`N)-1]};}
                                                
  endgroup
  
   function new(string name="alu_coverage",uvm_component parent);
    super.new(name,parent);
    cov_mon=new("cov_mon",this);
     monitor_cov2=new;
    monitor_cov1=new;
  endfunction
  
  
   function void write(alu_sequence_item t);
    t1 = t;
    monitor_cov1.sample();
 monitor_cov2.sample();
     `uvm_info(get_type_name(),$sformatf("DATA RECEIVED FROM MONITOR IN COV,ERR=%d,OFLOW=%d,COUT=%d,E=%d,G=%d,L=%d,RES=%d",t1.ERR,t1.OFLOW,t1.COUT,t1.E,t1.G,t1.L,t1.RES),UVM_NONE);
  endfunction
  
   function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    mon1_cov = monitor_cov1.get_coverage();
     mon2_cov= monitor_cov2.get_coverage();
  endfunction

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name, $sformatf("[INPUT] Coverage ------> %0.2f%%", mon2_cov), UVM_MEDIUM);
    `uvm_info(get_type_name, $sformatf("[OUTPUT] Coverage ------> %0.2f%%", mon1_cov), UVM_MEDIUM);
  endfunction
    
endclass


