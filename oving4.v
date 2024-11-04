module D_a (
    input wire A,
    input wire B, 
    input wire C,
    output wire Y
);

    wire NotA;
    wire NotC;
    wire NotAandB;
    wire NotCandA;

    // Creating necessary gates
    assign NotA = ~A; 
    assign NotC = ~C; 
    assign NotAandB = NotA & B; 
    assign NotCandA = A & NotC;
    assign Y = NotAandB | NotCandA;

endmodule

`timescale 1ns / 1ps

module D_a_tb;
    
    // Inputs
    reg A;
    reg B;
    reg C;

    // Output
    wire Y;

    // Instantiate the Unit Under Test (UUT)
    D_a uut (
        .A(A), 
        .B(B), 
        .C(C), 
        .Y(Y)
    );

    // Testbench variables
    integer i;

    // Expected output function
    function expected_Y;
        input A, B, C;
        begin
            expected_Y = (~A & B) | (A & ~C);
        end
    endfunction

    module D_a_tb;
    
    // Inputs
    reg A;
    reg B;
    reg C;

    // Output
    wire Y;

    // Instantiate the Unit Under Test (UUT)
    D_a uut (
        .A(A), 
        .B(B), 
        .C(C), 
        .Y(Y)
    );

    // Testbench variables
    integer i;

    // Expected output function
    function expected_Y;
        input A, B, C;
        begin
            expected_Y = (~A & B) | (A & ~C);
        end
    endfunction

    // Testbench procedure with waveform generation
    initial begin
        $dumpfile("simulation.vcd");  // Specify the output VCD file
        $dumpvars(0, D_a_tb);         // Dump all variables in the testbench
        
        $display("Starting simulation...");

        // Apply all possible input combinations
        for (i = 0; i < 8; i = i + 1) begin
            {A, B, C} = i;  // Assign binary value of i to {A, B, C}
            #10;             // Wait 10 time units for propagation

            // Check if Y matches the expected output
            if (Y !== expected_Y(A, B, C)) begin
                $display("Test failed for A=%b, B=%b, C=%b: Expected Y=%b, Got Y=%b", A, B, C, expected_Y(A, B, C), Y);
            end else begin
                $display("Test passed for A=%b, B=%b, C=%b: Y=%b", A, B, C, Y);
            end
        end

        $display("Simulation finished.");
        $stop;
    end
endmodule