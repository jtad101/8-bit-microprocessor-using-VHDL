LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity INS_DEC is
	Port(
		INS_in		:	in std_logic_vector(7 downto 0);
		Enable	:	out std_logic_vector(4 downto 0)
		);
		
end INS_DEC;

architecture logic of ins_dec is

signal Enable_out : std_logic_vector(4 downto 0);

begin
process(INS_in)
	begin
		Enable_out<="00000";
			case (INS_in) is
				when "00000001" =>	Enable_out	<=	"00100"; --ADR1
											
				when "01100100" =>	Enable_out	<=	"00010";	--ADR2
										
				when "01100101" =>	Enable_out	<=	"10000";	--ACC
																												
				when "00000100" =>	Enable_out	<=	"01000";	--TEMP
				
				when "00010100" =>	Enable_out	<=	"11000";	-- ADD
									
				when "00000111" =>	Enable_out	<=	"00001";	--STORE IN ACC
	
				when "00001100" => 	Enable_out <= "00011"; --A>=0 then B=C
				
				when "00110011" =>	Enable_out <= "00111"; --loads ACC with new value
				
				when others => Enable_out <= "00000";
				
			end case;				
	end process;
	Enable <= Enable_out;
end logic;