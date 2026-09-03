module _Data_Sampler
(
    input wire clk,       // Clock de 50kHz
    input wire rst,
    input wire Data,
    output reg CS,
    output reg StartConv, // Flag de controle de conversão
    output reg [7:0] sampler
);
    reg [7:0] countCtrl;  // Taxa de amostragem = 200Hz

    // Controle de tempo (Contador)
    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            countCtrl <= 8'd0;
            StartConv <= 1'b1; // Reset em nível alto
        end else begin
            // Se bate o tempo do período de 5ms, reseta o contador e habilita a conversão
            if (countCtrl == 8'd249) begin
                countCtrl <= 8'd0;
                StartConv <= 1'b0;
            end else begin
                // Quando a conversão terminar, desabilita a conversão
                if (countCtrl == 8'd13) begin
                    StartConv <= 1'b1;
                    countCtrl <= countCtrl + 8'd1;
                end else begin
                    countCtrl <= countCtrl + 8'd1;
                end
            end
        end
    end

    // MCP atualiza na borda de descida
    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            CS <= 1'b1;       // CS em nível alto desabilita conversor
            sampler <= 8'd0;  // Zera o registro de controle
        end else begin
            if (~StartConv) begin
                CS <= 1'b0;
                // Boa prática da indústria para Shift Registers (Concatenação)
                sampler <= {sampler[6:0], Data}; 
            end else begin
                CS <= 1'b1;
                // Após este ciclo, 'sampler' conterá os 8 bits mais significativos
            end
        end
    end
endmodule
