include "D_flip_flop.v"
`timescale 1ns / 1ps

module D_flip_flop_tb;

    // Testbench signals
    reg D;       // Data input
    reg clk;     // Clock input
    wire Q;      // Output from the DUT

    // Instantiate the DUT (Device Under Test)
    D_flip_flop uut (
        .D(D),
        .clk(clk),
        .Q(Q)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    // Test sequence
    initial begin
        // Open waveform dump
        $dumpfile("D_flip_flop_tb.vcd");
        $dumpvars(0, D_flip_flop_tb);

        // Initialize inputs
        D = 0;

        // Display header
        $display("Time (ns)\tD\tclk\tQ");

        // Apply test inputs
        #10 D = 1;   // Change D to 1 at 10 ns
        #10 D = 0;   // Change D to 0 at 20 ns
        #20 D = 1;   // Change D to 1 at 40 ns

        // Final check
        #20 $finish; // End simulation at 60 ns
    end

    // Monitor signal changes
    initial begin
        $monitor("%0t\t%b\t%b\t%b", $time, D, clk, Q);
    end

endmodule
