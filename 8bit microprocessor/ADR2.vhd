LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ADR2 is
	Port(
		CLK			:	in std_logic;
		ADR2_in		:	in std_logic_vector(7 downto 0);
		ADR2_out		:	out std_logic_vector(7 downto 0);
		Enable_bit	: 	in std_logic_vector(4 downto 0)
		);
		
end ADR2;

architecture logic of ADR2 is

signal ADR	:	std_logic_vector(7 downto 0);

begin
process(CLK,ADR2_in,Enable_bit,ADR)
	begin
		if rising_edge(CLK) then
			if Enable_bit = "00010" then
				ADR <= ADR2_in;
			end if;
		end if;
	end process;
ADR2_out<=ADR;
end logic;