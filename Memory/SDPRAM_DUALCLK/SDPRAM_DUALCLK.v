/*----------------------------------------------------------------------------
* SDPRAM_DUALCLK.v
*
* Simple Dual-Port RAM (Dual Clock)
*
* Version: 0.10
* Author : AUDIY
* Date   : 2026/04/12
*
* Port
*   Input
*       WCLK_I    : RAM Write Clock Input
*       WADDR_I   : Write Address Input
*       WENABLE_I : Write Enable Input
*       WDATA_I   : Stored Data Input
*       RCLK_I    : RAM Read Clock Input
*       RADDR_I   : Read Address Input
*       RENABLE_I : Read Enable Input
*
*   Output
*       RDATA_O      : Stored Data Output
*
*   Parameter
*       DATA_WIDTH   : DATA Bit Width
*       ADDR_WIDTH   : ROM Address Width
*       RAM_INIT_FILE: RAM Initialization File
*
* License under CERN-OHL-P v2
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

module SDPRAM_DUALCLK #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 6,
    parameter RAM_INIT_FILE = ""
) (
    input  wire                      WCLK_I,
    input  wire                      WENABLE_I,
    input  wire [(ADDR_WIDTH - 1):0] WADDR_I,
    input  wire [(DATA_WIDTH - 1):0] WDATA_I,
    input  wire                      RCLK_I,
    input  wire                      RENABLE_I,
    input  wire [(ADDR_WIDTH - 1):0] RADDR_I,
    output wire [(DATA_WIDTH - 1):0] RDATA_O
);

    reg [(DATA_WIDTH - 1):0] RAM [(2**ADDR_WIDTH - 1):0];
    reg [(DATA_WIDTH - 1):0] RDDATA_REG = {(DATA_WIDTH){1'b0}};

    /* Memory Initialization */
    initial begin
        if (RAM_INIT_FILE != "") begin
            $readmemh(RAM_INIT_FILE, RAM);
        end
    end

    /* Write operation */
    always @(posedge WCLK_I) begin
        if (WENABLE_I == 1'b1) begin
            RAM[WADDR_I] <= WDATA_I;
        end
    end

    /* Read operation */
    always @(posedge RCLK_I) begin
        if (RENABLE_I == 1'b1) begin
            RDDATA_REG <= RAM[RADDR_I];
        end
    end

    assign RDATA_O = RDDATA_REG;
    
endmodule

`default_nettype wire
