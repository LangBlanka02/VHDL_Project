library ieee; --asta verifica constant daca trebuie sa creasca nr de zile sau a ajuns la final signal se schimba luna 
use ieee.std_logic_1164.all;

entity nr_zile is 
	port (zi_zeci,zi_unitati:in std_logic_vector(3 downto 0);
	nr_zile_zeci,nr_zile_unitati:in std_logic_vector(3 downto 0);
	equal:out std_logic);
end entity;

architecture arhi of nr_zile is
begin 
	process(zi_zeci,zi_unitati)
	begin 
		if zi_zeci=nr_zile_zeci and zi_unitati=nr_zile_unitati then 
		equal<='1';	
		else equal<='0';
		end if;
	end process;
end architecture;