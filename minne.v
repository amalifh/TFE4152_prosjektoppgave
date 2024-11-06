// WORD MODUL //
// 8 bits som tar inn hver sin wire i data_in og gir ut hver sin data_out. 
// Hele ordet tar inn samme rw og sel signal

module word8bit (
    input wire [7:0] data_in,  // 8-bit data input
    input wire sel,            // Select signal for all bitcells
    input wire rw,             // Read/Write signal for all bitcells
    output wire [7:0] data_out // 8-bit data output
);

    // 8 bitceller indeksert fra 0 til 7
    bitcell bit0 (
        .data(data_in[0]),
        .sel(sel),
        .rw(rw),
        .out(data_out[0])
    );

    bitcell bit1 (
        .data(data_in[1]),
        .sel(sel),
        .rw(rw),
        .out(data_out[1])
    );

    bitcell bit2 (
        .data(data_in[2]),
        .sel(sel),
        .rw(rw),
        .out(data_out[2])
    );

    bitcell bit3 (
        .data(data_in[3]),
        .sel(sel),
        .rw(rw),
        .out(data_out[3])
    );

    bitcell bit4 (
        .data(data_in[4]),
        .sel(sel),
        .rw(rw),
        .out(data_out[4])
    );

    bitcell bit5 (
        .data(data_in[5]),
        .sel(sel),
        .rw(rw),
        .out(data_out[5])
    );

    bitcell bit6 (
        .data(data_in[6]),
        .sel(sel),
        .rw(rw),
        .out(data_out[6])
    );

    bitcell bit7 (
        .data(data_in[7]),
        .sel(sel),
        .rw(rw),
        .out(data_out[7])
    );

endmodule



// INTERN DEKODER //
// En 3 til 8 dekoder med Select i hver AND-gate. 

module decoder3to8 (
    input wire A2,
    input wire A1,
    input wire A0,
    input wire Select,
    
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
    wire notA2, notA1, notA0;
    assign notA2 = ~A2;
    assign notA1 = ~A1;
    assign notA0 = ~A0;

    // outputs
    assign Z0 = Select & notA2 & notA1 & notA0;
    assign Z1 = Select & notA2 & notA1 & A0;
    assign Z2 = Select & notA2 & A1 & notA0;
    assign Z3 = Select & notA2 & A1 & A0;
    assign Z4 = Select & A2 & notA1 & notA0;
    assign Z5 = Select & A2 & notA1 & A0;
    assign Z6 = Select & A2 & A1 & notA0;
    assign Z7 = Select & A2 & A1 & A0;

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
        .A2(address[2]),
        .A1(address[1]),
        .A0(address[0]),
        .Select(select),    
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
