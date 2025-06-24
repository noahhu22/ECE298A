module IDLE_STATE(
    input wire clk,
    input wire en_IDLE,
    input wire rst_IDLE,
    input wire complete_LFSR,
    input wire [6:0] LFSR_output,
    output wire en_LFSR,
    output wire [31:0] 32b_MEM_IN,
    output wire 32b_MEM_LOAD,
    output wire complete_IDLE
)

always @(posedge clk or posedge rst_IDLE)begin
    if(rst)
        en_LFSR <= 1'b0;
        32b_MEM_IN <= 32'b0;
        32b_MEM_LOAD <= 1'b0;
        complete_IDLE <= 1'b0;
    else if(en_IDLE) 
        if(complete_LFSR && ~32b_MEM_LOAD)
            // en_LFSR <= 1'b0;
            // 32b_MEM_IN <= {25'b0, LFSR_output};
            // 32b_MEM_LOAD <= 1'b1;
            // complete_IDLE <= 1'b1;

endmodule