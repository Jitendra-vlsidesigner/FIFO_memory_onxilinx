`timescale 1ns / 1ps

// FIFO Memory with 16 stages and 8-bit data width
// Includes status signals for Full, Empty, Overflow, Underflow, and Threshold

// Top-level FIFO module
module FIFO_Memory (
    input wire clk,
    input wire rst_n,
    input wire wr,
    input wire rd,
    input wire [7:0] data_in,
    output wire [7:0] data_out,
    output wire fifo_full,
    output wire fifo_empty,
    output wire fifo_threshold,
    output wire fifo_overflow,
    output wire fifo_underflow
);
    wire [4:0] wptr, rptr;
    wire fifo_we, fifo_rd;

    // Instantiate submodules
    Write_Pointer wp (
        .wptr(wptr),
        .fifo_we(fifo_we),
        .wr(wr),
        .fifo_full(fifo_full),
        .clk(clk),
        .rst_n(rst_n)
    );

    Read_Pointer rp (
        .rptr(rptr),
        .fifo_rd(fifo_rd),
        .rd(rd),
        .fifo_empty(fifo_empty),
        .clk(clk),
        .rst_n(rst_n)
    );

    Memory_Array ma (
        .data_out(data_out),
        .data_in(data_in),
        .clk(clk),
        .fifo_we(fifo_we),
        .wptr(wptr),
        .rptr(rptr)
    );

    Status_Signal ss (
        .fifo_full(fifo_full),
        .fifo_empty(fifo_empty),
        .fifo_threshold(fifo_threshold),
        .fifo_overflow(fifo_overflow),
        .fifo_underflow(fifo_underflow),
        .wr(wr),
        .rd(rd),
        .fifo_we(fifo_we),
        .fifo_rd(fifo_rd),
        .wptr(wptr),
        .rptr(rptr),
        .clk(clk),
        .rst_n(rst_n)
    );
endmodule