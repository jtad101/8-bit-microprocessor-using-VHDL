-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 64-Bit"
-- VERSION		"Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"
-- CREATED		"Tue Jun 30 12:53:51 2020"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY design IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		rst :  IN  STD_LOGIC
	);
END design;

ARCHITECTURE bdf_type OF design IS 

COMPONENT pc
	PORT(CLK : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 PC_INC : IN STD_LOGIC;
		 instruction : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ins_dec
	PORT(INS_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 Enable : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END COMPONENT;

COMPONENT acc
	PORT(CLK : IN STD_LOGIC;
		 ACC_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 ALU_Result : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 Enable_bit : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 OP : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 ACC_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT temp
	PORT(CLK : IN STD_LOGIC;
		 Enable_bit : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 TEMP_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 TEMP_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT adr1
	PORT(CLK : IN STD_LOGIC;
		 ADR1_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 Enable_bit : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 ADR1_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT adr2
	PORT(CLK : IN STD_LOGIC;
		 ADR2_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 Enable_bit : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 ADR2_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT control_unit
	PORT(CLK : IN STD_LOGIC;
		 RST : IN STD_LOGIC;
		 ACC_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 ADR_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 ALU_Result : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 Decoder : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 PC_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 stat : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 TEMP_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 WR : OUT STD_LOGIC;
		 PC_INC : OUT STD_LOGIC;
		 A_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 ALU1_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 ALU2_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 D_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 Enable : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		 OP_out : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ram
	PORT(CLK : IN STD_LOGIC;
		 RST : IN STD_LOGIC;
		 WR : IN STD_LOGIC;
		 A : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 D_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 D_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT alu
	PORT(A_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 B_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 OP : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 A_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 stat : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ins_reg
	PORT(Enable_bit : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 INS_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 INS_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT adr_mux
	PORT(ADR1_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 ADR2_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 Enable : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 MUX_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	acc_out :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	adr1_out :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	adr2_out :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	adr_out :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	alu1 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	alu2 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	alu_result :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	d_out :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	Decoder_out :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	Enable :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	ins_out :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	mux :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	OP :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	pc_inc :  STD_LOGIC;
SIGNAL	pc_out :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	RAM_out :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	stat :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	temp_out :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	write1 :  STD_LOGIC;


BEGIN 



b2v_inst : pc
PORT MAP(CLK => clk,
		 reset => rst,
		 PC_INC => pc_inc,
		 instruction => pc_out);


b2v_inst1 : ins_dec
PORT MAP(INS_in => ins_out,
		 Enable => Decoder_out);


b2v_inst10 : acc
PORT MAP(CLK => clk,
		 ACC_in => RAM_out,
		 ALU_Result => alu_result,
		 Enable_bit => Enable,
		 OP => OP,
		 ACC_out => acc_out);


b2v_inst11 : temp
PORT MAP(CLK => clk,
		 Enable_bit => Enable,
		 TEMP_in => RAM_out,
		 TEMP_out => temp_out);


b2v_inst13 : adr1
PORT MAP(CLK => clk,
		 ADR1_in => RAM_out,
		 Enable_bit => Enable,
		 ADR1_out => adr1_out);


b2v_inst14 : adr2
PORT MAP(CLK => clk,
		 ADR2_in => RAM_out,
		 Enable_bit => Enable,
		 ADR2_out => adr2_out);


b2v_inst21 : control_unit
PORT MAP(CLK => clk,
		 RST => rst,
		 ACC_in => acc_out,
		 ADR_in => mux,
		 ALU_Result => alu_result,
		 Decoder => Decoder_out,
		 PC_in => pc_out,
		 stat => stat,
		 TEMP_in => temp_out,
		 WR => write1,
		 PC_INC => pc_inc,
		 A_out => adr_out,
		 ALU1_out => alu1,
		 ALU2_out => alu2,
		 D_out => d_out,
		 Enable => Enable,
		 OP_out => OP);


b2v_inst23 : ram
PORT MAP(CLK => clk,
		 RST => rst,
		 WR => write1,
		 A => adr_out,
		 D_in => d_out,
		 D_out => RAM_out);


b2v_inst24 : alu
PORT MAP(A_in => alu1,
		 B_in => alu2,
		 OP => OP,
		 A_out => alu_result,
		 stat => stat);


b2v_inst25 : ins_reg
PORT MAP(Enable_bit => Enable,
		 INS_in => RAM_out,
		 INS_out => ins_out);


b2v_inst27 : adr_mux
PORT MAP(ADR1_in => adr1_out,
		 ADR2_in => adr2_out,
		 Enable => Enable,
		 MUX_out => mux);


END bdf_type;