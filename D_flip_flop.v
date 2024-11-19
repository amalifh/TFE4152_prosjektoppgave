module D_flip_flop (
    input wire D,    // Data input
    input wire clk,  // Clock input
    output reg Q     // Output
);

    always @(posedge clk) begin
        Q <= D;
    end

endmodule