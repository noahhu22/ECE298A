module simonsays (
    input  wire        clk,        // System clock
    input  wire        rst_n,      // Active-low synchronous reset
    input  wire        load,       // Parallel load enable (synchronous)
    input  wire        clk_en,     // Count enable (synchronous)
    input  wire [7:0]  load_data,  // Data to be loaded in parallel
    input  wire        oe,         // Output enable (when 1, outputs drive; when 0, Z)
    output wire [7:0]  bus         // Tri-state bus
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
