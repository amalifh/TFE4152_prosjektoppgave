`include "FSM_v2.v"         // Include the FSM module

`timescale 1ns / 1ps

module FSM_tb();

    // Testbench Signals
    reg op;
    reg selFSM;
    reg clk;             // Declare clk as a reg for toggling
    wire rw;
    wire valid;
    wire A_FSM;          // Internal state bit
    wire B_FSM;          // Internal state bit
    wire Aplus;          // Next state bit
    wire Bplus;          // Next state bit

    // Instantiate the FSM module with internal state connections
    FSM uut (
        .op(op),
        .selFSM(selFSM),
        .clk(clk),
        .rw(rw),
        .valid(valid),
        .A_FSM(A_FSM),    // Connect internal state bit
        .B_FSM(B_FSM)    // Connect internal state bit
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;  // Toggle clock every 5 time units, creating a 10ns period

    // Task for displaying the current state and outputs
    task display_state;
        begin
            $display("Time: %0dns | clk: %b | op: %b, selFSM: %b | valid: %b rw: %b | A_FSM: %b, B_FSM: %b", 
                     $time, clk, op, selFSM, valid, rw, A_FSM, B_FSM);
        end
    endtask

    // Test Sequence
    initial begin
        op = 0; selFSM = 0;
        #20
        // Her ender vi uansett opp i IDLE
        op = 0; selFSM = 0; 
    $display("\nIDLE til IDLE \nForventet state lk: -------------------------------------| A_FSM: 1, B_FSM: 0");
        #5 display_state();
        #5 display_state();
        #5 display_state();
        #5 display_state();

        op = 1; selFSM = 1;
    $display("\nIDLE til WRITE \nForventet state lk: -------------------------------------| A_FSM: 1, B_FSM: 1");
        #5 display_state();
        #5 display_state();
        #5 display_state();
        #5 display_state();


    $display("\nWRITE til STABLE til READ \nForventet state lk: ----------------------------------| A_FSM: 0, B_FSM: 0 så A_FSM: 0, B_FSM: 1 ");
        op = 0; selFSM = 1; 
        #5 display_state();
        #5 display_state();
        #5 display_state();
        #5 display_state();
        #5 display_state();
        #5 display_state();
        #5 display_state();

    $display("\nREAD til IDLE \nForventet state lk: -------------------------------------| A_FSM: 1, B_FSM: 0");
        op = 0; selFSM = 0; 
        #5 display_state();
        #5 display_state();
        #5 display_state();
        #5 display_state();

    $display("\n IDLE til READ \nForventet state lk: -------------------------------------| A_FSM: 0, B_FSM: 1");
        op = 0; selFSM = 1; 
        #5 display_state();
        #5 display_state();
        #5 display_state();
        #5 display_state();
        #5 display_state();
        #5 display_state();
        #5 display_state();
        #5 display_state();

    $display("\n READ til WRITE \nForventet state lk: -------------------------------------| A_FSM: 1, B_FSM: 1");
        op = 1; selFSM = 1; 
        #5 display_state();
        #5 display_state();
        #5 display_state();
        #5 display_state();
   
        $finish;  
    end

endmodule