 library ieee;
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all;

entity agenda_programabila is
	port(clk, reset, enable, load : in std_logic;
	ora_zeci : in std_logic_vector(3 downto 0);
	ora_unit : in std_logic_vector(3 downto 0);	 
	min_zeci : in std_logic_vector(3 downto 0);	 
	min_unit : in std_logic_vector(3 downto 0);	
	zi_zeci : in std_logic_vector(3 downto 0);	 
	zi_unit : in std_logic_vector(3 downto 0);	
	luna_zeci : in std_logic_vector(3 downto 0);   
	luna_unit : in std_logic_vector(3 downto 0);	
	an_unit : in std_logic_vector(3 downto 0);	 
	an_zeci : in std_logic_vector(3 downto 0); 
	al_ora_zeci : in std_logic_vector(3 downto 0);
	al_ora_unit : in std_logic_vector(3 downto 0);	 
	al_min_zeci : in std_logic_vector(3 downto 0);	 
	al_min_unit : in std_logic_vector(3 downto 0);	 
	al_on : in std_logic;
	
	ora_zeci_out : out std_logic_vector(3 downto 0);
	ora_unit_out : out std_logic_vector(3 downto 0); 
	min_zeci_out : out std_logic_vector(3 downto 0);	 
	min_unit_out : out std_logic_vector(3 downto 0);	
	zi_zeci_out : out std_logic_vector(3 downto 0);	 
	zi_unit_out : out std_logic_vector(3 downto 0);	
	luna_zeci_out : out std_logic_vector(3 downto 0);   
	luna_unit_out : out std_logic_vector(3 downto 0);	
	an_zeci_out : out std_logic_vector(3 downto 0);	 
	an_unit_out : out std_logic_vector(3 downto 0);  
    ziua_din_saptamana_out:out string (4 downto 1);
	alarma : out std_logic;
	temperatura_out : out std_logic_vector(4 downto 0));			 
end entity;	 

architecture arhi of agenda_programabila is

signal trigger_pentru_zi : std_logic; 
signal ora_zeci_aux, ora_unit_aux, min_zeci_aux, min_unit_aux : std_logic_vector(3 downto 0):="0000"; 
signal zi_zeci_aux, zi_unit_aux, luna_zeci_aux, luna_unit_aux, an_zeci_aux, an_unit_aux:std_logic_vector(3 downto 0):="0000";
signal ziua_din_saptamana_aux:string (4 downto 1);
signal temp_aux : std_logic_vector(4 downto 0); 
signal alarma_aux : std_logic;


begin  

	ceas_componenta : entity work.ceas port map(clk => clk,
		reset => reset, 
		load => load,
		enable=>enable,
		ora_zeci_in => ora_zeci,
		ora_unitati_in => ora_unit, 
		minut_zeci_in => min_zeci, 
		minut_unitati_in => min_unit,  
		ora_zeci_out => ora_zeci_aux,
		ora_unitati_out => ora_unit_aux,
		minut_zeci_out => min_zeci_aux, 
		minut_unitati_out => min_unit_aux,
		trigger_zi => trigger_pentru_zi); 		
		
	calendar_componenta : entity work.calendar port map(clk => trigger_pentru_zi,
		reset => reset, 
		load => load, 
		enable=>enable,
		zi_zeci_in => zi_zeci,
	 	zi_unitati_in => zi_unit,
		luna_zeci_in => luna_zeci,
	 	luna_unitati_in => luna_unit,
	 	an_zeci_in => an_zeci,
	 	an_unitati_in => an_unit,
	 	zi_zeci_out => zi_zeci_aux,
	 	zi_unitati_out =>	zi_unit_aux,
	 	luna_zeci_out => luna_zeci_aux,
	 	luna_unitati_out => luna_unit_aux,
	 	an_zeci_out => an_zeci_aux,
	 	an_unitati_out => an_unit_aux);
		
	zi_cu_litere_componenta : entity work.zi_cu_litere port map(trigger_pentru_zi,
		an_zeci_aux,
		an_unit_aux,
		luna_unit_aux,
		luna_zeci_aux,
		zi_unit_aux,
		zi_zeci_aux,
		ziua_din_saptamana_aux);	
		
	temperatura_componenta : entity work.temperatura port map(clk =>trigger_pentru_zi,
		reset => reset,
		temp_out=>temp_aux);
		
   alarma_componeta: entity work.compalarm port map(al_on,ora_zeci_aux,
	   ora_unit_aux,
	   min_zeci_aux,
	   min_unit_aux,
	   al_ora_zeci,
	   al_ora_unit,
	   al_min_zeci,
	   al_min_unit,
	   alarma); 
		
			
		
	 --Afisare pe 7 segmente                                                                                  	
--	afis_ora_zeci_out : entity work.bcd_7_segment_decodificator port map(cifra => ora_zeci_aux, cod_7_segment => ora_zeci_out);
--	afis_ora_unit_out : entity work.bcd_7_segment_decodificator port map(cifra => ora_unit_aux, cod_7_segment => ora_unit_out);
--	afis_min_zeci_out : entity work.bcd_7_segment_decodificator port map(cifra => min_zeci_aux, cod_7_segment => min_zeci_out);	 
--	afis_min_unit_out : entity work.bcd_7_segment_decodificator port map(cifra => min_unit_aux, cod_7_segment => min_unit_out);	
--	afis_zi_zeci_out : entity work.bcd_7_segment_decodificator port map(cifra => zi_zeci_aux, cod_7_segment => zi_zeci_out); 
--	afis_zi_unit_out : entity work.bcd_7_segment_decodificator port map(cifra => zi_unit_aux, cod_7_segment => zi_unit_out);
--	afis_luna_zeci_out : entity work.bcd_7_segment_decodificator port map(cifra => luna_zeci_aux, cod_7_segment => luna_zeci_out);   
--	afis_luna_unit_out : entity work.bcd_7_segment_decodificator port map(cifra => luna_unit_aux, cod_7_segment => luna_unit_out);	
--	afis_an_zeci_out : entity work.bcd_7_segment_decodificator port map(cifra => an_zeci_aux, cod_7_segment => an_zeci_out); 
--	afis_an_unit_out : entity work.bcd_7_segment_decodificator port map(cifra => an_unit_aux, cod_7_segment => an_unit_out); 	
--	afis_alarma : entity work.bcd_7_segment_decodificator port map(cifra => alarma_aux, cod_7_segment => alarma);	 	
--	afis_temp_zeci_out : entity work.bcd_7_segment_decodificator port map(cifra => temp_zeci_aux, cod_7_segment => temp_zeci_out);
--	afis_temp_unit_out : entity work.bcd_7_segment_decodificator port map(cifra => temp_unit_aux, cod_7_segment => temp_unit_out);
		
		
    ora_zeci_out<=ora_zeci_aux;
	ora_unit_out<=ora_unit_aux;
	min_zeci_out<=min_zeci_aux;	 
	min_unit_out<=min_unit_aux;
	zi_zeci_out<=zi_zeci_aux; 
	zi_unit_out<=zi_unit_aux;
	luna_zeci_out<=luna_zeci_aux; 
	luna_unit_out<=luna_unit_aux;
	an_zeci_out<=an_zeci_aux;
	an_unit_out<=an_unit_aux;
	temperatura_out<=temp_aux;
	ziua_din_saptamana_out<=ziua_din_saptamana_aux;
	

end	architecture;