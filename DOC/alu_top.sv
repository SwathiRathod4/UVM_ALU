`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "alu_pkg.sv"
`include "alu_interface.sv"
`include "design.sv"
module top;
  import uvm_pkg::*;
  import alu_pkg::*;

  bit CLK,RST;

  parameter int N = 8;
parameter int M = 4;

  always  #10 CLK=~CLK;

  initial begin
   @(posedge CLK)
    RST=1;
     repeat(1) @(posedge CLK)
      RST=0;

  end

  alu_interface intf(CLK,RST);

   ALU_DESIGN  #(  .DW(N) , .CW(M) ) dut1(.INP_VALID(intf.INP_VALID),.OPA(intf.OPA),.OPB(intf.OPB),.CIN(intf.CIN),.CLK(intf.CLK),.RST(intf.RST),.CMD(intf.CMD),.CE(intf.CE),.MODE(intf.MODE),.COUT(intf.COUT),.OFLOW(intf.OFLOW),.RES(intf.RES),.G(intf.G),.E(intf.E),.L(intf.L),.ERR(intf.ERR));


  initial begin
   // uvm_config_db#(virtual alu_interface)::set(uvm_root::get(),"*","vif",intf);
    $dumpfile("dump.vcd");
    $dumpvars;
  end

  initial begin
     uvm_config_db#(virtual alu_interface)::set(uvm_root::get(),"*","vif",intf);
    run_test("alu_test");
    #1000 $finish;
  end
endmodule
