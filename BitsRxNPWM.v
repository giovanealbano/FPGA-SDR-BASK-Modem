module BitsRxNPWM
(
    input wire clk16,
    input wire clk204khz,
    input wire rst,
    input wire data,
    output reg out
);
    reg [9:0] temp;
    (*keep*) reg [9:0] DutyCycle;
    (*keep*) reg [9:0] PWM;
    reg [3:0] intcnt;
    reg Allow;

    // Coleta de bits
    always @(posedge clk16 or negedge rst) begin
        if (~rst) begin
            temp      <= 10'd0;
            intcnt    <= 4'd0;
            DutyCycle <= 10'd0;
            Allow     <= 1'b0;
        end else begin
            temp[9:2] <= {temp[8:2], data}; // Coleta de 8 bits
            intcnt    <= intcnt + 4'd1;
            
            if (intcnt == 4'd7) begin
                DutyCycle <= {temp[8:2], data, 2'b00}; // Zera bits menos significativos
                intcnt    <= 4'd0;
                Allow     <= 1'b1;
            end else begin
                Allow     <= 1'b0; // Garante que o Allow não fique alto indevidamente
            end
        end
    end

    // Gera o PWM com 200 amostras por segundo
    always @(posedge clk204khz or negedge rst) begin
        if (~rst) begin
            PWM <= 10'd0;
            out <= 1'b0;
        end else if (Allow) begin
            if (PWM <= DutyCycle) 
                out <= 1'b1;
            else 
                out <= 1'b0;
                
            PWM <= PWM + 10'd1;
            if (PWM >= 10'd1019) 
                PWM <= 10'd0;
        end
    end
endmodule
