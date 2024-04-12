library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all;
use IEEE.STD_LOGIC_unsigned.ALL;


entity Counter_0_9 is
port (clk, enable, reset,load: in std_logic;
Dout : out std_logic_vector(3 downto 0);
Din:in std_logic_vector(3 downto 0);
ora_2:in std_logic_vector(3 downto 0):="0000";
Final: out std_logic
);		
end entity;

architecture behave of Counter_0_9 is

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
			 temporar <= temporar +"0001";
			 if temporar="0100" and ora_2="0010" then 
				 Final<='1';
				 temporar<="0000";
			 elsif temporar="1001" then 
				 Final<='1';
				 temporar<="0000";
				 else final<='0';
			 end if;
		 end if;
	 end if;
	 Dout<=temporar;
	 end process;
	 end architecture;
	 