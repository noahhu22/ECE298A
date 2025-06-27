module counter (
    input  wire        clk,        // System clock
    input  wire        rst_n,      // Active-low synchronous reset
    input  wire        load,       // Parallel load enable (synchronous)
    input  wire        clk_en,     // Count enable (synchronous)
    input  wire [7:0]  load_data,  // Data to be loaded in parallel
    input  wire        oe,         // Output enable (when 1, outputs drive; when 0, Z)
    output wire [7:0]  bus         // Tri-state bus
);

    wire [31:0] sequence_out;
    WAIT_STATE ws(
        .clk(clk),
        .rst(~rst_n), // invert if WAIT_STATE expects active-high reset
        .en(clk_en),
        .colour_in(/* connect appropriate signal */),
        .colour_val(load_data[1:0]),
        .sequence_len(load_data[3:0]),
        .complete_wait(bus[0]),
        .sequence(sequence_out)
    );

    // Example tri-state bus assignment (implement as needed)
    // assign bus = oe ? sequence_out[7:0] : 8'bz;

endmodule