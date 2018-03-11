-- == LIBRAIRIES ==

library ieee;
use ieee.std_logic_1164.all;


-- == ENTITE ==
ENTITY Gestion_ADC IS										-- Gestion de l'ADC MCP3201
	PORT(	Clk, Raz_n, data_in: in std_logic;
			--data_in : in integer range 0 to 65535;
			Cs_n, Clk_adc : out std_logic;
			angle_barre : out std_logic_vector(11 downto 0)
		 );
END Gestion_ADC ;
-- ============

-- == ARCHITECHTURE ==
ARCHITECTURE BEHV OF Gestion_ADC IS

-- Clock a 50 MHs => T_clk = 20ns
constant T_start_conv : natural := 5e6;				-- Pour compter les 100ms
constant T_cs : natural := 783;							-- Pour compter le temps du CS -- Fitter pour avoir 15 coup d'H 1MHz

signal sig_Clk_ADC : std_logic;
signal cpt_clk_ADC : integer range 0 to 20;			-- A FAIRE GAFFFFFE !!! ici 
signal sig_Cs_n : std_logic;
signal trame_ADC : std_logic_vector(14 downto 0);
signal flag_cpt : std_logic;
BEGIN


	-- /CS toutes les 100 ms
	gene_start_conv : process(clk,  raz_n)						-- Clock a 50MHz
							variable cpt_tps : integer range 0 to 5e6 := 0;
							begin
										if(raz_n = '1') then
											Cs_n <= '0';
											cpt_tps := 0;
										elsif(rising_edge(clk)) then
										
												if(cpt_tps < T_cs) then														
														cpt_tps := cpt_tps + 1;
														sig_Cs_n <= '0';
												elsif(cpt_tps < T_start_conv ) then
														cpt_tps := cpt_tps + 1;
														sig_Cs_n <= '1';
												elsif(cpt_tps = T_start_conv) then
														cpt_tps := 0;
												end if;																			
												Cs_n <= sig_Cs_n;
										end if;
							end process;
							
							
	gene_1MHz : process(sig_CS_n, clk, raz_n, cpt_clk_ADC)												-- sig_CS_n peut petre pas necessaire ?
					variable cpt_T : integer range 0 to 25 := 0;							-- 25*20ns = 0.5µS soit T1MHz/2
					begin
										if(raz_n = '1') then
												sig_Clk_ADC <= '0';
										elsif(rising_edge(clk)) then										
													if(sig_CS_n = '0') then
																if(cpt_T < 25) then
																		cpt_T := cpt_T + 1;
																elsif(cpt_T = 25) then
																		cpt_T := 0;
																		sig_Clk_ADC <= not sig_Clk_ADC;
																end if;
													--elsif(sig_CS_n = '1') then
														elsif(cpt_clk_ADC = 15) then
															sig_Clk_ADC <= '0';
													end if;													
										end if;
					
					end process;
					Clk_adc <= sig_Clk_ADC;
					
					
	compt_fronts : process(raz_n, sig_Clk_ADC, sig_CS_n)
						variable cpt_clk : integer range 0 to 255 := 0;
						begin
						-- == OKAI FONCTIONNE ..
								if(rising_edge(sig_CS_n)) then
										cpt_clk := 0;
								elsif(rising_edge(sig_Clk_ADC)) then
												if(sig_CS_n = '0') then
														
																cpt_clk := cpt_clk + 1;
														
												elsif(sig_CS_n = '1') then
														cpt_clk := 0;										
											end if;												
								end if;
								
						end process;
	
	-- RECUPERATION DES DATAS DE L'ADC
	rec_dec : process(sig_Clk_ADC,cpt_clk_ADC)
				 variable I : integer range 0 to 15 := 14;									-- INDICE A REVOIR !!!!!§				 
				 begin						
								if(falling_edge(sig_Clk_ADC)) then										-- Datas présentes sur les fronts descendant	

										trame_ADC(I) <= data_in;								
										if(I = 0) then
												I := 15;
										end if;
										I := I - 1;
								end if;
							angle_barre(11 downto 0) <= trame_ADC(11 downto 0);								
				 end process;
				 
	
END BEHV ;	
-- ======================