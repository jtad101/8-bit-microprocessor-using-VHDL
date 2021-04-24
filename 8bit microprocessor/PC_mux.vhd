library ieee;
use ieee.std_logic_1164.all;

entity PC_mux is
  port(
    PC_OE		 : in std_logic;                     
    JUMP_OE		 : in std_logic;
	 JUMP   	 : in std_logic_vector(7 downto 0);   
    PC   	 : in std_logic_vector(7 downto 0);   
    MUX_out  : out std_logic_vector(7 downto 0)   
  );
end PC_mux;


architecture logic of PC_mux is

begin
  process(PC_OE,JUMP_OE, JUMP, PC)
  begin
    if (PC_OE = '1') then
      MUX_out <= PC;
    elsif(JUMP_OE='1') then
      MUX_out  <= JUMP;
    end if;
  end process;

end logic;