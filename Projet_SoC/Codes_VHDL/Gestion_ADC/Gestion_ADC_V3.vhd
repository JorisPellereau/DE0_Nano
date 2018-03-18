-- == LIBRAIRIES ==

library ieee;
use ieee.std_logic_1164.all;

-- == ENTITE ==
ENTITY Gestion_ADC_V3 IS										-- Gestion de l'ADC MCP3201
	PORT(	Clk, Raz_n, data_in: in std_logic;
			Cs_n, Clk_adc : out std_logic;
			angle_barre : out std_logic_vector(11 downto 0)
		 );
END Gestion_ADC_V3 ;
-- ============

-- == ARCHITECHTURE ==
ARCHITECTURE BEHV OF Gestion_ADC_V3 IS

signal sig_Clk_ADC,  sig_cs : std_logic;
signal trame_ADC : std_logic_vector(14 downto 0);

BEGIN

-- ##############################################
gene_1MHz : process(clk, raz_n)												-- sig_CS_n peut petre pas necessaire ?
					variable cpt_T : integer range 0 to 25 := 0;							-- 25*20ns = 0.5µS soit T1MHz/2
				
					begin
										if(raz_n = '1') then
												sig_Clk_ADC <= '0';
										elsif(clk = '1' and clk'event) then
												
														if(cpt_T < 25) then
																cpt_T := cpt_T + 1;
														else  -- (cpt_T = 25) 
																cpt_T := 0;
																sig_Clk_ADC <= not sig_Clk_ADC;
														end if;
																											
										end if;					
					end process;
						
					Clk_adc <= sig_Clk_ADC;									-- Generation des 1MHz
---- #############################################

gestion_CS : process(sig_Clk_ADC)
				 variable cpt: integer range 0 to 30;
				 begin
					
						if(rising_edge(sig_Clk_ADC)) then
								cpt := cpt + 1;
								if(cpt = 15) then										
										sig_cs <= '1';
								elsif(cpt = 30) then
									   sig_cs <= '0';
										cpt := 0;
								end if;
								
						end if;							
				 
				 end process;
				 Cs_n <= sig_cs;
			 
				 
 recup_data :   process(sig_Clk_ADC, Raz_n)
	variable I : integer range 0 to 15;
	begin
			if(raz_n = '1') then
					I := 15;
			elsif(rising_edge(sig_Clk_ADC)) then
					if(sig_cs = '0') then											
						I :=  I - 1;
						trame_ADC(I) <= data_in;										
						if(I = 0) then
								I := 15;
						end if;																				
					end if;
			end if;
	end process;
 
				 
			angle_barre <= trame_ADC(11 downto 0);
END BEHV ;	

-- ======================





















--			
--	
---- #############################################
---- 
--	gene_start_conv : process(sig_Clk_ADC, flag_CS)						-- Clock a 50MHz
--							variable cpt_cs_on : integer range 0 to 100;
--							begin
--									if(Flag_CS = '1') then
--											sig_Cs_n <= '1';
--											Flag_CS <= '0';
--									elsif(sig_Clk_ADC'event and sig_Clk_ADC = '1') then				--// Sur front Montantde CLK ADC
--											if(cpt_cs_on < 100) then
--													cpt_cs_on := cpt_cs_on + 1;
--											else
--													cpt_cs_on := 0;
--													sig_Cs_n <= '0';					-- On active le CS
--													
--											end if;
--										
--									end if;
--							end process;
--	
--	Cs_n <= sig_Cs_n;
--
---- #############################################	
--
---- #############################################	
--
--compt_fronts : process(sig_Clk_ADC, Raz_n)
--					variable cpt_clk : integer range 0 to 15;
--					begin
--							if(Raz_n = '1') then
--									cpt_clk := 0;									
--							elsif(sig_Clk_ADC = '1' and sig_Clk_ADC'event) then
--							
--									if(sig_Cs_n = '0') then
--											if(cpt_clk < 15) then
--													cpt_clk := cpt_clk + 1;												
--											elsif(cpt_clk = 15) then 
--													Flag_CS <= '1';
--													cpt_clk := 0;					-- RAZ CPT
--											end if;
--									end if;
--									
--							end if;
--					end process;
--
---- #############################################	