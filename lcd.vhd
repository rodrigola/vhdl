--
-- Curso de FPGA WR Kits Channel
--
--
-- Aula 80: Utilizando o Display LCD do Kit EE03 
--                            
--
-- Kits Sugeridos:
--
-- Kit FPGA EE02-SOQ
--
-- Adquira em http://www.professoremersonmartins.com.br/site/prtoducts/KIT-FPGA-%252d-EE02-%252d-SOQ.html
--
--
-- Kit FPGA EE03
--
-- Adquira em http://www.professoremersonmartins.com.br/site/products/KIT-FPGA-%252d-EE03.html
--
--
-- Autor: Eng. Wagner Rambo     Data: Dezembro de 2016
--
-- www.wrkits.com.br | facebook.com/wrkits | youtube.com/user/canalwrkits
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


		entity lcd16b is
		generic (fclk: natural := 50_000_000); -- 50MHz , cristal do kit EE03
		port (
				-- R0, R1, R2, R3, R4, R5, R6, R7: in std_logic;
				 z : in bit_vector(31 downto 0); 
				 b :  in bit_vector(31 downto 0);
		       clk         :     in bit; 
				 RS, RW      :    out bit;
		       E           : buffer bit;  
		       DB          :    out bit_vector(7 downto 0)); 
		end lcd16b;



		architecture hardware of lcd16b is
		type state is (FunctionSetl, FunctionSet2, FunctionSet3,
		 FunctionSet4,FunctionSet6,FunctionSet7,FunctionSet9,ClearDisplay, DisplayControl, EntryMode, 
		 WriteDatal, WriteData2, WriteData9,SetAddress,SetAddress1, ReturnHome);
		signal pr_state, nx_state: state;
		signal xx1,xx2,xx3,xx4,xx5,xx6,xx7,xx8,yy1,yy2,yy3,yy4,yy5,yy6,yy7,yy8 :bit_vector(7 downto 0);
		signal y,y1,y2: bit_vector((8*14 +7)  downto 0);
		--signal z: bit_vector(31  downto 0);
		begin
		--y2<=X"746869616e732028" & xx1 & xx2 & xx3 & X"2C" & yy1 & yy2 & X"29"; --  segunda linha
		--	y<=X"636f72696e2d2020" & ax1 & ax2 & ax3 & X"2f" & bx1 & bx2 & X"3d X"2820736e61696874"  X"20202d6e69726f63" "; -- primeira linha
		--y<=X"202020" &  a(111 downto 8*2) ; -- primeira linha
		y1<=X"2020203d" & yy1 & yy2 & X"2c" & yy3 & yy4 & X"2f" & yy5 & yy6 & X"2c" &	yy7 & yy8   ; 
		y2<=X"202020202020" & xx1 & xx2 & xx3 & xx4 & X"2c" & xx5 & xx6 & xx7 & xx8   ; --  segunda linha
		--y2<=ax1 & ax2 & ax3 & X"20" & bx1 & bx2 & X"20" & X"20" & xx1 & xx2 & xx3 & X"20" & yy1 & yy2 & X"20" 
	--	z<= wd & wc & wb & wa
		xx8<= X"3" & b(31 downto 28);
		----- es
		xx7<= X"3" & b(27 downto 24);
		xx6<= X"3" & b(23 downto 20);
		---- es
		---- es
		xx1<= X"3" & b(3 downto 0);
		xx2<= X"3" & b(7 downto 4);
		xx3<= X"3" & b(11 downto 8);
		--- es
		xx4<= X"3" & b(15 downto 12);
		xx5<= X"3" & b(19 downto 16);
		
	-------------------------------------------	
		yy8<= X"3" & z(31 downto 28);
		----- es
		yy7<= X"3" & z(27 downto 24);
		yy6<= X"3" & z(23 downto 20);
		---- es
		---- es
		yy1<= X"3" & z(3 downto 0);
		yy2<= X"3" & z(7 downto 4);
		yy3<= X"3" & z(11 downto 8);
		--- es
		yy4<= X"3" & z(15 downto 12);
		yy5<= X"3" & z(19 downto 16);
		
		--- es
		
		------- b = max 15   
		--------a = max 255
		--------x = max 255
		--------y = max 14
		------- a/b =(x,y)
