`include "minne.v" 
`timescale 1ns / 1ps

module decoder3to8_tb;

    reg adr2, adr1, adr0;
    reg select;

    wire Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7;

    // Instantiate the decoder3to8 module
    decoder3to8 uut (
        .adr2(adr2),
        .adr1(adr1),
        .adr0(adr0),
        .select(select),
        .Z0(Z0),
        .Z1(Z1),
        .Z2(Z2),
        .Z3(Z3),
        .Z4(Z4),
        .Z5(Z5),
        .Z6(Z6),
        .Z7(Z7)
    );

    // Test sequence
    initial begin
        $display("Time\t select adr2 adr1 adr0 | Z0 Z1 Z2 Z3 Z4 Z5 Z6 Z7");
        $display("------------------------------------------------");
        
        // Test 1: select is low, no outputs should be active
        select = 0;
        adr2 = 0; adr1 = 0; adr0 = 0;
        #10;
        $display("Test 1: sel er lav, ingen outputs skal være aktive");
        $display("%0dns\t   %b     %b  %b  %b  | %b  %b  %b  %b  %b  %b  %b  %b",
                 $time, select, adr2, adr1, adr0, Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7);

        // Test 2: Count from 0 to 7 with select high
        select = 1;
        $display("Test 1: sel er høy, vanlig 3 til 8 decoder");
        // Each address combination
        adr2 = 0; adr1 = 0; adr0 = 0; #10;
        $display("%0dns\t   %b     %b  %b  %b  | %b  %b  %b  %b  %b  %b  %b  %b",
                 $time, select, adr2, adr1, adr0, Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7);

        adr2 = 0; adr1 = 0; adr0 = 1; #10;
        $display("%0dns\t   %b     %b  %b  %b  | %b  %b  %b  %b  %b  %b  %b  %b",
                 $time, select, adr2, adr1, adr0, Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7);

        adr2 = 0; adr1 = 1; adr0 = 0; #10;
        $display("%0dns\t   %b     %b  %b  %b  | %b  %b  %b  %b  %b  %b  %b  %b",
                 $time, select, adr2, adr1, adr0, Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7);

        adr2 = 0; adr1 = 1; adr0 = 1; #10;
        $display("%0dns\t   %b     %b  %b  %b  | %b  %b  %b  %b  %b  %b  %b  %b",
                 $time, select, adr2, adr1, adr0, Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7);

        adr2 = 1; adr1 = 0; adr0 = 0; #10;
        $display("%0dns\t   %b     %b  %b  %b  | %b  %b  %b  %b  %b  %b  %b  %b",
                 $time, select, adr2, adr1, adr0, Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7);

        adr2 = 1; adr1 = 0; adr0 = 1; #10;
        $display("%0dns\t   %b     %b  %b  %b  | %b  %b  %b  %b  %b  %b  %b  %b",
                 $time, select, adr2, adr1, adr0, Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7);

        adr2 = 1; adr1 = 1; adr0 = 0; #10;
        $display("%0dns\t   %b     %b  %b  %b  | %b  %b  %b  %b  %b  %b  %b  %b",
                 $time, select, adr2, adr1, adr0, Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7);

        adr2 = 1; adr1 = 1; adr0 = 1; #10;
        $display("%0dns\t   %b     %b  %b  %b  | %b  %b  %b  %b  %b  %b  %b  %b",
                 $time, select, adr2, adr1, adr0, Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7);

        // End simulation
        $finish;
    end

endmodule