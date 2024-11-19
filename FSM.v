`include "D_flip_flop.v" 
// navnene kan endres etter vi vet sikkert om det er samme sel signal osv
module FSM(
    input wire op,
    input wire selFSM,
    input wire clk,        

    output wire rw,
    output wire valid

    // Ønsker å se state bits i testbench, så eksponerer de

);

    // Current state og Next state logic foreløpig kmt ut hvis vi ikke vil ha de stikkende ut lenger
    wire A_FSM;              
    wire B_FSM;              

    wire Aplus;
    wire Bplus;

    // A+ logic
    wire norBSel, andSelOp;
    nor(norBSel, B_FSM, selFSM);
    and(andSelOp, op, selFSM);
    or(Aplus, norBSel, andSelOp);

    // B+ logic
    wire XnorAB;
    xnor(XnorAB, A_FSM, B_FSM);
    and(Bplus, selFSM, XnorAB);

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
    xnor(rw, valid, A_FSM);   // `rw` is high in WRITE and STABLE states

endmodule