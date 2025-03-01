# AUDIY_Verilog_IP
Verilog IP that AUDIY originally designed.
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
- [NRST_SYNCHRONIZER](https://github.com/AUDIY/AUDIY_Verilog_IP/tree/main/NRST_SYNCHRONIZER)  
  Asynchronous Reset Synchronizer.
- [\_\_Legacy\_\_](https://github.com/AUDIY/AUDIY_Verilog_IP/tree/main/__Legacy__)  
  Modules no longer maintained.

## Legacy Modules List
- [I2S_PCM_MCLK](https://github.com/AUDIY/AUDIY_Verilog_IP/tree/main/__Legacy__/I2S_MCLK)  
  I2S to stereo PCM converter (synchronous w/ Master clock).  
  I2S must be synchronized w/ MCLK by synchronizer. So it is NOT recommended.  
