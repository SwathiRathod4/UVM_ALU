`include "defines.svh"
class alu_sequence extends uvm_sequence #(alu_sequence_item);

  `uvm_object_utils(alu_sequence)

  function new(string name="alu_sequence");
    super.new(name);
  endfunction

  virtual task body();
    alu_sequence_item req;
    repeat (`no_of_transactions) begin   // send 5 transactions (you can change this number)
      req = alu_sequence_item::type_id::create("req");
      start_item(req);
      if (!req.randomize() ) begin
        `uvm_error("SEQ", "Randomization failed!")
      end
      finish_item(req);
    end
  endtask

endclass
