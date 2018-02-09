-- == LIBRAIRIES ==

library ieee;
use ieee.std_logic_1164.all;

-- == ENTITE ==
ENTITY counter_gen IS			
	GENERIC(S_Max : natural := 100);
	PORT(	Clk : in std_logic;
			out_cpt : out integer range 0 to S_Max
		 );
	
END counter_gen ;
-- ============

-- == ARCHITECHTURE ==
ARCHITECTURE BEHV OF counter_gen IS


BEGIN

	process(Clk)	
	variable cpt_tmp : integer range 0 to S_Max := 0;

	begin	
			if(Clk'event and Clk = '1') then
					
							if(cpt_tmp < S_Max) then
									cpt_tmp := cpt_tmp + 1;
							else
									cpt_tmp := 0;
							end if;					
			end if;
			out_cpt <= cpt_tmp;
	end process;
	
	
END BEHV ;	
-- ======================
