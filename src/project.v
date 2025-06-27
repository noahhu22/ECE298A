module tt_um_simonsays (
    input  wire       clk,      // clock
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       rst_n     // reset_n - low to reset
);

    // Internal register to hold the count value
    reg [7:0] count_reg;

    // Synchronous process: reset, load, or count
    always @(posedge clk) begin
        if (!rst_n) begin
            count_reg <= 8'b0;
        end else if (load) begin
            count_reg <= load_data;
        end else if (clk_en) begin
            count_reg <= count_reg + 1'b1;
        end
        // If neither reset, load, nor clk_en, hold current value
    end

    // Tri-state driver: when oe=1, drive count_reg; when oe=0, high-impedance
    assign bus = (oe) ? count_reg : 8'bz;

endmodule
