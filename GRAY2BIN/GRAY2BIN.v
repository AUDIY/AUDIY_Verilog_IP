/*-----------------------------------------------------------------------------
* GRAY2BIN.v
*
* Gray code to Binary Decoder
*
* Version: 0.10
* Author : AUDIY
* Date   : 2026/04/12
*
* Port
*   Input
*       GRAY_I: Gray code Input
*
*   Output
*       BIN_O: Binary Output
*
* Parameter
*       GRAY_WIDTH: Gray code width
*
* License under CERN-OHL-P v2
--------------------------------------------------------------------------------
| Copyright AUDIY 2026.                                                        |
|                                                                              |
| This source describes Open Hardware and is licensed under the CERN-OHL-P v2. |
|                                                                              |
| You may redistribute and modify this source and make products using it under |
| the terms of the CERN-OHL-P v2 (https://cern.ch/cern-ohl).                   |
|                                                                              |
| This source is distributed WITHOUT ANY EXPRESS OR IMPLIED WARRANTY,          |
| INCLUDING OF MERCHANTABILITY, SATISFACTORY QUALITY AND FITNESS FOR A         |
| PARTICULAR PURPOSE. Please see the CERN-OHL-P v2 for applicable conditions.  |
--------------------------------------------------------------------------------
*
-----------------------------------------------------------------------------*/
`default_nettype none

module GRAY2BIN #(
    parameter GRAY_WIDTH = 4
) (
    input  wire [(GRAY_WIDTH - 1):0] GRAY_I,
    output wire [(GRAY_WIDTH - 1):0] BIN_O
);

    genvar i;

    assign BIN_O[GRAY_WIDTH - 1] = GRAY_I[GRAY_WIDTH - 1];

    generate
        for (i = (GRAY_WIDTH - 2); i >= 0; i = i - 1) begin
            assign BIN_O[i] = BIN_O[i + 1] ^ GRAY_I[i];
        end
    endgenerate
    
endmodule

`default_nettype wire
