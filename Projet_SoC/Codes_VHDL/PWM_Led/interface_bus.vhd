library ieee;
use ieee.std_logic_1164.all;

-----Entite-----------

Entity interface_bus is
			Port( clk,chipselect, write_n, reset_n : in std_logic ;
					address :in std_logic_vector(1 downto 0) ;								-- @ sur 2 bits (4 possibilités)
					writedata : in std_logic_vector (31 downto 0);
					readdata : out std_logic_vector (31 downto 0);
					duty : out std_logic_vector (15 downto 0);
					freq : out std_logic_vector (15 downto 0);
					config : out std_logic_vector (4 downto 0)
					);
end interface_bus;


-------Achitecture--------

Architecture Arch_interface_bus of interface_bus is


Begin 

registers: process (clk, reset_n)
	begin

		if reset_n = '0' then
			freq <= (others =>'0') ;
			duty <= (others =>'0') ;
			elsif clk'event and clk ='1' then
							if chipselect ='1' and write_n = '0' then
												if (address = "00") then													-- Selection freq
													freq <= writedata (15 downto 0);
												elsif (address = "01") then												-- Selection Duty
														duty <= writedata (15 downto 0);
												elsif (address = "10") then												-- Selection config
														config(4 downto 0) <= writedata(4 downto 0); 				-- Ecriture du registre de config, suivant la valeur de WriteData
												end if ;
							end if;
		end if ;
	
end process registers ;

--readdata <= X"0000"&freq when address = 0;
--readdata <= X"0000"&duty when address = 1 ;
--readdata <= X"0000"&sig_sens when address = 2 ;

end Arch_interface_bus ;