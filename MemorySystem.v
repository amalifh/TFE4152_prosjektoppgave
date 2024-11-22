`include "FSM_v3.v"
`include "minne.v"

module MemorySystem (
    input wire clk,                // Clock input
    input wire [7:0] data_in,      // 8-bit data input
    input wire [2:0] address,      // 3-bit address input
    input wire op,                 // Operation signal (read/write)
    input wire select,             // Select signal for FSM
    output wire [7:0] data_out     // 8-bit data output
);

    // Internal wires
    wire valid;                    // Valid signal from FSM
    wire rw;                       // Read/Write control signal from FSM
    wire [7:0] word_select;        // Word select signals from decoder

    // FSM instantiation
    FSM fsm (
        .clk(clk),                 // Pass clk to FSM
        .op(op),
        .selFSM(select),
        .valid(valid),
        .rw(rw)
    );

    // Decoder instantiation
    decoder3to8 decoder (
        .adr2(address[2]),
        .adr1(address[1]),
        .adr0(address[0]),
        .select(valid),            // Use valid as the select signal for the decoder
        .Z0(word_select[0]),
        .Z1(word_select[1]),
        .Z2(word_select[2]),
        .Z3(word_select[3]),
        .Z4(word_select[4]),
        .Z5(word_select[5]),
        .Z6(word_select[6]),
        .Z7(word_select[7])
    );

    // Memory instantiation
    memory8x8 memory (
        .data_in(data_in),
        .word_select(word_select), // Use word_select signals for memory word activation
        .rw(rw),                   // Use rw signal from FSM
        .data_out(data_out)
    );

endmodule
