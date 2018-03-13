-- == LIBRAIRIES ==

library ieee;
use ieee.std_logic_1164.all;


-- == ENTITE ==
ENTITY Gestion_ADC_V2 IS										-- Gestion de l'ADC MCP3201
	PORT(	Clk, Raz_n, data_in: in std_logic;
			Cs_n, Clk_adc : out std_logic;
			angle_barre : out std_logic_vector(11 downto 0)
		 );
END Gestion_ADC_V2 ;
-- ============

-- == ARCHITECHTURE ==
ARCHITECTURE BEHV OF Gestion_ADC_V2 IS

signal sig_Clk_ADC, sig_Cs_n : std_logic;
signal cpt_clk : integer range 0 to 255 := 0;
signal trame_ADC : std_logic_vector(14 downto 0);
-- ==
--
constant max_T : natural := 5e3;												-- 5e3 pour 100µs //5e6 Pour les 100 ms
constant T_cs : natural := 1500;												-- Temps du CS actif de 30µs
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
									
					Clk_adc <= sig_Clk_ADC when sig_Cs_n = '0' else '0';			-- On genere les 1MHz en sortie  qu'au moment du CS
-- #############################################
	
	
	
-- #############################################
-- /CS toutes les 100 ms
	gene_start_conv : process(clk,  raz_n)						-- Clock a 50MHz
							variable cpt_tps : integer range 0 to max_T := 0;
							begin
										if(raz_n = '1') then
											sig_Cs_n <= '0';
											cpt_tps := 0;
										elsif(clk = '1' and clk'event) then										
												if(cpt_tps < T_cs) then														
														cpt_tps := cpt_tps + 1;
														sig_Cs_n <= '0';
												elsif(cpt_tps < max_T ) then
														cpt_tps := cpt_tps + 1;
														sig_Cs_n <= '1';
												elsif(cpt_tps = max_T) then
														cpt_tps := 0;
												end if;																															
										end if;
							end process;
							Cs_n <= sig_Cs_n;							-- Ecriture de la sortie
-- #############################################	

-- #############################################
compt_fronts : process(sig_Clk_ADC)
						variable cpt : integer range 0 to 255 := 0;
						begin
						-- == OKAI FONCTIONNE ..
								if(sig_Clk_ADC = '1' and sig_Clk_ADC'event) then											
											if(sig_Cs_n = '0') then
													cpt := cpt + 1;					-- Compte tous les front de clk_ADC pendant CS = 0
											else
													cpt := 0;	
											end if;											
								end if;
								cpt_clk <= cpt;								
						end process;
-- #############################################						
	
-- #############################################	
	rec_dec : process(sig_Clk_ADC , cpt_clk)
				 variable I : integer range 0 to 15 := 14;									-- INDICE A REVOIR !!!!!§				 
				 begin						
								if(falling_edge(sig_Clk_ADC)) then										-- Datas présentes sur les fronts descendant	
										if(cpt_clk > 3 and cpt_clk < 18) then					-- On recupère seulement la trame entre 3 et 18 => reste on s'en fout
													trame_ADC(I) <= data_in;								
													if(I = 0) then
															I := 15;
													end if;
													I := I - 1;
										end if;
								end if;
							angle_barre(11 downto 0) <= trame_ADC(11 downto 0);								
				 end process;
-- #############################################
END BEHV ;	
-- ======================