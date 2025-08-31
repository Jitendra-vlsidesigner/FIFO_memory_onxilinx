`timescale 1ns / 1ps

module Write_Pointer (
    output reg [4:0] wptr,
    output wire fifo_we,
    input wire wr,
    input wire fifo_full,
    input wire clk,
    input wire rst_n
);
    assign fifo_we = (~fifo_full) & wr;

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            wptr <= 5'b00000;
        end else if (fifo_we) begin
            wptr <= wptr + 5'b00001;
        end
    end
endmodule