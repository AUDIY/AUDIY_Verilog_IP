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

## Status
|Item|Status|
|:------|:---------|
|Version|1.00|
|Date   |2025/03/04|
|Simulated|Yes|
|Real Machine Checked|Yes|

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
