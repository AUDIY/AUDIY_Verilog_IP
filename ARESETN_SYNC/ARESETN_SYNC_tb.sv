/*-----------------------------------------------------------------------------
* ARESETN_SYNC_tb.v
*
* Testbench for ARESETN_SYNC.sv
*
* Version: 1.02
* Author : AUDIY
* Date   : 2025/03/23
*
* License under CERN-OHL-P v2
--------------------------------------------------------------------------------
| Copyright AUDIY 2024 - 2026.                                                 |
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

module ARESETN_SYNC_tb ();

    timeunit 1ns/1ps;

    localparam int STAGES = 3;

    bit   CLK_I     = 1'b0;
    bit   ARESETN_I = 1'b1;
    logic RESETN_O;

    property async_reset;
        @(posedge CLK_I)
            RESETN_O == 1'b0;
    endproperty

    /* Assertion 01: Asynchronous reset must be asserted immediately. */
    a_01: assert property (@(negedge ARESETN_I) 1'b1 |=> async_reset);

    /* Assertion 02: Output must be negated after > 1 clock cycle. */
    a_02: assert property (disable iff(~ARESETN_I) @(posedge CLK_I) ##[1:STAGES+1] RESETN_O);

    ARESETN_SYNC #(
        .STAGES(STAGES)
    ) u0 (
        .CLK_I    (CLK_I    ),
        .ARESETN_I(ARESETN_I),
        .RESETN_O (RESETN_O )
    );

    initial begin
        $dumpfile("ARESETN_SYNC.vcd");
        $dumpvars(0, ARESETN_SYNC_tb);

        #1  ARESETN_I = 1'b0;
        #1  ARESETN_I = 1'b1;
        #23 ARESETN_I = 1'b0;
        #14 ARESETN_I = 1'b1;

        #64 $finish();
    end

    /* Clock generation */
    initial begin
        forever begin
            #2 CLK_I <= ~CLK_I;
        end
    end
    
endmodule

`default_nettype wire

