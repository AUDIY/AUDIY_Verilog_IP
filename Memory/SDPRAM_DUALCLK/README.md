# SDPRAM_DUALCLK
Dual clock Simple Dual Port RAM (for Infering)

## File List
| No. |File name                                       |Description                                   |
|:---:|:-----------------------------------------------|:---------------------------------------------|
|  1  |[SDPRAM_DUALCLK.v](./SDPRAM_SINGLECLK.v)        |Dual clock Simple Dual Port RAM (for Infering)|
|  2  |[SDPRAM_DUALCLK_tb.sv](./SDPRAM_SINGLECLK_tb.sv)|Testbench for SDPRAM_DUALCLK.v                |
|  3  |[ram_init_file.mem](./ram_init_file.mem)        |RAM Initialization file for simulation.       |
|  4  |[README.md](./README.md)                        |README file.                                  |

## Status
|Item                |Status    |
|:-------------------|:---------|
|Version             |0.10      |
|Date                |2026/04/13|
|Simulated           |Yes       |
|Real Machine Checked|No        |

## Verified Devices
|No.|FPGA Vendor|Device|Board|
|:-:|:----------|:-----|:----|
| 1 |           |      |     |

## Port Definition
### Input
|Port name|Description          |
|:--------|:--------------------|
|WCLK_I   |RAM Write Clock Input|
|WADDR_I  |Write Address Input  |
|WENABLE_I|Write Enable Input   |
|WDATA_I  |Stored Data Input    |
|RCLK_I   |RAM Read Clock Input |
|RADDR_I  |Read Address Input   |
|RENABLE_I|Read Enable Input    |

### Output
|Port name|Description       |
|:--------|:-----------------|
|RDATA_O  |Stored Data Output|

## Parameters
|Parameter name|Description                           |
|:-------------|:-------------------------------------|
|DATA_WIDTH    |Data bit length (Default: 8).         |
|ADDR_WIDTH    |ROM Address Width (Default: 9).       |
|RAM_INIT_FILE |RAM Initialization File (Default: "").|

## Timing Chart
To be determined.

## Version History
### v0.10
- Initial Commit (2026/04/13)