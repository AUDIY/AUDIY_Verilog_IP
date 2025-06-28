# I2S_PCM_BCLK
I2S to stereo PCM conversion module (synchronous w/ BCLK_I)

## File List
| No. |File name|Description|
|:---:|:-------------------------|:----------|
|  1  |[I2S_PCM_BCLK.v](https://github.com/AUDIY/AUDIY_Verilog_IP/blob/main/I2S_PCM_BCLK/I2S_PCM_BCLK.v)|I2S to stereo PCM conversion module (synchronous w/ BCLK_I)|
|  2  |[I2S_PCM_BCLK_tb.sv](https://github.com/AUDIY/AUDIY_Verilog_IP/blob/main/I2S_PCM_BCLK/I2S_PCM_BCLK_tb.sv)|Testbench for I2S_PCM_BCLK.v|
|  3  |[PCM_1kHz_44100fs_32bit.txt](https://github.com/AUDIY/AUDIY_Verilog_IP/blob/main/I2S_PCM_BCLK/PCM_1kHz_44100fs_32bit.txt)|Input data file for simulation (sine wave).|
|  4  |[README.md](https://github.com/AUDIY/AUDIY_Verilog_IP/blob/main/I2S_PCM_BCLK/README.md)|README file.|
|  5  |[coverage_report.txt](https://github.com/AUDIY/AUDIY_Verilog_IP/blob/main/I2S_PCM_BCLK/coverage_report.txt)|Code coverage report.|
|  6  |[Timing_charts](https://github.com/AUDIY/AUDIY_Verilog_IP/tree/main/I2S_PCM_BCLK/Timing_charts)|Timing chart directory for README.md|

## Status
|Item|Status|
|:------|:---------|
|Version|1.00|
|Date   |2025/03/04|
|Simulated|Yes|
|Real Machine Checked|Yes|

## Verified Devices
|No.|FPGA Vendor|Device|Board|
|:-:|:----------|:-----|:----|
|1|Altera|Cyclone 10 LP 10CL025YU256I7G|[EK-10CL025U256](https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/cyclone/10-lp-evaluation-kit.html)|
|2|Altera|Cyclone IV E EP4CE22F17C6N|[DE0-Nano](https://www.terasic.com.tw/cgi-bin/page/archive.pl?No=593)|
|3|Altera|MAX 10 10M50DAF484C7G|[DE10-Lite](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=234&No=1021)|
|4|AMD|Artix 7 XC7A35T-1CPG236C|[Cmod A7](https://digilent.com/reference/programmable-logic/cmod-a7/start)|
|5|AMD|Spartan 7 XC7S25-1CSGA225C|[Cmod S7](https://digilent.com/reference/programmable-logic/cmod-s7/start)|

## Port Definition
### Input
|Port name|Description|
|:--------|:----------|
|BCLK_I|I2S bit Clock (SCK).|
|LRCK_I|I2S L/R clock (WS).|
|DATA_I|I2S data.|
|MUTEN_I|Mute control (Active Low).|
|ARESETN_I|Asynchronous reset (Active Low).|

### Output
|Port name|Description|
|:--------|:----------|
|WCLK_O|PCM word clock.|
|PCML_O|PCM left data.|
|PCMR_O|PCM right data.|

## Parameters
|Parameter name|Description|
|:-------------|:----------|
|LENGTH|PCM data bit length (Default: 32).|
|INPUT_REG|Input register enable. Enabled when 1'b1 (Default: 1'b1).|

## Timing Chart
### Input: I2S
Please refer [UM11732 I2S bus specification from NXP](https://www.nxp.com/docs/en/user-manual/UM11732.pdf) for more detail.
![I2S](https://github.com/AUDIY/AUDIY_Verilog_IP/blob/main/I2S_PCM_BCLK/Timing_charts/02_png/I2S.png)
### Output: Word clock & 2-channels (Left & Right) PCM
![PCM](https://github.com/AUDIY/AUDIY_Verilog_IP/blob/main/I2S_PCM_BCLK/Timing_charts/02_png/PCM.png)
### Sequence
![sequence](https://github.com/AUDIY/AUDIY_Verilog_IP/blob/main/I2S_PCM_BCLK/Timing_charts/02_png/I2S_PCM_BCLK_sequence.png)
![Questa](https://github.com/AUDIY/AUDIY_Verilog_IP/blob/main/I2S_PCM_BCLK/Timing_charts/02_png/Questa.png)

## Version History
### v0.01
- Initial Commit (2025/03/02).
### v1.00
- Verified on real machine. (2025/03/04)
- Add "Version History" section. (2025/03/04)
- Add timing charts. (2025/03/05)

