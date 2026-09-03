module comparador (
    input wire [7:0] contador,
    input wire [7:0] dados,
    output wire pwm
);
    assign pwm = (dados > contador) ? 1'b1 : 1'b0;
endmodule
