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
	port (clock, reset, paddle_left, paddle_right : in std_logic;
			ball_out_row: out unsigned(9 downto 0);
			ball_out_col: out unsigned(9 downto 0);
			paddle_out_row: out unsigned(9 downto 0);
			paddle_out_col: out unsigned(9 downto 0);
			blocks_out : out std_logic_vector(59 downto 0);
			score_out: out std_logic_vector(15 downto 0) ;
			level_out: out std_logic_vector(2 downto 0);
			life_out: out std_logic_vector(2 downto 0)
	);
end g25_Engine;


architecture arch of g25_Engine is

	signal pause : std_logic;
	signal pause_interval: integer := 50000000;
	signal pause_count : integer ;
	signal ball_row: integer;
	signal ball_col: integer;
	signal col_increment, row_increment: std_logic := '0';
	signal ball_update_count: std_logic_vector(24 downto 0);
	signal ball_update : std_logic;
	signal ball_speed : integer := 100000;	
	
	signal paddle_row : integer;
	signal paddle_col : integer;
	signal paddle_update_count: std_logic_vector(24 downto 0);
	signal paddle_update : std_logic;
	signal paddle_speed : integer := 100000;	
	
	signal blocks : std_logic_vector( 59 downto 0):= (others => '1');
	signal score : integer;
	signal level : integer;
	signal life : integer;

Begin
	
	ball_out_row <= to_unsigned(ball_row, 10);
	ball_out_col <= to_unsigned(ball_col, 10);
	paddle_out_row <= to_unsigned(paddle_row, 10);
	paddle_out_col <= to_unsigned(paddle_col, 10);
	blocks_out <= blocks; 
	score_out <= std_logic_vector(to_unsigned(score, 16));
	level_out <= std_logic_vector(to_unsigned(level, 3));
	life_out <= std_logic_vector(to_unsigned(life, 3));

--***********Ball update clock *********--
	ball_update_counter : lpm_counter 
	generic map(LPM_WIDTH => 25)
	port map (clock =>clock, sclr => ball_update, aclr => reset, q =>ball_update_count);						
	ball_update <= '1' when ball_update_count = std_logic_vector(to_unsigned(ball_speed, 25)) else
					 '0';	
	--*************************************--

--***********Paddle update clock *********--
	paddle_update_counter : lpm_counter 
	generic map(LPM_WIDTH => 25)
	port map (clock =>clock, sclr => paddle_update, aclr => reset, q =>paddle_update_count);						
	paddle_update <= '1' when paddle_update_count = std_logic_vector(to_unsigned(paddle_speed, 25)) else
					 '0';	
	--*************************************--	
update_game : process(clock, reset)

	variable ball_x: integer := ball_col;
	variable ball_y: integer := ball_row;
	variable paddle_x: integer := paddle_col;
	variable paddle_y: integer := paddle_row;
	variable p_count: integer := pause_count;

Begin
	if (reset = '1') then
		ball_x := 400;
		ball_y := 450;
		paddle_x := 336;
		paddle_y := 496;
		col_increment <= '0';
		row_increment <= '0';
		blocks <= (others => '1');
		score <= 0;
		level <= 1;
		life  <= 5;
		pause <= '0';
		p_count := 0;
	elsif(rising_edge(clock)) then
	
		if(pause = '0') then
			--Update ball
			if(ball_update = '1') then
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
						--Hit the bottom 
						if (ball_x - 15 ) mod 64 = 0 then
							col_increment <= not col_increment;
						--Hit the left side
						elsif (ball_y - 15) mod 32 = 0 then
							row_increment <= not row_increment;
						--hit a corner
						else
							col_increment <= not col_increment;
							row_increment <= not row_increment;
						end if;
					end if;
					
				elsif	blocks(12 * ((ball_y - 8)/32) + (ball_x -8)/64) = '1'  then
					if(12 * ((ball_y - 8)/32) + (ball_x -8)/64 < 60) then
						
						blocks(12 * ((ball_y - 8)/32) + (ball_x -8)/64) <= '0';
						score <= score +10;
						--Hit the top
						if (ball_x - 8) mod 64 = 0 then
							col_increment <= not col_increment;
						--Hit the right side
						elsif (ball_y - 8) mod 32 = 0 then
							row_increment <= not row_increment;
						--hit a corner
						else
							col_increment <= not col_increment;
							row_increment <= not row_increment;
						end if;
					end if;
		
				end if;
				
					
				--Check if hit top of paddle
				if(ball_y + 8 = paddle_y and ball_x +8 >= paddle_x and ball_x < paddle_x +128) then
						row_increment <= not row_increment;
				end if;
				--Check if hit side of paddle
				if ( ball_y + 8 > paddle_y and (ball_x + 8 = paddle_x or ball_x = paddle_x + 128 ) ) then
					col_increment <= not col_increment;
				end if;
				
				--Check if below paddle then lose life
				if(ball_y > paddle_y) then
					life <= life -1;
					ball_x := 400;
					ball_y := 450;
					col_increment <= '0';
					row_increment <= '0';
					paddle_x := 336;
					paddle_y := 496;
					pause <= '1';
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
				if(ball_y > 503)then
					row_increment <= '0';
				end if;
				
			end if;
				
			--Update paddle
			if (paddle_update ='1') then
		
				if(paddle_left ='0' and paddle_right ='0') then
				
				elsif(paddle_left ='0') then
					if(paddle_x > 15) then
					paddle_x := paddle_x -1;
					end if;
				elsif(paddle_right ='0') then
					if(paddle_x <=656) then
					paddle_x := paddle_x +1;
					end if;
				else
				
				end if;
				
			end if;

		else
			p_count := p_count +1;
			
			if(p_count = pause_interval) then
				p_count := 0;
				pause <='0';
			end if;
			
		end if;
	
	end if;
	
	ball_col <= ball_x;
	ball_row <= ball_y;
	paddle_col <= paddle_x;
	paddle_row <= paddle_y;
	pause_count <= p_count;		
	
end process update_game;


end arch;