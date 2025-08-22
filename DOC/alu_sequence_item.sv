`include "defines.svh"
 `include "uvm_macros.svh"
  import uvm_pkg::*;
class alu_sequence_item extends uvm_sequence_item;


  rand bit [1:0]INP_VALID;
  rand bit [`M-1:0]CMD;
  rand bit CE,CIN,MODE;
  rand bit [`N-1:0]OPA,OPB;

  bit ERR,OFLOW,COUT,E,G,L,RST;
  bit [`N:0] RES;


  function new(string name="alu_sequence_item");
    super.new(name);
  endfunction

  `uvm_object_utils_begin(alu_sequence_item)

  `uvm_field_int(INP_VALID,UVM_ALL_ON);
  `uvm_field_int(CMD,UVM_ALL_ON);
  `uvm_field_int(CE,UVM_ALL_ON);
  `uvm_field_int(CIN,UVM_ALL_ON);
  `uvm_field_int(MODE,UVM_ALL_ON);
  `uvm_field_int(OPA,UVM_ALL_ON);
  `uvm_field_int(OPB,UVM_ALL_ON);
  `uvm_field_int(ERR,UVM_ALL_ON);
  `uvm_field_int(OFLOW,UVM_ALL_ON);
  `uvm_field_int(COUT,UVM_ALL_ON);
  `uvm_field_int(E,UVM_ALL_ON);
  `uvm_field_int(G,UVM_ALL_ON);
  `uvm_field_int(L,UVM_ALL_ON);
  `uvm_field_int(RES,UVM_ALL_ON);

  `uvm_object_utils_end

  //constraint c1{if(MODE==1) CMD inside {[4:5]};
                 // else
                   // CMD inside {[0:13]};CE==1;}
  constraint c2{MODE==0;INP_VALID==1;CMD inside{7};}
endclass
