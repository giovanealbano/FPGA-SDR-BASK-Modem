module contador (
    input wire clk,
    input wire rst,
    input wire enable,
    output reg [7:0] contador,
    output wire overflow
);
    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            contador <= 8'b0;
        end else if (enable == 1'b1) begin
            contador <= contador + 1'b1;
        end
    end
    
    assign overflow = (contador == 8'd255 && enable == 1'b1) ? 1'b1 : 1'b0;
endmodule
