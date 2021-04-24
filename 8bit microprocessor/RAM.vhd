LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity RAM is
	
	PORT(
		CLK		:	in		std_logic;                 
		RST		:	in		std_logic;
		WR			:	in		std_logic;  
		A			:	in		std_logic_vector(7 downto 0):=(others => '0');
		D_in		: 	in		std_logic_vector(7 downto 0);
		D_out		:	out	std_logic_vector(7 downto 0)
		);
end RAM;

ARCHITECTURE ram OF RAM is
	type memory is array(0 to 255) of std_logic_vector(7 downto 0);
	signal 	ram_array:	memory := (
--instuction set from address 0 to 5
			0 => "00000001", --load adr1 =100		VAL=1
			1 => "01100100", --load adr2 =101		VAL=100
			2 => "01100101", --load acc				VAL=101
			3 => "00000100", --load temp reg			VAL=4
			4 => "00010100", --ADD						VAL=20
			5 => "00000111", --store acc to memory	VAL=7
			6 => "00001100", --check if A>=0 then B=C VAL=12
			7 => "00110011", --new value of B to ACC	VAL=51
			8 => "01100101", --load acc				VAL=101
			9 => "00000100", --load temp reg			VAL=4
			10 => "00010100", --ADD						VAL=20
			11 => "00000111", --store acc to memory	VAL=7
			
			--100 => "10000101", --storing value -123 in address 100		VAL=-123
			--101 => "00100011", --storing value 35 in adress 101			VAL=35
			
			100 => "00000101", --storing value 5 in address 100		VAL=5
			101 => "00000011", --storing value 3 in adress 101			VAL=3
			others => "00000000"
			);
	
begin
process(RST,WR,A,D_in,CLK)
		begin
			if falling_edge(CLK) then
				if RST='1' then
					if WR='1' then
						ram_array(conv_integer(A)) <= D_in;
					end if;
				end if;
			end if;
		end process;
D_out <= ram_array(conv_integer(A));
end ram;