-- entity name: g25_Renderer
-- Copyright (C) 2016 Callum May, Graeme Balint
-- Version 1.0
-- Author: Callum May, Graeme Balint
-- Date: November 20, 2016

library ieee; -- allows use of the std_logic_vector type
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity g25_Renderer is
	port( clock, reset: in std_logic;
			life, level : in std_logic_vector (2 downto 0);
			score : in std_logic_vector (15 downto 0);
			COLUMN, ROW : in unsigned(9 downto 0);
			ball_col, ball_row : in unsigned(9 downto 0);
			RGB : out std_logic_vector (11 downto 0)
	);
end g25_Renderer;

architecture arch of g25_Renderer is 

	component g25_video_overlay is
		port(clock, reset: in std_logic;
				level, life: in std_logic_vector (2 downto 0);
				score: in std_logic_vector (15 downto 0);
				COLUMN, ROW : in unsigned(9 downto 0);
				RGB : out std_logic_vector(11 downto 0)
				);
	end component;

	signal int_col, int_row: integer;
	signal scorebar_RGB : std_logic_vector(11 downto 0); 
	
Begin

	int_col <= to_integer(COLUMN)/16;
	int_row <= to_integer(ROW)/16;
	
		--********** Score bar **********--
	ScoreOverlay : g25_video_overlay port map (
			clock => clock, 
			reset => reset, 
			level => level, 
			life => life, 
			score => score, 
			COLUMN => COLUMN, 
			ROW => ROW, 
			RGB => scorebar_RGB);
	--*******************************--
	

	RGB <= 
		--Render walls
		"111100001111" when int_row = 0 or ((int_col = 0 or int_col = 49) and int_row < 32) else
		--Render ball
		"111111111111" when (ROW >= ball_row and ROW < to_unsigned(to_integer(ball_row) + 8, 10)) and (COLUMN >= ball_col and COLUMN < to_unsigned(to_integer(ball_col) + 8, 10)) else
		--Render scorebar
		scorebar_RGB when int_row >32 else
		--Render blank
	   "000000000000";

end arch;