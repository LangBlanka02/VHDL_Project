library ieee;
use ieee.std_logic_1164.all;

entity comparator_24_de_ore is 
	port (ora_zeci,ora_unitati:in std_logic_vector(3 downto 0);
	trigger_24_de_ore:out std_logic);
end entity;

architecture arhi_24_ore of comparator_24_de_ore is 

component comparator_4_biti is 
	port (num1,num2:in std_logic_vector(3 downto 0);
	equal:out std_logic); 
end component;

component and2 is 
	port(x,y:in std_logic;
	z:out std_logic);
end component;

signal equal_1,equal_2:std_logic;
signal four:std_logic_vector(3 downto 0):="0100";
signal two:std_logic_vector(3 downto 0):="0010";

begin 
	verif_ora_zeci: comparator_4_biti port map(ora_zeci,two,equal_1);
	verif_ora_unitati: comparator_4_biti port map (ora_unitati,four,equal_2);
	verif_egalitate: and2 port map (equal_1,equal_2,trigger_24_de_ore);
end architecture;


























		
		