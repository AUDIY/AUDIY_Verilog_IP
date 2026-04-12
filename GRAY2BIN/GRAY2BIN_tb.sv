/*-----------------------------------------------------------------------------
* GRAY2BIN_tb.sv
*
* Testbench of GRAY2BIN.v
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
| the terms of the CERN-OHL-P v2 (https://cern.ch/cern-ohl).                   |
|                                                                              |
| This source is distributed WITHOUT ANY EXPRESS OR IMPLIED WARRANTY,          |
| INCLUDING OF MERCHANTABILITY, SATISFACTORY QUALITY AND FITNESS FOR A         |
| PARTICULAR PURPOSE. Please see the CERN-OHL-P v2 for applicable conditions.  |
--------------------------------------------------------------------------------
*
-----------------------------------------------------------------------------*/
`default_nettype none

module GRAY2BIN_tb ();

    timeunit 1ns / 1ps;

    localparam CLK_CYCLE = 10;

    localparam               BIN_WIDTH  = 4;
    localparam               GRAY_WIDTH = BIN_WIDTH;
    localparam [BIN_WIDTH:0] ALL_COUNT  = {(BIN_WIDTH + 1){1'b1}};

    reg CLK = 1'b1;

    wire [(GRAY_WIDTH - 1):0] GRAY_I;
    wire [(BIN_WIDTH - 1):0] BIN_O; 

    reg  [(BIN_WIDTH - 1):0] BIN = '0;

    GRAY2BIN #(
        .GRAY_WIDTH(GRAY_WIDTH)
    ) dut (
        .GRAY_I(GRAY_I),
        .BIN_O (BIN_O )
    );

    initial begin
        $dumpfile("GRAY2BIN.vcd");
        $dumpvars(0, GRAY2BIN_tb);

        #(CLK_CYCLE * ALL_COUNT) $finish(0);
    end

    /* Clock Generation */
    initial begin
        forever begin
            #(CLK_CYCLE / 2) CLK = ~CLK;
        end
    end

    /* Gray Code Generation */
    always @(posedge CLK) begin
        BIN <= BIN + 1'b1;
    end
    
    assign GRAY_I = BIN ^ {1'b0, BIN[(BIN_WIDTH - 1):1]};

    `ifdef SVA
        // Assertion 1: Decoded binary must be equals to BIN
        sva_bin_comp: assert property (
            @(posedge CLK) (BIN_O == BIN)
        );
    `endif /* SVA */

endmodule

`default_nettype wire
