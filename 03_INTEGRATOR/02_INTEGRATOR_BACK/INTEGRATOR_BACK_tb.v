/*-----------------------------------------------------------------------------
* INTEGRATOR_BACK_tb.v
*
* Test bench for INTEGRATOR_BACK.v
*
* Version: 1.02
* Author : AUDIY
* Date   : 2024/05/03
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
`timescale 1ns/1ps

module INTEGRATOR_BACK_tb ();
    
    localparam DATA_BIT_WIDTH = 5;

    wire MCLK_I;
    wire CLK_I ;
    reg  signed [DATA_BIT_WIDTH-1:0] DATA_I = {(DATA_BIT_WIDTH){1'b0}};
    reg  NRST_I = 1'b1;

    reg [5:0] CLK_REG = 6'b000000;

    wire                             CLK_O  ;
    wire signed [DATA_BIT_WIDTH-1:0] DATA_O ;
    wire                             OFDET_O;
    wire                             UFDET_O;

    INTEGRATOR_BACK #(
        .DATA_BIT_WIDTH(DATA_BIT_WIDTH)
    ) u0 (
        .MCLK_I (MCLK_I ),
        .CLK_I  (CLK_I  ),
        .DATA_I (DATA_I ),
        .NRST_I (NRST_I ),
        .CLK_O  (CLK_O  ),
        .DATA_O (DATA_O ),
        .OFDET_O(OFDET_O),
        .UFDET_O(UFDET_O)
    );

    initial begin
        $dumpfile("INTEGRATOR_BACK_tb.vcd");
        $dumpvars(0, INTEGRATOR_BACK_tb);

        #100000 $finish;
    end

    always begin
        #1 CLK_REG <= CLK_REG + 1'b1;
    end

    always begin
        // Decrement
        #4096 DATA_I <= {(DATA_BIT_WIDTH){1'b1}};

        // Increment
        #4096 DATA_I <= {{(DATA_BIT_WIDTH-1){1'b0}}, 1'b1};
    end

    always begin
        #30000 NRST_I <= 1'b0;
        #20    NRST_I <= 1'b1;
    end

    assign MCLK_I = CLK_REG[0];
    assign CLK_I = CLK_REG[5];

endmodule
