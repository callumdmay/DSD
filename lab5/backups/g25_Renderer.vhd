-- entity name: g25_Renderer
-- Copyright (C) 2016 Callum May, Graeme Balint
-- Version 1.0
-- Author: Callum May, Graeme Balint
-- Date: November 20, 2016

library ieee; -- allows use of the std_logic_vector type
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity g25_Renderer is
	port( COLUMN, ROW : in unsigned(9 downto 0);
			ball_col, ball_row : in unsigned(9 downto 0);
			scorebar_RGB : in std_logic_vector (11 downto 0);
			RGB : out std_logic_vector (11 downto 0)
	);
end g25_Renderer;

architecture arch of g25_Renderer is 

	signal int_col, int_row: integer;
	
Begin

	int_col <= to_integer(COLUMN)/16;
	int_row <= to_integer(ROW)/16;

	RGB <= "111100001111" when int_row = 0 or ((int_col = 0 or int_col = 49) and int_row < 32) else
			 "111111111111" when (ROW >= ball_row and ROW < to_unsigned(to_integer(ball_row) + 8, 10)) and (COLUMN >= ball_col and COLUMN < to_unsigned(to_integer(ball_col) + 8, 10)) else
			 scorebar_RGB when int_row >32 else
			 "000000000000";

end arch;