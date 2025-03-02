# I2S_PCM_BCLK
I2S to stereo PCM conversion module (synchronous w/ BCLK_I)

## Port Definition
### Input
- BCLK_I  
I2S bit Clock (SCK).
- LRCK_I  
I2S L/R clock (WS).
- DATA_I  
I2S data.
- MUTEN_I  
Mute control (Active Low).
- ARESETN_I  
Asynchronous reset (Active Low).

### Output
- WCLK_O  
PCM word clock.
- PCML_O  
PCM left data.
- PCMR_O  
PCM right data.

## Parameters
- LENGTH  
  PCM data bit length (Default: 32).
- INPUT_REG  
  Input register enable. Enabled when 1'b1 (Default: 1'b1).   
