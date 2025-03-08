# INTEGRATOR_FWD
Forward Eular Method Integrator (w/ Saturation) Module.

## File List
| No. |File name|Description|
|:---:|:-------------------------|:----------|
|  1  |INTEGRATOR_FWD.v|Forward eular method integrator (w/ saturation) module|
|  2  |INTEGRATOR_FWD_tb.sv|Testbench for INTEGRATOR_FWD.v|
|  3  |README.md|README file.|
|  4  |coverage_report.txt|Code coverage report.|

## Status
|Item|Status|
|:------|:---------|
|Version|1.10|
|Date   |2025/03/08|
|Simulated|Yes|
|Real Machine Checked|Not yet|

## Port Definition
### Input
|Port name|Description|
|:--------|:----------|
|CLK_I|Data clock.|
|DATA_I|Data.|
|ARESETN_I|Asynchronous reset (Active Low).|

### Output
|Port name|Description|
|:--------|:----------|
|DATA_O|Integrated data.|
|OFDET_O|Overflow Detection.|
|UFDET_O|Underflow Detection.|

## Parameters
|Parameter name|Description|
|:-------------|:----------|
|LENGTH|PCM data bit length (Default: 32).|
|INPUT_REG|Input register enable. Enabled when 1'b1 (Default: 1'b1).|

## Timing Chart
## Version History
### v1.02
- Commit to this repository. (2024/12/22)
### v1.03
- Change test bench from Verilog to SystemVerilog. (2025/03/08)
- Refactored the RTL. (2025/03/08)
- Add README. (2025/03/08)
### v1.10
- RTL simulation is finished. (2025/03/08)
