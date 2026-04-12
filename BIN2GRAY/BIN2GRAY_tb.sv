/*-----------------------------------------------------------------------------
* BIN2GRAY_tb.sv
*
* Testbench of BIN2GRAY.v
*
* Version: 0.10
* Author : AUDIY
* Date   : 2026/04/12
*
* License
--------------------------------------------------------------------------------
| Copyright AUDIY 2026.                                                        |
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

module BIN2GRAY_tb ();

    timeunit 1ns / 1ps;

    localparam CLK_CYCLE = 10;

    localparam               BIN_WIDTH = 4;
    localparam [BIN_WIDTH:0] ALL_COUNT = {(BIN_WIDTH + 1){1'b1}};

    reg CLK = 1'b1;

    reg  [(BIN_WIDTH - 1):0] BIN_I = '0;
    wire [(BIN_WIDTH - 1):0] GRAY_O; 

    reg  [BIN_WIDTH:0] COUNT = '0;

    BIN2GRAY #(
        .BIN_WIDTH(BIN_WIDTH)
    ) dut (
        .BIN_I (BIN_I ),
        .GRAY_O(GRAY_O)
    );

    initial begin
        $dumpfile("BIN2GRAY.vcd");
        $dumpvars(0, BIN2GRAY_tb);

        #(CLK_CYCLE * ALL_COUNT) $finish(0);
    end

    /* Clock Generation */
    initial begin
        forever begin
            #(CLK_CYCLE / 2) CLK = ~CLK;
        end
    end

    /* Binary Generation and Cloc Count */
    always @(posedge CLK) begin
        BIN_I <= BIN_I + 1'b1;
        COUNT <= COUNT + 1'b1;
    end

    `ifdef SVA
        // Assertion 1: Gray code must be changed only 1 bit.
        sva_change_onehot: assert property (
            @(posedge CLK) (COUNT > 0) |-> $onehot(GRAY_O ^ $past(GRAY_O))
        );
    `endif /* SVA */
    
endmodule

`default_nettype wire
