/*-----------------------------------------------------------------------------
* NRST_SYNCHRONIZER_tb.v
*
* Testbench for NRST_SYNCHRONIZER.sv
*
* Version: 1.00
* Author : AUDIY
* Date   : 2024/12/16
*
* License under CERN-OHL-P v2
--------------------------------------------------------------------------------
| Copyright AUDIY 2024.                                                        |
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
`timescale 1ns/1ps

module NRST_SYNCHRONIZER_tb ();

    localparam  STAGES = 3;

    reg CLK_I = 1'b0;
    reg NRST_I = 1'b1;
    wire NRST_O;

    NRST_SYNCHRONIZER #(
        .STAGES(STAGES)
    ) u0 (
        .CLK_I(CLK_I),
        .NRST_I(NRST_I),
        .NRST_O(NRST_O)
    );

    initial begin
        $dumpfile("NRST_SYNCHRONIZER.vcd");
        $dumpvars(0, NRST_SYNCHRONIZER_tb);

        #23 NRST_I = 1'b0;
        #14 NRST_I = 1'b1;

        #64 $finish();
    end

    always begin
        #2 CLK_I <= ~CLK_I;
    end
    
endmodule
