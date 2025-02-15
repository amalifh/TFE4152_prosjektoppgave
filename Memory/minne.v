`include "bitcell_v2.v"

// WORD MODUL //
// 8 bits som tar inn hver sin wire i data_in og gir ut hver sin data_out. 
// Hele ordet tar inn samme rw og sel signal

module word8bit (
    input wire [7:0] data_in,  // 8-bit data input
    input wire sel,            // Select signal for all bitcells
    input wire rw,             // Read/Write signal for all bitcells
    output wire [7:0] data_out // 8-bit data output
);

    // Internal wires to hold the output from each bitcell
    wire [7:0] internal_data_out;

    //Logikk for active MUX
    wire notrw, MUXsel, notMUXsel;
    wire [7:0] MUXa; 
    wire [7:0] MUXb;

    not(notrw, rw);
    and(MUXsel, notrw, sel);

    not (notMUXsel, MUXsel);


    // Instantiate 8 bitcell modules, each outputting to internal_data_out
    bitcell bit0 (.data(data_in[0]), .sel(sel), .rw(rw), .out(internal_data_out[0]));
    bitcell bit1 (.data(data_in[1]), .sel(sel), .rw(rw), .out(internal_data_out[1]));
    bitcell bit2 (.data(data_in[2]), .sel(sel), .rw(rw), .out(internal_data_out[2]));
    bitcell bit3 (.data(data_in[3]), .sel(sel), .rw(rw), .out(internal_data_out[3]));
    bitcell bit4 (.data(data_in[4]), .sel(sel), .rw(rw), .out(internal_data_out[4]));
    bitcell bit5 (.data(data_in[5]), .sel(sel), .rw(rw), .out(internal_data_out[5]));
    bitcell bit6 (.data(data_in[6]), .sel(sel), .rw(rw), .out(internal_data_out[6]));
    bitcell bit7 (.data(data_in[7]), .sel(sel), .rw(rw), .out(internal_data_out[7]));

    // MUX-like structure with gate-level logic for each bit of data_out

    // Bit 0
    nand (MUXa[0], internal_data_out[0], rw);
    nand (MUXb[0], data_in[0], notrw);
    nand (data_out[0], MUXa[0], MUXb[0]);

    // Bit 1
    nand (MUXa[1], internal_data_out[1], rw);
    nand (MUXb[1], data_in[1], notrw);
    nand (data_out[1], MUXa[1], MUXb[1]);

    // Bit 2
    nand (MUXa[2], internal_data_out[2], rw);
    nand (MUXb[2], data_in[2], notrw);
    nand (data_out[2], MUXa[2], MUXb[2]);

    // Bit 3
    nand (MUXa[3], internal_data_out[3], rw);
    nand (MUXb[3], data_in[3], notrw);
    nand (data_out[3], MUXa[3], MUXb[3]);

    // Bit 4
    nand (MUXa[4], internal_data_out[4], rw);
    nand (MUXb[4], data_in[4], notrw);
    nand (data_out[4], MUXa[4], MUXb[4]);

    // Bit 5
    nand (MUXa[5], internal_data_out[5], rw);
    nand (MUXb[5], data_in[5], notrw);
    nand (data_out[5], MUXa[5], MUXb[5]);

    // Bit 6
    nand (MUXa[6], internal_data_out[6], rw);
    nand (MUXb[6], data_in[6], notrw);
    nand (data_out[6], MUXa[6], MUXb[6]);

    // Bit 7
    nand (MUXa[7], internal_data_out[7], rw);
    nand (MUXb[7], data_in[7], notrw);
    nand (data_out[7], MUXa[7], MUXb[7]);

endmodule

// INTERN DEKODER //
// En 3 til 8 dekoder med select i hver AND-gate. 

module decoder3to8 (
    input wire adr2,
    input wire adr1,
    input wire adr0,
    input wire select,
    
    output wire Z0,
    output wire Z1,
    output wire Z2,
    output wire Z3,
    output wire Z4,
    output wire Z5,
    output wire Z6,
    output wire Z7
);
    // Inverterte inputs
    wire notadr2, notadr1, notadr0;
    
    // NOT gates for inversion
    not (notadr2, adr2);
    not (notadr1, adr1);
    not (notadr0, adr0);

    // AND gates for decoder outputs
    and (Z0, select, notadr2, notadr1, notadr0);
    and (Z1, select, notadr2, notadr1, adr0);
    and (Z2, select, notadr2, adr1, notadr0);
    and (Z3, select, notadr2, adr1, adr0);
    and (Z4, select, adr2, notadr1, notadr0);
    and (Z5, select, adr2, notadr1, adr0);
    and (Z6, select, adr2, adr1, notadr0);
    and (Z7, select, adr2, adr1, adr0);

    
endmodule


// MINNE ENHET //
// 8 ord hvor hvilket ord som blir valgt avhenger av hvilket z-signal som er aktivt.
// En 8-bits buss for input_data og en for output_data. Logikken for read write er 
// implementert i bit'en

module memory8x8 (
    input wire [2:0] address,  
    input wire [7:0] data_in,  
    input wire select,         
    input wire rw,             
    output wire [7:0] data_out 
);

    // Indre ledninger
    wire [7:0] word_select;

    // Oppretter 3-to-8 decoderen vi lagde ovenfor
    decoder3to8 decoder (
        .adr2(address[2]),
        .adr1(address[1]),
        .adr0(address[0]),
        .select(select),    
        .Z0(word_select[0]),
        .Z1(word_select[1]),
        .Z2(word_select[2]),
        .Z3(word_select[3]),
        .Z4(word_select[4]),
        .Z5(word_select[5]),
        .Z6(word_select[6]),
        .Z7(word_select[7])
    );

    // Lager 8 ord, alle bygd opp og 8 bitceller
    word8bit word0 (
        .data_in(data_in),
        .sel(word_select[0]),
        .rw(rw),
        .data_out(data_out)
    );

    word8bit word1 (
        .data_in(data_in),
        .sel(word_select[1]),
        .rw(rw),
        .data_out(data_out)
    );

    word8bit word2 (
        .data_in(data_in),
        .sel(word_select[2]),
        .rw(rw),
        .data_out(data_out)
    );

    word8bit word3 (
        .data_in(data_in),
        .sel(word_select[3]),
        .rw(rw),
        .data_out(data_out)
    );

    word8bit word4 (
        .data_in(data_in),
        .sel(word_select[4]),
        .rw(rw),
        .data_out(data_out)
    );

    word8bit word5 (
        .data_in(data_in),
        .sel(word_select[5]),
        .rw(rw),
        .data_out(data_out)
    );

    word8bit word6 (
        .data_in(data_in),
        .sel(word_select[6]),
        .rw(rw),
        .data_out(data_out)
    );

    word8bit word7 (
        .data_in(data_in),
        .sel(word_select[7]),
        .rw(rw),
        .data_out(data_out)
    );


endmodule

