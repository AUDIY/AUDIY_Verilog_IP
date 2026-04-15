/*-----------------------------------------------------------------------------
* BIN2GRAY.v
*
* Binary to Gray code Encoder
*
* Version: 0.10
* Author : AUDIY
* Date   : 2026/04/12
*
* Port
*   Input
*       BIN_I: Binary Input
*
*   Output
*       GRAY_O: Gray code Output
*
* Parameter
*       BIN_WIDTH: Binary data width
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

module BIN2GRAY #(
    parameter BIN_WIDTH = 4
) (
    input  wire [(BIN_WIDTH-1):0] BIN_I,
    output wire [(BIN_WIDTH-1):0] GRAY_O
);

    assign GRAY_O = BIN_I ^ {1'b0, BIN_I[(BIN_WIDTH - 1):1]};
    
endmodule

`default_nettype wire
