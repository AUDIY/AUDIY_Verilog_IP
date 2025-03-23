# NRST_SYNCHRONIZER
Asynchronous Reset Synchronizer Module.

## File List
| No. |File name|Description|
|:---:|:-------------------------|:----------|
|  1  |[NRST_SYNCHRONIZER.v]()|Back eular method integrator (w/ saturation) module|
|  2  |[NRST_SYNCHRONIZER_tb.sv]()|Testbench for NRST_SYNCHRONIZER.v|
|  3  |[README.md]()|README file.|
|  4  |[coverage_report.txt]()|Code coverage report.|
|  5  |[Timing_charts]()|Timing chart directory for README.md|

## Status
|Item|Status|
|:------|:---------|
|Version|1.01|
|Date   |2024/12/22|
|Simulated|Yes|
|Real Machine Checked|Yes|

## Verified Devices
|No.|FPGA Vendor|Device|Board|
|:-:|:----------|:-----|:----|
| 1 |AMD|[Spartan-7 XC7S25-1CSGA225C](https://www.amd.com/ja/products/adaptive-socs-and-fpgas/fpga/spartan-7.html)|[Digilent Cmod S7](https://digilent.com/reference/programmable-logic/cmod-s7/start)|

## Port Definition
### Input
|Port name|Description|
|:--------|:----------|
|CLK_I|Clock.|
|NRST_I|Asynchronous reset (Active Low).|

### Output
|Port name|Description|
|:--------|:----------|
|NRST_O|Reset Output (Synchronized when it negated.)|

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
