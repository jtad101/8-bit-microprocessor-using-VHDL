library ieee;
use ieee.std_logic_1164.all;

entity RAM_demux is
  port(
    RAM_in		 : in std_logic_vector(7 downto 0);-- from RAM output                 
    demux_en	 :	in std_logic_vector(2 downto 0);
	 DEMUX_out 	 : out std_logic_vector(7 downto 0)--to the required register   
  );
end RAM_demux;


architecture logic of RAM_demux is

signal output 	:	std_logic_vector(7 downto 0);

begin
  process(RAM_in,demux_en)
  begin
	if demux_en="001" then		-- for ADR1
      output <= RAM_in;
   elsif demux_en="010" then	-- for ADR2
      output  <= RAM_in;
	elsif demux_en="011" then	-- for ACC
      output  <= RAM_in;
	elsif demux_en="100" then	-- for TEMP
      output  <= RAM_in;
	elsif demux_en="000" then	-- for INS_REG
      output  <= RAM_in;		
   end if;
  end process;
DEMUX_out<=output;
end logic;