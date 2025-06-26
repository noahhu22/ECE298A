// remove dff module when merge w/ lfsr code, already defined there.
module dff(output reg q, input d, input clk, input en, input rst);
    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 1'b0;
        else if (en)
            q <= d;
    end
endmodule

// 32-bit Register Memory w/ async reset signal.
module 32b_Reg_Mem(
    input wire clk,
    input wire 32b_MEM_LOAD,
    input wire [7:0] 32b_MEM_IN,
    input wire rst_32b_MEM,
    input wire [1:0] 32b_MEM_LOAD_VAL, // which bits to load.
    output wire [31:0] 32b_MEM_OUT
);

@always (posedge clk)begin
    if(rst_32b_MEM)
        32b_MEM_OUT  <= 32'b00000000000000000000000000000000;
    else if(32b_MEM_LOAD_VAL == 2'b00 && 32b_MEM_LOAD)
        32b_MEM_OUT <= {32b_MEM_OUT[31:8], 32b_MEM_IN[7:0]}
    else if(32b_MEM_LOAD_VAL == 2'b01 && 32b_MEM_LOAD)
        32b_MEM_OUT <= {32b_MEM_OUT[31:16], 32b_MEM_IN[7:0], 32b_MEM_OUT[7:0]}
    else if(32b_MEM_LOAD_VAL == 2'b10 && 32b_MEM_LOAD)
        32b_MEM_OUT <= {32b_MEM_OUT[31:24], 32b_MEM_IN[7:0], 32b_MEM_OUT[15:0]}
    else if(32b_MEM_LOAD_VAL == 2'11 && 32b_MEM_LOAD)
        32b_MEM_OUT <= {32b_MEM_IN[7:0], 32b_MEM_OUT[23:0]}


endmodule