/*-----------------------------------------------------------------------------
* INTEGRATOR_FWD_tb.v
*
* Test bench for INTEGRATOR_FWD.v
*
* Version: 1.03
* Author : AUDIY
* Date   : 2025/03/07
* 
* License under CERN-OHL-P v2
--------------------------------------------------------------------------------
| Copyright AUDIY 2024 - 2025.                                                 |
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

module INTEGRATOR_FWD_tb ();

    timeunit 1ns/1ps;

    localparam int LENGTH    = 5;
    localparam bit INPUT_REG = 1'b1;

    localparam int cnt_width = 12;

    bit                       CLK_I     = 1'b0;
    bit signed [LENGTH - 1:0] DATA_I    = {(LENGTH){1'b1}};
    bit                       ARESETN_I = 1'b1;
    
    bit unsigned [cnt_width - 1:0] CLK_COUNT = '0;

    logic signed [LENGTH - 1:0] DATA_O;
    logic                       OFDET_O;
    logic                       UFDET_O;

    // Assertion 1: all outputs must be 0 within 1 CLK_I cycle after ARESETN_I is asserted (0).
    property outputs_zero;
        @(posedge CLK_I)
            (DATA_O == '0) && (OFDET_O == '0) && (UFDET_O == '0);
    endproperty
    
    a_01: assert property (@(negedge ARESETN_I) 1'b1 |=> outputs_zero);

    // Assertion 2: DATA_O must be satulated when OFDET_O is asserted.
    a_02: assert property (@(posedge CLK_I) OFDET_O |-> (DATA_O == {1'b0, {(LENGTH - 1){1'b1}}}));

    // Assertion 3: DATA_O must be satulated when UFDET_O is asserted.
    a_03: assert property (@(posedge CLK_I) UFDET_O |-> (DATA_O == {1'b1, {(LENGTH - 1){1'b0}}}));

    // Assertion 4: OFDET_O & UFDET_O must NOT be asserted simultaneously.
    a_04: assert property (@(posedge CLK_I) !(OFDET_O & UFDET_O));

    INTEGRATOR_FWD #(
        .LENGTH   (LENGTH   ),
        .INPUT_REG(INPUT_REG)
    ) u0 (
        .CLK_I    (CLK_I    ),
        .DATA_I   (DATA_I   ),
        .ARESETN_I(ARESETN_I),
        .DATA_O   (DATA_O   ),
        .OFDET_O  (OFDET_O  ),
        .UFDET_O  (UFDET_O  )
    );

    /* Clock Generation */
    initial begin
        forever begin
            #10 CLK_I = ~CLK_I;
        end
    end

    initial begin
        $dumpfile("./INTEGRATOR_FWD.vcd");
        $dumpvars(0, INTEGRATOR_FWD_tb);

        #100000 $finish(0);
    end

    initial begin
        /* Initial Reset */
        #1     ARESETN_I = 1'b0;
        #1     ARESETN_I = 1'b1;
        forever begin
            #12345 ARESETN_I = 1'b0;
            #1     ARESETN_I = 1'b1; 
        end
    end

    always_ff @( CLK_I ) begin
        CLK_COUNT <= CLK_COUNT + 1'b1;
        if (CLK_COUNT == 4000) begin
            CLK_COUNT <= '0;
            if (DATA_I == '1) begin
                DATA_I <= {{(LENGTH - 1){1'b0}}, 1'b1};
            end else if (DATA_I == {{(LENGTH - 1){1'b0}}, 1'b1}) begin
                DATA_I <= '1;
            end
        end
    end
    
endmodule

`default_nettype wire
