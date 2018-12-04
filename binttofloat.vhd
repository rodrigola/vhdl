library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
USE IEEE.NUMERIC_STD.ALL;
--use work;



		entity display is
	
		port ( 
				
				ll: in std_logic_vector(15 downto 0); ---- tipo 00,00; (entrada);-- exemplo 9999 = 99,99 = 270F 
				y:out std_logic_vector(22 downto 0 ); --- saida em bcd;--mantissa
				y5:out std_logic_vector(7 downto 0)); ---- saida do expoente;
	--			y3:out std_logic_vector(35 downto 0); ---- saida em display;
	--			b: out std_logic_vector(5 downto 0));
			
		end display;


		---------------------
		--seletor de entrada ------ 
		--------------------------
		----- coloca a entrada conforme os 4 primeiros bits e desloca conforme digita
		-------- entrada em bcd 
		
		architecture hardware of display is
		-------------------------------------------------------
		---------- aqui estou digitanto 16 valores referente a tela , podendo ser menor para n bits
	
		---------------------------------------------------
		signal yz,z,s: std_logic_vector(35  downto 0);
		signal zzz,ap1,ap2,ap3,ap4: std_logic_vector(23  downto 0);
		signal zx1: std_logic_vector(23  downto 0);
		signal oni: std_logic_vector(7 downto 0); 
		signal lix: integer range 0 to 20;
	 --  signal lc: std_logic_vector(5 downto 0); 
		begin
		--lc<= (others => '0');
		--b<=lix+lc;
		-----
		---- inteiro demilita a opera
		---- em 2147483647 infelismente logo teremos 
		--- que usar vetor de bits , multiplicar por 10 = & X"A"
		-- tranfforma o numero bcd em hexa

		--ll <= ((((X"000000" + ((k(3 downto 0)))) +  (k(7 downto 4)) * (X"000A")) + ((k(11 downto 5)) * X"0064")) +	(k(15 downto 12) * X"03E8")) ;
		--ap1 <= X"000000" + k(3 downto 0) ;
		--ap2 <= X"000000" + (k(7 downto 4))* (X"000A");
		--ap3 <= X"000000" +  ((k(11 downto 5)) * X"0064");
		--ap4 <= X"000000" + (k(15 downto 12) * X"03E8") ;
		--ll <= ap1+ap2+ap3+ap4;
		
		--y2<= X"00" & ll;
		----------------------------------------
		z<= (others => '0');
	   oni(6 downto 0)<= (others => '1'); ---------- basta muda esse range para mudar o valor do espoente
		oni(7)<='0';
		s<= X"032_000_000";
		  
		process(ll,lix)
		
		--variable n1,p,n2: integer range 0 to 130;
		variable ma,ma2 : std_logic_vector(35 downto 0);--- 32 pq S variavel mantissa
		--variable Re: real;
		--variable k: std_logic_vector((8*13 +7)  downto 0);
		--variable zmv: std_logic_vector(4 downto 0);
		begin
		-------------
		-- agora basta deslocar o numero qualquer até que ele seja > 2^23*100
		---------------
		 -- 2^23*100 --- mantiissa de 22 elementos , mais 2 = 100 de precisao
		------------ basta trocar esse valor para mudar os bits da mantissa 
		
	   -------
		--n1:=0;
		ma:=z;
		ma(29 downto 29-(lix)):=ll((lix) downto 0);
		if ( s >= ma) then
		ma := ma(34 downto 0) & '0';
		end if;
	
		ma2:= ma + 55; --- arredondar

		yz <= std_logic_vector(unsigned(ma2)/100);
		
		--yz  <= z + ma2/X"AA";
		
		y <= yz(22 downto 0) ; -- mantissa de 23 bit
--		y3 <= ma;
		end process;
		
		process(ll)
		variable n1,n2,n3: integer range 0 to 45;
		variable ll2: std_logic_vector(15  downto 0);
		BEGIN
		n1:=0;
		n2:=0;
		n3:=0;

		
			while (n1=0 and n2<(ll2'length)) loop
			n2:=n2+1;
			if (ll2(ll2'length-n2) = '1') then
			n1:=1;
			n3:=ll2'length-n2;
			end if;
        END LOOP;
		 
		 if (ll >=100) then
		 ll2:= std_logic_vector(unsigned(ll)/100);
		 y5 <= oni + n3;  -- ( valor de 00,01)
		 else
		 ll2 := ll;
		 if (ll > 0) then
		 y5 <= oni + n3 -7 ; -- (acrecimo de 1 por n ter o 0)
		 else
		 y5 <= (others => '0');
		 end if;
		 end if;
		 
		 
		
		end process;
		
		
		
		process(ll)
		variable n1,n2,n3: integer range 0 to 45;
		variable ll2: std_logic_vector(15  downto 0);
		BEGIN
		n1:=0;
		n2:=0;
		n3:=0;

		
			while (n1=0 and n2<(ll2'length)) loop
			n2:=n2+1;
			if (ll(ll'length-n2) = '1') then
			n1:=1;
			n3:=ll2'length-n2;
			end if;
        END LOOP;
		
		
		 lix<=n3;
		
		end process;
		
end hardware;

