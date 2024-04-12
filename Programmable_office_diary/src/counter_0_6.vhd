 library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Counter_0_6 is
	port(clk,reset,load:in std_logic; 
	Din:in std_logic_vector(3 downto 0);
	Dout:out std_logic_vector(3 downto 0);
	final:out std_logic);
end entity;

architecture arhi of Counter_0_6 is

signal temp:std_logic_vector(3 downto 0) := "0000";

begin
	process (clk, reset)
	begin
			if (reset = '1') then
				temp<= "0000";
			
			elsif (load = '1') then
				temp<= Din;
			
			elsif (clk = '1' and clk'event) then
				temp<=temp+ "0001";
				if (temp= "0110") then
					temp<= "0000";
				end if;
			end if;	
			
			if (temp= "0110") then
				final<='1';
			else 
				final<='0';
			end if;
		
		Dout<=temp;	
		
	end process;  
end architecture;