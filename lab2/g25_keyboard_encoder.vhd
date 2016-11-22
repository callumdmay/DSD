-- entity name: g25_keyboard_encoder

-- Copyright (C) 2016 Callum May, Graeme Balint
-- Version 1.0
-- Author: Callum May, Graeme Balint
-- Date: October 3, 2016

library ieee; -- allows use of the std_logic_vector type
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity g25_keyboard_encoder is 
	port(	keys : in std_logic_vector (63 downto 0);
			ASCII_CODE : out std_logic_vector (6 downto 0)
			);
end g25_keyboard_encoder;

architecture implementation of g25_keyboard_encoder is

component g25_64_6_encoder
	port ( input : in std_logic_vector(63 downto 0); outputCode : out std_logic_vector(5 downto 0); error : out std_logic);
end component;  

signal encoderOutput : std_logic_vector(5 downto 0);
signal preASCII : std_logic_vector(6 downto 0);
Begin

	Encoder0 : g25_64_6_encoder port map (input => keys, outputCode => encoderOutput);
	
ASCII_CODE(3 downto 0 ) <= encoderOutput(3 downto 0);
	
with	encoderOutput(5 downto 4) select

		ASCII_CODE(6 downto 4) 
		<=
			"010" when "00",
			"011" when "01",
			"100" when "10",
			"101" when "11",
			"000" when others;	

end implementation;