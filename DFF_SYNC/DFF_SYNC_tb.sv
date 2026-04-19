/*-----------------------------------------------------------------------------
* DFF_SYNC_tb.sv
*
* Testbench for DFF_SYNC.v
*
* Version: 0.10
* Author : AUDIY
* Date   : 2026/04/19
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

module DFF_SYNC_tb ();

    timeunit 1ns / 1ps;

    localparam INCLK_CYC = 4;
    localparam OUTCLK_CYC = 4;

    localparam OUT_STAGE = 2;

    reg  INCLK_I  = 1'b0;
    reg  DATA_I   = 1'b0;
    reg  OUTCLK_I = 1'b0;
    wire DATA_O;

    /* Instantiation */
    DFF_SYNC #(
        .OUT_STAGE(OUT_STAGE)
    ) dut (
        .INCLK_I (INCLK_I ),
        .DATA_I  (DATA_I  ),
        .OUTCLK_I(OUTCLK_I),
        .DATA_O  (DATA_O  )
    );

    initial begin
        assume (OUTCLK_CYC <= INCLK_CYC);

        $dumpfile("DFF_SYNC.vcd");
        $dumpvars(0, DFF_SYNC_tb);

        #1000 $finish;
    end

    /* Generate INCLK */
    initial begin
        forever begin
            #(INCLK_CYC / 2) INCLK_I = ~INCLK_I;
        end
    end

    /* Generate OUTCLK */
    initial begin
        #(INCLK_CYC / 4); // Phase delay between INCLK and OUTCLK
        forever begin
            #(OUTCLK_CYC / 2) OUTCLK_I = ~OUTCLK_I;
        end
    end

    /* Generate random DATA_I */
    always @(posedge INCLK_I) begin
        DATA_I <= $urandom_range(0, 1);
    end
    
endmodule

`default_nettype wire
