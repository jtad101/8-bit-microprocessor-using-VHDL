LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity TEMP is
	Port(
		CLK			:	in std_logic;
		TEMP_in		:	in std_logic_vector(7 downto 0);
		TEMP_out		:	out std_logic_vector(7 downto 0);
		Enable_bit	: 	in std_logic_vector(4 downto 0)
		);
		
end TEMP;

architecture logic of TEMP is


signal output : std_logic_vector(7 downto 0);


begin
process(CLK,TEMP_in,Enable_bit,output)
	begin
		if rising_edge(CLK) then
			if Enable_bit="01000"then
				output <= TEMP_in;
			end if;
		end if;
	end process;
	TEMP_out<=output;
end logic;