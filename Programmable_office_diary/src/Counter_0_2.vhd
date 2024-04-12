library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all;
use IEEE.STD_LOGIC_unsigned.ALL;

entity Counter_0_2 is
port (clk, enable, reset,load: in std_logic;
Dout : out std_logic_vector(3 downto 0);
Din:in std_logic_vector(3 downto 0);
verificare:in std_logic_vector(3 downto 0);
Final: out std_logic
);		
end entity;

architecture behave of Counter_0_2 is

signal temporar : std_logic_vector(3 downto 0):="0000" ; 
begin
 process(load,reset,enable,clk)
 begin
	 if reset ='1' then 
		 temporar<="0000";
	 elsif load='1' then 
		 temporar<=Din;
	 elsif clk='1' and clk'event then 
		 if enable='1' then  
			 if temporar="0010" and verificare="0100" then
				 Final<='1';
				 temporar<="0000";			 
			 elsif  temporar < "0010" then temporar<=temporar+"0001";
				 Final<='0';
			 elsif temporar="0010" and verificare>"0100" then 
				 Final<='1';
				 temporar<="0000";
			 end if ;
			end if;
	 end if;
	 
		 end process; 
		  Dout<=temporar;
	 end architecture;
	 