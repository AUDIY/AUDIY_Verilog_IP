/*-----------------------------------------------------------------------------
* PCM_I2S_MCLK_tb.v
*
* Testbench for PCM_I2S_MCLK.v
*
* Version: 0.10
* Author : AUDIY
* Date   : 2025/06/26
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

module PCM_I2S_MCLK_tb ();

    timeunit 1ns / 1ps;

    parameter MCLK_CYC = 2;

    localparam int DATA_WIDTH = 32;

    bit MCLK_I = 1'b0;
    bit BCLK_I;
    bit WCLK_I;
    bit signed [DATA_WIDTH - 1:0] PCML_I = '0;
    bit signed [DATA_WIDTH - 1:0] PCMR_I = '0;
    bit ARESETN_I = 1'b0;


    logic BCLK_O;
    logic LRCK_O;
    logic DATA_O;

    bit unsigned [9:0] MCLK_count = '0;
    bit signed [DATA_WIDTH - 1:0] PCM = '0;
    integer fp;
    integer rp;

    PCM_I2S_MCLK #(
        .DATA_WIDTH(DATA_WIDTH)
    ) u0 (
        .MCLK_I   (MCLK_I   ),
        .BCLK_I   (BCLK_I   ),
        .WCLK_I   (WCLK_I   ),
        .PCML_I   (PCML_I   ),
        .PCMR_I   (PCMR_I   ),
        .ARESETN_I(ARESETN_I),
        .BCLK_O   (BCLK_O   ),
        .LRCK_O   (LRCK_O   ),
        .DATA_O   (DATA_O   )
    );

    initial begin
        $dumpfile("PCM_I2S_MCLK.vcd");
        $dumpvars(0, PCM_I2S_MCLK_tb);

        if (fp != 0) begin
            $fclose(fp);
        end

        fp = $fopen("PCM_1kHz_44100fs_32bit.txt", "r");

        if (fp == 0) begin
            $fatal(0, "Error!: The file doesn't exist.");
        end

        #10000 $finish(0);
    end

    initial begin
        #1 ARESETN_I = 1'b0;
        #1 ARESETN_I = 1'b1;
    end

    /* MCLK generation */
    initial begin
        forever begin
            #(MCLK_CYC / 2) MCLK_I = ~MCLK_I;
        end
    end

    always @(posedge MCLK_I) begin
        MCLK_count <= MCLK_count + 1'b1;
    end

    /* BCLK & WCLK generation */
    assign BCLK_I = MCLK_count[2];
    assign WCLK_I = MCLK_count[8];

    always @(posedge WCLK_I) begin
        rp = $fscanf(fp, "%d\n", PCM);
    end

    /* PCM Data Input */
    always @(negedge WCLK_I) begin
        PCML_I <= PCM;
        PCMR_I <= ~PCM;
    end
    
endmodule

`default_nettype wire
