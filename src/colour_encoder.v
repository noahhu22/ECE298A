// uo[0] = red, uo[1] = blue, uo[2] = yellow, uo[3] = green
// colour_enc_in[1:0] mapping: 00 = red, 01 = blue, 10 = yellow, 11 = green

module colour_encoder (
    input wire [1:0] colour_enc_in, 
    output  wire [3:0] uo   
);

    // colour[1] goes high for Yellow or Green
    assign uo[0] = ~colour_enc_in[0] & ~colour_enc_in[1];             // uo[0] = red    
    assign uo[1] = colour_enc_in[0] & ~colour_enc_in[1];              // uo[1] = blue
    assign uo[2] = ~colour_enc_in[0] & colour_enc_in[1];              // uo[2] = yellow
    assign uo[3] = colour_enc_in[0] & colour_enc_in[1];               // uo[3] = green

endmodule
