// ui[0] = red, ui[1] = blue, ui[2] = yellow, ui[3] = green
// colour[1:0] mapping: 00 = red, 01 = blue, 10 = yellow, 11 = green

module colour_decoder (
    input wire [1:0] colour, 
    output  wire [3:0] ui   
);

    // colour[1] goes high for Yellow or Green
    assign ui[0] = ~colour[0] & ~colour[1];             // ui[0] = red    
    assign ui[1] = ~colour[0] & colour[1];              // ui[1] = blue
    assign ui[2] = colour[0] & ~colour[1];              // ui[2] = yellow
    assign ui[3] = colour[0] & colour[1];               // ui[3] = green

endmodule
