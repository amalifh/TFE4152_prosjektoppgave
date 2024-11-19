# TFE4152_prosjektoppgave
Prosjektoppgave i IC, med de besteste bestejentene Amalie og Andrea :)

Testbenchs: 


Terminal commands:
    Bitcell_tb
        Kompilere: iverilog -o bitcell_tb bitcell_tb.v

    word_tb
        Kompilere: iverilog -o word8bit_tb word8bit_tb.v 
        Runne: vvp word8bit_tb

    decoder3to8_tb    
        Kompilere: iverilog -o decoder3to8_tb decoder3to8_tb.v 
        Runne: vvp decoder3to8_tb

    memory8x8_tb
        Kompilere: iverilog -o memory8x8_tb memory8x8_tb.v 
        Runne: vvp memory8x8_tb

    FSM_tb
        Kompilere: iverilog -o FSM_tb FSM_tb.v 
        Runne: vvp FSM_tb