-- == LIBRAIRIES ==

library ieee;
use ieee.std_logic_1164.all;
use work.DE0_pack.all;

-- == ENTITE ==
ENTITY PWM IS			
	GENERIC( Max_T : natural := 100;
				Max_Duty : natural := 100
	);
	PORT(	Clk : in std_logic;
			S_pwm : out std_logic
		 );
END PWM ;
-- ============

-- == ARCHITECHTURE ==
ARCHITECTURE BEHV OF PWM IS



BEGIN
		process(Clk)
		variable cpt_T : integer range 0 to Max_T := 0;
		variable duty_cycle : integer  range 0 to Max_T := 0;
		begin
				if(Clk'event and Clk = '1') then
				
					duty_cycle := duty_cycle +1;
					cpt_T := cpt_T + 1;
					if(duty_cycle < Max_Duty) then							
							S_pwm <= '1';	
					elsif(duty_cycle >= Max_duty) then
							S_pwm <= '0';
					elsif(duty_cycle = Max_T) then
							duty_cycle := 0;
							cpt_T := 0;
					end if;
				end if;
		end process;
		
	
END BEHV ;	
-- ======================
