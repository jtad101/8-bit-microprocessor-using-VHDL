LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity control_unit is
	
	PORT(
		CLK			:	in		std_logic;       
		RST			:	in 	std_logic;
		Decoder		:	in		std_logic_vector(4 downto 0);	-- from decoder
		ADR_in		:	in		std_logic_vector(7 downto 0);	--from ADR_MUX
		stat			:	in 	std_logic_vector(1 downto 0);--from ALU status
		ALU_Result	:	in		std_logic_vector(7 downto 0);-- from ALU_Result
		ACC_in		: 	in		std_logic_vector(7 downto 0);	--from ACC output
		TEMP_in		: 	in		std_logic_vector(7 downto 0);	--from TEMP output
		PC_in			:	in		std_logic_vector(7 downto 0);
		
		Enable		:	out	std_logic_vector(4 downto 0);	-- enables for all registers
		OP_out		:	out	std_logic_vector(2 downto 0);	--OP code
		ALU1_out		:	out	std_logic_vector(7 downto 0); --ALU input A
		ALU2_out		:	out	std_logic_vector(7 downto 0);	-- ALU input B
		WR				:	out	std_logic;
		D_out			:	out	std_logic_vector(7 downto 0);	-- To RAM data in for writing
		A_out			: 	out	std_logic_vector(7 downto 0); -- to RAM Address
		PC_INC		:	out	std_logic -- for incrementing PC
		);
end control_unit;

ARCHITECTURE logic OF control_unit is

	type state_type is (idle,FETCH,EXECUTE);	-- states
	signal state : state_type;
	
begin
first : process(CLK,RST,state)
	begin
		if RST='0' then
				state<=idle;
		elsif rising_edge(CLK) then
			case state is
				when idle => state<= FETCH;
				when FETCH 	 => state <= EXECUTE;
				when EXECUTE => state <= FETCH;
				when others => state <= idle;
			end case;
		end if;
end process;

second : process(state,Decoder,stat,ADR_in,PC_in,TEMP_in,ACC_in)
begin
		Enable <="00000"; 	
		OP_out <="111";
		ALU1_out	<="00000000";
		ALU2_out	<="00000000";	
		WR	<= '0';
		D_out	<="00000000";
		A_out	<="00000000";
		PC_INC <='0';
	case state is
		when idle =>
			PC_INC <= '0';
		when FETCH =>
			A_out<=PC_in;  -- address to RAM
			Enable<="00001";	-- enables INS_REG
			PC_INC<='0';
		when EXECUTE =>
			case Decoder is
				when "00100" =>
					Enable<="00100";	-- enables ADR1 and disable INS_REG
					A_out <= PC_in + '1';	--address from the next instruction in memory
					PC_INC<='1';
				when "00010" =>
					Enable<="00010";		-- Enables ADR2 
					A_out <= PC_in + '1';
					PC_INC<='1';
				when "10000" =>
					Enable<="10000";	-- enables ACC
					A_out <= ADR_in;
					PC_INC<='1';
				when "01000" => 
					Enable<="01000";		-- enables TEMP_REG
					A_out <= ADR_in;
					PC_INC<='1';
				when "11000" =>
					OP_out<="000";		-- addition in ALU
					ALU1_out<=ACC_in;
					ALU2_out<=TEMP_in;	
					PC_INC<='1';
				when "00001" =>
					OP_out<="111";
					Enable<="00000";		-- all registers disabled
					A_out<=ADR_in;		
					D_out<=ACC_in;
					WR<='1';			-- value from accumulator is written in the memory
					PC_INC<='1';		
				when "00011" =>
					WR<='0';
					case stat is
						when "00" =>	--checks if ALU result is positive
							Enable<="00011";
							A_out<=ADR_in;		-- write 
							D_out<=TEMP_in;	--writes TEMP to address 100(B=C)
							WR<='1';
							PC_INC<='1';
						when "10" =>	--checks if ALU result is negative
							A_out<="00110010"; -- address 50 that has no instruction
							Enable<="00001";	--INS_REG JNEG
						when others =>
					end case;
				when "00111" =>
					WR<='0';
					Enable<="10000";		--loads ACC
					A_out<=ADR_in;		-- loads ACC with new value.
					PC_INC<='1';						
				when others =>
					PC_INC<='1';	-- increment program counter		
				end case;									
		when others =>
	end case;
end process;
end logic;