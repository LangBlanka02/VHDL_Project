library ieee;
use ieee.std_logic_1164.all;

entity ceas is 
	port (clk,reset,load,enable:in std_logic;
	      minut_unitati_in:in std_logic_vector(3 downto 0);
          minut_zeci_in:in std_logic_vector(3 downto 0);
		  ora_unitati_in:in std_logic_vector(3 downto 0);
		  ora_zeci_in:in std_logic_vector(3 downto 0);
		  minut_unitati_out:out std_logic_vector(3 downto 0);
          minut_zeci_out:out std_logic_vector(3 downto 0);
		  ora_unitati_out:out std_logic_vector(3 downto 0);
		  ora_zeci_out:out std_logic_vector(3 downto 0);
		  trigger_zi:out std_logic);
end entity;

architecture arhi of ceas is 

component  Counter_0_9 is
port (clk, enable, reset,load: in std_logic;
Dout : out std_logic_vector(3 downto 0);
Din:in std_logic_vector(3 downto 0);
ora_2:in std_logic_vector(3 downto 0):="0000";
Final: out std_logic
);		
end component;

component Counter_0_5 is
port (clk, enable, reset,load: in std_logic;
Dout : out std_logic_vector(3 downto 0);
Din:in std_logic_vector(3 downto 0);
Final: out std_logic
);		
end component;

component Counter_0_2 is
port (clk, enable, reset,load: in std_logic;
Dout : out std_logic_vector(3 downto 0);
Din:in std_logic_vector(3 downto 0);
verificare:in std_logic_vector(3 downto 0);
Final: out std_logic
);		
end component;

component comp24 is 
	port (ora_zeci,ora_unitati:in std_logic_vector(3 downto 0);
	minut_unitati,minut_zeci:in std_logic_vector(3 downto 0);
	trigger_zi_24:out std_logic);
end component;

signal minut_unitati_temporar:std_logic_vector(3 downto 0):="0000";
signal minut_zeci_temporar:std_logic_vector(3 downto 0):="0000";
signal ora_unitati_temporar:std_logic_vector(3 downto 0):="0000";
signal ora_zeci_temporar:std_logic_vector(3 downto 0):="0000";
signal trigger_minut_zeci:std_logic;
signal trigger_ora_unitati:std_logic;
signal trigger_ora_zeci:std_logic;
signal trigger_ora_final:std_logic;
signal stop:std_logic;

begin 
	
casc_minut_unitati:Counter_0_9 port map(clk=>clk,
enable=>enable,
reset=>reset,
load=>load,
Dout=>minut_unitati_temporar,
Din=>minut_unitati_in,
final=>trigger_minut_zeci);

casc_minute_zeci:Counter_0_5 port map(clk=>trigger_minut_zeci,
enable=>enable,
reset=>reset,
load=>load,
Dout=>minut_zeci_temporar,
Din=>minut_zeci_in,
final=>trigger_ora_unitati);

casc_ora_unitati:Counter_0_9 port map(clk=>trigger_ora_unitati,
enable=>enable,
reset=>reset,
load=>load,
Dout=>ora_unitati_temporar,
Din=>ora_unitati_in,
ora_2=>ora_zeci_temporar,
final=>trigger_ora_zeci);

casc_ora_zeci:Counter_0_2 port map(clk=>trigger_ora_zeci,
enable=>enable,
reset=>reset,
load=>load,
Dout=>ora_zeci_temporar,
verificare=>ora_unitati_temporar,
Din=>ora_zeci_in,
final=>stop);

comparare_24_de_ore: comp24 port map (ora_zeci=>ora_zeci_temporar,
ora_unitati=>ora_unitati_temporar,
minut_zeci=>minut_zeci_temporar,
minut_unitati=>minut_unitati_temporar,
trigger_zi_24=>trigger_ora_final);

minut_unitati_out<=minut_unitati_temporar;
minut_zeci_out<=minut_zeci_temporar;
ora_unitati_out<=ora_unitati_temporar;
ora_zeci_out<=ora_zeci_temporar;
trigger_zi<=trigger_ora_final;

end architecture;