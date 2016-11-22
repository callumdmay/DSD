-- entity name: g25_7_segment_encoder

-- Copyright (C) 2016 Callum May, Graeme Balint
-- Version 1.0
-- Author: Callum May, Graeme Balint
-- Date: October 8, 2016

library ieee; -- allows use of the std_logic_vector type
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity g25_7_segment_decoder is 
	port(	asci_code : in std_logic_vector (6 downto 0);
			segments : out std_logic_vector (6 downto 0)
			);
end g25_7_segment_decoder;

architecture implementation of g25_7_segment_decoder is

Begin

	with asci_code select
	
		segments <= 
			
			--numbers 0-9
			"1000000" when "0110000",
			"1111001" when "0110001",
			"0100100" when "0110010",
			"0110000" when "0110011",
			"0011001" when "0110100",
			"0010010" when "0110101",
			"0000011" when "0110110",
			"1111000" when "0110111",
			"0000000" when "0111000",
			"0011000" when "0111001",
			
			--letters A-Z
			"0001000" when "1000001", --A
			"0000011" when "1000010",
			"1000110" when "1000011", --C
			"0100001" when "1000100",
			"0000110" when "1000101", --E
			"0001110" when "1000110",
			"1000010" when "1000111", --G
			"0001011" when "1001000",
			"1001111" when "1001001", --I
			"1100001" when "1001010",
			"0001111" when "1001011", --K
			"1000111" when "1001100",
			"1001000" when "1001101", --M
			"0101011" when "1001110",
			"1000000" when "1001111", --O
			"0001100" when "1010000",
			"0100011" when "1010001", --Q
			"1001110" when "1010010",
			"0010010" when "1010011", --S
			"0000111" when "1010100",
			"1000001" when "1010101", --U
			"1011001" when "1010110",
			"1100011" when "1010111", --W
			"0001001" when "1011000",
			"0010001" when "1011001", --Y
			"0100100" when "1011010",
			
			--letters a-z
			"0001000" when "1100001", --a
			"0000011" when "1100010",
			"1000110" when "1100011", --c
			"0100001" when "1100100",
			"0000110" when "1100101", --e
			"0001110" when "1100110",
			"1000010" when "1100111", --g
			"0001011" when "1101000",
			"1001111" when "1101001", --i
			"1100001" when "1101010",
			"0001111" when "1101011", --k
			"1000111" when "1101100",
			"1001000" when "1101101", --m
			"0101011" when "1101110",
			"1000000" when "1101111", --o
			"0001100" when "1110000",
			"0100011" when "1110001", --q
			"1001110" when "1110010",
			"0010010" when "1110011", --s
			"0000111" when "1110100",
			"1000001" when "1110101", --u
			"1011001" when "1110110",
			"1100011" when "1110111", --w
			"0001001" when "1111000",
			"0010001" when "1111001", --y
			"0100100" when "1111010",
			
			"1111111" when others;

end implementation;