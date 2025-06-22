module test;

// Signals for LFSR
reg rst = 0;
reg enable = 1;
reg [6:0] LFSR_SEED = 7'b1101001; // Example seed
wire [6:0] LFSR_OUT;
wire complete_LFSR;

// Internal signal to observe feedback calculation
wire feedback;
assign feedback = LFSR_OUT[6] ^ LFSR_OUT[5];

// Instantiate the LFSR module
LFSR uut (
    .LFSR_SEED(LFSR_SEED),
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .LFSR_OUT(LFSR_OUT),
    .complete_LFSR(complete_LFSR)
);

// Clock generation
reg clk = 0;
always #1 clk = ~clk;

// Test sequence
initial begin
    $dumpfile("LFSR_test.vcd");
    $dumpvars(0, test);

    #1 enable = 1;
    #90 rst = 1; // Reset the LFSR
    #1 rst = 0;

    #100 enable = 0;
    // #17 rst = 1;
    // #11 rst = 0;
    // #29 rst = 1;
    // #5  rst = 0;

    // #20 enable = 0;
    // #20 enable = 1;
    #513 $finish;
end

// Monitor outputs and XOR feedback
always @(posedge clk) begin
    $display("At time %t, LFSR_OUT = %b, feedback (LFSR_OUT[6] ^ LFSR_OUT[5]) = %b, complete_LFSR = %b", 
        $time, LFSR_OUT, feedback, complete_LFSR);
end

endmodule //test