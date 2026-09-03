module clk_div (
    input wire clk,
    input wire rst,
    output reg enable
);
    reg [31:0] ciclos;
    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            ciclos <= 32'd0;
            enable <= 1'b0;
        end else if (ciclos >= 32'd762) begin
            enable <= 1'b1;
            ciclos <= 32'd0;
        end else begin
            enable <= 1'b0;
            ciclos <= ciclos + 32'd1;
        end
    end
endmodule
