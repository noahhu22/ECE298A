
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

    // Instantiate only the LFSR_OLD module and connect all I/O
    LFSR_OLD lfsr_inst (
        .LFSR_SEED(ui_in[6:0]),      // Use the first 7 bits of ui_in as the seed
        .clk(clk),
        .rst(~rst_n),                // Active low reset
        .enable(ena),                // Enable signal
        .LFSR_OUT(uio_out[6:0]),     // Output the LFSR value to uio_out[6:0]
        .complete_LFSR(uio_out[7])   // Indicate completion in the last bit of uio_out
    );

    // All output pins must be assigned. If not used, assign to 0.
    assign uo_out  = 8'b0;
    assign uio_oe  = 8'b1111_1111; // All uio_out pins are outputs

endmodule