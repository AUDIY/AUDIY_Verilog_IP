# PCM_I2S_MCLK
Stereo PCM to I2S conversion module (synchronous w/ MCLK_I)

## File List
| No. |File name|Description|
|:---:|:-------------------------|:----------|
|  1  |[PCM_I2S_MCLK.v](./PCM_I2S_MCLK.v)|Stereo PCM to I2S conversion module (synchronous w/ MCLK_I)|
|  2  |[PCM_I2S_MCLK_tb.sv](./PCM_I2S_MCLK_tb.sv)|Testbench for PCM_I2S_MCLK.v|
|  3  |[PCM_1kHz_44100fs_32bit.txt](./PCM_1kHz_44100fs_32bit.txt)|Input data file for simulation (sine wave).|
|  4  |[README.md](./README.md)|README file.|
|  5  |[coverage_report.txt](./coverage_report.txt)|Code coverage report.|

## Status
|Item|Status|
|:------|:---------|
|Version|1.00|
|Date   |2025/06/29|
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
|MCLK_I|Master Clock Input|
|BCLK_I|Bit Clock Input|
|WCLK_I|PCM Word Clock|
|PCML_I|PCM Left Data|
|PCMR_I|PCM Right Data|
|ARESETN_I|Asynchronous reset (Active Low).|

### Output
|Port name|Description|
|:--------|:----------|
|BCLK_O|I2S BCLK|
|LRCK_O|I2S LRCK|
|DATA_O|I2S DATA|

## Parameters
|Parameter name|Description|
|:-------------|:----------|
|DATA_WIDTH|PCM data bit length (Default: 32).|

## Timing Chart
To be determined

## Version History
### v0.10
- Initial Commit (2025/06/26).
### v1.00
- Real Machine Checked (2025/06/28).
