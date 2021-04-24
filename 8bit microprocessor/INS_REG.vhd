LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity INS_REG is
	Port(
		Enable_bit	:	in	std_logic_vector(4 downto 0);	-- from CU
		INS_in		:	in std_logic_vector(7 downto 0); --from RAM
		INS_out		:	out std_logic_vector(7 downto 0)	-- to INS_DEC
		);
		
end INS_REG;

architecture logic of ins_reg is
begin
process(Enable_bit,INS_in)
	begin
		INS_out<="00000000";
			if Enable_bit="00001" then
				INS_out<=INS_in;
			end if;
	end process;
	
end logic;