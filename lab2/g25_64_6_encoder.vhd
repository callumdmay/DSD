-- entity name: g25_64_6_encoder

-- Copyright (C) 2016 your name
-- Version 1.0
-- Author: designers’ names
-- Date: October 3, 2016

library ieee; -- allows use of the std_logic_vector type
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity g25_64_6_encoder is
port ( input : in std_logic_vector(63 downto 0); outputCode : out std_logic_vector(5 downto 0); error : out std_logic);
	end g25_64_6_encoder;  
	
Architecture implementation of g25_64_6_encoder is

	component g25_16_4_encoder
		port(block_col: in std_logic_vector(15 downto 0); error: out std_logic; code: out std_logic_vector(3 downto 0));
	end component;

	signal errors : std_logic_vector(3 downto 0) := "0000";
	signal value0, value1, value2, value3 : std_logic_vector(5 downto 0) := "000000";
	
Begin
	
	encoder0: g25_16_4_encoder port map(block_col => input(15 downto 0), error => errors(0), code => value0(3 downto 0) );
	encoder1: g25_16_4_encoder port map(block_col => input(31 downto 16), error => errors(1), code => value1(3 downto 0) );
	encoder2: g25_16_4_encoder port map(block_col => input(47 downto 32), error => errors(2), code => value2(3 downto 0) );
	encoder3: g25_16_4_encoder port map(block_col => input(63 downto 48), error => errors(3), code => value3(3 downto 0) );
	
	outputCode <=
		std_logic_vector(unsigned(value0) + 0) when errors(0) = '0' else
		std_logic_vector(unsigned(value1) + 16) when errors(1) = '0' else
		std_logic_vector(unsigned(value2) + 32) when errors(2) = '0' else
		std_logic_vector(unsigned(value3) + 48) when errors(3) = '0' else
		(others => '0');
		
		error <= '1' when errors = "1111" else '0';

	
End implementation;
