/*-----------------------------------------------------------------------------
* PCM_MCLK_SYNC_tb.v
*
* Testbench for PCM_MCLK_SYNC.v
*
* Version: 0.10
* Author : AUDIY
* Date   : 2025/06/22
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

module PCM_MCLK_SYNC_tb ();

    timeunit 1ns / 1ps;

    localparam int CYC = 1;
    localparam int MCLK_CYCLE = 4;
    localparam int BCLK_CYCLE = MCLK_CYCLE * 2;

    localparam int DATA_WIDTH = 32;

    bit MCLK_I = 1'b0;
    bit WCLK_I;
    bit [DATA_WIDTH - 1:0] PCML_I = '0;
    bit [DATA_WIDTH - 1:0] PCMR_I = '0;
    bit ARESETN_I;

    logic WCLK_O;
    logic [DATA_WIDTH - 1:0] PCML_O;
    logic [DATA_WIDTH - 1:0] PCMR_O;

    integer fp;
    integer rp;
    bit BCLK;
    bit MCLK;
    bit [5:0] BCLK_cnt = '0;
    bit [DATA_WIDTH - 1:0] PCM = '0;
    bit CLK;

    PCM_MCLK_SYNC #(
        .DATA_WIDTH(DATA_WIDTH)
    ) u0 (
        .MCLK_I   (MCLK_I   ),
        .WCLK_I   (WCLK_I   ),
        .PCML_I   (PCML_I   ),
        .PCMR_I   (PCMR_I   ),
        .ARESETN_I(ARESETN_I),
        .WCLK_O   (WCLK_O   ),
        .PCML_O   (PCML_O   ),
        .PCMR_O   (PCMR_O   )
    );

    initial begin
        $dumpfile("PCM_MCLK_SYNC.vcd");
        $dumpvars(0, PCM_MCLK_SYNC_tb);

        if (fp != 0) begin
            $fclose(fp);
        end

        fp = $fopen("PCM_1kHz_44100fs_32bit.txt", "r");

        if (fp == 0) begin
            $fatal(0, "The file doesn't exist!");
        end

        #100000 $finish(0);
    end

    /* BCLK generation */
    initial begin
        forever begin
            #(BCLK_CYCLE / 2) BCLK = ~BCLK;
        end
    end

    /* MCLK generation */
    initial begin
        forever begin
            #(MCLK_CYCLE / 2) MCLK = ~MCLK;
        end
    end

    initial begin
        forever begin
            #(CYC) CLK = ~CLK;
        end
    end

    always_ff @(posedge CLK) begin
        // Delay MCLK_I.
        MCLK_I <= MCLK;
    end

    /* WCLK_I generation */
    always_ff @(posedge BCLK) begin
        BCLK_cnt <= BCLK_cnt + 1'b1;
    end

    assign WCLK_I = BCLK_cnt[5];

    always_ff @(posedge WCLK_I) begin
        rp <= $fscanf(fp, "%d\n", PCM);
    end

    always_ff @(negedge WCLK_I) begin
        PCML_I <= PCM;
        PCMR_I <= ~PCM;
    end

    initial begin
        #1     ARESETN_I = 1'b0;
        #1     ARESETN_I = 1'b1;
        #32761 ARESETN_I = 1'b0;
        #5     ARESETN_I = 1'b1;
    end
    
endmodule

`default_nettype wire
