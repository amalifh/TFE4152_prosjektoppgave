module fsm_101_detector (
    input wire clk,         // Clk signal
    input wire reset,       
    input wire x,        
    output reg y            
);

    reg QA, QB;

    // 
    wire DA = (QB & ~x) | (QA & ~QB & x);
    wire DB = x;

    assign y = QA & QB;

    // Sørger for positive edge response
    // og initialiserer en start-state på 00
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            QA <= 0;
            QB <= 0;
        end else begin
            QA <= DA;
            QB <= DB;
        end
    end

endmodule