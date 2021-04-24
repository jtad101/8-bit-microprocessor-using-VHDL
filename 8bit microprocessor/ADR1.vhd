LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ADR1 is
	Port(
		CLK			:	in std_logic;
		ADR1_in		:	in std_logic_vector(7 downto 0);
		ADR1_out		:	out std_logic_vector(7 downto 0);
		Enable_bit	:	in	std_logic_vector(4 downto 0)
		);
end ADR1;

architecture logic of ADR1 is


signal ADR	:	std_logic_vector(7 downto 0);--:= "00000000";


begin
process(CLK,ADR1_in,Enable_bit,ADR)
	begin
		if rising_edge(CLK) then
			if Enable_bit = "00100" then
				ADR <= ADR1_in;
			end if;
		end if;
end process;
ADR1_out<=ADR;
end logic;