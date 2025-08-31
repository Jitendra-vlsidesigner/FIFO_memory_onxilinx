`timescale 1ns / 1ps

module Status_Signal (
    output reg fifo_full,
    output reg fifo_empty,
    output reg fifo_threshold,
    output reg fifo_overflow,
    output reg fifo_underflow,
    input wire wr,
    input wire rd,
    input wire fifo_we,
    input wire fifo_rd,
    input wire [4:0] wptr,
    input wire [4:0] rptr,
    input wire clk,
    input wire rst_n
);
    wire fbit_comp;
    wire pointer_equal;
    wire overflow_set;
    wire underflow_set;
    wire [4:0] pointer_result;

    assign fbit_comp = wptr[4] ^ rptr[4];
    assign pointer_equal = (wptr[3:0] == rptr[3:0]);
    assign pointer_result = wptr - rptr;
    assign overflow_set = fifo_full & wr;
    assign underflow_set = fifo_empty & rd;

    always @(*) begin
        fifo_full = fbit_comp & pointer_equal;
        fifo_empty = (~fbit_comp) & pointer_equal;
        fifo_threshold = (pointer_result[4] || pointer_result[3]);
    end

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            fifo_overflow <= 0;
        end else if (overflow_set && !fifo_rd) begin
            fifo_overflow <= 1;
        end else if (fifo_rd) begin
            fifo_overflow <= 0;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            fifo_underflow <= 0;
        end else if (underflow_set && !fifo_we) begin
            fifo_underflow <= 1;
        end else if (fifo_we) begin
            fifo_underflow <= 0;
        end
    end
endmodule