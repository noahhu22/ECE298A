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

wire dff_en_0_7 = (32b_MEM_LOAD_VAL == 2'b00);
wire dff_en_8_15 = (32b_MEM_LOAD_VAL == 2'b01);
wire dff_en_16_23 = (32b_MEM_LOAD_VAL == 2'b10);
wire dff_en_24_31 = (32b_MEM_LOAD_VAL == 2'b11);

dff dff_0(.q(32b_MEM_OUT[0]), .d(32b_MEM_IN[0]), .clk(clk), .en(dff_en_0_7), .rst(rst_32b_MEM));
dff dff_1(.q(32b_MEM_OUT[1]), .d(32b_MEM_IN[1]), .clk(clk), .en(dff_en_0_7), .rst(rst_32b_MEM));
dff dff_2(.q(32b_MEM_OUT[2]), .d(32b_MEM_IN[2]), .clk(clk), .en(dff_en_0_7), .rst(rst_32b_MEM));
dff dff_3(.q(32b_MEM_OUT[3]), .d(32b_MEM_IN[3]), .clk(clk), .en(dff_en_0_7), .rst(rst_32b_MEM));
dff dff_4(.q(32b_MEM_OUT[4]), .d(32b_MEM_IN[4]), .clk(clk), .en(dff_en_0_7), .rst(rst_32b_MEM));
dff dff_5(.q(32b_MEM_OUT[5]), .d(32b_MEM_IN[5]), .clk(clk), .en(dff_en_0_7), .rst(rst_32b_MEM));
dff dff_6(.q(32b_MEM_OUT[6]), .d(32b_MEM_IN[6]), .clk(clk), .en(dff_en_0_7), .rst(rst_32b_MEM));
dff dff_7(.q(32b_MEM_OUT[7]), .d(32b_MEM_IN[7]), .clk(clk), .en(dff_en_0_7), .rst(rst_32b_MEM));
dff dff_8(.q(32b_MEM_OUT[0]), .d(32b_MEM_IN[8]), .clk(clk), .en(dff_en_8_15), .rst(rst_32b_MEM));
dff dff_9(.q(32b_MEM_OUT[1]), .d(32b_MEM_IN[9]), .clk(clk), .en(dff_en_8_15), .rst(rst_32b_MEM));
dff dff_10(.q(32b_MEM_OUT[2]), .d(32b_MEM_IN[10]), .clk(clk), .en(dff_en_8_15), .rst(rst_32b_MEM));
dff dff_11(.q(32b_MEM_OUT[3]), .d(32b_MEM_IN[11]), .clk(clk), .en(dff_en_8_15), .rst(rst_32b_MEM));
dff dff_12(.q(32b_MEM_OUT[4]), .d(32b_MEM_IN[12]), .clk(clk), .en(dff_en_8_15), .rst(rst_32b_MEM));
dff dff_13(.q(32b_MEM_OUT[5]), .d(32b_MEM_IN[13]), .clk(clk), .en(dff_en_8_15), .rst(rst_32b_MEM));
dff dff_14(.q(32b_MEM_OUT[6]), .d(32b_MEM_IN[14]), .clk(clk), .en(dff_en_8_15), .rst(rst_32b_MEM));
dff dff_15(.q(32b_MEM_OUT[7]), .d(32b_MEM_IN[15]), .clk(clk), .en(dff_en_8_15), .rst(rst_32b_MEM));
dff dff_16(.q(32b_MEM_OUT[0]), .d(32b_MEM_IN[16]), .clk(clk), .en(dff_en_16_23), .rst(rst_32b_MEM));
dff dff_17(.q(32b_MEM_OUT[1]), .d(32b_MEM_IN[17]), .clk(clk), .en(dff_en_16_23), .rst(rst_32b_MEM));
dff dff_18(.q(32b_MEM_OUT[2]), .d(32b_MEM_IN[18]), .clk(clk), .en(dff_en_16_23), .rst(rst_32b_MEM));
dff dff_19(.q(32b_MEM_OUT[3]), .d(32b_MEM_IN[19]), .clk(clk), .en(dff_en_16_23), .rst(rst_32b_MEM));
dff dff_20(.q(32b_MEM_OUT[4]), .d(32b_MEM_IN[20]), .clk(clk), .en(dff_en_16_23), .rst(rst_32b_MEM));
dff dff_21(.q(32b_MEM_OUT[5]), .d(32b_MEM_IN[21]), .clk(clk), .en(dff_en_16_23), .rst(rst_32b_MEM));
dff dff_22(.q(32b_MEM_OUT[6]), .d(32b_MEM_IN[22]), .clk(clk), .en(dff_en_16_23), .rst(rst_32b_MEM));
dff dff_23(.q(32b_MEM_OUT[7]), .d(32b_MEM_IN[23]), .clk(clk), .en(dff_en_16_23), .rst(rst_32b_MEM));
dff dff_24(.q(32b_MEM_OUT[0]), .d(32b_MEM_IN[24]), .clk(clk), .en(dff_en_24_31), .rst(rst_32b_MEM));
dff dff_25(.q(32b_MEM_OUT[1]), .d(32b_MEM_IN[25]), .clk(clk), .en(dff_en_24_31), .rst(rst_32b_MEM));
dff dff_26(.q(32b_MEM_OUT[2]), .d(32b_MEM_IN[26]), .clk(clk), .en(dff_en_24_31), .rst(rst_32b_MEM));
dff dff_27(.q(32b_MEM_OUT[3]), .d(32b_MEM_IN[27]), .clk(clk), .en(dff_en_24_31), .rst(rst_32b_MEM));
dff dff_28(.q(32b_MEM_OUT[4]), .d(32b_MEM_IN[28]), .clk(clk), .en(dff_en_24_31), .rst(rst_32b_MEM));
dff dff_29(.q(32b_MEM_OUT[5]), .d(32b_MEM_IN[29]), .clk(clk), .en(dff_en_24_31), .rst(rst_32b_MEM));
dff dff_30(.q(32b_MEM_OUT[6]), .d(32b_MEM_IN[30]), .clk(clk), .en(dff_en_24_31), .rst(rst_32b_MEM));
dff dff_31(.q(32b_MEM_OUT[7]), .d(32b_MEM_IN[31]), .clk(clk), .en(dff_en_24_31), .rst(rst_32b_MEM));

endmodule