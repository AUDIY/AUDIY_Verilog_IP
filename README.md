# AUDIY_Verilog_IP
Verilog IP that AUDIY originally designed.
Code reviews are welcome!

## Modules List
- DIFFERENTIATOR  
  Differentiator.
- I2S_PCM_BCLK  
  I2S to stereo PCM converter (synchronous w/ Bit clock).
- INTEGRATOR  
  Forward & Back eular method integrator.
- Memory  
  Memory code examples.
- NRST_SYNCHRONIZER  
  Asynchronous Reset Synchronizer.
- \_\_Legacy\_\_  
  Modules no longer maintained.

## Legacy Modules List
- I2S_PCM_MCLK  
  I2S to stereo PCM converter (synchronous w/ Master clock).  
  I2S must be synchronized w/ MCLK by synchronizer. So it is NOT recommended.  
