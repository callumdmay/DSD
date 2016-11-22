-- entity name: g25_16_4_encoder

-- Copyright (C) 2016 your name
-- Version 1.0
-- Author: designers’ names
-- Date: October 3, 2016

library ieee; -- allows use of the std_logic_vector type
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Library ieee;
use ieee.std_logic_1164.all;

entity g25_16_4_encoder is
	port(block_col: in std_logic_vector(15 downto 0); error: out std_logic; code: out std_logic_vector(3 downto 0));
end  g25_16_4_encoder;

architecture implementation of  g25_16_4_encoder is
	begin 
		code <= 
				"0000" when block_col(0)  = '1' else
				"0001" when block_col(1)  = '1' else
				"0010" when block_col(2)  = '1' else
				"0011" when block_col(3)  = '1' else
				"0100" when block_col(4)  = '1' else
				"0101" when block_col(5)  = '1' else
				"0110" when block_col(6)  = '1' else
				"0111" when block_col(7)  = '1' else
				"1000" when block_col(8)  = '1' else
				"1001" when block_col(9)  = '1' else
				"1010" when block_col(10) = '1' else
				"1011" when block_col(11) = '1' else
				"1100" when block_col(12) = '1' else
				"1101" when block_col(13) = '1' else
				"1110" when block_col(14) = '1' else
				"1111" when block_col(15) = '1' else
				"0000";
					
		error <= '1' when block_col = "0000000000000000" else '0';
		
end implementation;

		