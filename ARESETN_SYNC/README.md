# ARESETN_SYNC
Asynchronous Reset Synchronizer Module.

## File List
| No. |File name|Description|
|:---:|:-------------------------|:----------|
|  1  |[ARESETN_SYNC.v]()|Asynchronous reset synchronizer module|
|  2  |[ARESETN_SYNC_tb.sv]()|Testbench for ARESETN_SYNC.v|
|  3  |[README.md]()|README file.|
|  4  |[coverage_report.txt]()|Code coverage report.|
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

## Version History
### v1.01
- Commit to this repository. (2024/12/22)
### v1.02
- Change moddule name from "NRST_SYNCHRONIZER" to "ARESETN_SYNC" (2025/03/23).
- Change testbench from Verilog to SystemVerilog (2025/03/23).
