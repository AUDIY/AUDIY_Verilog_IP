/*-----------------------------------------------------------------------------
* I2S_PCM_BCLK_tb.v
* 
*   Testbench for I2S_PCM_BCLK.v
*
* Version: 0.01
* Author : AUDIY
* Date   : 2025/03/02
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

module I2S_PCM_BCLK_tb;

    timeunit 1ns/1ps;

    localparam int unsigned LENGTH    = 32;
    localparam bit          INPUT_REG = 1'b1;

    logic BCLK_I    = 1'b0;
    logic LRCK_I    = 1'b0;
    logic DATA_I;
    logic MUTEN_I   = 1'b1;
    logic ARESETN_I = 1'b1;

    logic               WCLK_O;
    logic signed [31:0] PCML_O;
    logic signed [31:0] PCMR_O;

    integer fp;
    integer rp;
    logic   data                       = 1'b0;
    logic   unsigned [5:0]  bclk_count = 6'b000000;
    logic   signed   [31:0] SINE       = 32'h0000_0000;
    logic   unsigned [63:0] DATAREG    = 64'h0000_0000_0000_0000;

    // Assertion 1: all outputs must be 0 within 1 BCLK_I cycle after ARESETN_I is asserted (0).
    property outputs_zero;
        @(posedge BCLK_I)
            (WCLK_O == '0) && (PCML_O == '0) && (PCMR_O == '0);
    endproperty
    
    a_01: assert property (@(negedge ARESETN_I) 1'b1 |=> outputs_zero);

    // Assertion 2: PCMx_O must be 0 when MUTEN_I is active (0) and negedge LRCK_I 
    property PCMx_zero;
        @(posedge WCLK_O)
            (PCML_O == '0) && (PCMR_O == '0);
    endproperty

    a_02: assert property (@(negedge LRCK_I) !MUTEN_I |=> PCMx_zero);

    I2S_PCM_BCLK #(
        .LENGTH   (LENGTH   ),
        .INPUT_REG(INPUT_REG)
    ) u0 (
        .BCLK_I   (BCLK_I   ),
        .LRCK_I   (LRCK_I   ),
        .DATA_I   (DATA_I   ),
        .MUTEN_I  (MUTEN_I  ),
        .ARESETN_I(ARESETN_I),
        .WCLK_O   (WCLK_O   ),
        .PCML_O   (PCML_O   ),
        .PCMR_O   (PCMR_O   )
    );

    initial begin
        $dumpfile("I2S_PCM_BCLK.vcd");
        $dumpvars(0, I2S_PCM_BCLK_tb);

        if (fp != 0) begin
            $fclose(fp);
        end

        fp = $fopen("PCM_1kHz_44100fs_32bit.txt", "r");

        if (fp == 0) begin
            $error("ERROR: The file doesn't exist.");
        end

        #1    ARESETN_I = 1'b0;
        #7    ARESETN_I = 1'b1;
        #2465 ARESETN_I = 1'b0;
        #4    ARESETN_I = 1'b1;

        #1000000 $finish(0);
    end

    initial begin
        #500000 MUTEN_I = 1'b0;
        #11000 MUTEN_I = 1'b1;
    end

    initial begin
        forever #2 begin
            BCLK_I = ~BCLK_I;
        end
    end

    always_ff @( negedge BCLK_I ) begin: genblk_lrckgen
        bclk_count <= bclk_count + 1'b1;
        LRCK_I     <= bclk_count[5];
        data       <= DATAREG[63];
        DATA_I     <= data;
    end

    always_ff @( posedge BCLK_I ) begin: genblk_preparedata
        if (bclk_count == 6'b000000) begin
            DATAREG <= {SINE, -SINE};
        end else begin
            DATAREG <= DATAREG << 1;
        end
    end

    always_ff @( negedge LRCK_I ) begin: genblk_readdata
        rp <= $fscanf(fp, "%d\n", SINE);
    end
    
endmodule

`default_nettype wire
