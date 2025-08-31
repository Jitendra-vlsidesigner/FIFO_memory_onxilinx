`timescale 1ns / 1ps

module Read_Pointer (
    output reg [4:0] rptr,
    output wire fifo_rd,
    input wire rd,
    input wire fifo_empty,
    input wire clk,
    input wire rst_n
);
    assign fifo_rd = (~fifo_empty) & rd;

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            rptr <= 5'b00000;
        end else if (fifo_rd) begin
            rptr <= rptr + 5'b00001;
        end
    end
endmodule
