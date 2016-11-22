-- entity name: g25_keyboard_to_decoder_bridge

-- Copyright (C) 2016 Callum May, Graeme Balint
-- Version 1.0
-- Author: Callum May, Graeme Balint
-- Date: October 8, 2016

library ieee; -- allows use of the std_logic_vector type
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity g25_keyboard_to_decoder_bridge is
	port(inputKeys : in std_logic_vector (9 downto 0);
	     LEDsegments : out std_logic_vector (6 downto 0));
end g25_keyboard_to_decoder_bridge;

architecture implementation of g25_keyboard_to_decoder_bridge is

component g25_keyboard_encoder 
	port(	keys : in std_logic_vector (63 downto 0);
			ASCII_CODE : out std_logic_vector (6 downto 0)
			);
end component;

component g25_7_segment_decoder
	port(	asci_code : in std_logic_vector (6 downto 0);
			segments : out std_logic_vector (6 downto 0)
			);
end component;

signal asciiCodeBridge: std_logic_vector (6 downto 0);
signal tempKeys: std_logic_vector(63 downto 0);
Begin

	KeyboardEncoder: g25_keyboard_encoder port map(keys => tempKeys, ASCII_CODE => asciiCodeBridge);
	SegmentDecoder: g25_7_segment_decoder port map(asci_code => asciiCodeBridge, segments => LEDsegments);

	tempKeys(25 downto 16) <= inputKeys;
	
	tempKeys(15 downto 0) <= (others =>'0');
	tempKeys(63 downto 26) <= (others =>'0');

end implementation;
	