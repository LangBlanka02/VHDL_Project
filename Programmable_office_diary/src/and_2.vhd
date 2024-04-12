library ieee;
use ieee.std_logic_1164.all;

entity and2 is 
	port(x,y:in std_logic;
	z:out std_logic);
end entity;

architecture and2 of and2 is 
begin 
	z<=x and y;
end architecture;


