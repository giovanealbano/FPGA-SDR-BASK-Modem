module contador_enderecos (
    input wire clk,
    input wire rst,
    input wire overflow,
    output reg [7:0] endereco
);
    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            endereco <= 8'd0;
        end else if (overflow == 1'b1) begin
            endereco <= endereco + 8'd1;
        end
    end
endmodule
