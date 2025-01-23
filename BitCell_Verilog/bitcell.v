module bitcell (
    input wire data,
    input wire sel,
    input wire rw,
    output wire out
);

    wire node3, node4, tempOut, outNot, almostOut;

    // Første 3-input NAND gate
    wire nand1_out;
    assign nand1_out = ~(data & sel & rw);

    // Andre 3-input NAND gate
    wire nand2_out;
    assign nand2_out = ~(nand1_out & sel & rw);

    // SR-latch implementert med to NAND-porter
    wire sr_out1, sr_out2;
    assign sr_out1 = ~(nand1_out & sr_out2);  // første NAND i SR-latch
    assign sr_out2 = ~(nand2_out & sr_out1);  // andre NAND i SR-latch

    // NOT-port for invertering
    assign outNot = ~rw;

    // Tredje 3-input NAND gate
    wire nand3_out;
    assign nand3_out = ~(sr_out1 & outNot & sel);

    // Siste NOT-port for invertering
    assign out = ~nand3_out;

endmodule

