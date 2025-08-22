`include "defines.svh"
class alu_scoreboard extends uvm_scoreboard;

  alu_sequence_item p[$];

 // bit [7:0] smem[4];

  `uvm_component_utils(alu_scoreboard)

  uvm_analysis_imp #(alu_sequence_item, alu_scoreboard) sco_port;

  function new (string name="alu_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sco_port = new("sco_port", this);
    $display("sco_port built");
  endfunction

  virtual function void write(alu_sequence_item packet_1);
    $display("Scoreboard received :: Packet");
    p.push_back(packet_1);
  endfunction

  virtual task run_phase(uvm_phase phase);
  alu_sequence_item p1;
    forever
      begin
      wait(p.size()>0)
      if(p.size()>0)
        begin
          p1=p.pop_front();
          $display("I CAME HERE");
          if(p1.INP_VALID == 2'b11 && p1.MODE==1)
            begin

              if(p1.CMD==0)begin
                if(p1.OPA+p1.OPB==p1.RES)begin
                  `uvm_info(get_type_name(),$sformatf("ADD PASS WITH OPA=%d,OPB=%d,RES=%d",p1.OPA,p1.OPB,p1.RES),UVM_LOW);end
              else begin
                `uvm_info(get_type_name(),$sformatf("ADD FAIL WITH OPA=%d,OPB=%d,RES=%d",p1.OPA,p1.OPB,p1.RES),UVM_LOW);end
              end


              if(p1.CMD==1)begin
                int OFLOW;
                OFLOW=(p1.OPA < p1.OPB) ? 1 : 0;
                if(p1.OPA-p1.OPB==p1.RES  && OFLOW==p1.OFLOW)begin
                  `uvm_info(get_type_name(),$sformatf("SUB PASS WITH OPA=%d,OPB=%d,RES=%d,OFLOW=%d",p1.OPA,p1.OPB,p1.RES,p1.OFLOW),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("SUB FAIL WITH OPA=%d,OPB=%d,RES=%d,OFLOW=%d",p1.OPA,p1.OPB,p1.RES,p1.OFLOW),UVM_LOW);end
              end

              if(p1.CMD==2)begin
                int COUT;
                COUT=p1.RES[`N]?1:0;
                if(p1.OPA+p1.OPB+p1.CIN==p1.RES && COUT==p1.COUT)begin
                  `uvm_info(get_type_name(),$sformatf("ADD_CIN PASS WITH OPA=%d,OPB=%d,RES=%d,CIN=%d,COUT=%d",p1.OPA,p1.OPB,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("ADD_CIN FAIL WITH OPA=%d,OPB=%d,RES=%d,CIN=%d,COUT=%d",p1.OPA,p1.OPB,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
              end

              if(p1.CMD==3)begin
                 int OFLOW;
                OFLOW=(p1.OPA < p1.OPB) ? 1 : 0;
                if(p1.OPA-p1.OPB-p1.CIN==p1.RES && OFLOW==p1.OFLOW)begin
                  `uvm_info(get_type_name(),$sformatf("SUB_CIN PASS WITH OPA=%d,OPB=%d,RES=%d,CIN=%d,COUT=%d",p1.OPA,p1.OPB,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("SUB_CIN FAIL WITH OPA=%d,OPB=%d,RES=%d,CIN=%d,COUT=%d",p1.OPA,p1.OPB,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
              end

              if(p1.CMD==4)begin
                if(p1.OPA+1==p1.RES)begin
                  `uvm_info(get_type_name(),$sformatf("INC_A PASS WITH OPA=%d,OPB=%d,RES=%d,CIN=%d,COUT=%d",p1.OPA,p1.OPB,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("INC_A FAIL WITH OPA=%d,OPB=%d,RES=%d,CIN=%d,COUT=%d",p1.OPA,p1.OPB,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
              end

              if(p1.CMD==5)begin
                if(p1.OPA-1==p1.RES)begin
                  `uvm_info(get_type_name(),$sformatf("DEC_A PASS WITH OPA=%d,OPB=%d,RES=%d,CIN=%d,COUT=%d",p1.OPA,p1.OPB,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("DEC_A FAIL WITH OPA=%d,OPB=%d,RES=%d,CIN=%d,COUT=%d",p1.OPA,p1.OPB,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
              end

              if(p1.CMD==6)begin
                if(p1.OPB+1==p1.RES)begin
                  `uvm_info(get_type_name(),$sformatf("INC_B PASS WITH OPA=%d,OPB=%d,RES=%d,CIN=%d,COUT=%d",p1.OPA,p1.OPB,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("INC_B FAIL WITH OPA=%d,OPB=%d,RES=%d,CIN=%d,COUT=%d",p1.OPA,p1.OPB,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
              end

              if(p1.CMD==7)begin
                if(p1.OPB-1==p1.RES)begin
                  `uvm_info(get_type_name(),$sformatf("DEC_B PASS WITH OPA=%d,OPB=%d,RES=%d,CIN=%d,COUT=%d",p1.OPA,p1.OPB,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("DEC_B FAIL WITH OPA=%d,OPB=%d,RES=%d,CIN=%d,COUT=%d",p1.OPA,p1.OPB,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
              end

              if(p1.CMD==8)begin
                int E,G,L;
                E=(p1.OPA==p1.OPB)?1:0;
                G=(p1.OPA>p1.OPB)?1:0;
                L=(p1.OPA<p1.OPB)?1:0;
                if(p1.OPA==p1.OPB)begin
                  if( E==p1.E)begin
                  `uvm_info(get_type_name(),$sformatf("CMP_E PASS WITH OPA=%d,OPB=%d,RES=%d,CIN=%d,COUT=%d",p1.OPA,p1.OPB,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("CMP_E FAIL WITH OPA=%d,OPB=%d,RES=%d,CIN=%d,COUT=%d",p1.OPA,p1.OPB,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                end

                else if(p1.OPA>p1.OPB)begin
                  if(G==p1.G)begin
                  `uvm_info(get_type_name(),$sformatf("CMP_G PASS WITH OPA=%d,OPB=%d,RES=%d,CIN=%d,COUT=%d",p1.OPA,p1.OPB,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("CMP_G FAIL WITH OPA=%d,OPB=%d,RES=%d,CIN=%d,COUT=%d",p1.OPA,p1.OPB,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                end

                else if(p1.OPA<p1.OPB)begin
                  if( L==p1.L)begin
                  `uvm_info(get_type_name(),$sformatf("CMP_L PASS WITH OPA=%d,OPB=%d,RES=%d,CIN=%d,COUT=%d",p1.OPA,p1.OPB,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("CMP_L FAIL WITH OPA=%d,OPB=%d,RES=%d,CIN=%d,COUT=%d",p1.OPA,p1.OPB,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                end

              end

              if(p1.CMD==9)begin
                if((((p1.OPA+1)*(p1.OPB+1))& 9'h1FF)==p1.RES)begin
                  `uvm_info(get_type_name(),$sformatf("INC_MUL PASS WITH OPA=%d,OPB=%d,RES=%d,CIN=%d,COUT=%d",p1.OPA,p1.OPB,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("INC_MUL FAIL WITH OPA=%d,OPB=%d,RES=%d,CIN=%d,COUT=%d",p1.OPA,p1.OPB,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                end

              if(p1.CMD==10)begin
                if((((p1.OPA<<1)*(p1.OPB))& 9'h1FF)==p1.RES)begin
                  `uvm_info(get_type_name(),$sformatf("SHI_MUL PASS WITH OPA=%d,OPB=%d,RES=%d,CIN=%d,COUT=%d",p1.OPA,p1.OPB,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("SHI_MUL FAIL WITH OPA=%d,OPB=%d,RES=%d,CIN=%d,COUT=%d",p1.OPA,p1.OPB,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                end

            end

              else if(p1.INP_VALID == 2'b11 && p1.MODE==0) begin

                if(p1.CMD==0)begin
                  if((p1.OPA & p1.OPB)==p1.RES )begin
                      `uvm_info(get_type_name(),$sformatf("AND PASS WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("AND FAIL WITH OPA=%d,OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
              end

                if(p1.CMD==1)begin
                if({1'b0, ~(p1.OPA & p1.OPB)} == p1.RES)begin
                    `uvm_info(get_type_name(),$sformatf("NAND PASS WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("NAND FAIL WITH OPA=%d,OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
              end

                if(p1.CMD==2)begin
                  if((p1.OPA | p1.OPB)==p1.RES )begin
                    `uvm_info(get_type_name(),$sformatf("OR PASS WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("OR FAIL WITH OPA=%d,OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
              end

                if(p1.CMD==3)begin
                  if({1'b0, ~(p1.OPA | p1.OPB)} == p1.RES)begin
                    `uvm_info(get_type_name(),$sformatf("NOR PASS WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("NOR FAIL WITH OPA=%d,OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
              end

                if(p1.CMD==4)begin
                  if((p1.OPA ^ p1.OPB)==p1.RES )begin
                    `uvm_info(get_type_name(),$sformatf("XOR PASS WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("XOR FAIL WITH OPA=%d,OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
              end

                if(p1.CMD==5)begin
                  if({1'b0, ~(p1.OPA ^ p1.OPB)} == p1.RES)begin
                    `uvm_info(get_type_name(),$sformatf("XNOR PASS WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("XNOR FAIL WITH OPA=%d,OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
              end

                if(p1.CMD==6)begin
                  if({1'b0,(~p1.OPA)} ==p1.RES )begin
                    `uvm_info(get_type_name(),$sformatf("NOT_A PASS WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("NOT_A FAIL WITH OPA=%d,OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
              end

                if(p1.CMD==7)begin
                  if({1'b0,(~p1.OPB)} ==p1.RES )begin
                    `uvm_info(get_type_name(),$sformatf("NOT_B PASS WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("NOT_B FAIL WITH OPA=%d,OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
              end


                if(p1.CMD==8)begin
                  if((p1.OPA>>1) ==p1.RES )begin
                    `uvm_info(get_type_name(),$sformatf("SHRA PASS WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("SHRA FAIL WITH OPA=%d,OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
              end


                if(p1.CMD==9)begin
                  if((p1.OPA<<1) ==p1.RES )begin
                    `uvm_info(get_type_name(),$sformatf("SHLA PASS WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("SHLA FAIL WITH OPA=%d,OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
              end

                if(p1.CMD==10)begin
                  if((p1.OPB>>1) ==p1.RES )begin
                    `uvm_info(get_type_name(),$sformatf("SHRB PASS WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("SHRB FAIL WITH OPA=%d,OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
              end

                if(p1.CMD==11)begin
                  if((p1.OPB<<1) ==p1.RES )begin
                    `uvm_info(get_type_name(),$sformatf("SHLB PASS WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("SHLB FAIL WITH OPA=%d,OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT),UVM_LOW);end
              end


            end

          else if(p1.INP_VALID==2'b01 && p1.CMD==4 && p1.MODE==1)begin
            int ERR;
            if((p1.OPA+1)==p1.RES)begin
              `uvm_info(get_type_name(),$sformatf("INC_A PASS WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d,INP_VALID=%d,ERR=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT,p1.INP_VALID,p1.ERR),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("INC_A FAIL WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d,INP_VALID=%d,ERR=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT,p1.INP_VALID,p1.ERR),UVM_LOW);end
          end


          else if(p1.INP_VALID==2'b01 && p1.CMD==5 && p1.MODE==1)begin
            int ERR;
            if((p1.OPA-1)==p1.RES)begin
              `uvm_info(get_type_name(),$sformatf("DEC_A PASS WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d,INP_VALID=%d,ERR=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT,p1.INP_VALID,p1.ERR),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("DEC_A FAIL WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d,INP_VALID=%d,ERR=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT,p1.INP_VALID,p1.ERR),UVM_LOW);end

          end


          else if(p1.INP_VALID==2'b10 && p1.CMD==6 && p1.MODE==1)begin
            int ERR;
            if((p1.OPB+1)==p1.RES)begin
              `uvm_info(get_type_name(),$sformatf("INC_B PASS WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d,INP_VALID=%d,ERR=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT,p1.INP_VALID,p1.ERR),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("INC_B FAIL WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d,INP_VALID=%d,ERR=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT,p1.INP_VALID,p1.ERR),UVM_LOW);end
          end


          else if(p1.INP_VALID==2'b10 && p1.CMD==7 && p1.MODE==1)begin
            int ERR;
            if((p1.OPB-1)==p1.RES)begin
              `uvm_info(get_type_name(),$sformatf("DEC_B PASS WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d,INP_VALID=%d,ERR=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT,p1.INP_VALID,p1.ERR),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("DEC_B FAIL WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d,INP_VALID=%d,ERR=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT,p1.INP_VALID,p1.ERR),UVM_LOW);end

          end




          else if(p1.INP_VALID==2'b01 && p1.MODE==1 && (p1.CMD==6 || p1.CMD==7))begin
            int ERR=1'b1;
           // $display("ERROR RAISED ERR=%d,INP_VALID=%d,CMD=%d
            if(ERR==p1.ERR )begin
              `uvm_info(get_type_name(),$sformatf("INC_B PASS WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d,INP_VALID=%d,EERR=%0d,ERR=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT,p1.INP_VALID,ERR,p1.ERR),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("INC_B FAIL WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d,INP_VALID=%d,EERR=%0d,ERR=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT,p1.INP_VALID,ERR,p1.ERR),UVM_LOW);end

          end

          else if(p1.INP_VALID==2'b01 && p1.MODE==0 &&  p1.CMD==7)begin
            int ERR=1'b1;
            if(ERR==p1.ERR)begin
              `uvm_info(get_type_name(),$sformatf("NOT_B PASS WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d,INP_VALID=%d,EERR=%0d,ERR=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT,p1.INP_VALID,ERR,p1.ERR),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("NOT_B FAIL WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d,INP_VALID=%d,EERR=%0d,ERR=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT,p1.INP_VALID,ERR,p1.ERR),UVM_LOW);end

          end

          else if(p1.INP_VALID==2'b10 && p1.MODE==1 && (p1.CMD==4 || p1.CMD==5))begin
            int ERR=1'b1;
            if(ERR==p1.ERR)begin
              `uvm_info(get_type_name(),$sformatf("INC_A PASS WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d,INP_VALID=%d,EERR=%0d,ERR=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT,p1.INP_VALID,ERR,p1.ERR),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("INC_A FAIL WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d,INP_VALID=%d,EERR=%0d,ERR=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT,p1.INP_VALID,ERR,p1.ERR),UVM_LOW);end

          end

          else if(p1.INP_VALID==2'b10 && p1.MODE==0 && p1.CMD==6)begin
            int ERR=1'b1;
            if(ERR==p1.ERR)begin
              `uvm_info(get_type_name(),$sformatf("NOT_A PASS WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d,INP_VALID=%d,EERR=%0d,ERR=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT,p1.INP_VALID,ERR,p1.ERR),UVM_LOW);end
                else begin
                  `uvm_info(get_type_name(),$sformatf("NOT_A FAIL WITH OPA=%d OPA=%b,OPB=%d,OPB=%b,RES=%d,RES=%b,CIN=%d,COUT=%d,INP_VALID=%d,EERR=%0d,ERR=%d",p1.OPA,p1.OPA,p1.OPB,p1.OPB,p1.RES,p1.RES,p1.CIN,p1.COUT,p1.INP_VALID,ERR,p1.ERR),UVM_LOW);end

          end




        end
      end




  endtask
endclass
