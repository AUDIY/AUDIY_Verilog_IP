/*-----------------------------------------------------------------------------
* PCM_I2S_MCLK.v
*
* PCM to I2S converter synchronized w/ MCLK
*
* Version: 1.00
* Author : AUDIY
* Date   : 2025/06/29
*
* Port
*   Input
*       MCLK_I     : Master Clock Input
*       BCLK_I     : Bit Clock Input
*       WCLK_I     : PCM Word Clock
*       PCML_I     : PCM Left Data
*       PCMR_I     : PCM Right Data
*       ARESETN_I  : Asynchronous Reset (Active LOW)
*
*   Output
*       BCLK_O     : I2S BCLK
*       LRCK_O     : I2S LRCK
*       DATA_O     : I2S DATA
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

module PCM_I2S_MCLK #(
    parameter DATA_WIDTH = 32
) (
    input  wire                           MCLK_I   ,
    input  wire                           BCLK_I   , 
    input  wire                           WCLK_I   ,
    input  wire signed [DATA_WIDTH - 1:0] PCML_I   ,
    input  wire signed [DATA_WIDTH - 1:0] PCMR_I   ,
    input  wire                           ARESETN_I,
    output wire                           BCLK_O   ,
    output wire                           LRCK_O   ,
    output wire                           DATA_O
);

    localparam OUT_WIDTH = 32;

    /* Internal wire/reg */
    reg BCLKI_reg = 1'b0;
    reg BCLKO_reg = 1'b0;
    reg WCLKI_reg = 1'b0;
    reg WCLKO_reg = 1'b0;
    reg DATAO_reg = 1'b0;
    reg [(2 * OUT_WIDTH - 1):0] PCM_LR = {(2 * OUT_WIDTH){1'b0}};

    /* BCLK Edge detection */
    always @(posedge MCLK_I or negedge ARESETN_I) begin
        if (!ARESETN_I) begin
            BCLKI_reg <= 1'b0;
        end else begin
            BCLKI_reg <= BCLK_I;
        end
    end
    
    /* WCLK Edge detection */
    always @(posedge MCLK_I or negedge ARESETN_I) begin
        if (!ARESETN_I) begin
            WCLKI_reg <= 1'b0;
        end else begin
            if ({BCLKI_reg, BCLK_I} == 2'b01) begin
                WCLKI_reg <= WCLK_I;
            end
        end
    end

    /* PCM Buffering */
    always @(posedge MCLK_I or negedge ARESETN_I) begin
        if (!ARESETN_I) begin
            PCM_LR <= {(2 * OUT_WIDTH){1'b0}};
        end else begin
            if ({WCLKI_reg, WCLK_I} == 2'b01) begin
                PCM_LR <= {{PCML_I, {(OUT_WIDTH - DATA_WIDTH){1'b0}}}, {PCMR_I, {(OUT_WIDTH - DATA_WIDTH){1'b0}}}};
            end else if ({BCLKI_reg, BCLK_I} == 2'b01) begin
                PCM_LR <= {PCM_LR[(2 * OUT_WIDTH - 2):0], 1'b0};
            end
        end
    end

    /* WCLK_O generation */
    always @(posedge MCLK_I or negedge ARESETN_I) begin
        if (!ARESETN_I) begin
            WCLKO_reg <= 1'b0;
        end else begin
            if ({WCLKI_reg, WCLK_I} == 2'b01) begin
                WCLKO_reg <= 1'b0;
            end else if ({WCLKI_reg, WCLK_I} == 2'b10) begin
                WCLKO_reg <= 1'b1;
            end
        end
    end

    /* I2S Data output */
    always @(posedge MCLK_I or negedge ARESETN_I ) begin
        if (!ARESETN_I) begin
            DATAO_reg <= 1'b0;
        end else begin
            if ({BCLKI_reg, BCLK_I} == 2'b10) begin
                DATAO_reg <= PCM_LR[2 * OUT_WIDTH - 1];
            end
        end
    end

    /* BCLK_O generation */
    always @(posedge MCLK_I or negedge ARESETN_I ) begin
        if (!ARESETN_I) begin
            BCLKO_reg <= 1'b0;
        end else begin
            if ({BCLKI_reg, BCLK_I} == 2'b01) begin
                BCLKO_reg <= 1'b1;
            end else if ({BCLKI_reg, BCLK_I} == 2'b10) begin
                BCLKO_reg <= 1'b0;
            end 
        end
    end

    assign BCLK_O = BCLKO_reg;
    assign LRCK_O = WCLKO_reg;
    assign DATA_O = DATAO_reg;
    
endmodule

`default_nettype wire
