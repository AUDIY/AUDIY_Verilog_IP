# AUDIY_Verilog_IP
Generic Verilog IP that AUDIY originally designed.  
Code reviews are welcome!

## Modules List
- [DIFFERENTIATOR](https://github.com/AUDIY/AUDIY_Verilog_IP/tree/main/DIFFERENTIATOR)  
  Differentiator.
- [I2S_PCM_BCLK](https://github.com/AUDIY/AUDIY_Verilog_IP/tree/main/I2S_PCM_BCLK)  
  I2S to stereo PCM converter (synchronous w/ Bit clock).
- [INTEGRATOR](https://github.com/AUDIY/AUDIY_Verilog_IP/tree/main/INTEGRATOR)  
  Forward & Back eular method integrator.
- [Memory](https://github.com/AUDIY/AUDIY_Verilog_IP/tree/main/Memory)  
  Memory code examples.  
  *Note*: It is recommended to use vendor original ROM/RAM IP.  
- [ARESETN_SYNC](https://github.com/AUDIY/AUDIY_Verilog_IP/tree/main/ARESETN_SYNC)  
  Asynchronous Reset (Active LOW) Synchronizer.
- [PCM_MCLK_SYNC](https://github.com/AUDIY/AUDIY_Verilog_IP/tree/main/PCM_MCLK_SYNC)  
  PCM Data Synchronizer w/ MCLK.
- [\_\_Legacy\_\_](https://github.com/AUDIY/AUDIY_Verilog_IP/tree/main/__Legacy__)  
  Modules no longer maintained.

## Legacy Modules List
- [I2S_MCLK](https://github.com/AUDIY/AUDIY_Verilog_IP/tree/main/__Legacy__/I2S_MCLK)  
  I2S to stereo PCM converter (synchronous w/ Master clock).  
  I2S must be synchronized w/ MCLK by synchronizer. So it is NOT recommended.  

## License under CERN-OHL-P v2
Copyright AUDIY 2023 - 2025.

This source describes Open Hardware and is licensed under the CERN-OHL-P v2.

You may redistribute and modify this source and make products using it under the terms of the CERN-OHL-P v2 (https:/cern.ch/cern-ohl).

This source is distributed WITHOUT ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING OF MERCHANTABILITY, SATISFACTORY QUALITY AND FITNESS FOR A PARTICULAR PURPOSE.  
Please see the CERN-OHL-P v2 for applicable conditions.
