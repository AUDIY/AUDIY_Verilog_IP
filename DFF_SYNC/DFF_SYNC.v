/*-----------------------------------------------------------------------------
* DFF_SYNC.v
*
* DFF Synchronizer for asynchronous 1bit signal
*
* Version: 0.10
* Author : AUDIY
* Date   : 2026/04/19
*
* Port
*   Input
*       INCLK_I  : Input Clock Domain
*       DATA_I   : Input Data
*       OUTCLK_I : Output Clock Domain
*
*   Output
*       DATA_O   : Synchronized Data
*
* Parameter
*   OUT_STAGE : Output Synchronizer Stage
*
* License
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

module DFF_SYNC #(
    parameter OUT_STAGE = 2
) (
    input  wire INCLK_I,
    input  wire DATA_I,
    input  wire OUTCLK_I,
    output wire DATA_O
);
    
    localparam RIGHT_OUT_STAGE = (OUT_STAGE < 2) ? 2 : OUT_STAGE;

    reg                           INDATA  = 1'b0;
    reg [(RIGHT_OUT_STAGE - 1):0] OUTDATA = {(RIGHT_OUT_STAGE){1'b0}};

    always @(posedge INCLK_I) begin
        INDATA <= DATA_I;
    end

    always @(posedge OUTCLK_I) begin
        OUTDATA <= {OUTDATA[(RIGHT_OUT_STAGE - 2):0], INDATA};
    end

    assign DATA_O = OUTDATA[RIGHT_OUT_STAGE - 1];
    
endmodule

`default_nettype wire
