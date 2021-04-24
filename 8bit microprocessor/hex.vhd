LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
entity hex is
	Port(
	hex_in	: in std_logic_vector(7 downto 0);
	hex_out	: out std_logic_vector(6 downto 0)
	);
	
end hex;

ARCHITECTURE display of hex is
begin
process(hex_in)
	begin
	case hex_in is 		-- using case statement to map binary to 7segment.
		when "00000000" => hex_out <= "0000001";--0 
		when "00000001" => hex_out <= "1001111";--1	
		when "00000010" => hex_out <= "0010010";--2
		when "00000011" => hex_out <= "0000110";--3
		when "00000100" => hex_out <= "1001100";--4
		when "00000101" => hex_out <= "0100100";--5
		when "00000110" => hex_out <= "0100000";--6
		when "00000111" => hex_out <= "0001111";--7
		when "00001000" => hex_out <= "0000000";--8
		when "00001001" => hex_out <= "0000100";--9
		--when "1010" => ssegment := "0001000";--A
		--when "1011" => ssegment := "1100000";--B
		--when "1100" => ssegment := "0110001";--C
		--when "1101" => ssegment := "1000010";--D
		--when "1110" => ssegment := "0110000";--E
		--when "1111" => ssegment := "0111000";--F
		when others => hex_out <= "1111111";
		end case;
	end process;
end display;
