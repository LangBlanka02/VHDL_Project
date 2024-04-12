library ieee;
use ieee.std_logic_1164.all;

entity verificare_final_an is 
	port(luna_zeci,luna_unitati:in std_logic_vector(3 downto 0);
	final_an:out std_logic);
end entity;

architecture arhi of verificare_final_an is

component comparator_4_biti is 
	port (num1,num2:in std_logic_vector(3 downto 0);
	equal:out std_logic);	 
end component;

component and2 is 
	port(x,y:in std_logic;
	z:out std_logic);
end component; 

signal temp1:std_logic;
signal temp2:std_logic;
signal two:std_logic_vector(3 downto 0):="0010";
signal one:std_logic_vector(3 downto 0):="0001";

begin
	verif_luna_zeci: comparator_4_biti port map (luna_zeci,one,temp1);
	verif_luna_unitati: comparator_4_biti port map (luna_unitati,two,temp2);
	verif_final: and2 port map (temp1,temp2,final_an);
	
end architecture;



