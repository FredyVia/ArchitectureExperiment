`timescale 1 ps / 1 ps

module pc_ctrl_1
   (input wire branchD,branchM,succM,actual_takeM,pred_takeD,pc_trapM,jumpD,jump_conflictD,jump_conflictE,
    output wire [2:0]pc_sel);
  assign pc_sel = pc_trapM ? 3'b110:
                    ((branchM & ~succM) ? (actual_takeM ? 3'b100: 3'b101) : 
                    (jump_conflictE ? 3'b011:
                    (jumpD & ~jump_conflictD ? 3'b010:
                    (branchD & pred_takeD ? 3'b001 : 3'b000))));
endmodule