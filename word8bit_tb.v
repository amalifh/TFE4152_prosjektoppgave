`include "minne.v"      
`timescale 1ns / 1ps

module word8bit_tb;

    reg [7:0] data_in;       
    reg sel;                 
    reg rw;                  
    wire [7:0] data_out;     
    
    // Oppretter word8bit modul
    word8bit uut (
        .data_in(data_in),
        .sel(sel),
        .rw(rw),
        .data_out(data_out)
    );

    // Clock generation
    reg clk;
    initial clk = 0;
    always #5 clk = ~clk;  // 10 ns clk (merk at tb for bitcellen har 20 ns men det endrer ikke selve bitcellen)

  // Tester
    initial begin
        // Monitor output values during tests
        $monitor("Tid: %0dns, sel=%b, rw=%b, data_in=%b, data_out=%b", $time, sel, rw, data_in, data_out);

        $display("\nStartverditest \nForventet verdi data_out på siste klokkeflanke: 00000000");
        data_in = 8'b00000000;
        sel = 1;
        rw = 1;  
        #10;

        data_in = 8'bxxxxxxxx;
        sel = 1;
        rw = 0;  // Nå leser vi
        #10;     

        $display("\nSkrivetest 1 \nForventet verdi data_out på siste klokkeflanke: 01010101");
        data_in = 8'b01010101;
        sel = 1;
        rw = 1;
        #10;

        data_in = 8'bxxxxxxxx;
        sel = 1;
        rw = 0;  // Nå leser vi
        #10;  

        $display("\nSkrivetest 2 \nForventet verdi data_out på siste klokkeflanke: 10100000");
        data_in = 8'b10100000;
        sel = 1;
        rw = 1;
        #10;

        data_in = 8'bxxxxxxxx;
        sel = 1;
        rw = 0;  // Nå leser vi
        #10; 

        $display("\nHoldetest: Forrige verdi skal holdes på når word ikke er aktivt \nForventet verdi data_out på siste klokkeflanke: 10100000");
        data_in = 8'bxxxxxxxx;
        sel = 0;
        rw = 1;
        #10;

        data_in = 8'bxxxxxxxx;
        sel = 1;
        rw = 0;  // Nå leser vi
        #10; 
   
        $finish;
    end

endmodule

