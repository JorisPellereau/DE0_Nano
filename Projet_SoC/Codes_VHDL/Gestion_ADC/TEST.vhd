-- == LIBRAIRIES ==

library ieee;
use ieee.std_logic_1164.all;

-- == ENTITE ==
ENTITY TEST IS										-- Gestion de l'ADC MCP3201
	PORT(	Clk, Raz_n, data_in : in std_logic;
			Cs_n, Clk_adc, en_mot : out std_logic;
			leds : out std_logic_vector(7 downto 0)
			--angle_barre : out std_logic_vector(11 downto 0)
		 );
END TEST ;
-- ============

-- == ARCHITECHTURE ==
ARCHITECTURE BEHV OF TEST IS

component Gestion_ADC_V3
PORT(	Clk, Raz_n, data_in : in std_logic;
			Cs_n, Clk_adc : out std_logic;
			angle_barre : out std_logic_vector(11 downto 0)
		 );
end component;

signal angle_barre : std_logic_vector(11 downto 0);

BEGIN
		en_mot <= '0';
		leds(7 downto 0) <= angle_barre(11 downto 4);
	
	toto : Gestion_ADC_V3 port map(	Clk, Raz_n, data_in, Cs_n, Clk_adc, angle_barre);
END BEHV ;	

-- ======================
