/*----------------------------------------------------------------------------
* SDPRAM_DUALCLK_tb.v
*
* Test bench for Simple Dual-Port RAM (Dual Clock)
*
* Version: 0.10
* Author : AUDIY
* Date   : 2026/04/12
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

module SDPRAM_DUALCLK_tb ();

    timeunit 1ns / 10ps;

    localparam DATA_WIDTH    = 8;
    localparam ADDR_WIDTH    = 9;
    localparam RAM_INIT_FILE = "../ram_init_file.mem";

    reg                             WCLK_I    = 1'b0;
    reg                             WENABLE_I = 1'b0;
    reg  unsigned  [ADDR_WIDTH-1:0] WADDR_I   = '0;
    reg  unsigned  [DATA_WIDTH-1:0] WDATA_I   = '0;
    reg                             RCLK_I    = 1'b0;
    reg                             RENABLE_I = 1'b0;
    reg  unsigned  [ADDR_WIDTH-1:0] RADDR_I   = '0;
    wire unsigned  [DATA_WIDTH-1:0] RDATA_O;

    reg                               CLK = 1'b0;
    reg     unsigned [DATA_WIDTH-1:0] expected_data;
    integer signed                    cycle_count;

    SDPRAM_DUALCLK #(
        .DATA_WIDTH   (DATA_WIDTH   ),
        .ADDR_WIDTH   (ADDR_WIDTH   ),
        .RAM_INIT_FILE(RAM_INIT_FILE)
    ) dut (
        .WCLK_I   (WCLK_I   ),
        .WENABLE_I(WENABLE_I),
        .WADDR_I  (WADDR_I  ),
        .WDATA_I  (WDATA_I  ),
        .RCLK_I   (RCLK_I   ),
        .RENABLE_I(RENABLE_I),
        .RADDR_I  (RADDR_I  ),
        .RDATA_O  (RDATA_O  )
    );

    initial begin
        $dumpfile("SDPRAM_DUALCLK.vcd");
        $dumpvars(0, SDPRAM_DUALCLK_tb);

        // Initialize the DUT inputs
        WDATA_I = 70;

        // Give 2 cycles for initial state to settle
        cycle_count = -4;
    end

    // Generate the clocks
    // drive read & write clock from same system clock
    always #75 begin
        CLK = ~CLK;
        #25 RCLK_I = ~RCLK_I;
        #25 WCLK_I = ~WCLK_I;
    end

    // Increment the cycle counter on the postive clock
    always @(negedge CLK) begin
        cycle_count = cycle_count + 1;

        // Allow 3 complete traversals of the memory address space
        if (cycle_count == 77) begin
            $display("Test completed successfully!");
            $finish;
        end
    end

    // Simulate the write port
    always @(negedge WCLK_I) begin
        // let some cycles go before starting the writing and reading
        if (cycle_count == -1) begin
            // Enable writing just before cycle 0
            WENABLE_I = 1'b1;
        end else if (cycle_count >= 0) begin
            $display("%t === === === Write Cycle:%d === === ===", $time, cycle_count);
            $display("WDATA : %d\tWADDR : %d\tWE : %d", WDATA_I, WADDR_I, WENABLE_I);

            //Increment data and address
            WDATA_I = WDATA_I + 2;
            WADDR_I = WADDR_I + 1;
        end
    end

    // Simulate the read port
    always @(negedge RCLK_I) begin
        // let some cycles go before starting the writing and reading
        if (cycle_count == -1) begin
            // Enable reading just before cycle 0
            RENABLE_I = 1'b1;
        end else if (cycle_count >= 0) begin
            $display("%t === === === Read Cycle: %d === === ===", $time, cycle_count);
            $display("RADDR : %d\tRE : %d", RADDR_I, RENABLE_I);
            $display("\tRDATA : %d", RDATA_O);

            // First read 256 uninitialized memory locations
            if (cycle_count < 512) begin
                expected_data = 255 - cycle_count;
            end

            // For the next 256 reads the data should be the value 00-FF
            if (cycle_count >= 512) begin
                expected_data = 70 + ((cycle_count - 512) * 2);
            end

            if (expected_data !== RDATA_O) begin
                $display("\tMISMATCH: Expected %d got RDATA : %d", expected_data, RDATA_O);
                $display("Test failed at cycle %d!", cycle_count);
                $finish;
		    end

            // Increment address
            RADDR_I = RADDR_I + 1;
        end
    end
    
endmodule

`default_nettype wire
