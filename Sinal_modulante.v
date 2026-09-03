module Sinal_modulante (
    input wire clk,
    input wire rst,
    output wire pwm,
    output wire [7:0] debug_onda
);
    wire w_enable;
    wire [7:0] w_contador;
    wire w_overflow;
    wire [7:0] w_endereco;
    wire [7:0] w_dados;

    clk_div inst_divisor (
        .clk(clk),
        .rst(rst),
        .enable (w_enable)
    );

    contador inst_contador (
        .clk(clk),
        .rst (rst),
        .enable (w_enable),
        .contador (w_contador),
        .overflow(w_overflow)
    );

    contador_enderecos inst_contador_enderecos (
        .clk(clk),
        .rst(rst),
        .overflow(w_overflow),
        .endereco (w_endereco)
    );

    ROM inst_ROM (
        .clock(clk),
        .address(w_endereco),
        .q(w_dados)
    );

    comparador inst_comparador (
        .contador(w_contador),
        .dados(w_dados),
        .pwm(pwm)
    );
endmodule
