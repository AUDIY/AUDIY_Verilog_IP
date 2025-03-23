# ARESETN_SYNC
Asynchronous Reset (Active LOW) Synchronizer Module.

## File List
| No. |File name|Description|
|:---:|:-------------------------|:----------|
|  1  |[ARESETN_SYNC.v](https://github.com/AUDIY/AUDIY_Verilog_IP/blob/main/ARESETN_SYNC/ARESETN_SYNC.v)|Asynchronous reset synchronizer module|
|  2  |[ARESETN_SYNC_tb.sv](https://github.com/AUDIY/AUDIY_Verilog_IP/blob/main/ARESETN_SYNC/ARESETN_SYNC_tb.sv)|Testbench for ARESETN_SYNC.v|
|  3  |[README.md](https://github.com/AUDIY/AUDIY_Verilog_IP/blob/main/ARESETN_SYNC/README.md)|README file.|
|  4  |[coverage_report.txt](https://github.com/AUDIY/AUDIY_Verilog_IP/blob/main/ARESETN_SYNC/coverage_report.txt)|Code coverage report.|
|  5  |[Timing_charts]()|Timing chart directory for README.md|

## Status
|Item|Status|
|:------|:---------|
|Version|1.02|
|Date   |2025/03/23|
|Simulated|Yes|
|Real Machine Checked|Not yet|

## Verified Devices
|No.|FPGA Vendor|Device|Board|
|:-:|:----------|:-----|:----|
| 1 ||||

## Port Definition
### Input
|Port name|Description|
|:--------|:----------|
|CLK_I|Clock.|
|ARESETN_I|Asynchronous reset (Active Low).|

### Output
|Port name|Description|
|:--------|:----------|
|RESETN_O|Reset Output (Synchronized when it negated.)|

## Parameters
|Parameter name|Description|
|:-------------|:----------|
|STAGES|Synchronization Stage Length (Default: 2).|

## Timing Chart
### Input
### Output
### Sequence
![Sequence](https://github.com/AUDIY/AUDIY_Verilog_IP/blob/main/ARESETN_SYNC/Timing_charts/02_png/ARESETN_SYNC_sequence.png)

## Version History
### v1.01
- Commit to this repository. (2024/12/22)
### v1.02
- Change moddule name from "NRST_SYNCHRONIZER" to "ARESETN_SYNC" (2025/03/23).
- Change testbench from Verilog to SystemVerilog (2025/03/23).
- Add sequence chart (2025/03/23).
