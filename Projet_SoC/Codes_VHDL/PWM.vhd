library ieee;
use ieee.std_logic_1164.all;

-----Entite-----------

Entity PWM is
			Port( clk, Raz_n, Enable_pwm : in std_logic ;
					freq : in integer range 0 to 65535;		-- Division de la fr�quence clk
					duty : in integer range 0 to 65535;		--duty en %
					out_pwm: out std_logic ) ;
end PWM;


-------Achitecture--------

Architecture Arch_pwm of PWM is

Begin 

	Process(clk)		
		variable cpt_freq : integer range 0 to 65535 := 0;
	begin
		if (clk'event and clk='1') then				-- Front montant de l'H
				if(cpt_freq < duty) then
						out_pwm <= '1';
						cpt_freq := cpt_freq + 1;
				elsif(cpt_freq > duty and cpt_freq < freq) then
						out_pwm <='0';
						cpt_freq := cpt_freq + 1;
				elsif(cpt_freq = freq) then
						cpt_freq := 0;
				end if;
		end if;
	end process;

end arch_PWM ;