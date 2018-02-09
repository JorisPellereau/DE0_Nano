-- == LIBRAIRIES ==

library ieee;
use ieee.std_logic_1164.all;



package DE0_pack is

		component Clk_div
				PORT(	Clk : in std_logic;
						Clk_div2, Clk_div4, Clk_div8, Clk_div16, Clk_div32, Clk_div64, Clk_div128, Clk_div256 : out std_logic
						);
		end component;

		component pwm
				GENERIC( Max_T : natural := 100;
							Max_Duty : natural := 100
							);
				PORT(	Clk : in std_logic;
						S_pwm : out std_logic
						);
		end component;

		
		component PWM_gen
		GENERIC( Max_T : natural := 100
				--Max_Duty : natural := 100
					);
		PORT(	Clk : in std_logic;
				Duty_prescal : integer range 0 to Max_T;
				S_pwm : out std_logic
				);
		end component;
		
		component Clk_low_div
		GENERIC(T_2 : natural := 100);
		PORT(	Clk : in std_logic;
				Clk_05s : out std_logic
				);	
		end component;
		
		component counter_gen
		GENERIC(S_Max : natural := 100);
		PORT(	Clk : in std_logic;
				out_cpt : out integer range 0 to S_Max
				);
		end component;
end package;