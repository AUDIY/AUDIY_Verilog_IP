# SPROM
Single Port ROM (for Infering)

## File List
| No. |File name|Description|
|:---:|:-------------------------|:----------|
|  1  |[SPROM.v](./SPROM.v)|Single Port ROM (for Infering)|
|  2  |[SPROM_tb.sv](./SPROM_tb.sv)|Testbench for SPROM.v|
|  3  |[initrom.hex](./initrom.hex)|ROM Initialization file for simulation.|
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
|4|Efinix|Trion T20F256I4|[T20 BGA256 Development Kit](https://www.efinixinc.com/products-devkits-triont20.html)|

## Port Definition
### Input
|Port name|Description|
|:--------|:----------|
|CLK_I|RAM Write/Read Clock Input|
|RADDR_I|Read Address Input|

### Output
|Port name|Description|
|:--------|:----------|
|RDATA_O|Stored Data Output|

## Parameters
|Parameter name|Description|
|:-------------|:----------|
|DATA_WIDTH|Data bit length (Default: 16).|
|ADDR_WIDTH|ROM Address Width (Default: 8).|
|OUTPUT_REG|Output Register Enable (Default:"TRUE").|
|RAM_INIT_FILE|RAM Initialization File (Default: "RAMINIT.hex").|

## Timing Chart
To be determined.

## Version History
### v1.00
- Real machine checked (2025/06/26).
