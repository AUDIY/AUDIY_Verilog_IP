# PCM_MCLK_SYNC
PCM Data Synchronizer w/ MCLK.

## File List
| No. |File name|Description|
|:---:|:-------------------------|:----------|
|  1  |[PCM_MCLK_SYNC.v]()|PCM Data Synchronizer w/ MCLK.|
|  2  |[PCM_MCLK_SYNV_tb.sv]()|Testbench for PCM_MCLK_SYNC.v|
|  3  |[PCM_1kHz_44100fs_32bit.txt]()|Input data file for simulation (sine wave).|
|  4  |[README.md]()|README file.|
|  5  |[coverage_report.txt]()|Code coverage report.|


## Status
|Item|Status|
|:------|:---------|
|Version|0.10|
|Date   |2025/06/22|
|Simulated|Yes|
|Real Machine Checked|Not Yet|

## Port Definition
### Input
|Port name|Description|
|:--------|:----------|
|MCLK_I|Master clock|
|WCLK_I|PCM word clock|
|PCML_I|PCM left data|
|PCMR_I|PCM right data|
|ARESETN_I|Asynchronous reset (Active Low).|

### Output
|Port name|Description|
|:--------|:----------|
|WCLK_O|Synchronized PCM word clock|
|PCML_O|Synchronized PCM left data|
|PCMR_O|Synchronized PCM right data|

## Parameters
|Parameter name|Description|
|:-------------|:----------|
|DATA_WIDTH|PCM data bit length (Default: 32).|

## Timing Chart
To be determined

## Version History
### v0.10
- Initial Commit (2025/06/22).