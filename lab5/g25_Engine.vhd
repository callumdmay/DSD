-- entity name: g25_Engine
-- Copyright (C) 2016 Callum May, Graeme Balint
-- Version 1.0
-- Author: Callum May, Graeme Balint
-- Date: November 20, 2016

library ieee; -- allows use of the std_logic_vector type
library lpm;
use lpm.lpm_components.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity g25_Engine is 
	port (clock, reset : in std_logic;
			ball_out_row: out unsigned(9 downto 0);
			ball_out_col: out unsigned(9 downto 0);
			blocks_out : out std_logic_vector(59 downto 0);
			score_out: out std_logic_vector(15 downto 0) ;
			level_out: out std_logic_vector(2 downto 0);
			life_out: out std_logic_vector(2 downto 0)
	);
end g25_Engine;


architecture arch of g25_Engine is

	signal ball_row: unsigned(9 downto 0);
	signal ball_col: unsigned(9 downto 0);
	signal col_increment, row_increment: std_logic := '0';
	signal blocks : std_logic_vector( 59 downto 0):= (others => '1');
	signal ball_update_count: std_logic_vector(24 downto 0);
	signal ball_update : std_logic;
	signal ball_speed : integer := 100000;	
	signal score : integer;
	signal level : integer;
	signal life : integer;

Begin
	
	ball_out_row <= ball_row;
	ball_out_col <= ball_col;
	blocks_out <= blocks; 
	score_out <= std_logic_vector(to_unsigned(score, 16));
	level_out <= std_logic_vector(to_unsigned(level, 3));
	life_out <= std_logic_vector(to_unsigned(life, 3));

--***********Game update clock *********--
	update_counter : lpm_counter 
	generic map(LPM_WIDTH => 25)
	port map (clock =>clock, sclr => ball_update, aclr => reset, q =>ball_update_count);						
	ball_update <= '1' when ball_update_count = std_logic_vector(to_unsigned(ball_speed, 25)) else
					 '0';	
	--*************************************--
	
update_game : process(ball_update, reset)

	variable ball_x: integer := to_integer(ball_col);
	variable ball_y: integer := to_integer(ball_row);
	variable block_col : integer := (to_integer(ball_col) - 16)/32;
	variable block_row : integer := (to_integer(ball_row) - 16)/32;
		
Begin
	if (reset = '1') then
		ball_x := 400;
		ball_y := 450;
		col_increment <= '0';
		row_increment <= '0';
		blocks <= (others => '1');
		score <= 0;
		level <= 1;
		life  <= 5;
	elsif(rising_edge(ball_update)) then
		--update position
		if(col_increment ='1') then
			ball_x := ball_x + 1;
		else
			ball_x := ball_x - 1;
		end if;
		if(row_increment ='1') then
			ball_y := ball_y + 1;
		else
			ball_y := ball_y - 1;
		end if;
		
		--Check if hit block
		if blocks(12 * ((ball_y - 16)/32) + (ball_x -16)/64) = '1' then
			if(12 * ((ball_y - 16)/32) + (ball_x -16)/64 < 60) then
				
				blocks(12 * ((ball_y - 16)/32) + (ball_x -16)/64) <= '0';
				score <= score +10;
				
				if (ball_x - 15 ) mod 64 = 0 then
					col_increment <= not col_increment;
				elsif (ball_y - 15) mod 32 = 0 then
					row_increment <= not row_increment;
				end if;
			end if;
			
		elsif	blocks(12 * ((ball_y - 8)/32) + (ball_x -8)/64) = '1'  then
			if(12 * ((ball_y - 8)/32) + (ball_x -8)/64 < 60) then
				
				blocks(12 * ((ball_y - 8)/32) + (ball_x -8)/64) <= '0';
				score <= score +10;
				
				if (ball_x - 8) mod 64 = 0 then
					col_increment <= not col_increment;
				elsif (ball_y - 8) mod 32 = 0 then
					row_increment <= not row_increment;
				end if;
			end if;
	
		end if;

		
		--Check if hit wall
		if(ball_x <= 16) then
			col_increment <= '1';
		end if;
		if(ball_x > 775) then
			col_increment <= '0';
		end if;
		if(ball_y <= 16) then 
			row_increment <= '1';
		end if;
		if(ball_y >= 512)then
			row_increment <= '0';
		end if;
	
	end if;
	
	
	ball_col <= to_unsigned(ball_x, 10);
	ball_row <= to_unsigned(ball_y, 10);
			
end process update_game;
	

end arch;