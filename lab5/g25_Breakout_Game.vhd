-- entity name: g25_Breakout_Game
-- Copyright (C) 2016 Callum May, Graeme Balint
-- Version 1.0
-- Author: Callum May, Graeme Balint
-- Date: November 20, 2016


library ieee; -- allows use of the std_logic_vector type
library lpm;
use lpm.lpm_components.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity g25_Breakout_Game is
	port(clock, reset, VGA_reset, paddle_left, paddle_right: in std_logic;
			R, G, B : out std_logic_vector(3 downto 0);
			HSYNC : out std_logic;
			VSYNC: out std_logic);
end g25_Breakout_Game;
	

architecture arch of g25_Breakout_Game is

component g25_VGA is 
		port ( clock : in std_logic; -- 50MHz
		rst : in std_logic; -- reset
		BLANKING : out std_logic; -- blank display when zero
		ROW : out unsigned(9 downto 0); -- line 0 to 599
		COLUMN : out unsigned(9 downto 0); -- column 0 to 799
		HSYNC : out std_logic; -- horizontal sync signal
		VSYNC : out std_logic); -- vertical sync signal
end component;

component g25_Renderer is
	port( clock, reset: in std_logic;
			life, level : in std_logic_vector (2 downto 0);
			score : in std_logic_vector (15 downto 0);
			blocks: in std_logic_vector (59 downto 0);
			COLUMN, ROW : in unsigned(9 downto 0);
			ball_col, ball_row : in unsigned(9 downto 0);
			paddle_col, paddle_row : in unsigned(9 downto 0);
			RGB : out std_logic_vector (11 downto 0)
	);
end component;

component g25_Engine is 
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
end component;

	signal ROW, COLUMN : unsigned(9 downto 0);
	signal BLANKING : std_logic;
	
	signal RGB_out : std_logic_vector (11 downto 0);
	signal ball_row: unsigned(9 downto 0);
	signal ball_col: unsigned(9 downto 0);
	signal paddle_row: unsigned(9 downto 0);
	signal paddle_col: unsigned(9 downto 0);
	signal score: std_logic_vector(15 downto 0);
	signal level: std_logic_vector(2 downto 0);
	signal life: std_logic_vector(2 downto 0);
	signal blocks : std_logic_vector (59 downto 0);
	
Begin

	R <= RGB_out(11 downto 8);
	G <= RGB_out(7 downto 4);
	B <= RGB_out(3 downto 0);
  
	VGA0 : g25_VGA port map(clock => clock, rst => VGA_reset, BLANKING => BLANKING, ROW => ROW, COLUMN => COLUMN, HSYNC => HSYNC, VSYNC => VSYNC);
	
	Renderer : g25_Renderer port map(
		clock => clock,
		reset => reset,
		life => life,
		level => level,
		score => score,
		blocks => blocks,
		COLUMN => COLUMN,
		ROW => ROW,
		ball_col => ball_col,
		ball_row => ball_row,
		paddle_col => paddle_col,
		paddle_row => paddle_row,
		RGB => RGB_out
	);
			
	Engine: g25_Engine port map(
		clock => clock,
		reset => reset,
		paddle_left => paddle_left,
		paddle_right => paddle_right,
		ball_out_row => ball_row,
		ball_out_col => ball_col,
		paddle_out_row => paddle_row,
		paddle_out_col => paddle_col,
		blocks_out => blocks,
		score_out => score,
		level_out => level,
		life_out => life
	);

end arch;