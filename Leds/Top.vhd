-- == LIBRAIRIES ==

library ieee;
use ieee.std_logic_1164.all;
use work.DE0_pack.all;

-- == ENTITE ==
ENTITY Top IS			
	generic(	Max_per : natural := 1000;
				Duty_pre : natural := 200;
				T_2_low_H : natural := 2e5
				);
	PORT(	Clk, Key0, Key1 : in std_logic;
			Leds : out std_logic_vector(7 downto 0)
		 );
	

	END Top ;
-- ============

-- == ARCHITECHTURE ==
ARCHITECTURE BEHV OF Top IS

signal out_cpt : integer range 0 to Max_per;
signal Clk_05s : std_logic;
BEGIN
		
		Low_clk : Clk_low_div generic map(T_2 => T_2_low_H) port map(Clk , Clk_05s);
		cpt_gen : counter_gen generic map(S_Max => Max_per-Duty_pre) port map(Clk_05s, out_cpt);
		cmd_pwm1 : PWM_gen generic map(Max_T => Max_per) port map(Clk , out_cpt , Leds(0));
		cmd_pwm2 : PWM_gen generic map(Max_T => Max_per) port map(Clk , out_cpt , Leds(1));
		cmd_pwm3 : PWM_gen generic map(Max_T => Max_per) port map(Clk , out_cpt , Leds(2));
		cmd_pwm4 : PWM_gen generic map(Max_T => Max_per) port map(Clk , out_cpt , Leds(3));
		cmd_pwm5 : PWM_gen generic map(Max_T => Max_per) port map(Clk , out_cpt , Leds(4));
		cmd_pwm6 : PWM_gen generic map(Max_T => Max_per) port map(Clk , out_cpt , Leds(5));
		cmd_pwm7 : PWM_gen generic map(Max_T => Max_per) port map(Clk , out_cpt , Leds(6));
		cmd_pwm8 : PWM_gen generic map(Max_T => Max_per) port map(Clk , out_cpt , Leds(7));
		
END BEHV ;	
-- ======================


-- ===

--signal cmd_pwm7, cmd_pwm6, cmd_pwm5, cmd_pwm4, cmd_pwm3, cmd_pwm2, cmd_pwm1, cmd_pwm0 : std_logic;

--diviseur_clk : Clk_div port map(Clk , cmd_pwm7 ,cmd_pwm6 , cmd_pwm5 , cmd_pwm4 , cmd_pwm3 , cmd_pwm2 , cmd_pwm1 , cmd_pwm0);
		--pwm0 : pwm generic map(Max_T => 1000, Max_Duty => 1) port map(cmd_pwm0 , Leds(0));
		--pwm1 : pwm generic map(Max_T => 1000, Max_Duty => 50) port map(cmd_pwm1 , Leds(1));
		--pwm2 : pwm generic map(Max_T => 1000, Max_Duty => 150) port map(cmd_pwm2 , Leds(2));
		--pwm3 : pwm generic map(Max_T => 1000, Max_Duty => 500) port map(cmd_pwm3 , Leds(3));
		--pwm4 : pwm generic map(Max_T => 1000, Max_Duty => 500) port map(cmd_pwm4 , Leds(4));
		--pwm5 : pwm generic map(Max_T => 1000, Max_Duty => 150) port map(cmd_pwm5 , Leds(5));
		--pwm6 : pwm generic map(Max_T => 1000, Max_Duty => 50) port map(cmd_pwm6 , Leds(6));
		--pwm7 : pwm generic map(Max_T => 1000, Max_Duty => 1) port map(cmd_pwm7 , Leds(7));
		
		--========