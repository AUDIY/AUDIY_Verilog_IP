/*----------------------------------------------------------------------------
* TDPRAM_DUALCLK.v
*
* True Dual-Port RAM (Dual Clock)
*
* Version: 0.01
* Author : AUDIY
* Date   : 2024/12/23
*
* Port
*   Input
*       CLKA_I : Clock Input for Port A
*       WENA_I : Write Enable Input for Port A
*       ADDRA_I: Address Input for Port A
*       DINA_I : Data Input for Port A
*       CLKB_I : Clock Input for Port B
*       WENB_I : Write Enable Input for Port B
*       ADDRB_I: Address Input for Port B
*       DINB_I : Data Input for Port B
*
*   Output
*       DOUTA_O: Data Output for Port A
*       DOUTB_O: Data Output for Port B
*
*   Parameter
*       DATA_WIDTH   : Data bit width
*       ADDR_WIDTH   : RAM Address width
*       WRITE_MODE_A : Read-during-Write Mode for Port A
*       WRITE_MODE_B : Read-during-Write Mode for Port B
*       OUTPUT_REG_A : Output Register Enable for Port A
*       OUTPUT_REG_B : Output Register Enable for Port B
*       RAM_INIT_FILE: RAM Initialization File Name
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

module TDPRAM_DUALCLK #(
    /* Parameter Definition */
    parameter DATA_WIDTH    = 8,
    parameter ADDR_WIDTH    = 9,
    parameter WRITE_MODE_A  = "READ_FIRST",
    parameter WRITE_MODE_B  = "READ_FIRST",
    parameter OUTPUT_REG_A  = "FALSE",
    parameter OUTPUT_REG_B  = "FALSE",
    parameter RAM_INIT_FILE = "RAMINIT.hex"
) (
    /* Port Definition */
    // Port A
    input  wire                  CLKA_I,
    input  wire                  WENA_I,
    input  wire [ADDR_WIDTH-1:0] ADDRA_I,
    input  wire [DATA_WIDTH-1:0] DINA_I,
    output wire [DATA_WIDTH-1:0] DOUTA_O,
    // Port B
    input  wire                  CLKB_I,
    input  wire                  WENB_I,
    input  wire [ADDR_WIDTH-1:0] ADDRB_I,
    input  wire [DATA_WIDTH-1:0] DINB_I,
    output wire [DATA_WIDTH-1:0] DOUTB_O
);
    /* Local Parameters */
    localparam DEPTH    =  2**ADDR_WIDTH   ;
    //localparam MAX_DATA = (1<<ADDR_WIDTH-1);

    /* Internal Wire/Register Definition */
    reg [DATA_WIDTH-1:0] RAM[DEPTH-1:0];

    reg [DATA_WIDTH-1:0] R_DOUTA_1P = {(DATA_WIDTH){1'b0}};
    reg [DATA_WIDTH-1:0] R_DOUTA_2P = {(DATA_WIDTH){1'b0}};

    reg [DATA_WIDTH-1:0] R_DOUTB_1P = {(DATA_WIDTH){1'b0}};
    reg [DATA_WIDTH-1:0] R_DOUTB_2P = {(DATA_WIDTH){1'b0}};

    /* RAM Initialization */
    initial begin
        // If Initialization File is NOT defined, the initial values depend on the vendor.
        if (RAM_INIT_FILE != "") begin
            $readmemh(RAM_INIT_FILE, RAM);
        end
    end

    generate
        /* Port A Operation */
        if ( WRITE_MODE_A == "WRITE_FIRST" ) begin: blk_WFA
            always @(posedge CLKA_I ) begin
                if (WENA_I == 1'b1) begin
                    RAM[ADDRA_I] <= DINA_I;
                    R_DOUTA_1P   <= DINA_I;
                end else begin
                    R_DOUTA_1P <= RAM[ADDRA_I];
                end
            end
        end else if ( WRITE_MODE_A == "READ_FIRST" ) begin: blk_RFA
            always @(posedge CLKA_I ) begin
                if (WENA_I == 1'b1) begin
                    RAM[ADDRA_I] <= DINA_I;
                end
                R_DOUTA_1P <= RAM[ADDRA_I];
            end
        end else if ( WRITE_MODE_A == "NO_CHANGE" ) begin: blk_NCA
            always @(posedge CLKA_I ) begin
                if (WENA_I == 1'b1) begin
                    RAM[ADDRA_I] <= DINA_I;
                end else begin
                    R_DOUTA_1P <= RAM[ADDRA_I];
                end
            end
        end
        /* Port B Operation */
        if ( WRITE_MODE_B == "WRITE_FIRST" ) begin: blk_WFB
            always @(posedge CLKB_I ) begin
                if (WENB_I == 1'b1) begin
                    RAM[ADDRB_I] <= DINB_I;
                    R_DOUTB_1P   <= DINB_I;
                end else begin
                    R_DOUTB_1P <= RAM[ADDRB_I];
                end
            end
        end else if ( WRITE_MODE_B == "READ_FIRST" ) begin: blk_RFB
            always @(posedge CLKB_I ) begin
                if (WENB_I == 1'b1) begin
                    RAM[ADDRB_I] <= DINB_I;
                end
                R_DOUTB_1P <= RAM[ADDRB_I];
            end
        end else if ( WRITE_MODE_B == "NO_CHANGE" ) begin: blk_NCB
            always @(posedge CLKB_I ) begin
                if (WENB_I == 1'b1) begin
                    RAM[ADDRB_I] <= DINB_I;
                end else begin
                    R_DOUTB_1P <= RAM[ADDRB_I];
                end
            end
        end

        /* Output Register */
        // Port A
        if (OUTPUT_REG_A == "TRUE") begin: blk_REGA
            always @(posedge CLKA_I ) begin
                R_DOUTA_2P <= R_DOUTA_1P;
            end

            assign DOUTA_O = R_DOUTA_2P;
        end else begin: blk_NOREGA
            assign DOUTA_O = R_DOUTA_1P;
        end
        // Port B
        if (OUTPUT_REG_B == "TRUE") begin: blk_REGB
            always @(posedge CLKB_I ) begin
                R_DOUTB_2P <= R_DOUTB_1P;
            end

            assign DOUTB_O = R_DOUTB_2P;
        end else begin: blk_NOREGB
            assign DOUTB_O = R_DOUTB_1P;
        end
    endgenerate
    
endmodule

`default_nettype wire
