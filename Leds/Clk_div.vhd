-- == LIBRAIRIES ==

library ieee;
use ieee.std_logic_1164.all;

-- == ENTITE ==
ENTITY Clk_div IS			
	
	PORT(	Clk : in std_logic;
			Clk_div2, Clk_div4, Clk_div8, Clk_div16, Clk_div32, Clk_div64, Clk_div128, Clk_div256 : out std_logic
			);
	

	END Clk_div ;
-- ============

-- == ARCHITECHTURE ==
ARCHITECTURE BEHV OF Clk_div IS

signal clk_tmp, clk_tmp2, clk_tmp4 , clk_tmp8, clk_tmp16, clk_tmp32, clk_tmp64, clk_tmp128, clk_tmp256 : std_logic;

BEGIN
		process(Clk)
		
		variable cpt2 : integer range 0 to 2 := 0;
		variable cpt4 : integer range 0 to 4 := 0;
		variable cpt8 : integer range 0 to 8 := 0;
		variable cpt16 : integer range 0 to 16 := 0;
		variable cpt32 : integer range 0 to 32 := 0;
		variable cpt64 : integer range 0 to 64 := 0;
		variable cpt128 : integer range 0 to 128 := 0;
		variable cpt256 : integer range 0 to 256 := 0;
		begin
				if(clk'event and Clk = '1') then	

						if(cpt2 < 2) then
								cpt2 := cpt2 + 1;
						elsif(cpt2 = 2) then
								cpt2 := 0;
								clk_tmp2 <= not clk_tmp2;
						end if;

						if(cpt4 < 4) then
								cpt4 := cpt4 + 1;
						elsif(cpt4 = 4) then
								cpt4 := 0;
								clk_tmp4 <= not clk_tmp4;
						end if;
						
						if(cpt8< 8) then
								cpt8 := cpt8 + 1;
						elsif(cpt8 = 8) then
								cpt8 := 0;
								clk_tmp8 <= not clk_tmp8;
						end if;
						
						if(cpt16 < 16) then
								cpt16 := cpt16 + 1;
						elsif(cpt16 = 16) then
								cpt16 := 0;
								clk_tmp16 <= not clk_tmp16;
						end if;
						
				
						if(cpt32 < 32) then
								cpt32 := cpt32 + 1;
						elsif(cpt32 = 32) then
								cpt32 := 0;
								clk_tmp32 <= not clk_tmp32;
						end if;	

						if(cpt64 < 64) then
								cpt64 := cpt64 + 1;
						elsif(cpt64 = 64) then
								cpt64 := 0;
								clk_tmp64 <= not clk_tmp64;
						end if;
						
						if(cpt128 < 128) then
								cpt128 := cpt128 + 1;
						elsif(cpt128 = 128) then
								cpt128 := 0;
								clk_tmp128 <= not clk_tmp128;
						end if;	

						if(cpt256 < 256) then
								cpt256 := cpt256 + 1;
						elsif(cpt256 = 256) then
								cpt256 := 0;
								clk_tmp256 <= not clk_tmp256;
						end if;
						
				end if;
		end process;
		
		Clk_div2 <= clk_tmp2;
		Clk_div4 <= clk_tmp4;
		Clk_div8 <= clk_tmp8;
		Clk_div16 <= clk_tmp16;
		Clk_div32 <= clk_tmp32;
		Clk_div64 <= clk_tmp64;
		Clk_div128 <= clk_tmp128;
		Clk_div256 <= clk_tmp256;
		
	
END BEHV ;	
-- ======================