library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.Std_logic_Unsigned.all;

entity PC is
  port(
	 CLK				:	in std_logic;
    reset			:	in std_logic;
	 PC_INC			:	in std_logic;
	 instruction   :	out std_logic_vector(7 downto 0)  -- next instruction  
  );
end PC;


architecture logic of PC is

signal nxt : std_logic_vector(7 downto 0):="00000000";

begin
process(CLK,reset,PC_INC,nxt)
  begin
	if reset='0' then
		nxt <= "00000000";
	elsif rising_edge(CLK) then
		if PC_INC='1' then
			nxt <= nxt +'1';
		end if;
	end if;
	end process;
instruction<=nxt;
end logic;