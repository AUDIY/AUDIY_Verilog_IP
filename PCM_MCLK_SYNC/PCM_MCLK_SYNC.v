/*-----------------------------------------------------------------------------
* PCM_MCLK_SYNC.v
*
* PCM Data Synchronizer w/ MCLK.
*
* Version: 1.00
* Author : AUDIY
* Date   : 2025/06/26
*
* Port
*   Input
*       MCLK_I     : Master Clock Input
*       WCLK_I     : PCM Word Clock
*       PCML_I     : PCM Left Data
*       PCMR_I     : PCM Right Data
*       ARESETN_I  : Asynchronous Reset (Active LOW)
*
*   Output
*       WCLK_O     : Synchronized Word Clock
*       PCML_O     : Synchronized PCM Left Data
*       PCMR_O     : Synchronized PCM Right Data
*
* Parameter
*       DATA_WIDTH : Data width (Default: 32)
*
* License
--------------------------------------------------------------------------------
| Copyright AUDIY 2025.                                                        |
|                                                                              |
| This source describes Open Hardware and is licensed under the CERN-OHL-W v2. |
|                                                                              |
| You may redistribute and modify this source and make products using it under |
| the terms of the CERN-OHL-W v2 (https:/cern.ch/cern-ohl).                    |
|                                                                              |
| This source is distributed WITHOUT ANY EXPRESS OR IMPLIED WARRANTY,          |
| INCLUDING OF MERCHANTABILITY, SATISFACTORY QUALITY AND FITNESS FOR A         |
| PARTICULAR PURPOSE. Please see the CERN-OHL-W v2 for applicable conditions.  |
|                                                                              |
| Source location: https://github.com/AUDIY/FIR_x2                             |
|                                                                              |
| As per CERN-OHL-W v2 section 4.1, should You produce hardware based on these |
| sources, You must maintain the Source Location visible on the external case  |
| of the FIR_x2 or other products you make using this source.                  |
--------------------------------------------------------------------------------
*
-----------------------------------------------------------------------------*/
`default_nettype none

module PCM_MCLK_SYNC #(
    parameter DATA_WIDTH = 32
) (
    input  wire                  MCLK_I,
    input  wire                  WCLK_I,
    input  wire [DATA_WIDTH-1:0] PCML_I,
    input  wire [DATA_WIDTH-1:0] PCMR_I,
    input  wire                  ARESETN_I,
    output wire                  WCLK_O,
    output wire [DATA_WIDTH-1:0] PCML_O,
    output wire [DATA_WIDTH-1:0] PCMR_O
);
    /* Internal wire/reg */
    reg [2:0] WCLK_reg = 3'b000;

    reg [DATA_WIDTH-1:0] PCML_reg  = {(DATA_WIDTH){1'b0}};
    reg [DATA_WIDTH-1:0] PCMR_reg  = {(DATA_WIDTH){1'b0}};
    reg                  WCLKO_reg = 1'b0;

    /* WCLK Synchronization & Edge detection */
    always @(posedge MCLK_I or negedge ARESETN_I) begin
        if (!ARESETN_I) begin
            WCLK_reg <= 3'b000;
        end else begin
            WCLK_reg <= {WCLK_reg[1:0], WCLK_I};
        end
    end

    /* PCM Synchronization */
    always @(posedge MCLK_I or negedge ARESETN_I) begin
        if (!ARESETN_I) begin
            PCML_reg <= {(DATA_WIDTH){1'b0}};
            PCMR_reg <= {(DATA_WIDTH){1'b0}};
        end else begin
            if (WCLK_reg[2:1] == 2'b01) begin
                PCML_reg <= PCML_I;
                PCMR_reg <= PCMR_I;
            end else begin
                PCML_reg <= PCML_reg;
                PCMR_reg <= PCMR_reg;
            end
        end
    end

    /* WCLK & PCM Phase Alignment */
    always @(posedge MCLK_I or negedge ARESETN_I) begin
        if (!ARESETN_I) begin
            WCLKO_reg <= 1'b0;
        end else begin
            if (WCLK_reg[2:1] == 2'b01) begin
                WCLKO_reg <= 1'b0;
            end else if (WCLK_reg[2:1] == 2'b10) begin
                WCLKO_reg <= 1'b1;
            end
        end
    end

    assign WCLK_O = WCLKO_reg;
    assign PCML_O = PCML_reg;
    assign PCMR_O = PCMR_reg;
    
endmodule

`default_nettype wire
