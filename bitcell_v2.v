
module SR_Latch(
    input wire In1, In2,
    output wire OutSR
);

    wire C2;
    
    nand G1(OutSR, In1, C2);
    nand G2(C2, In2, OutSR);
    
endmodule

module bitcell(
    input wire data, sel, rw,
    output wire out
    );

    wire C1, C2, C3, TempOut;

	nand(C1, data, sel, rw);

    SR_Latch B1(
        .In1(C1),
        .In2(C2),
        .OutSR(TempOut)
    ); 

	nand(C2, C1, sel, rw);

    not G3(C3, rw);

	and(out, TempOut, sel, C3);

endmodule