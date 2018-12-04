library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity binbcd32 is
    port (
        B: in STD_LOGIC_VECTOR (31 downto 0);
        P: out STD_LOGIC_VECTOR (4*8-1 downto 0)
    );
end binbcd32;

architecture binbcd32_arch of binbcd32 is
begin
  process(B)
	variable z: STD_LOGIC_VECTOR (70 downto 0);
----- deslocar 8 casas de 4
	begin

	z:= (others => '0');
	z(31 downto 0):=B;
	
	for Ki in 0 to (31) loop

	
	for I in 8 downto 1 loop
	if z((32+I*4)-1 downto 32+(I-1)*4) > 4 then
	z((32+I*4)-1 downto 32+(I-1)*4):=z((32+I*4)-1 downto 32+(I-1)*4) +3;
	end if;
	end loop;
	z(70 downto 1):=z(69 downto 0);
	z(0):='0';
	end loop;
	
	
	
	P<=z(32*2-1 downto 32);

	
end process;

end binbcd32_arch;


