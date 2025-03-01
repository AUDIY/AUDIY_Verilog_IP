# I2S_PCM_BCLK
I2S to stereo PCM conversion module (synchronous w/ BCLK_I)

## Port Definition
### Input
- BCLK_I  
I2S Bit Clock (SCK).
- LRCK_I  
I2S L/R Clock (WS).
- DATA_I  
I2S Data.
- MUTEN_I  
Mute control (Active Low).
- ARESETN_I  
Asynchronous reset (Active Low).

### Output
- WCLK_O  
PCM Word Clock.
- PCML_O  
PCM Left Data.
- PCMR_O
PCM Right Data.
