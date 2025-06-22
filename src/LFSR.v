module LFSR_OLD (
    input [6:0] LFSR_SEED, // Load value
    input clk,
    input rst,
    input enable,
    output [6:0] LFSR_OUT,
    output complete_LFSR
);

    // reg [6:0] LFSR_out_next = 7'b0; // Next value to be assigned
    // reg complete_LFSR_reg = 1'b0; // Register to hold completion status
    // reg [3:0] count = 4'b0; // Counter to track the number of cycles

    reg [6:0] LFSR_out_next; // Next value to be assigned
    reg complete_LFSR_reg; // Register to hold completion status
    reg [3:0] count; // Counter to track the number of cycles


    always @(posedge clk or posedge rst) begin
        if (rst) begin
            LFSR_out_next <= LFSR_SEED; // Load the seed value on reset
            complete_LFSR_reg <= 1'b0; // Reset completion status
            count <= 4'b0; // Reset the cycle counter
        end else if (enable && !complete_LFSR_reg) begin
            // If all zeros, reload the seed
            if (LFSR_out_next == 7'b0000000) begin
                LFSR_out_next <= LFSR_SEED;
                complete_LFSR_reg <= 1'b0;
                count <= 4'b0;
            end else begin
                // 7-bit LFSR with taps at bits 7 and 6 (primitive polynomial x^7 + x^6 + 1)
                LFSR_out_next <= {LFSR_out_next[5:0], LFSR_out_next[6] ^ LFSR_out_next[5]};
                    if (count < 6)
                        count <= count + 1;
                    else
                        complete_LFSR_reg <= 1;
            end
        end
        // else: hold value (do nothing)
    end

    assign LFSR_OUT = LFSR_out_next;
    assign complete_LFSR = complete_LFSR_reg;

endmodule