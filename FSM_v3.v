`include "D_flip_flop.v"

module FSM(
    input wire op,
    input wire selFSM,
    input wire clk,        

    output wire rw,
    output wire valid,
    output wire A_FSM,      // Expose A_FSM for testbench observation
    output wire B_FSM       // Expose B_FSM for testbench observation
);

    // Next state logic
    wire Aplus;
    wire Bplus;

    // A+ logic
    wire notSel, notB, AandnotB;
    not(notSel, selFSM);
    not(notB, B_FSM);
    and(AandnotB, A_FSM, notB); // A and not B for maintaining IDLE

    wire selAndOp, notBAndNotSel;
    and(selAndOp, selFSM, op);
    and(notBAndNotSel, notB, notSel);

    or(Aplus, AandnotB, selAndOp, notBAndNotSel);

    // B+ logic
    wire notA, notAAndNotOp, AandOp;
    not(notA, A_FSM);
    and(notAAndNotOp, notA, ~op);
    and(AandOp, A_FSM, op);

    wire selFSMAndOpLogic, idleToReadLogic;
    or(selFSMAndOpLogic, notAAndNotOp, AandOp);
    and(idleToReadLogic, notA, B_FSM, ~op, selFSM);  // IDLE to READ condition
    or(Bplus, selFSMAndOpLogic, idleToReadLogic);

    // D flip-flops for state storage, clocked by `clk`
    D_flip_flop Astate (
        .D(Aplus),
        .clk(clk),
        .Q(A_FSM)
    );

    D_flip_flop Bstate (
        .D(Bplus),
        .clk(clk),
        .Q(B_FSM)
    );

    // Output logic for `valid` and `rw`
    buf(valid, B_FSM);       // `valid` is the same as `B_FSM`
    xnor(rw, A_FSM, B_FSM);   // `rw` is high in WRITE and STABLE states

endmodule