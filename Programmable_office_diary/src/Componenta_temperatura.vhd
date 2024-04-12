library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity temperatura is
    Port ( clk:in std_logic;
           reset:in std_logic;
           temp_out:out std_logic_vector (4 downto 0));
end entity;

architecture arhi of temperatura is

signal num1:std_logic_vector(4 downto 0):="00000";
signal num2:std_logic_vector(4 downto 0):="01100";

begin
	process(clk, reset)
	begin
		if reset = '1' then 
			num1 <= (others => '0');
			num2 <= (others => '1');
		elsif clk='1' and clk'event then
			num1<=num1 + 1;
			num2<=num2 + 2;
		end if;
	end process;
temp_out<= (num1 xor num2);

end architecture;

