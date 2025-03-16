# INTEGRATOR_BACK
Back Eular Method Integrator (w/ Saturation) Module.

## File List
| No. |File name|Description|
|:---:|:-------------------------|:----------|
|  1  |[INTEGRATOR_FWD.v](https://github.com/AUDIY/AUDIY_Verilog_IP/blob/main/INTEGRATOR/INTEGRATOR_BACK/INTEGRATOR_BACK.v)|Back eular method integrator (w/ saturation) module|
|  2  |[INTEGRATOR_FWD_tb.sv](https://github.com/AUDIY/AUDIY_Verilog_IP/blob/main/INTEGRATOR/INTEGRATOR_BACK/INTEGRATOR_BACK_tb.sv)|Testbench for INTEGRATOR_BACK.v|
|  3  |[README.md](https://github.com/AUDIY/AUDIY_Verilog_IP/blob/main/INTEGRATOR/INTEGRATOR_BACK/README.md)|README file.|
|  4  |[coverage_report.txt](https://github.com/AUDIY/AUDIY_Verilog_IP/blob/main/INTEGRATOR/INTEGRATOR_BACK/coverage_report.txt)|Code coverage report.|
|  5  |[Timing_charts](https://github.com/AUDIY/AUDIY_Verilog_IP/tree/main/INTEGRATOR/INTEGRATOR_BACK/Timing_charts)|Timing chart directory for README.md|

## Status
|Item|Status|
|:------|:---------|
|Version|1.04|
|Date   |2025/03/16|
|Simulated|Not Yet|
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
### Input
### Output
### Sequence
## Version History
### v1.03
- Commit to this repository. (2024/12/22)
### v1.04
- Change test bench from Verilog to SystemVerilog. (2025/03/16)
- Refactored the RTL. (2025/03/16)
- Add README. (2025/03/16)
