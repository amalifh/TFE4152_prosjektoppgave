`include "minne.v" // Include the bitcell module
`timescale 1ns / 1ps

module word8bit_tb;

    // Inputs and Outputs
    reg [7:0] data_in;    // 8-bit input data
    reg sel;              // Select signal
    reg rw;               // Read/Write control
    wire [7:0] data_out;  // 8-bit output data

    // Instantiate the DUT (Device Under Test)
    word8bit uut (
        .data_in(data_in),
        .sel(sel),
        .rw(rw),
        .data_out(data_out)
    );

    // Clock signal for monitoring
    reg clk;
    initial clk = 0;
    always #5 clk = ~clk; // Generate a clock signal with a 10ns period

    // Test cases
    initial begin
        $monitor("Time: %0dns | sel: %b | rw: %b | data_in: %b | data_out: %b", 
                 $time, sel, rw, data_in, data_out);

        // Reset Test
        $display("\n[Reset Test] Expect data_out = 00000000");
        data_in = 8'b00000000;
        sel = 1;
        rw = 1;  // Write mode
        #10;

        // Read after write test
        $display("\n[Read Test] Expect data_out = 00000000");
        data_in = 8'bxxxxxxxx; // Input ignored in read mode
        rw = 0;  // Read mode
        #10;

        // Write 1st pattern test
        $display("\n[Write Test 1] Expect data_out = 01010101");
        data_in = 8'b01010101;
        rw = 1;  // Write mode
        sel = 1;
        #10;

        $display("\n[Read Test 1] Expect data_out = 01010101");
        rw = 0;  // Read mode
        #10;

        // Write 2nd pattern test
        $display("\n[Write Test 2] Expect data_out = 10100000");
        data_in = 8'b10100000;
        rw = 1;  // Write mode
        #10;

        $display("\n[Read Test 2] Expect data_out = 10100000");
        rw = 0;  // Read mode
        #10;

        // Hold test
        $display("\n[Hold Test] Expect data_out = 10100000");
        sel = 0;  // Deactivate word
        #10;

        $display("\n[Read After Hold Test] Expect data_out = 10100000");
        sel = 1;  // Reactivate word
        rw = 0;   // Read mode
        #10;

        $finish; // End simulation
    end

endmodule


