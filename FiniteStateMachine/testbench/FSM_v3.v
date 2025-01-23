`include "D_flip_flop.v"

//DENNE skal funke, har prøvd å shorte ned gates men det lar seg ikke gjøres uten å påvirke tb

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
    wire notrw, notrwAndvalid, notvalid, notrwandvalidOrnotvalid;

    // A
    not(notrw, rw);
    and(notrwAndvalid, valid, notrw);
    not(notvalid, valid);
    or(notrwandvalidOrnotvalid, notvalid, notrwAndvalid);

    and(Aplus, notrwandvalidOrnotvalid, selFSM);

    // B
    wire opAndnotrwandvalidOrnotvalid, rwAndvalid;

    and(opAndnotrwandvalidOrnotvalid, op, notrwandvalidOrnotvalid);
    and(rwAndvalid, rw, valid);
    or(Bplus, rwAndvalid, opAndnotrwandvalidOrnotvalid);

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
    buf(valid, B_FSM);      // `valid` is the same as `B_FSM`
    buf(rw, A_FSM);         // `rw` is the same as `A_FSM`

endmodule
