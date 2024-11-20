module D_flip_flop (
    input wire D,    // Data input
    input wire clk,  // Clock input
    output reg Q     // Output
);

    wire Dnandclk, notD, notDNandclk, notclk;
    not(notclk, clk);
    not(notD, D);
    nand(Dnandclk, D, clk);
    nand(notDNandclk, notD, clk);

    wire C2;
    
    nand (OutSR, Dnandclk, C2);
    nand (C2, notDNandclk, OutSR);

    wire uppernand, undernand;
    nand(uppernand, OutSR, notclk);
    nand(undernand, C2, notclk);

    wire C3;
    
    nand (OutFinalSR, uppernand, C3);
    nand (C3, undernand, OutFinalSR);

endmodule
