library ieee;
use ieee.std_logic_1164.all;	
use ieee.std_logic_unsigned.all;	   
use ieee.std_logic_arith.all;

entity comp24 is 
	port (ora_zeci,ora_unitati:in std_logic_vector(3 downto 0);
	minut_unitati,minut_zeci:in std_logic_vector(3 downto 0);
	trigger_zi_24:out std_logic);
end entity;

architecture arhi of comp24 is 

signal equal_1,equal_2:std_logic;
signal two:std_logic_vector(3 downto 0):="0010";
signal three:std_logic_vector(3 downto 0):="0011";
signal five:std_logic_vector(3 downto 0):="0101";
signal nine:std_logic_vector(3 downto 0):="1001";

begin 
	process(ora_zeci,ora_unitati,minut_zeci,minut_unitati)
	begin 
		if ((ora_zeci = two) and (ora_unitati = three) and (minut_zeci=five) and (minut_unitati=nine))then 
			trigger_zi_24<='1';
		else trigger_zi_24<='0';
		end if;
	end process;
end architecture;
	