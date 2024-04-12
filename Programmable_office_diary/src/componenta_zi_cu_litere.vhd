library ieee;
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all;

entity zi_cu_litere is
	port(clk:in std_logic;
	an_zeci,an_unitati:in std_logic_vector(3 downto 0);
	luna_unitati,luna_zeci:in std_logic_vector(3 downto 0);
	ziua_unitati,ziua_zeci:in std_logic_vector(3 downto 0);
	ziua_cu_litere:out string (4 downto 1));
end	entity;

architecture arh_zi_cu_litere of zi_cu_litere is

type vector is array (0 to 11) of integer;
signal luna:vector;

signal rezultat:integer:=0;	

signal an_sute: std_logic_vector(3 downto 0):="0000";
signal an_mii: std_logic_vector(3 downto 0):="0010";

signal ziua_unitati_d,ziua_zeci_d:integer:=0;
signal luna_unitati_d,luna_zeci_d:integer:=0;
signal an_unitati_d,an_zeci_d,an_sute_d,an_mii_d:integer:=0;

signal luna_total,ziua_total:integer; 
   signal an_total:integer:=2022;

begin
ziua_unitati_d<=conv_integer(ziua_unitati);
ziua_zeci_d<=conv_integer(ziua_zeci);
luna_unitati_d<=conv_integer(luna_unitati);
luna_zeci_d<=conv_integer(luna_zeci);
an_unitati_d<=conv_integer(an_unitati);
an_zeci_d<=conv_integer(an_zeci);
an_sute_d<=conv_integer(an_sute);
an_mii_d<=conv_integer(an_mii);

ziua_total<=ziua_unitati_d+ (ziua_zeci_d *10);
luna_total<=luna_unitati_d	+ (luna_zeci_d *10);
--an_total<=an_unitati_d + an_zeci_d * 10+ an_sute_d*100 + an_mii_d*1000;

luna(0)<=0;
luna(1)<=3;
luna(2)<=2;
luna(3)<=5;
luna(4)<=0;
luna(5)<=3;
luna(6)<=5;
luna(7)<=1;
luna(8)<=4;
luna(9)<=6;
luna(10)<=2;
luna(11)<=4;


process(an_total,luna_total,ziua_total,clk)
begin 
	if clk='1' and clk'event then 
if luna_total<3 then
	an_total<=an_total-1;
	else an_total<=an_unitati_d + an_zeci_d * 10+ an_sute_d*100 + an_mii_d*1000;
end if;

if luna_total>0 then 
	rezultat<=(an_total + an_total/4 - an_total/100+ an_total/400 + luna(luna_total - 1) + ziua_total)mod 7;
end if;
end if;

case rezultat is 
	when 0 => ziua_cu_litere <="SUN "; 
	when 1 => ziua_cu_litere <="MON ";
	when 2 => ziua_cu_litere <="TUE ";
	when 3 => ziua_cu_litere <="WED ";
	when 4 => ziua_cu_litere <="THU ";
	when 5 => ziua_cu_litere <="FRY ";
	when others => ziua_cu_litere <="SAT ";
end case;
end process;

end architecture;
	
		 
	