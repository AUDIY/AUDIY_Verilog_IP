# INTEGRATOR_FWD
Forward Eular Method Integrator (w/ Saturation) Module.

## File List
| No. |File name|Description|
|:---:|:-------------------------|:----------|
|  1  |[INTEGRATOR_FWD.v](./INTEGRATOR_FWD.v)|Forward eular method integrator (w/ saturation) module|
|  2  |[INTEGRATOR_FWD_tb.sv](./INTEGRATOR_FWD_tb.sv)|Testbench for INTEGRATOR_FWD.v|
|  3  |[README.md](./README.md)|README file.|
|  4  |[coverage_report.txt](./coverage_report.txt)|Code coverage report.|
|  5  |[Timing_charts](./Timing_charts)|Timing chart directory for README.md|

## Status
|Item|Status|
|:------|:---------|
|Version|2.00|
|Date   |2025/03/17|
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
![Input_pos](./Timing_charts/02_png/INTEGRATOR_FWD_input_pos.png)  
Note: When you connect inputs to the FPGA's I/O pin, it is recommended to input the center-aligned signal.
![Input_neg](./Timing_charts/02_png/INTEGRATOR_FWD_input_neg.png)
### Output
![Output](./Timing_charts/02_png/INTEGRATOR_FWD_output.png)
### Sequence
![Sequence](./Timing_charts/02_png/INTEGRATOR_FWD_sequence.png)
## Version History
### v1.02
- Commit to this repository. (2024/12/22)
### v1.03
- Change test bench from Verilog to SystemVerilog. (2025/03/08)
- Refactored the RTL. (2025/03/08)
- Add README. (2025/03/08)
### v1.10
- RTL simulation is finished. (2025/03/08)
- Add timing charts. (2025/03/09)
### v2.00
- Checked on real machine. (2025/03/17)
- Add "Verified Devices" section in README. (2025/03/17)
