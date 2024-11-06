`include "bitcell_v2.v"        

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
        // gjennomgang av diverse verdier
        #20; sel = 1; rw = 0; data = 0;

        #20; sel = 1; rw = 0; data = 1;
        
        #20; sel = 1; rw = 1; data = 0;
        
        #20;  sel = 1; rw = 1; data = 1;

        #20;  sel = 0; rw = 1; data = 1;

        // Her begynner den ekte testen: En "1" vil KUN dukke opp etter 
        // alle signalene er høye;

        #20;  sel = 1; rw = 1; data = 1;

        // denne under burde bli positiv, her leser vi ut en 1:

        #20;  sel = 1; rw = 0; data = 0;

        // overskriver og ønsker å lese ut en 0

        #20;  sel = 1; rw = 1; data = 0;

        //forsikre at data=1 ikke forstyrrer

        #20;  sel = 1; rw = 0; data = 1;

        $display("Test på om bitcelle kan holde på verdi mens ikke aktiv");
        // Skriver 
        #20;  sel = 1; rw = 1; data = 1;

        // Leser
        #20;  sel = 1; rw = 0; data = 1;

        //Skrur av
        #20;  sel = 0; rw = 0; data = 1;
        #20;  sel = 0; rw = 1; data = 1;

        //Og på igjen
        #20;  sel = 1; rw = 0; data = 0;
        
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