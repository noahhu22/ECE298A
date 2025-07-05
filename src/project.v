
`default_nettype none

module tt_um_simonsays (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // Local Signals
    //Input
    wire [3:0] colour_dec_in = ui_in[3:0];                // 4-bit input for colour decoding
    wire reset = ui_in[4];                             // Reset signal
    wire start = ui_in[5];                                // Start signal
    wire [7:0] LFSR_SEED = uio_in[7:0];

    //LFSR
    wire [7:0] LFSR_out;
    wire complete_LFSR;                                      // LFSR completion signal
    wire en_LFSR;

    //IDLE 
    wire en_IDLE = ui_in[6]; // temp
    wire rst_IDLE = ui_in[6]; // temp
    wire complete_IDLE = ui_in[6]; // temp

    //32bMEM
    wire MEM_LOAD;
    wire [7:0]MEM_IN; // load 8 bits at a time
    wire [1:0]MEM_LOAD_VAL;


    LFSR lfsr(
        .LFSR_SEED(LFSR_SEED),      // Use the first 7 bits of ui_in as the seed
        .clk(clk),
        .rst(~rst_n),                // Active low reset
        .enable(ena),                // Enable signal
        .LFSR_OUT(LFSR_out),     // Output the LFSR value to uio_out[6:0]
        .complete_LFSR(complete_LFSR)   // Indicate completion in the last bit of uio_out
    );

    IDLE_STATE idle(
        .clk(clk),
        .en_IDLE(en_IDLE),
        .rst_IDLE(rst_IDLE),
        .complete_LFSR(complete_LFSR),
        .LFSR_output(LFSR_out), // Use the first 7 bits of LFSR output
        .en_LFSR(en_LFSR),
        .MEM_IN(MEM_IN), // Load the LFSR output into memory
        .MEM_LOAD(MEM_LOAD),
        .complete_IDLE(complete_IDLE),
        .MEM_LOAD_VAL(MEM_LOAD_VAL)
    );


    // All output pins must be assigned. If not used, assign to 0.
    assign uo_out  = MEM_IN;
    assign uio_oe  = 8'b1111_1111; // All uio_out pins are outputs
    assign uio_out = 8'b0;
endmodule