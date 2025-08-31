`timescale 1ns / 1ps

module Memory_Array (
    output wire [7:0] data_out,
    input wire [7:0] data_in,
    input wire clk,
    input wire fifo_we,
    input wire [4:0] wptr,
    input wire [4:0] rptr
);
    reg [7:0] memory [15:0];

    always @(posedge clk) begin
        if (fifo_we) begin
            memory[wptr[3:0]] <= data_in;
        end
    end

    assign data_out = memory[rptr[3:0]];
endmodule
