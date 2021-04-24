Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity ALU is
   Port (
	A_in 				: 	in	 std_logic_vector(7 downto 0);-- 8 bits input
   B_in				:	in  std_logic_vector(7 downto 0);-- 8 bit input
	OP	 				: 	in	 STD_LOGIC_VECTOR(2 downto 0);-- 3 bits input for selecting function
	A_out				:	out STD_LOGIC_VECTOR(7 downto 0);-- 8 bits output 
	stat				: 	out std_logic_vector(1 downto 0)--status bit
	);
end ALU; 

architecture unit of ALU is 

signal Result 	: std_logic_vector (7 downto 0);
signal tmp		: std_logic_vector(8 downto 0);
begin
process(A_in,B_in,OP,Result,tmp)
	variable flag : std_logic;
 begin
	stat<="11";
	Result<="00000000";
	tmp<="000000000";
  case(OP) is
  
  when "000" =>					 -- Addition
					tmp <= std_logic_vector(signed(A_in(7) & A_in) + signed(B_in(7) & B_in));
					Result <= tmp(7 downto 0);
					flag := tmp(8);
					stat(1) <= Result(7) xor A_in(7) xor B_in(7) xor flag;--overflow bit
	
  when "001" => 				-- Subtraction
					tmp <= std_logic_vector(signed(A_in(7) & A_in) - signed(B_in(7) & B_in));
					Result <= tmp(7 downto 0);
					flag := tmp(8);
					stat(1) <= Result(7) xor A_in(7) xor B_in(7) xor flag;
	
  when "010" => Result <= A_in and B_in;  -- Logical AND
	
  when "011" => Result <= A_in or B_in;  -- Logical OR
	
  when others => 
  
end case;

case (Result) is
	when "00000000" => stat(0) <= '1'; --if result is zero
	when others 	 => stat(0) <= '0';	-- if result is not zero
end case;

A_out<=Result;			  

end process;

end unit;