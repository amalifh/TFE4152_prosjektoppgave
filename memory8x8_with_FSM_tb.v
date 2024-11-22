`include "minne.v"
`include "FSM_v3.v"
`timescale 1ns / 1ps

module memory8x8_with_FSM_tb;

    reg clk;                      // Clock signal
    reg [2:0] address;            // Address input
    reg [7:0] data_in;            // Data input
    reg op;                       // Operation signal for FSM
    reg selFSM;                   // Select signal for FSM

    // Outputs
    wire [7:0] data_out;          // Data output
    wire rw, valid;               // FSM outputs

    // Instantiate FSM
    FSM fsm (
        .clk(clk),
        .op(op),
        .selFSM(selFSM),
        .valid(valid),
        .rw(rw)
    );

    // Instantiate memory8x8 module
    memory8x8 uut (
        .address(address),
        .data_in(data_in),
        .select(valid),           // Connect FSM's valid signal to memory's select
        .rw(rw),                  // Connect FSM's rw signal to memory's rw
        .data_out(data_out)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 10ns clock period

    // Test sequence
    initial begin
        $display("Memory Test with FSM");

        // Initialize FSM inputs
        selFSM = 1; op = 1;       // FSM in write mode

        // Write to Address 000 and Read Back
        address = 3'b000;         // Set address
        data_in = 8'b10101010;    // Data to write
        #20;                      // Wait for FSM to set valid and rw
        op = 0;                   // Switch FSM to read mode
        #20;

        $display("Write 10101010 at Addr 000: Data Out=%b (Expected: 10101010)", data_out);

        // Write to Address 001 and Read Back
        op = 1;                   // FSM in write mode
        address = 3'b001;
        data_in = 8'b01010101;    // Data to write
        #20;
        op = 0;                   // Switch FSM to read mode
        #10;

        $display("Write 01010101 at Addr 001: Data Out=%b (Expected: 01010101)", data_out);

        // Test Hold Behavior (no writes or reads)
        op = 0;                   // FSM in idle mode
        selFSM = 0;               // Disable FSM
        address = 3'b000;         // Set address back to 000
        #10;

        $display("Hold Addr 000: Data Out=%b (Expected: 10101010)", data_out);

        // End test
        $finish;
    end

endmodule
