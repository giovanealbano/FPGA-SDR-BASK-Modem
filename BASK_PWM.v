module _BASK_PWM
(
    input wire clk100khz,
    input wire clk1_6khz,
    input wire rst,
    input wire [7:0] sampler,
    input wire Allow,
    output wire BASK
);
    reg [7:0] tmp; 
    reg [7:0] tmp2;
    reg [3:0] ctrl;
    reg T;

    // Modulação AND para geração do sinal
    assign BASK = clk100khz & tmp2[7];

    always @(posedge Allow or negedge rst) begin
        if (~rst) begin
            tmp <= 8'd0;
            T   <= 1'b0;
        end else begin
            tmp <= sampler;
            T   <= 1'b1;
        end
    end

    // Desloca o registro 8 vezes, depois atualiza o valor e repete
    always @(posedge clk1_6khz or negedge rst) begin
        if (~rst) begin
            ctrl <= 4'd0;
            tmp2 <= 8'd0;
        end else if (T) begin
            if (ctrl <= 4'd6) begin
                tmp2 <= {tmp2[6:0], 1'b0}; // Shift lógico para a esquerda
                ctrl <= ctrl + 4'd1;
            end else begin
                tmp2 <= tmp;
                ctrl <= 4'd0;
            end
        end
    end
endmodule
