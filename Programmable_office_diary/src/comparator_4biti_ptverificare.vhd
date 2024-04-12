library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity comparator_4_biti is 
	port (num1,num2:in std_logic_vector(3 downto 0);
	equal:out std_logic);
end entity;

architecture compar24 of comparator_4_biti is 
begin 
	process(num1,num2)
	begin 
		if num1=num2 then equal<='1';
		else equal<='0';
		end if;
	end process;
end architecture;