-- == LIBRAIRIES ==

library ieee;
use ieee.std_logic_1164.all;

-- == ENTITE ==
ENTITY Clk_low_div IS			
	GENERIC(T_2 : natural := 100);
	PORT(	Clk : in std_logic;
			Clk_05s : out std_logic
			);
	

	END Clk_low_div ;
-- ============

-- == ARCHITECHTURE ==
ARCHITECTURE BEHV OF Clk_low_div IS

signal clk_tmp : std_logic;

BEGIN
		process(Clk)
		
		variable cpt : integer range 0 to T_2 := 0;
		
		begin
				if(clk'event and Clk = '1') then	

							

						if(cpt < T_2) then
								cpt := cpt + 1;
						elsif(cpt = T_2) then
								cpt := 0;
								clk_tmp <= not clk_tmp;
						end if;
						
				end if;
		end process;
		
		Clk_05s <= clk_tmp;
		
		
	
END BEHV ;	
-- ======================