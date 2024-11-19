`include "minne.v"
`timescale 1ns / 1ps

// Jeg mistenker at dekoderen tar en klokkesyklusen, for den funker bare du gir henne nok tid
// 

module memory8x8_tb;

    reg [2:0] address;
    reg [7:0] data_in;
    reg select;
    reg rw;

    wire [7:0] data_out;

    // Oppretter memory8x8 modul
    memory8x8 uut (
        .address(address),
        .data_in(data_in),
        .select(select), 
        .rw(rw),
        .data_out(data_out)
    );

    // Test sequence
   initial begin
    $display("Simplified Memory Test");

    // Initialization: Set select and address, perform a read
    select = 1; rw = 1; address = 3'b000;
    data_in = 8'b00000000;
    #10;
    rw = 0; // Write mode
    #10;
    #10;

    $display("Init Check: Addr=%b Data Out=%b (Expected: 00000000)", address, data_out);

    // Write to Address 000 and Read Back
    rw = 1; // Write mode

    data_in = 8'b10101010;
    #10;    // Allow write time
    rw = 0; // Read mode
    #10;
    $display("Write 10101010 at Addr 000: Data Out=%b (Expected: 10101010)", data_out);

    $finish;
    end
    

endmodule