module IDLE_STATE(
    input wire clk,
    input wire en_IDLE,
    input wire rst_IDLE,
    input wire complete_LFSR,
    input wire [6:0] LFSR_output,
    output wire en_LFSR,
    output wire [6:0] 32b_MEM_IN,
    output wire 32b_MEM_LOAD,
    output wire complete_IDLE
    output wire 32b_MEM_LOAD_VAL
)

wire [1:0] count = 2'b00; 

always @(posedge clk)begin
    if(rst_IDLE)
        en_LFSR <= 1'b0;
        32b_MEM_IN <= 32'b0;
        32b_MEM_LOAD <= 1'b0;
        complete_IDLE <= 1'b0;
        count <= 2'b00;
    else if(en_IDLE) 
        if(complete_LFSR && ~32b_MEM_LOAD) // lfsr is done shifting (ie valid value on lfsr output), and has not been loaded to mem.
            begin
                en_LFSR <= 1'b0; // disable LFSR to stop further shifting
                32b_MEM_IN <= LFSR_output; // load the lfsr output into the mem
                32b_MEM_LOAD_VAL <= count; // set the load value to current count
                32b_MEM_LOAD <= 1'b1; // enable mem load
            end
        else if(32b_MEM_LOAD) begin
            // may need to reset lfsr counter ??
            en_LFSR <= 1'b1; // reenable lfsr 
            32b_MEM_LOAD <= 1'b0; // reset mem load signal
            if(count == 2'b00) count <= 2'b01; // increment count
            else if(count == 2'b01) count <= 2'b10; // increment count
            else if(count == 2'b10) count <= 2'b11; // increment count
            else if(count == 2'b11) begin
                complete_IDLE <= 1'b1; // set complete signal when all bits loaded
                count <= 2'b00; // reset count for next cycle
            end else begin
                complete_IDLE <= 1'b0; // reset complete signal if not done
        end
        else begin
            en_LFSR <= 1'b1; // keep LFSR enabled for next cycle
        end

            

endmodule