# SDPRAM_SINGLECLK
Single clock Simple Dual Port RAM (for Infering)

## File List
| No. |File name|Description|
|:---:|:-------------------------|:----------|
|  1  |[SDPRAM_SINGLECLK.v](./SDPRAM_SINGLECLK.v)|Single clock Simple Dual Port RAM (for Infering)|
|  2  |[SDPRAM_SINGLECLK_tb.sv](./SDPRAM_SINGLECLK_tb.sv)|Testbench for SDPRAM_SINGLECLK.v|
|  3  |[ram_init_file.mem](./ram_init_file.mem)|RAM Initialization file for simulation.|
|  4  |[README.md](./README.md)|README file.|

## Status
|Item|Status|
|:------|:---------|
|Version|1.00|
|Date   |2025/01/20|
|Simulated|Yes|
|Real Machine Checked|Yes|

## Verified Devices
|No.|FPGA Vendor|Device|Board|
|:-:|:----------|:-----|:----|
|1|Altera|Cyclone 10 LP 10CL025YU256I7G|[EK-10CL025U256](https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/cyclone/10-lp-evaluation-kit.html)|
|2|Altera|Cyclone IV E EP4CE22F17C6N|[DE0-Nano](https://www.terasic.com.tw/cgi-bin/page/archive.pl?No=593)|
|3|Altera|MAX 10 10M50DAF484C7G|[DE10-Lite](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=234&No=1021)|

## Port Definition
### Input
|Port name|Description|
|:--------|:----------|
|CLK_I|RAM Write/Read Clock Input|
|WADDR_I|Write Address Input|
|WENABLE_I|Write Enable Input|
|WDATA_I|Stored Data Input|
|RADDR_I|Read Address Input|
|RENABLE_I|Read Enable Input|

### Output
|Port name|Description|
|:--------|:----------|
|RDATA_O|Stored Data Output|

## Parameters
|Parameter name|Description|
|:-------------|:----------|
|DATA_WIDTH|PCM data bit length (Default: 8).|
|ADDR_WIDTH|ROM Address Width (Default: 9).|
|OUTPUT_REG|Output Register Enable (Default:"TRUE").|
|RAM_INIT_FILE|RAM Initialization File (Default: "RAMINIT.hex").|

## Timing Chart
To be determined.

## Version History
### v1.00
- Real machine checked (2025/06/26).
