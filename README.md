# simon_says
This is a simple systemVerilog project synthesized on a De1-Soc.
It is basically a "Simon Says" game with the LEDR 0-3 and SW 0-3. 
Where in each round a "random" LED will blink and the player will need to flip the corresponding switch for it and every other led in the sequence.
The game goes on until level 10 or until the player makes a mistake, in this case it restarts. It can also be restarted by pressing KEY0.


State machine (raw)
--------------------------------------
![Alt text](https://github.com/F2507/simon_says/blob/main/images/simonSays_fsm.png)

--------------------------------------

State machine (conditional)
--------------------------------------
![Alt text](https://github.com/F2507/simon_says/blob/main/images/simonSays_fsm_2.png)

