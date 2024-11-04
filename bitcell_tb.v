`include "bitcell.v"        // Include the module

`timescale 1ns / 1ps

module bitcell_tb;

    // Inputs
    reg data;
    reg sel;
    reg rw;

    // Output
    wire out;

    // Instantiate the Unit Under Test (UUT)
    bitcell uut (
        .data(data),
        .sel(sel),
        .rw(rw),
        .out(out)
    );

    // Test procedure
    initial begin
        // Initialize inputs to set SR latch to hold a "1"
        data = 1;
        sel = 1;
        rw = 1;

        #20; sel = 1; rw = 0; data = 0;

        #20; sel = 1; rw = 0; data = 1;
        
        #20; sel = 1; rw = 1; data = 0;
        
        #20;  sel = 1; rw = 1; data = 1;

        #20;  sel = 0; rw = 1; data = 1;

        #20;  sel = 1; rw = 1; data = 1;

        // End simulation
        #20;
        $finish;
    end

    // Monitor changes in signals
    initial begin
        $monitor("At time %0dns: sel = %b, rw = %b, data = %b, out = %b",
                 $time, sel, rw, data, out);
    end

endmodule