 library ieee;
 use ieee.std_logic_unsigned.all;
 use ieee.std_logic_1164.all;
 
 entity numarul_lunii is --stabilirea numarului lunii
	 port (luna_zeci,luna_unitati:in std_logic_vector(3 downto 0);
	 nr_luna:out std_logic_vector(3 downto 0));
 end entity;
 
 architecture arhi of numarul_lunii is
 begin
	 process(luna_zeci,luna_unitati)
	 begin 
		 case luna_zeci is
			 when "0000" =>
			 case luna_unitati is 
			  when "0001" => nr_luna<="0001";
 			  when "0010" => nr_luna<="0010";
			  when "0011" => nr_luna<="0011";
			  when "0100" => nr_luna<="0100";
			  when "0101" => nr_luna<="0101";
			  when "0110" => nr_luna<="0110";
			  when "0111" => nr_luna<="0111";
			  when "1000" => nr_luna<="1000";
			  when "1001" => nr_luna<="1001";
			  when others => nr_luna<="0000";
			 end case;
			 
			 when "0001" => 
			 case luna_unitati is 
				 when "0000" => nr_luna<="1010";
				 when "0001" =>nr_luna<="1011";
				 when "0010" =>nr_luna<="1100";
				 when others =>nr_luna<="0000";
			 end case;
			 when others =>nr_luna<="0000";
		 end case;
	 end process;
 end architecture;
 
 
 library ieee;
 use ieee.std_logic_1164.all;
 
 entity stabilire_zi_unitati is 
	 port (nr_luna:in std_logic_vector(3 downto 0);
	 bisect:in std_logic;
	 zi_unitati:out std_logic_vector(3 downto 0));
 end entity;
 
 architecture arhi of stabilire_zi_unitati is
 begin 
	 process(nr_luna,bisect)
	 begin 
		 case nr_luna is
			 when "0001" =>zi_unitati<="0001";
			 when "0010" =>
			     if bisect='1'then 
				         zi_unitati<="1000";
			        else zi_unitati<="1000";
				 end if;
			when "0011" =>zi_unitati<="0001";
			when "0100" =>zi_unitati<="0000";
			when "0101" =>zi_unitati<="0001";
			when "0110" =>zi_unitati<="0000";
			when "0111" =>zi_unitati<="0001";
			when "1000" =>zi_unitati<="0001";
			when "1001" =>zi_unitati<="0000";
			when "1010" =>zi_unitati<="0001";
			when "1011" =>zi_unitati<="0000";
			when "1100" =>zi_unitati<="0001";
			when others =>zi_unitati<="0000";
			end case;
	 end process;
end architecture;



library ieee;
use ieee.std_logic_1164.all;

entity stabilire_zi_zeci is 
	port (nr_luna:in std_logic_vector(3 downto 0);
	zi_zeci:out std_logic_vector(3 downto 0));
end entity;

architecture arhi of stabilire_zi_zeci is 
begin 
	process(nr_luna)
	begin 
		case nr_luna is 
			when "0001" => zi_zeci <= "0011";
			when "0010" => zi_zeci <= "0010"; 				
			when "0011" => zi_zeci <= "0011";		
			when "0100" => zi_zeci <= "0011";		
			when "0101" => zi_zeci <= "0011";		
			when "0110" => zi_zeci <= "0011";	
			when "0111" => zi_zeci <= "0011";		
			when "1000" => zi_zeci <= "0011";		
			when "1001" => zi_zeci <= "0011";		
			when "1010" => zi_zeci <= "0011";		
			when "1011" => zi_zeci <= "0011";		
			when "1100"	=> zi_zeci <= "0011";	
			when others => zi_zeci <= "0011";
		end case;
	end process;
end architecture;



library ieee;
use ieee.std_logic_1164.all;

entity nr_zile_din_luna is 
	port (luna_zeci,luna_unitati:std_logic_vector(3 downto 0);
	bisect:in std_logic;
	zi_zeci,zi_unitati:out std_logic_vector (3 downto 0));
end entity;


architecture arhi of nr_zile_din_luna is 
component numarul_lunii is 
	 port (luna_zeci,luna_unitati:in std_logic_vector(3 downto 0);
	 nr_luna:out std_logic_vector(3 downto 0));
end component;

component stabilire_zi_unitati is 
	 port (nr_luna:in std_logic_vector(3 downto 0);
	 bisect:in std_logic;
	 zi_unitati:out std_logic_vector(3 downto 0));
end component;

component stabilire_zi_zeci is 
	port (nr_luna:in std_logic_vector(3 downto 0);
	zi_zeci:out std_logic_vector(3 downto 0));
end component;

signal nr_luna :std_logic_vector(3 downto 0);

begin 
	aflam_luna:numarul_lunii port map (luna_zeci,luna_unitati,nr_luna);
	aflam_zeci_luna:stabilire_zi_zeci port map (nr_luna,zi_zeci);
	aflam_unitati_luna:stabilire_zi_unitati port map (nr_luna,bisect,zi_unitati);
	
end architecture;