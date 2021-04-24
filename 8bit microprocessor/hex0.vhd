LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
entity hex0 is
	Port(
	hex_in	: in std_logic_vector(7 downto 0);
	hex_out	: out std_logic_vector(6 downto 0)
	);
	
end hex0;

ARCHITECTURE display of hex0 is
begin
process(hex_in)
	begin
	case hex_in is 		-- using case statement to map binary to 7segment.
		when "00000000" => hex_out <= "1000000";--0 
		when "00000001" => hex_out <= "1111001";--1	
		when "00000010" => hex_out <= "0100100";--2
		when "00000011" => hex_out <= "0110000";--3
		when "00000100" => hex_out <= "0011001";--4
		when "00000101" => hex_out <= "0010010";--5
		when "00000110" => hex_out <= "0000010";--6
		when "00000111" => hex_out <= "1111000";--7
		when "00001000" => hex_out <= "0000000";--8
		when "00001001" => hex_out <= "0010000";--9
		when others => hex_out <= "1110111";
		end case;
	end process;
end display;
