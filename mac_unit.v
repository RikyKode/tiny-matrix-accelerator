`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2026 10:42:48 PM
// Design Name: 
// Module Name: mac_unit
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


module mac_unit #(
parameter INPUT_WIDTH = 4,
    parameter ACC_WIDTH = 12
)
(
    input  wire clk,
    input  wire rst_n,
    input  wire clear,
    input  wire enable,

    input  wire signed [INPUT_WIDTH-1:0] a,
    input  wire signed [INPUT_WIDTH-1:0] b,

    output reg signed [ACC_WIDTH-1:0] acc_out
);

    /*
     * Two INPUT_WIDTH-bit operands produce a product that is
     * twice as wide.
     *
     * With INPUT_WIDTH = 4:
     * PRODUCT_WIDTH = 8
     */
    localparam PRODUCT_WIDTH = 2 * INPUT_WIDTH;

    /*
     * product holds the result of a × b.
     * It is combinational and signed.
     */
    wire signed [PRODUCT_WIDTH-1:0] product;

    /*
     * extended_product holds the same numerical value as product,
     * but widened to ACC_WIDTH bits.
     */
    wire signed [ACC_WIDTH-1:0] extended_product;

    /*
     * TODO 1: Signed multiplication
     *
     * Continuously assign product to a multiplied by b.
     *
     * Hint:
     * assign destination = expression;
     */

    // Write TODO 1 here.
    assign product = a*b;

    /*
     * TODO 2: Sign extension
     *
     * Expand product from PRODUCT_WIDTH bits to ACC_WIDTH bits.
     *
     * For positive values, fill the new upper bits with zero.
     * For negative values, fill them with one.
     *
     * The product's sign bit is:
     * product[PRODUCT_WIDTH-1]
     *
     * Number of extra bits:
     * ACC_WIDTH - PRODUCT_WIDTH
     *
     * General repetition syntax:
     * {NUMBER{BIT}}
     *
     * General concatenation syntax:
     * {upper_bits, lower_bits}
     */

    // Write TODO 2 here.

assign extended_product = {
{(ACC_WIDTH - PRODUCT_WIDTH){product[PRODUCT_WIDTH-1]}}, product
};
    /*
     * TODO 3: Sequential accumulator
     *
     * On every rising clock edge, use this priority:
     *
     * 1. rst_n == 0:
     *       Set acc_out to zero.
     *
     * 2. clear == 1:
     *       Set acc_out to zero.
     *
     * 3. enable == 1:
     *       acc_out becomes acc_out + extended_product.
     *
     * 4. Otherwise:
     *       acc_out retains its current value.
     *
     * Use:
     * always @(posedge clk)
     *
     * Use nonblocking assignment:
     * <=
     */

    // Write TODO 3 here.
always @(posedge clk) begin
    if (!rst_n) begin
        acc_out <= {ACC_WIDTH{1'b0}};
    end
    
    else if (clear) begin 
        acc_out <= {ACC_WIDTH{1'b0}};
    end
    else if (enable) begin
        acc_out <= acc_out + extended_product;
    end
end
    


endmodule

