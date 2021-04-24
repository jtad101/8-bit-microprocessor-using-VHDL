library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ADR_MUX is
	Port (
		ADR1_in		:	in		std_logic_vector(7 downto 0);--from ADR1 register
		ADR2_in		:	in 	std_logic_vector(7 downto 0);--from ADR2 register
		Enable		:	in 	std_logic_vector(4 downto 0);
		MUX_out		:	out	std_logic_vector(7 downto 0)
		);
		
end ADR_MUX;

architecture logic of ADR_MUX is

signal ADR	:	std_logic_vector(7 downto 0);

begin
process(Enable,ADR1_in,ADR2_in,ADR)
	begin
		ADR<="11111111";
		case Enable is
			when "10000" =>	ADR <= ADR1_in;
			when "00000" => 	ADR <= ADR1_in;
			when "00011" =>	ADR <= ADR1_in;
			when "01000" => 	ADR <= ADR2_in;
			when "00010" => 	ADR <= ADR2_in;
			when others =>		
		end case;
end process;
MUX_out<=ADR;
end logic;		