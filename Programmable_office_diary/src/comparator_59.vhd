 library ieee;
use ieee.std_logic_1164.all;

entity comparator59 is 
	port (zeci,unitati:in std_logic_vector(3 downto 0);
	trigger:out std_logic);
end entity;

architecture arhit of comparator59 is

component comparator_4_biti is 
	port (num1,num2:in std_logic_vector(3 downto 0);
	equal:out std_logic);
end component;

component and2 is 
	port(x,y:in std_logic;
	z:out std_logic);
end component;

signal five:std_logic_vector(3 downto 0):="0101";
signal nine:std_logic_vector(3 downto 0):="1001";
signal equal_1,equal_2:std_logic;

begin 
	verif_minut_zeci: comparator_4_biti port map (zeci,five,equal_1);
	verif_minut_unitati: comparator_4_biti port map (unitati,nine,equal_2);
	verif_final: and2 port map (equal_1,equal_2,trigger);
	
end architecture;

