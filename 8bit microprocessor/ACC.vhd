 LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ACC is
	Port(
		CLK			:	in std_logic;
		ACC_in		:	in std_logic_vector(7 downto 0);
		ALU_Result	:	in std_logic_vector(7 downto 0);
		ACC_out		:	out std_logic_vector(7 downto 0);
		Enable_bit	: 	in std_logic_vector(4 downto 0);
		OP				:	in	std_logic_vector(2 downto 0)
		);
		
end ACC;

architecture logic of ACC is

signal output : std_logic_vector(7 downto 0);

begin
process(ACC_in,ALU_Result,Enable_bit,OP,CLK,output)
	begin
		if rising_edge(CLK) then
			if Enable_bit = "10000" then
				output <= ACC_in;
			elsif OP = "000" then
				output<= ALU_Result;
			end if;
		end if;
end process;
	ACC_out<=output;
end logic;