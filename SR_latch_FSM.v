module SR_latch_FSM(
    input wire In1, In2,
    output wire OutSR
);

    wire C2;
    
    nand G1(OutSR, In1, C2);
    nand G2(C2, In2, OutSR);
    
endmodule