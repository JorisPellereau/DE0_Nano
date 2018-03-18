library ieee;
use ieee.std_logic_1164.all;

use ieee.std_Logic_Arith.all;

-----Entite-----------

Entity avalon_barre is
			Port( clk,chipselect, write_n, reset_n : in std_logic ;
					address : in std_logic_vector (1 downto 0) ;
					writedata : in std_logic_vector (31 downto 0);
					readdata : out std_logic_vector (31 downto 0) ;
					pwm_out : out std_logic
					);
end avalon_barre;


-------Achitecture--------

Architecture Arch_avalon of avalon_barre is

component pwm 
					Port( clk, Raz_n, Enable_pwm : in std_logic ;
							freq : in integer range 0 to 65535;		-- Division de la fr�quence clk
							duty : in integer range 0 to 65535;		--duty en %
							out_pwm: out std_logic 
							);
end component;

component interface_bus
			Port( clk, chipselect, write_n, reset_n : in std_logic ;
					address :in std_logic_vector(1 downto 0) ;								-- @ sur 2 bits (4 possibilités)
					writedata : in std_logic_vector (31 downto 0);
					readdata : out std_logic_vector (31 downto 0);
					duty : out std_logic_vector (15 downto 0);
					freq : out std_logic_vector (15 downto 0);
					config : out std_logic_vector (4 downto 0)
					);
end component ;


signal duty : std_logic_vector (15 downto 0);												-- Pour aller vers la PWM
signal freq : std_logic_vector (15 downto 0);
signal config : std_logic_vector (4 downto 0);												-- Registre de config 



Begin 

	interface : interface_bus port map(clk, chipselect, write_n, reset_n, address, writedata, readdata, duty, freq, config) ;
	pwm_interface : pwm port map (clk, config(0), config(1), conv_integer(unsigned(freq)), conv_integer(unsigned(duty)), pwm_out);
end Arch_avalon ;