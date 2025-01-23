# TFE4152_project
A project with a goal to design and implement a system of 8x8 bit memory module for an IoT device.

## Contributors
Amalie Fridfeldt Hauge, 3rd year of Electronic System Design and Innovation

Andrea Gladhaug, 3rd year of Electronic System Design and Innovation

### Terminal commands to run in Visual Studio code:

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