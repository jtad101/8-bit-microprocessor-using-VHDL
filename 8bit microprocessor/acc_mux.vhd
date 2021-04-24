library ieee;
use ieee.std_logic_1164.all;

entity ACC_mux is
  port(
    ACC_OE		: in std_logic;                     	
    OP			: in std_logic_vector(2 downto 0);
	 ALU_Result : in std_logic_vector(7 downto 0);   
    ACC   		: in std_logic_vector(7 downto 0);   
    MUX_out 	: out std_logic_vector(7 downto 0)   
  );
end ACC_mux;


architecture logic of ACC_mux is

signal output :	std_logic_vector(7 downto 0);
begin
  process(ACC_OE,TEMP_OE, TEMP, ACC)
  begin
    if (ACC_OE = '1') then
      output <= ACC;
    elsif (OP='0') then
      output  <= ALU_Result;
    end if;
  end process;
MUX_out<=output;
end logic;