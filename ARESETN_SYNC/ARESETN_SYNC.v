/*-----------------------------------------------------------------------------
* ARESETN_SYNC.v
*
* Asynchronous Reset (Active LOW) Synchronizer
*
* Version: 1.02
* Author : AUDIY
* Date   : 2025/03/23
* 
* Port
*   Input
*       CLK_I     : Data Clock Input
*       ARESETN_I : Asynchronous Reset Input (Active LOW)
*
*   Output
*       RESETN_O : Reset Output (Synchronized when it negated.)
*
* Parameters
*   STAGES: Synchronization Stage Length (Default: 2)
*
* License under CERN-OHL-P v2
--------------------------------------------------------------------------------
| Copyright AUDIY 2024 - 2025.                                                 |
|                                                                              |
| This source describes Open Hardware and is licensed under the CERN-OHL-P v2. |
|                                                                              |
| You may redistribute and modify this source and make products using it under |
| the terms of the CERN-OHL-P v2 (https:/cern.ch/cern-ohl).                    |
|                                                                              |
| This source is distributed WITHOUT ANY EXPRESS OR IMPLIED WARRANTY,          |
| INCLUDING OF MERCHANTABILITY, SATISFACTORY QUALITY AND FITNESS FOR A         |
| PARTICULAR PURPOSE. Please see the CERN-OHL-P v2 for applicable conditions.  |
--------------------------------------------------------------------------------
*
-----------------------------------------------------------------------------*/
`default_nettype none

module ARESETN_SYNC #(
    parameter STAGES = 2
) (
    input  wire CLK_I,
    input  wire ARESETN_I,
    output wire RESETN_O
);

    reg [STAGES - 1:0] RESETN_reg = {(STAGES){1'b0}};

    always @(posedge CLK_I or negedge ARESETN_I ) begin
        if (!ARESETN_I) begin
            /* When NRST_I is asserted, assert reset immediately */
            RESETN_reg <= {(STAGES){1'b0}};
        end else begin
            /* Negate reset synchronized with CLK_I */
            RESETN_reg <= {RESETN_reg[STAGES - 2:0], 1'b1};
        end
    end

    assign RESETN_O = RESETN_reg[STAGES - 1];
    
endmodule

`default_nettype wire
