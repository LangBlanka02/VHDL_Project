library ieee;
use ieee.std_logic_1164.all;

entity calendar is 
	port (clk,reset,load,enable:in std_logic;
	zi_zeci_in:in std_logic_vector(3 downto 0);
	zi_unitati_in:in std_logic_vector(3 downto 0);
	luna_zeci_in:in std_logic_vector(3 downto 0);
	luna_unitati_in:in std_logic_vector(3 downto 0);
	an_zeci_in:in std_logic_vector(3 downto 0);
	an_unitati_in:in std_logic_vector(3 downto 0);
	zi_zeci_out:out std_logic_vector(3 downto 0);
	zi_unitati_out:out std_logic_vector(3 downto 0);
	luna_zeci_out:out std_logic_vector(3 downto 0);
	luna_unitati_out:out std_logic_vector(3 downto 0);
	an_zeci_out:out std_logic_vector(3 downto 0);
	an_unitati_out:out std_logic_vector(3 downto 0));
end entity;

architecture arhi of calendar is 

signal an:std_logic_vector (15 downto 0) :="0010000000000000";--2000
signal bisect:std_logic;

signal nr_zile_zeci_temp:std_logic_vector(3 downto 0):="0000";	
signal nr_zile_unitati_temp:std_logic_vector(3 downto 0):="0000";

signal zi_zeci_temp:std_logic_vector(3 downto 0):="0000";	
signal zi_unitati_temp:std_logic_vector(3 downto 0):="0001";  
signal luna_zeci_temp:std_logic_vector(3 downto 0):="0000";	 
signal luna_unitati_temp:std_logic_vector(3 downto 0):="0001";

signal stop:std_logic;

signal final_luna, trigger_zi_zeci, trigger_luna_zeci, final_an, trigger_an_unitati, trigger_an_zeci : std_logic;

component an_bisect is 
	port(an:in std_logic_vector(15 downto 0);
	bisect:out std_logic);
end component ;

component nr_zile_din_luna is 
	port (luna_zeci,luna_unitati:std_logic_vector(3 downto 0);
	bisect:in std_logic;
	zi_zeci,zi_unitati:out std_logic_vector (3 downto 0));
end component ;

component  nr_zile is 
	port (zi_zeci,zi_unitati:in std_logic_vector(3 downto 0);
	nr_zile_zeci,nr_zile_unitati:in std_logic_vector(3 downto 0);
	equal:out std_logic);
end component;

component Counter_0_9 is
port (clk, enable, reset,load: in std_logic;
Dout : out std_logic_vector(3 downto 0);
Din:in std_logic_vector(3 downto 0);
Final: out std_logic);
end component;

component Counter_0_3 is
port (clk, enable, reset,load: in std_logic;
Dout : out std_logic_vector(3 downto 0);
Din:in std_logic_vector(3 downto 0);
Final: out std_logic);		
end component;

component Counter_0_1 is
port (clk, enable, reset,load: in std_logic;
Dout : out std_logic_vector(3 downto 0);
Din:in std_logic_vector(3 downto 0);
Final: out std_logic
);		
end component;

component verificare_final_an is 
	port(luna_zeci,luna_unitati:in std_logic_vector(3 downto 0);
	final_an:out std_logic);
end component; 

begin 
	an(7 downto 4)<=an_zeci_in;
	an(3 downto 0)<=an_unitati_in;
	
bisect_nubisect: an_bisect port map (an=>an,
bisect=>bisect);

num_zile_din_luna:nr_zile_din_luna port map (luna_zeci=>luna_zeci_temp,
luna_unitati=>luna_unitati_temp,
bisect=>bisect,
zi_zeci=>nr_zile_zeci_temp,
zi_unitati=>nr_zile_unitati_temp);

finalul_luna:nr_zile port map(zi_zeci=>zi_zeci_temp,
nr_zile_zeci=>nr_zile_zeci_temp,
		zi_unitati=>zi_unitati_temp,
		nr_zile_unitati=>nr_zile_unitati_temp,
		equal=>final_luna);
		
zile_unitati : counter_0_9 port map(clk=>clk, 
		reset=>final_luna,
		load =>load,
		enable=>enable,
		Din=>zi_unitati_in, 
		Dout=>zi_unitati_temp,
		Final=>trigger_zi_zeci);   
		
		
zile_zeci : counter_0_3 port map(clk=>trigger_zi_zeci, 
		reset=>final_luna,
		load =>load,
		enable=>enable,
		Din=>zi_zeci_in, 
		Dout=>zi_zeci_temp,
		Final=>stop); 
		
luna_unitati:Counter_0_9 port map(clk => final_luna, 
		reset => final_an,
		load => load,
		enable=>enable,
		Din => luna_unitati_in, 
		Dout => luna_unitati_temp,
		final=> trigger_luna_zeci);	

luna_zeci:Counter_0_1 port map(clk =>trigger_luna_zeci, 
		reset=>reset,
		load=>load,
		enable=>enable,
		Din=>luna_zeci_in, 
		Dout=>luna_zeci_temp,
		final=> trigger_an_unitati); 
				
verificaree_final_an:verificare_final_an port map (luna_zeci=>luna_zeci_temp,
luna_unitati=>luna_unitati_temp,
final_an=>final_an);

an_unitati:counter_0_9 port map(clk => final_an, 
		reset => reset,
		load => load,
		enable=>enable,
		Din => an_unitati_in, 
		Dout => an_unitati_out,
		final=>trigger_an_zeci);	
		
	an_zeci :counter_0_9 port map(clk =>trigger_an_zeci, 
		reset=>reset,
		load=>load,
		enable=>enable,
		Din => an_zeci_in, 
		Dout => an_zeci_out,
		final=>stop);
		
	 zi_zeci_out <= zi_zeci_temp;
	 zi_unitati_out <= zi_unitati_temp;
	 luna_zeci_out<= luna_zeci_temp;
	 luna_unitati_out<= luna_unitati_temp;
		
end architecture;