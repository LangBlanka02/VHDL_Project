library ieee;
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all;  

entity mux_2_1 is
	port(intrare_0, intrare_1 : in std_logic;
	selectie : in std_logic;
	iesire : out std_logic);
end entity;	  

architecture arhi of mux_2_1 is

begin
	process(intrare_0, intrare_1,selectie)
	begin
		case selectie is
			when '0' => iesire <= intrare_0 ;
			when '1' => iesire <= intrare_1;	   
			when others => iesire <= '0';
		end case;							
	end process;
end architecture; 


library ieee;
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all;  

entity mux_2_1_specific is
	port(selectie : in std_logic;
	iesire : out std_logic_vector(1 downto 0));
end entity;	  

architecture arhi of mux_2_1_specific is

begin
	process(selectie)
	begin
		case selectie is
			when '0' => iesire <= "00";
			when '1' => iesire <= "10";	   
			when others => iesire <= "11";
		end case;							
	end process;
end architecture; 


library ieee;
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all;  

entity mux_2_1_final is
	port(intrare : in std_logic;
	selectie : in std_logic;
	iesire : out std_logic);
end entity;	  

architecture arhi of mux_2_1_final is

begin
	process(intrare, selectie)
	begin
		case selectie is
			when '0' => iesire <= '0' ;
			when '1' => iesire <= intrare;	   
			when others => iesire <= '0';
		end case;							
	end process;
end architecture;


library ieee;
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all; 

entity sumator_1_bit is
	port(intrare_0, intrare_1 : in std_logic;
	carry_in : in std_logic;
	iesire : out std_logic;
	carry_out : out std_logic);
end entity;	  

architecture arhi of sumator_1_bit is

begin
	iesire <= intrare_0 xor intrare_1 xor carry_in;
	carry_out <= (intrare_0 and intrare_1) or (carry_in and (intrare_0 xor intrare_1));
end architecture;


library ieee;
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all; 

entity sumator_2_biti is
	port(an_0, an_1, intrare_0, intrare_1 : in std_logic;
	carry_in : in std_logic;
	iesire_0, iesire_1 : out std_logic;
	carry_out : out std_logic);
end entity;	  

architecture arhi of sumator_2_biti is

component sumator_1_bit 
	port(intrare_0, intrare_1 : in std_logic;
	carry_in : in std_logic;
	iesire : out std_logic;
	carry_out : out std_logic);
end component;

signal carry_aux : std_logic; 

begin
	prima_adunare : sumator_1_bit port map(an_0, intrare_0, carry_in, iesire_0, carry_aux);
	a_doua_adunare : sumator_1_bit port map(an_1, intrare_1, carry_aux, iesire_1, carry_out);
end architecture;


library ieee;
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all;

entity poarta_nu is
	port(numar : in std_logic;
	inversat : out std_logic);
end entity;

architecture arhi of poarta_nu is
begin
	inversat <= not numar;
end architecture; 


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity si_2 is
	port(x, y : in std_logic;
	q : out std_logic);
end entity;

architecture arh_si_2 of si_2 is
begin
	q <= x and y;
end;


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity or_8_intrari is
	port(a, b, c, d, e, f, g, h : in std_logic;
	rezultat : out std_logic);
end entity;

architecture arhi of or_8_intrari is

begin
	rezultat <= a or b or c or d or e or f or g;
end architecture;	


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity an_bisect is
	port(an : in std_logic_vector(15 downto 0);
	bisect : out std_logic);
end entity;

architecture arhi_bisect of an_bisect is

component mux_2_1 
	port(intrare_0, intrare_1 : in std_logic;
	selectie : in std_logic;
	iesire : out std_logic);
end component;

component mux_2_1_specific
	port(selectie : in std_logic;
	iesire : out std_logic_vector(1 downto 0));
end component; 

component sumator_2_biti 
	port(an_0, an_1, intrare_0, intrare_1 : in std_logic;
	carry_in : in std_logic;
	iesire_0, iesire_1 : out std_logic;
	carry_out : out std_logic);
end component; 

component poarta_nu
	port(numar : in std_logic;
	inversat : out std_logic);
end component;	 

component si_2
	port(x, y : in std_logic;
	q : out std_logic);
end component;	 

component or_8_intrari 
	port(a, b, c, d, e, f, g, h : in std_logic;
	rezultat : out std_logic);
end component;	

component mux_2_1_final
	port(intrare : in std_logic;
	selectie : in std_logic;
	iesire : out std_logic);
end component;

signal iesire_1_aux, iesire_2_aux : std_logic_vector(1 downto 0);	   
signal carry_out_aux : std_logic;
signal inversat_0, inversat_1, inversat_2, inversat_3 : std_logic;	 
signal rezultat_0, rezultat_1 : std_logic;
signal rezultat_or_0, rezultat_or_1 : std_logic; 
signal rezultat_mux : std_logic;

begin 
	mux_1_specific : mux_2_1_specific port map(an(4), iesire_1_aux); 
	sumator_1 : sumator_2_biti port map(an(0), an(1), iesire_1_aux(0), iesire_1_aux(1), '0', carry_out_aux);  
	
	inversare_1 : poarta_nu port map(iesire_1_aux(0), inversat_0);
	inversare_2 : poarta_nu port map(iesire_1_aux(1), inversat_1);	 
	
	and_1 : si_2 port map(inversat_0, inversat_1, rezultat_0);
	
	mux_2_specific : mux_2_1_specific port map(an(12), iesire_2_aux);	
	sumator_2 : sumator_2_biti port map(an(8), an(9), iesire_2_aux(0), iesire_2_aux(1), '0', carry_out_aux);	
	
	inversare_3 : poarta_nu port map(iesire_2_aux(0), inversat_2);
	inversare_4 : poarta_nu port map(iesire_2_aux(1), inversat_3);	 
	
	and_2 : si_2 port map(inversat_2, inversat_3, rezultat_1); 
	
	or_1 : or_8_intrari port map(an(0), an(1), an(2), an(3), an(4), an(5), an(6), an(7), rezultat_or_0);	
	
	mux_1 : mux_2_1 port map(rezultat_1, rezultat_0, rezultat_or_0, rezultat_mux);  
	
	or_2 : or_8_intrari port map(an(8), an(9), an(10), an(11), an(12), an(13), an(14), an(15), rezultat_or_1);
	
	mux_final : mux_2_1_final port map(rezultat_mux, rezultat_or_1, bisect);

end architecture;