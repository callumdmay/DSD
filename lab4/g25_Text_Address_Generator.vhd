-- entity name: g25_Text_Address_Generator 
-- Copyright (C) 2016 Callum May, Graeme Balint
-- Version 1.0
-- Author: Callum May, Graeme Balint
-- Date: November 7, 2016 


library ieee; -- allows use of the std_logic_vector type
library lpm;
use lpm.lpm_components.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity g25_Text_Address_Generator is
	port (ROW : in unsigned(9 downto 0);
			COLUMN : in unsigned(9 downto 0); 
			font_col: out std_logic_vector(2 downto 0); -- pixel column location within character on 8x16 grid 
			font_row: out std_logic_vector(3 downto 0); -- pixel row location within character on 8x16 grid 
			text_col: out std_logic_vector(5 downto 0); -- pixel column location on 19x50 grid 
			text_row: out std_logic_vector(4 downto 0));  -- pixel row location on 19x50 grid 
	end g25_Text_Address_Generator;

Architecture implementation of g25_Text_Address_Generator is


begin 
		 
	text_row <= std_logic_vector(to_unsigned(to_integer(ROW)/32, 5));
	text_col <= std_logic_vector(to_unsigned(to_integer(COLUMN)/16, 6));
	font_row <= std_logic_vector(to_unsigned((to_integer(ROW)/2) mod 16, 4));
	font_col <= std_logic_vector(to_unsigned((to_integer(COLUMN)/2) mod 8, 3)); 
		
end implementation; 
	
			
			