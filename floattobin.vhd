library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
USE IEEE.NUMERIC_STD.All;
--use work;



		entity displat is

		port ( 

				llxc: out std_logic_vector(31 downto 0); ---- tipo 0000,0000; (saida);-- exemplo 99999999 = 9999,9999 = 270F 
				yiuh:in std_logic_vector(22 downto 0 ); --- saida em bcd;--mantissa
				yiuh5:in std_logic_vector(7 downto 0)); ---- saida do expoente;

			
		end displat;

		
		
		architecture hardware of displat is
		-------------------------------------------------------
		---------- aqui estou digitanto 16 valores referente a tela , podendo ser menor para n bits
		---------------------------------------------------
		signal z: std_logic_vector(39  downto 0);
		signal zzz,ap1,ap2,ap3,ap4: std_logic_vector(23  downto 0);
		signal zxl: std_logic_vector(23  downto 0);
		signal oni: std_logic_vector(8 downto 0); 
		signal lix: integer;
		--signal k: std_logic_vector(
	
		begin
		
		
		process(yiuh,yiuh5)
		variable n1: integer range 0 to 27;
		variable zx2: std_logic_vector(23  downto 0);
		variable zx3: std_logic_vector(7  downto 0);
		variable yiuhz: std_logic_vector(39  downto 0);
		begin
		n1:=0;
		zx2 := (others => '0');
		if (IS_X(yiuh) nand IS_X(yiuh5)) then
		zx2(22 downto 0):=yiuh;
		zx2(23):='1';

		zx3:= ((X"8C") - (yiuh5)); --- 13 é o valor max
		
		
		
	
		if (not IS_X(zx3)) then
		n1 := to_integer(unsigned(zx3));
		if (not IS_X(zx2))then
		yiuhz:= (zx2)*(X"2710"); --- * 10000
		
		
		if (yiuh5 = X"00") then
		yiuhz:= (others => '0');
		end if;
		
		if (yiuh5 = X"ff") then
		n1:=2;
		yiuhz:= X"5F5E0FF000";
		end if;
	
	     --- X"7F" + 26 = X"99" = 100000000 = 99,99/0,01 = 9999,9999
		
		
		if (not IS_X(yiuhz) and n1>=0)then
		llxc(29-n1 downto 0)<=yiuhz(39 downto 39+n1-29);
		llxc(31 downto 29-n1+1)<= (others => '0');
		else
		llxc <= (others => '0');
		end if;
		end if;
		end if;
		end if;
		
		
		end process;
		
		
end hardware;

