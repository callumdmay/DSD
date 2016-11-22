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
	port(clock, reset: in std_logic;
			R, G, B : out std_logic_vector(3 downto 0);
			HSYNC : out std_logic;
			VSYNC: out std_logic);
end g25_Breakout_Game;
	

architecture arch of g25_Breakout_Game is

component g25_video_overlay is
	port(clock, reset: in std_logic;
			level, life: in std_logic_vector (2 downto 0);
			score: in std_logic_vector (15 downto 0);
			COLUMN, ROW : in unsigned(9 downto 0);
			RGB : out std_logic_vector(11 downto 0)
			);
end component;

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
	port( COLUMN, ROW : in unsigned(9 downto 0);
			ball_col, ball_row : in unsigned(9 downto 0);
			scorebar_RGB : in std_logic_vector (11 downto 0);
			RGB : out std_logic_vector (11 downto 0)
	);
end component;

	signal ROW, COLUMN : unsigned(9 downto 0);
	signal BLANKING : std_logic;
	signal int_col, int_row: integer;

	signal scorebar_RGB : std_logic_vector(11 downto 0); 
	signal vo_score: std_logic_vector(15 downto 0) := "1111111111111111";
	signal RGB_out : std_logic_vector (11 downto 0);
	
	signal ball_row: unsigned(9 downto 0) := "0111000010";
	signal ball_col: unsigned(9 downto 0) := "0110010000";
	signal col_increment, row_increment: std_logic := '0';
	signal vo_update_count: std_logic_vector(24 downto 0);
	signal vo_update : std_logic;
	signal update_max_value : integer := 1000000;
	signal level: std_logic_vector(2 downto 0) := "001";
	signal life: std_logic_vector(2 downto 0) := "111";
	
Begin

	R <= RGB_out(11 downto 8);
	G <= RGB_out(7 downto 4);
	B <= RGB_out(3 downto 0);
	
	int_col <= to_integer(COLUMN)/16;
	int_row <= to_integer(ROW)/16;
  
	VGA0 : g25_VGA port map(clock => clock, rst => reset, BLANKING => BLANKING, ROW => ROW, COLUMN => COLUMN, HSYNC => HSYNC, VSYNC => VSYNC);
	Renderer : g25_Renderer port map(COLUMN => COLUMN, ROW => ROW, ball_col => ball_col, ball_row => ball_row, scorebar_RGB => scorebar_RGB, RGB => RGB_out);
		
	--********** Score bar **********--
	ScoreOverlay : g25_video_overlay port map (clock => clock, reset => reset, level => level, life => life, score => vo_score, COLUMN => COLUMN, ROW => ROW, RGB => scorebar_RGB);
	--*******************************--
	
	--***********Game update clock *********--
	update_counter : lpm_counter 
	generic map(LPM_WIDTH => 25)
	port map (clock =>clock, sclr => vo_update, aclr => reset, q =>vo_update_count);						
	vo_update <= '1' when vo_update_count = std_logic_vector(to_unsigned(update_max_value, 25)) else
					 '0';	
	--*************************************--

	--********** Ball movement **********--
	update_ball : process(vo_update, reset)
		variable ball_x: unsigned(9 downto 0) := ball_col;
		variable ball_y: unsigned(9 downto 0) := ball_row;
	Begin
		if (reset = '1') then
		ball_col <= "0110010000";
		ball_row <= "0111000010";
		else if(rising_edge(vo_update)) then
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
			
			if(to_integer(ball_x) <= 16) then
				col_increment <= '1';
			end if;
			
			if(to_integer(ball_x) > 775) then
				col_increment <= '0';
			end if;
			
			if(to_integer(ball_y) <= 16) then 
				row_increment <= '1';
			end if;
			
			if(to_integer(ball_y) >= 512)then
				row_increment <= '0';
			end if;
			
			ball_col <= ball_x;
			ball_row <= ball_y;
		end if;
	end process;

end arch;