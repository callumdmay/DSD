-- entity name: g25_video_overlay
-- Copyright (C) 2016 Callum May, Graeme Balint
-- Version 1.0
-- Author: Callum May, Graeme Balint
-- Date: November 18, 2016


library ieee; -- allows use of the std_logic_vector type
library lpm;
use lpm.lpm_components.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity g25_video_overlay is
	port(clock, reset: in std_logic;
			level, life: in std_logic_vector (2 downto 0);
			score: in std_logic_vector (15 downto 0);
			COLUMN, ROW : in unsigned(9 downto 0);
			RGB : out std_logic_vector(11 downto 0)
			);
end g25_video_overlay;
	

architecture arch of g25_video_overlay is

component g25_fontROM is
	generic(
		addrWidth: integer := 11;
		dataWidth: integer := 8
	);
	port(
		clkA: in std_logic;
		char_code : in std_logic_vector(6 downto 0); -- 7-bit ASCII character code
		font_row : in std_logic_vector(3 downto 0); -- 0-15 row address in single character
		font_col : in std_logic_vector(2 downto 0); -- 0-7 column address in single character
		font_bit : out std_logic -- pixel value at the given row and column for the selected character code
	);
end component;

component g25_Text_Generator_Circuit is
	port(text_col: in std_logic_vector(5 downto 0); -- pixel column location on 18x50 grid 
		  text_row: in std_logic_vector(4 downto 0);  -- pixel row location on 18x50 grid
		  score: in std_logic_vector(15 downto 0);
		  level, life: in std_logic_vector (2 downto 0);
		  ASCII_code: out std_logic_vector(6 downto 0);
		  RGB: out std_logic_vector (11 downto 0));
end component;

component g25_Text_Address_Generator is
	port (ROW : in unsigned(9 downto 0);
			COLUMN : in unsigned(9 downto 0); 
			font_col: out std_logic_vector(2 downto 0); -- pixel column location within character on 8x16 grid 
			font_row: out std_logic_vector(3 downto 0); -- pixel row location within character on 8x16 grid 
			text_col: out std_logic_vector(5 downto 0); -- pixel column location on 19x50 grid 
			text_row: out std_logic_vector(4 downto 0));  -- pixel row location on 19x50 grid 
end component;

component g25_3bit_register IS PORT(
    d   : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    ld  : IN STD_LOGIC; -- load/enable.
    clr : IN STD_LOGIC; -- async. clear.
    clk : IN STD_LOGIC; -- clock.
    q   : OUT STD_LOGIC_VECTOR(2 DOWNTO 0) -- output
);
END component;

component g25_4bit_register IS PORT(
    d   : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    ld  : IN STD_LOGIC; -- load/enable.
    clr : IN STD_LOGIC; -- async. clear.
    clk : IN STD_LOGIC; -- clock.
    q   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- output
);
END component;

component g25_12bit_register IS PORT(
    d   : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    ld  : IN STD_LOGIC; -- load/enable.
    clr : IN STD_LOGIC; -- async. clear.
    clk : IN STD_LOGIC; -- clock.
    q   : OUT STD_LOGIC_VECTOR(11 DOWNTO 0) -- output
);
END component;
	
	signal BLANKING :  std_logic;
	signal vo_font_col: std_logic_vector(2 downto 0);
	signal vo_font_row: std_logic_vector(3 downto 0);
	signal vo_text_col: std_logic_vector(5 downto 0);
	signal vo_text_row: std_logic_vector(4 downto 0);
	signal vo_ASCII_code: std_logic_vector(6 downto 0);
	signal vo_RGB : std_logic_vector(11 downto 0); 

	signal vo_render: std_logic;
	signal vo_scoretoggle1 : std_logic;
	signal vo_clockCount1: std_logic_vector(25 downto 0);
	signal reg_font_col: std_logic_vector(2 downto 0);
	signal reg_font_row: std_logic_vector(3 downto 0);
	signal reg_RGB: std_logic_vector(11 downto 0);
Begin
	

	TAG0 : g25_Text_Address_Generator port map(ROW => ROW, COLUMN=> COLUMN, font_col => reg_font_col, font_row => reg_font_row, text_col => vo_text_col, text_row => vo_text_row);
	TGC0 : g25_Text_Generator_Circuit port map(text_col => vo_text_col, text_row => vo_text_row, score => score, level => level, life => life,  ASCII_code => vo_ASCII_code, RGB => reg_RGB);
   FR0  : g25_fontROM port map(clkA => clock, char_code => vo_ASCII_code, font_row => vo_font_row, font_col => vo_font_col, font_bit => vo_render);
	
	REG3 : g25_3bit_register port map(d => reg_font_col, ld=> '1' , clr => '0', clk => clock, q => vo_font_col);
	REG4 : g25_4bit_register port map(d => reg_font_row, ld=> '1', clr => '0', clk => clock, q => vo_font_row);
	REG12: g25_12bit_register port map(d => reg_RGB, ld=> '1', clr => '0', clk => clock, q => vo_RGB);
	
   RGB <=  vo_RGB when vo_render = '1' else
		   "000000000000";
			

end arch;