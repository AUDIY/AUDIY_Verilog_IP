/*-----------------------------------------------------------------------------
* I2S_PCM_BCLK.v
* 
*   I2S to PCM converter module (Synchronous w/ BCLK)
*
* Version: 0.01
* Author : AUDIY
* Date   : 2025/03/02
*
* Port
*   Input
*       BCLK_I   : I2S Bit Clock (SCK) Input
*       LRCK_I   : I2S LR Clock (WS) Input
*       DATA_I   : I2S Data Input
*       MUTEN_I  : Mute Control Input (Active Low) 
*       ARESETN_I: Asynchronous Reset Input (Active Low)
*
*   Output
*       WCLK_O: Word Clock Output
*       PCML_O: PCM Left Data Output
*       PCMR_O: PCM Right Data Output
*
* Parameters
*   LENGTH   : PCM Data Length (Default: 32)
*   INPUT_REG: Input Register Enable (Default: 1'b1)
*
* License under CERN-OHL-P v2
--------------------------------------------------------------------------------
| Copyright AUDIY 2025.                                                        |
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

module I2S_PCM_BCLK #(
    parameter LENGTH    = 32,
    parameter INPUT_REG = 1'b1
) (
    input  wire                       BCLK_I   ,
    input  wire                       LRCK_I   ,
    input  wire                       DATA_I   ,
    input  wire                       MUTEN_I  ,
    input  wire                       ARESETN_I,
    output wire                       WCLK_O   ,
    output wire signed [LENGTH - 1:0] PCML_O   ,
    output wire signed [LENGTH - 1:0] PCMR_O
);

    /* Local parameters */
    localparam LSB_WIDTH = 32 - LENGTH;

    /* Internal wire/reg */
    wire                       LRCK_wire;
    wire                       DATA_wire;
    wire                       MUTEN_wire;
    reg                        muten_reg = 1'b0;
    reg                        lrck_reg  = 1'b0;
    reg         [63:0]         data_reg  = {64{1'b0}};
    reg  signed [31:0]         PCML_reg  = {32{1'b0}};
    reg  signed [31:0]         PCMR_reg  = {32{1'b0}};
    reg  signed [LENGTH - 1:0] PCMLO_reg = {(LENGTH){1'b0}};
    reg  signed [LENGTH - 1:0] PCMRO_reg = {(LENGTH){1'b0}};

    generate
        if (INPUT_REG == 1'b1) begin: genblk_ireg1
            /* w/ Input registers */
            reg LRCKI_reg  = 1'b0;
            reg DATAI_reg  = 1'b0;
            reg MUTENI_reg = 1'b0;

            always @(posedge BCLK_I or negedge ARESETN_I ) begin
                if (ARESETN_I == 1'b0) begin
                    LRCKI_reg  <= 1'b0;
                    DATAI_reg  <= 1'b0;
                    MUTENI_reg <= 1'b0;
                end else begin
                    LRCKI_reg  <= LRCK_I ;
                    DATAI_reg  <= DATA_I ;
                    MUTENI_reg <= MUTEN_I;
                end
            end

            assign LRCK_wire  = LRCKI_reg ;
            assign DATA_wire  = DATAI_reg ;
            assign MUTEN_wire = MUTENI_reg;

        end else begin: genblk_ireg0
            /* w/o Input registers */
            assign LRCK_wire  = LRCK_I ;
            assign DATA_wire  = DATA_I ;
            assign MUTEN_wire = MUTEN_I;

        end
    endgenerate

    /* Mute (Active Low) */
    always @(posedge BCLK_I or negedge ARESETN_I ) begin
        if (ARESETN_I == 1'b0) begin
            muten_reg <= 1'b0;
        end else begin
            muten_reg <= MUTEN_wire;
        end
    end

    /* LRCK & DATA */
    always @(posedge BCLK_I or negedge ARESETN_I ) begin
        if (ARESETN_I == 1'b0) begin
            lrck_reg  <= 1'b0;
            data_reg  <= {64{1'b0}};
        end else begin
            lrck_reg  <= LRCK_wire;
            data_reg  <= {data_reg[62:0], DATA_wire};
        end
    end

    /* 32bit data split */
    always @(posedge BCLK_I or negedge ARESETN_I ) begin
        if (ARESETN_I == 1'b0) begin
            PCML_reg  <= {32{1'b0}};
            PCMR_reg  <= {32{1'b0}};
        end else begin
            /* Negative edge of LRCK. */
            if (lrck_reg & ~LRCK_wire == 1'b1) begin
                if (muten_reg == 1'b0) begin
                    PCML_reg <= {32{1'b0}};
                    PCMR_reg <= {32{1'b0}};
                end else begin
                    PCML_reg <= data_reg[62:31];
                    PCMR_reg <= {data_reg[30:0], DATA_wire};
                end
            end
        end
    end

    /* 32bit to (LENGTH) bit data assign. */
    always @(posedge BCLK_I or negedge ARESETN_I ) begin
        if (ARESETN_I == 1'b0) begin
            PCMLO_reg <= {(LENGTH){1'b0}};
            PCMRO_reg <= {(LENGTH){1'b0}};
        end else begin
            /* Negative edge of LRCK. */
            if (lrck_reg & ~LRCK_wire == 1'b1) begin
                if (muten_reg == 1'b0) begin
                    PCMLO_reg <= {(LENGTH){1'b0}};
                    PCMRO_reg <= {(LENGTH){1'b0}};
                end else begin
                    PCMLO_reg <= PCML_reg[31:LSB_WIDTH];
                    PCMRO_reg <= PCMR_reg[31:LSB_WIDTH];
                end
            end
        end
    end

    /* Output assign */
    assign WCLK_O = lrck_reg;
    assign PCML_O = PCMLO_reg;
    assign PCMR_O = PCMRO_reg;
    
endmodule

`default_nettype wire