---—Clock generator (E->500Hz) :---------
		process (clk)
		variable count: natural range 0 to fclk/1000; 
		begin
			if (clk' event and clk = '1') then 
				count := count + 1;
				if (count=fclk/1000) then 
				 E <= not E; 
				 count := 0; 
				end if; 
			end if; 
		end process;
		
-----Lower section of FSM:---------------
		process (E) 
		begin
			if (E' event and E = '1') then 
			--	IF (rst= '0') THEN
				pr_state <= FunctionSetl; 
		--ELSE
		pr_state <= nx_state; 
		--END IF; 
		end if; 
		end process;
		
-----Upper section of FSX:---------------
		process (pr_state,E) 
		variable n1,n2: integer range 0 to 10;
		begin
		case pr_state is


		when FunctionSetl => 
		RS<= '0'; RW<= '0'; 
		DB<= "00111000"; 
		nx_state <= FunctionSet2; 
		when FunctionSet2 => 
		RS<= '0'; RW<= '0'; 
		DB <= "00111000";
		nx_state <= FunctionSet3; 
		when FunctionSet3 => 
		RS <= '0'; RW<='0'; 
		DB <= "00111000"; 
		nx_state <= FunctionSet4;

		when   FunctionSet4   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet6;

	

		when   FunctionSet6   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet7;

		when   FunctionSet7   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet9;

	



		when   FunctionSet9   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= ClearDisplay ;



		when ClearDisplay =>
		RS<= '0'; RW<= '0';
		DB <= "00000001";
		nx_state   <=   DisplayControl; 
		when   DisplayControl   =>
		RS<= '0';   RW<=  '0';
		DB   <=  "00001100";
		nx_state <= EntryMode; 
		when EntryMode =>
		RS<= '0'; RW<= '0';
		DB <= "00000110";
		nx_state   <=  WriteDatal; 

		when  WriteDatal =>
		RS<=   '1';   RW <='0';
		DB   <=   "00100000";   --'ESCREVE UM ESPAÇO EM BRANDO
		nx_state <= SetAddress1; 

		when SetAddress1 =>
		RS<=   '0';   RW<=   '0';
		DB   <=  X"80";   --COMANDO PARA POSICIONAR O CURSOR NA LINHA 0 COLUNA 5
		nx_state  <= WriteData2; 

		when WriteData2 =>
		RS<= '1'; RW<= '0';
		if (E'event and E='1') then
		if (n1>=0 and n1<15)then
		n1:=n1+1;
		elsif ((n1>=15) or (n1<0)) then
		n1:=0;
		end if;
		else
		n1:=n1;
		end if;
		DB<=y1(8*n1+7 downto 8*n1);
		--DB <= X"41";		--'A'
		if (n1>=0 and n1<15)then
		nx_state <= WriteData2; 
		else
		nx_state <= setAddress;
		end if;
		

		when SetAddress =>

		RS<=   '0';   RW<=   '0';
		DB   <=  "11000000";   --COMANDO PARA POSICIONAR O CURSOR NA LINHA 1 COLUNA 3
		nx_state  <= WriteData9; 

		

		when WriteData9 =>
		RS<= '1'; RW<= '0';
		if (E'event and E='1') then
		if (n2>=0 and n2<15)then
		n2:=n2+1;
		elsif ((n2>=15) or (n2<0)) then
		n2:=0;
		end if;
		else
		n2:=n2;
		end if;
		DB<=y2(8*n2+7 downto 8*n2);
		--DB <= X"41";		--'A'
		if (n2>=0 and n2<15)then
		nx_state <= WriteData9; 
		else
		nx_state <= setAddress1;
		end if;



		when   ReturnHome   =>
		RS<=   '0';   RW<=  '0';
		DB   <=  "10000000";
		nx_state <= WriteDatal; 
		end case; 
		end process;
		
	end hardware;



















