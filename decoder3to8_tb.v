`include "minne.v" 
`timescale 1ns / 1ps

module decoder3to8_tb;

    reg A2, A1, A0;
    reg Select;

    wire Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7;

    // Instantiate the decoder3to8 module
    decoder3to8 uut (
        .A2(A2),
        .A1(A1),
        .A0(A0),
        .Select(Select),
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
        $display("Time\t Select A2 A1 A0 | Z0 Z1 Z2 Z3 Z4 Z5 Z6 Z7");
        $display("------------------------------------------------");
        
        // Test 1: Select is low, no outputs should be active
        Select = 0;
        A2 = 0; A1 = 0; A0 = 0;
        #10;
        $display("Test 1: sel er lav, ingen outputs skal være aktive");
        $display("%0dns\t   %b     %b  %b  %b  | %b  %b  %b  %b  %b  %b  %b  %b",
                 $time, Select, A2, A1, A0, Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7);

        // Test 2: Count from 0 to 7 with Select high
        Select = 1;
        $display("Test 1: sel er høy, vanlig 3 til 8 decoder");
        // Each address combination
        A2 = 0; A1 = 0; A0 = 0; #10;
        $display("%0dns\t   %b     %b  %b  %b  | %b  %b  %b  %b  %b  %b  %b  %b",
                 $time, Select, A2, A1, A0, Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7);

        A2 = 0; A1 = 0; A0 = 1; #10;
        $display("%0dns\t   %b     %b  %b  %b  | %b  %b  %b  %b  %b  %b  %b  %b",
                 $time, Select, A2, A1, A0, Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7);

        A2 = 0; A1 = 1; A0 = 0; #10;
        $display("%0dns\t   %b     %b  %b  %b  | %b  %b  %b  %b  %b  %b  %b  %b",
                 $time, Select, A2, A1, A0, Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7);

        A2 = 0; A1 = 1; A0 = 1; #10;
        $display("%0dns\t   %b     %b  %b  %b  | %b  %b  %b  %b  %b  %b  %b  %b",
                 $time, Select, A2, A1, A0, Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7);

        A2 = 1; A1 = 0; A0 = 0; #10;
        $display("%0dns\t   %b     %b  %b  %b  | %b  %b  %b  %b  %b  %b  %b  %b",
                 $time, Select, A2, A1, A0, Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7);

        A2 = 1; A1 = 0; A0 = 1; #10;
        $display("%0dns\t   %b     %b  %b  %b  | %b  %b  %b  %b  %b  %b  %b  %b",
                 $time, Select, A2, A1, A0, Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7);

        A2 = 1; A1 = 1; A0 = 0; #10;
        $display("%0dns\t   %b     %b  %b  %b  | %b  %b  %b  %b  %b  %b  %b  %b",
                 $time, Select, A2, A1, A0, Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7);

        A2 = 1; A1 = 1; A0 = 1; #10;
        $display("%0dns\t   %b     %b  %b  %b  | %b  %b  %b  %b  %b  %b  %b  %b",
                 $time, Select, A2, A1, A0, Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7);

        // End simulation
        $finish;
    end

endmodule