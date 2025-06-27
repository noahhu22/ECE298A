module start_register (
    input  wire clk,
    input  wire rst_start,  
    input  wire ui[5],      
    output reg  start_out_reg  
);

    always @(posedge clk or posedge rst_start) begin
        if (rst_start)
            start_out_reg <= 1'b0;                    // clear
        else if (~start_out_reg)                      // inverted buffer path
            start_out_reg <= ui[5];                     // capture ui5 only while 0
    end

endmodule
