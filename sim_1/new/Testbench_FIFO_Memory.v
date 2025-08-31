`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.08.2024 16:42:41
// Design Name: 
// Module Name: Testbench_FIFO_Memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Testbench_FIFO_Memory;
    reg clk;
    reg rst_n;
    reg wr;
    reg rd;
    reg [7:0] data_in;
    wire [7:0] data_out;
    wire fifo_empty;
    wire fifo_full;
    wire fifo_threshold;
    wire fifo_overflow;
    wire fifo_underflow;

    FIFO_Memory uut (
        .clk(clk),
        .rst_n(rst_n),
        .wr(wr),
        .rd(rd),
        .data_in(data_in),
        .data_out(data_out),
        .fifo_full(fifo_full),
        .fifo_empty(fifo_empty),
        .fifo_threshold(fifo_threshold),
        .fifo_overflow(fifo_overflow),
        .fifo_underflow(fifo_underflow)
    );
    initial clk=0;
        always #5 clk = ~clk;

    initial begin
        // Initial conditions
        rst_n = 0;
        wr = 0;
        rd = 0;
        data_in = 8'd0;

        // Reset the FIFO
        #10 rst_n = 1;
        #10 rst_n = 0;
        #10 rst_n = 1;

        // Write data into FIFO
        for (integer i = 0; i < 17; i = i + 1) begin
            #10 wr = 1;
            data_in = data_in + 1;
            #10 wr = 0;
        end

        // Read data from FIFO
        for (integer i = 0; i < 17; i = i + 1) begin
            #10 rd = 1;
            #10 rd = 0;
        end

        #10 $stop;
    end

    // Monitor FIFO status and data
    initial begin
        $monitor("TIME = %t | wr = %b | rd = %b | data_in = %h | data_out = %h | full = %b | empty = %b | overflow = %b | underflow = %b",
                 $time, wr, rd, data_in, data_out, fifo_full, fifo_empty, fifo_overflow, fifo_underflow);
    end
endmodule
