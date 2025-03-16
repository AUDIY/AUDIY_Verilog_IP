/*-----------------------------------------------------------------------------
* INTEGRATOR_BACK.v
*
* Back Eular Method Integrator (w/ Saturation) Module
*
* Transfer Function:
*      1             z
* ------------ or -------
*  1 - z^(-1)      z - 1 
*
* Version: 1.10
* Author : AUDIY
* Date   : 2025/03/16
* 
* Port
*   Input
*       CLK_I     : Data Clock Input
*       DATA_I    : Data Input (Width: DATA_BIT_WIDTH)
*       ARESETN_I : Synchronous Reset Input (Active LOW)
*
*   Output
*       DATA_O : Integrated Data Output
*       OFDET_O: Overflow Detection
*                1'b1: Overflow
*                1'b0: Valid (NOT Overflow)
*       UFDET_O: Underflow Detection
*                1'b1: Underflow
*                1'b0: Valid (NOT Underflow)
*
* Parameters
*   LENGTH   : Input Data Bit Width (Default: 32)
*   INPUT_REG: Input Register Enable (Default: 1'b1)
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

module INTEGRATOR_BACK #(
    /* Parameter Definition */
    parameter LENGTH    = 32,
    parameter INPUT_REG = 1'b1
)(
    /* Input Port Definition */
    input  wire                     CLK_I    ,
    input  wire signed [LENGTH-1:0] DATA_I   ,
    input  wire                     ARESETN_I,

    /* Output Port Definition */
    output wire signed [LENGTH-1:0] DATA_O ,
    output wire                     OFDET_O,
    output wire                     UFDET_O
);

    /* Internal wire/reg Definition */
    reg  signed [LENGTH-1:0] ODATA_reg = {(LENGTH){1'b0}};
    wire signed [LENGTH:0]   SUM_DATA;

    wire signed [LENGTH-1:0] DATA_wire;

    assign SUM_DATA = {DATA_wire[LENGTH-1], DATA_wire} + {ODATA_reg[LENGTH-1], ODATA_reg};

    generate
        if (INPUT_REG == 1'b1) begin: blk_ireg1
            reg signed [LENGTH - 1:0] DATAI_reg = {(LENGTH){1'b0}};

            always @(posedge CLK_I or negedge ARESETN_I ) begin
                if (ARESETN_I == 1'b0) begin
                    DATAI_reg <= {(LENGTH){1'b0}};
                end else begin
                    DATAI_reg <= DATA_I;
                end
            end

            assign DATA_wire = DATAI_reg;
        end else begin: blk_ireg0
            assign DATA_wire = DATA_I;
        end    
    endgenerate

    always @(posedge CLK_I or negedge ARESETN_I) begin
        if (ARESETN_I == 1'b0) begin
            /* Reset */
            ODATA_reg <= {(LENGTH){1'b0}};
        end else begin
            ODATA_reg <= DATA_O;
        end
    end

    /* Assign Output */
    assign {UFDET_O, OFDET_O, DATA_O} = assign_out(SUM_DATA);

    /* Saturation process */
    // Output: {UFDET_O, OFDET_O, DATA_O}
    function [LENGTH+1:0] assign_out;
        input [LENGTH:0] SUMDATA;
    begin
        case (SUMDATA[LENGTH:LENGTH-1])
            2'b01: begin
                // Overflow
                // Ex. 5'b01111 + 5'b00001 = 5'b01111 (6'b010000)
                assign_out = {1'b0, 1'b1, 1'b0, {(LENGTH-1){1'b1}}};
            end

            2'b10: begin
                // Underflow
                // Ex. 5'b10000 + 5'b11110 = 5'b10000 (6'b101111)
                assign_out = {1'b1, 1'b0, 1'b1, {(LENGTH-1){1'b0}}};
            end 

            default: begin
                // Normal Operation
                assign_out = {1'b0, 1'b0, SUMDATA[LENGTH], SUMDATA[LENGTH-2:0]};
            end 
        endcase
    end  
    endfunction

endmodule

`default_nettype wire
