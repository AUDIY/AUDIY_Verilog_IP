/*-----------------------------------------------------------------------------
* DFF_SYNC.v
*
* D-FF Synchronizer for asynchronous signal
*
* Version: 0.20
* Author : AUDIY
* Date   : 2026/04/26
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
*   BIT_WIDTH : Input/Output Data Bit Width.
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
    parameter BIT_WIDTH = 4,
    parameter OUT_STAGE = 2
) (
    input  wire                     INCLK_I,
    input  wire [(BIT_WIDTH - 1):0] DATA_I,
    input  wire                     OUTCLK_I,
    output wire [(BIT_WIDTH - 1):0] DATA_O
);
    
    localparam RIGHT_OUT_STAGE = (OUT_STAGE < 2) ? 2 : OUT_STAGE;

    reg [(BIT_WIDTH - 1):0] INDATA = {(BIT_WIDTH){1'b0}};
    reg [(BIT_WIDTH - 1):0] OUTDATA [(RIGHT_OUT_STAGE - 1):0];

    integer i;
    integer j;

    initial begin
        for (i = 0; i < RIGHT_OUT_STAGE; i = i + 1) begin
            OUTDATA[i] = {(BIT_WIDTH){1'b0}};
        end
    end

    /* Input Clock Domain */
    always @(posedge INCLK_I) begin
        INDATA <= DATA_I;
    end

    /* Output Clock Domain (2 or more D-FF synchronize) */
    always @(posedge OUTCLK_I) begin
        OUTDATA[0] <= INDATA;

        for (j = 1; j < RIGHT_OUT_STAGE; j = j + 1) begin
            OUTDATA[j] <= OUTDATA[j - 1];
        end
    end

    assign DATA_O = OUTDATA[RIGHT_OUT_STAGE - 1];
    
endmodule

`default_nettype wire
