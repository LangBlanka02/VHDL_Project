library ieee;
use ieee.std_logic_1164.all;

entity compalarm is 
	port (alarma_pornita:in std_logic;
	ora_zeci_ceas,ora_unitati_ceas:in std_logic_vector(3 downto 0);
	minut_zeci_ceas,minut_unitati_ceas:in std_logic_vector(3 downto 0);
	ora_zeci_alarma,ora_unitati_alarma:in std_logic_vector(3 downto 0);
	minut_zeci_alarma,minut_unitati_alarma:in std_logic_vector(3 downto 0);
	equal:out std_logic);
end entity;

architecture arhi of compalarm is 
begin
process(ora_zeci_ceas,ora_unitati_ceas,minut_zeci_ceas,minut_unitati_ceas,ora_zeci_alarma,ora_unitati_alarma,minut_zeci_alarma,minut_unitati_alarma,alarma_pornita)
begin
	if alarma_pornita='1' then 
	if ((ora_zeci_ceas=ora_zeci_alarma) and (ora_unitati_ceas=ora_unitati_alarma) and (minut_zeci_ceas=minut_zeci_Alarma) and (minut_unitati_ceas=minut_unitati_alarma)) then 
		equal<='1';
	else 
		equal<='0';
	end if;
	end if;
	end process;
end architecture;
