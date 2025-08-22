`include "defines.svh"
class alu_driver extends uvm_driver#(alu_sequence_item);
  virtual alu_interface vif;
  bit got_valid;

  `uvm_component_utils(alu_driver)

  uvm_analysis_port#(alu_sequence_item) dri_cov_port;

  function new(string name="alu_driver",uvm_component parent);
    super.new(name,parent);
    dri_cov_port=new("driver_port",this);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db#(virtual alu_interface)::get(this,"","vif",vif))
    `uvm_fatal("NO_VIF",{"virtual interface must be set for:",get_full_name(),".vif"});
  endfunction

    virtual task run_phase(uvm_phase phase);
      $display("driver run phase started");
      wait (vif.RST == 1'b1);   // wait for reset asserted
@(negedge vif.RST);       // wait for reset deassert
      repeat(1) @(vif.drv_cb);
      //reset_phase(phase);
        for(int i=0;i<`no_of_transactions;i++)
      begin
        seq_item_port.get_next_item(req);
        drive();
        seq_item_port.item_done();
        repeat(2) @(vif.drv_cb);
      end
    endtask



    virtual task drive();
      $display("driver task started");
       begin
   // repeat(2) @(vif.drv_cb);
    //$display("driver after enter [%0t] ",$time);

        if(req.RST == 1)
        // @(vif.drv_cb)
          begin
          vif.drv_cb.INP_VALID<=0;
          vif.drv_cb.CE<=0;
          vif.drv_cb.CIN<=0;
          vif.drv_cb.MODE<=0;
          vif.drv_cb.OPA<=0;
          vif.drv_cb.OPB<=0;
          vif.drv_cb.CMD<=0;

            // repeat(1) @(vif.drv_cb)
               `uvm_info("DRV",$sformatf("DRIVER DRIVING VALUES TO INTERFACE ,INP_VALID =%d,CMD=%d,CE=%d,CIN=%d,MODE=%d,OPA=%d,OPB=%d",req.INP_VALID,req.CMD,req.CE,req.CIN,req.MODE,req.OPA,req.OPB),UVM_NONE);

          end
        else
          begin

          got_valid = 0;
            if (req.INP_VALID != 2'b11) begin
              if(req.INP_VALID==2'b01 && req.MODE==1 && (req.CMD==4 || req.CMD==5))begin
                vif.drv_cb.INP_VALID<=req.INP_VALID;
          vif.drv_cb.CE<=req.CE;
          vif.drv_cb.CIN<=req.CIN;
          vif.drv_cb.MODE<=req.MODE;
          vif.drv_cb.OPA<=req.OPA;
          vif.drv_cb.OPB<=req.OPB;
          vif.drv_cb.CMD<=req.CMD;
             // @(vif.drv_cb)
                `uvm_info("DRV",$sformatf("DRIVER DRIVING VALUES TO INTERFACE ,INP_VALID =%d,CMD=%d,CE=%d,CIN=%d,MODE=%d,OPA=%d,OPB=%d",req.INP_VALID,req.CMD,req.CE,req.CIN,req.MODE,req.OPA,req.OPB),UVM_NONE);
              end

              if(req.INP_VALID==2'b01 && req.MODE==0 && req.CMD==6)begin
                vif.drv_cb.INP_VALID<=req.INP_VALID;
          vif.drv_cb.CE<=req.CE;
          vif.drv_cb.CIN<=req.CIN;
          vif.drv_cb.MODE<=req.MODE;
          vif.drv_cb.OPA<=req.OPA;
          vif.drv_cb.OPB<=req.OPB;
          vif.drv_cb.CMD<=req.CMD;
             // @(vif.drv_cb)
                `uvm_info("DRV",$sformatf("DRIVER DRIVING VALUES TO INTERFACE ,INP_VALID =%d,CMD=%d,CE=%d,CIN=%d,MODE=%d,OPA=%d,OPB=%d",req.INP_VALID,req.CMD,req.CE,req.CIN,req.MODE,req.OPA,req.OPB),UVM_NONE);
              end


              if(req.INP_VALID==2'b10 && req.MODE==1 && (req.CMD==6 || req.CMD==7))begin
                vif.drv_cb.INP_VALID<=req.INP_VALID;
          vif.drv_cb.CE<=req.CE;
          vif.drv_cb.CIN<=req.CIN;
          vif.drv_cb.MODE<=req.MODE;
          vif.drv_cb.OPA<=req.OPA;
          vif.drv_cb.OPB<=req.OPB;
          vif.drv_cb.CMD<=req.CMD;
             // @(vif.drv_cb)
                `uvm_info("DRV",$sformatf("DRIVER DRIVING VALUES TO INTERFACE ,INP_VALID =%d,CMD=%d,CE=%d,CIN=%d,MODE=%d,OPA=%d,OPB=%d",req.INP_VALID,req.CMD,req.CE,req.CIN,req.MODE,req.OPA,req.OPB),UVM_NONE);
              end

              if(req.INP_VALID==2'b10 && req.MODE==0 && req.CMD==7)begin
                vif.drv_cb.INP_VALID<=req.INP_VALID;
          vif.drv_cb.CE<=req.CE;
          vif.drv_cb.CIN<=req.CIN;
          vif.drv_cb.MODE<=req.MODE;
          vif.drv_cb.OPA<=req.OPA;
          vif.drv_cb.OPB<=req.OPB;
          vif.drv_cb.CMD<=req.CMD;
             // @(vif.drv_cb)
                `uvm_info("DRV",$sformatf("DRIVER DRIVING VALUES TO INTERFACE ,INP_VALID =%d,CMD=%d,CE=%d,CIN=%d,MODE=%d,OPA=%d,OPB=%d",req.INP_VALID,req.CMD,req.CE,req.CIN,req.MODE,req.OPA,req.OPB),UVM_NONE);
              end

              else begin
          req.CMD.rand_mode(0);
          req.MODE.rand_mode(0);
          req.CIN.rand_mode(0);
          req.CE.rand_mode(0);
          // req.OPA.rand_mode(0);
          // req.OPB.rand_mode(0);

        for (int j = 0; j < 16; j++) begin
          req.randomize();

          if(req.INP_VALID==2'b01 && req.MODE==0 && req.CMD==6)begin
                vif.drv_cb.INP_VALID<=req.INP_VALID;
          vif.drv_cb.CE<=req.CE;
          vif.drv_cb.CIN<=req.CIN;
          vif.drv_cb.MODE<=req.MODE;
          vif.drv_cb.OPA<=req.OPA;
          vif.drv_cb.OPB<=req.OPB;
          vif.drv_cb.CMD<=req.CMD;
             // @(vif.drv_cb)
                `uvm_info("DRV",$sformatf("DRIVER DRIVING VALUES TO INTERFACE ,INP_VALID =%d,CMD=%d,CE=%d,CIN=%d,MODE=%d,OPA=%d,OPB=%d",req.INP_VALID,req.CMD,req.CE,req.CIN,req.MODE,req.OPA,req.OPB),UVM_NONE);
            break;
              end



          else if(req.INP_VALID==2'b01 && req.MODE==1 && (req.CMD==4 || req.CMD==5))begin
                vif.drv_cb.INP_VALID<=req.INP_VALID;
          vif.drv_cb.CE<=req.CE;
          vif.drv_cb.CIN<=req.CIN;
          vif.drv_cb.MODE<=req.MODE;
          vif.drv_cb.OPA<=req.OPA;
          vif.drv_cb.OPB<=req.OPB;
          vif.drv_cb.CMD<=req.CMD;
             // @(vif.drv_cb)
                `uvm_info("DRV",$sformatf("DRIVER DRIVING VALUES TO INTERFACE ,INP_VALID =%d,CMD=%d,CE=%d,CIN=%d,MODE=%d,OPA=%d,OPB=%d",req.INP_VALID,req.CMD,req.CE,req.CIN,req.MODE,req.OPA,req.OPB),UVM_NONE);
            break;
              end


          else if(req.INP_VALID==2'b10 && req.MODE==0 && req.CMD==7)begin
                vif.drv_cb.INP_VALID<=req.INP_VALID;
          vif.drv_cb.CE<=req.CE;
          vif.drv_cb.CIN<=req.CIN;
          vif.drv_cb.MODE<=req.MODE;
          vif.drv_cb.OPA<=req.OPA;
          vif.drv_cb.OPB<=req.OPB;
          vif.drv_cb.CMD<=req.CMD;
             // @(vif.drv_cb)
                `uvm_info("DRV",$sformatf("DRIVER DRIVING VALUES TO INTERFACE ,INP_VALID =%d,CMD=%d,CE=%d,CIN=%d,MODE=%d,OPA=%d,OPB=%d",req.INP_VALID,req.CMD,req.CE,req.CIN,req.MODE,req.OPA,req.OPB),UVM_NONE);
            break;
              end

          else if(req.INP_VALID==2'b10 && req.MODE==1 && (req.CMD==7||req.CMD==6))begin
                vif.drv_cb.INP_VALID<=req.INP_VALID;
          vif.drv_cb.CE<=req.CE;
          vif.drv_cb.CIN<=req.CIN;
          vif.drv_cb.MODE<=req.MODE;
          vif.drv_cb.OPA<=req.OPA;
          vif.drv_cb.OPB<=req.OPB;
          vif.drv_cb.CMD<=req.CMD;
             // @(vif.drv_cb)
                `uvm_info("DRV",$sformatf("DRIVER DRIVING VALUES TO INTERFACE ,INP_VALID =%d,CMD=%d,CE=%d,CIN=%d,MODE=%d,OPA=%d,OPB=%d",req.INP_VALID,req.CMD,req.CE,req.CIN,req.MODE,req.OPA,req.OPB),UVM_NONE);
            break;
              end


        //repeat(2) @(vif.drv_cb);
          vif.drv_cb.INP_VALID<=req.INP_VALID;
          vif.drv_cb.CE<=req.CE;
          vif.drv_cb.CIN<=req.CIN;
          vif.drv_cb.MODE<=req.MODE;
          vif.drv_cb.OPA<=req.OPA;
          vif.drv_cb.OPB<=req.OPB;
          vif.drv_cb.CMD<=req.CMD;
             // @(vif.drv_cb)
                `uvm_info("DRV",$sformatf("DRIVER DRIVING VALUES TO INTERFACE ,INP_VALID =%d,CMD=%d,CE=%d,CIN=%d,MODE=%d,OPA=%d,OPB=%d",req.INP_VALID,req.CMD,req.CE,req.CIN,req.MODE,req.OPA,req.OPB),UVM_NONE);

          if (req.INP_VALID == 2'b11) begin
            got_valid = 1;
            req.CMD.rand_mode(1);
            req.MODE.rand_mode(1);
            req.CIN.rand_mode(1);
            req.CE.rand_mode(1);
      //    req.OPA.rand_mode(1);
        //  req.OPB.rand_mode(1);
            break;
          end
        end
      end
            end
   // end

            else  if(req.INP_VALID==2'b11 )begin
            if(req.MODE==1 &&(req.CMD==9 || req.CMD==10))begin

           vif.drv_cb.INP_VALID<=req.INP_VALID;
          vif.drv_cb.CE<=req.CE;
          vif.drv_cb.CIN<=req.CIN;
          vif.drv_cb.MODE<=req.MODE;
          vif.drv_cb.OPA<=req.OPA;
          vif.drv_cb.OPB<=req.OPB;
          vif.drv_cb.CMD<=req.CMD;
             // repeat(1) @(vif.drv_cb)
                `uvm_info("DRV",$sformatf("DRIVER DRIVING VALUES TO INTERFACE,INP_VALID =%d,CMD=%d,CE=%d,CIN=%d,MODE=%d,OPA=%d,OPB=%d",req.INP_VALID,req.CMD,req.CE,req.CIN,req.MODE,req.OPA,req.OPB),UVM_NONE);
              repeat(1) @(vif.drv_cb);
              end
              else begin
                 vif.drv_cb.INP_VALID<=req.INP_VALID;
          vif.drv_cb.CE<=req.CE;
          vif.drv_cb.CIN<=req.CIN;
          vif.drv_cb.MODE<=req.MODE;
          vif.drv_cb.OPA<=req.OPA;
          vif.drv_cb.OPB<=req.OPB;
          vif.drv_cb.CMD<=req.CMD;
             // repeat(1) @(vif.drv_cb)
                `uvm_info("DRV",$sformatf("DRIVER DRIVING VALUES TO INTERFACE,INP_VALID =%d,CMD=%d,CE=%d,CIN=%d,MODE=%d,OPA=%d,OPB=%d",req.INP_VALID,req.CMD,req.CE,req.CIN,req.MODE,req.OPA,req.OPB),UVM_NONE);
              end
              req.print();
      dri_cov_port.write(req);

      end
end

end
  endtask

endclass
