-- == LIBRAIRIES ==

library ieee;
use ieee.std_logic_1164.all;
use work.DE0_pack.all;

-- == ENTITE ==
ENTITY PWM_gen IS			
	GENERIC( Max_T : natural := 100
				--Max_Duty : natural := 100
	);
	PORT(	Clk : in std_logic;
			Duty_prescal : integer range 0 to Max_T;
			S_pwm : out std_logic
		 );
END PWM_gen ;
-- ============

-- == ARCHITECHTURE ==
ARCHITECTURE BEHV OF PWM_gen IS



BEGIN
		process(Clk)
		variable duty_cycle : integer  range 0 to Max_T := 0;
		variable Max_Duty : integer range 0 to Max_T := 0;
		begin
				if(Clk'event and Clk = '1') then
					Max_Duty := Duty_prescal;					-- Pour la consigne rapport syclique
					duty_cycle := duty_cycle + 1;
					if(duty_cycle < Max_Duty) then							
							S_pwm <= '1';	
					elsif(duty_cycle >= Max_duty) then
							S_pwm <= '0';
					elsif(duty_cycle = Max_T) then
							duty_cycle := 0;
					end if;
				end if;
		end process;
		
	
END BEHV ;	
-- ======================
