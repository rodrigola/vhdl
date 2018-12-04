library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
USE IEEE.NUMERIC_STD.ALL;
--use work;



		entity adapta is

		port ( 
				zg1:in std_logic_vector(15 downto 0 ); --- saida em bcd;--mantissa
				dfg:in std_logic;
				lh1,lh2: out std_logic_vector(15 downto 0); ---- saida em divisor exp;
				uj:out std_logic_vector(31 downto 0)); ---- saida em divisor mantiss;
		

			
		end adapta;


	   ------------------------------------------
		-------------------------------------
		--yko/xko divide
		--ykou5/xkou5 = subtrai
		--
		----------------
	
		architecture hardware of adapta is
		
			signal g1,g2,g3,g4,g5,y1,o0,o1,k0,k1 : boolean ;
			signal u1,u5 :std_logic;
			
		-------------------------------------------------------
		begin 
		o0 <= (dfg = '0');
		o1 <= (dfg = '1');
		g2 <= (zg1(3 downto 0)<=9);
		g3 <= (zg1(7 downto 4)<=9);
		g4 <= (zg1(11 downto 8)<=9);
		g5 <= (zg1(15 downto 12)<=9);
		y1 <= g5 and g2 and g3 and g4 ;
		k0 <= o0 and y1;
		k1 <= o1 and y1;
		
		
		u1 <= '1' when k0 else 
		'0';
		u5 <= '1' when k1 else
		'0';
		
	
		process(u1,u5)
		
		variable n1,n2 : std_logic_vector(15 downto 0 );
		
		begin
		
		if (u1='1' and u1'event and u5='0') then
		n1 := zg1; 
		else
		n1 := n1;
		end if;
		if (u5='1' and u5'event and u1='0') then
		n2 := zg1; 
		else
		n2 := n2;
		end if;
		
		lh2 <= n2;
		lh1 <= n1;
		uj <= n1 & n2 ;
		
		end process;
		
end hardware;

