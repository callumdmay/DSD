-- entity name: g25_VGA_test_pattern
-- Copyright (C) 2016 Callum May, Graeme Balint
-- Version 1.0
-- Author: Callum May, Graeme Balint
-- Date: November 03, 2016


library ieee; -- allows use of the std_logic_vector type
library lpm;
use lpm.lpm_components.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity g25_VGA_test_pattern is
	port(clock, reset: in std_logic;
			R, G, B : out std_logic_vector(3 downto 0);
			HSYNC : out std_logic;
			VSYNC: out std_logic);
end g25_VGA_test_pattern;
	

architecture arch of g25_VGA_test_pattern is

component g25_VGA is 
		port ( clock : in std_logic; -- 50MHz
		rst : in std_logic; -- reset
		BLANKING : out std_logic; -- blank display when zero
		ROW : out unsigned(9 downto 0); -- line 0 to 599
		COLUMN : out unsigned(9 downto 0); -- column 0 to 799
		HSYNC : out std_logic; -- horizontal sync signal
		VSYNC : out std_logic); -- vertical sync signal
end component;
	
signal ROW, COLUMN : unsigned(9 downto 0);	
signal BLANKING :  std_logic;
Begin

	VGA0 : g25_VGA port map(clock => clock, rst => reset, BLANKING => BLANKING, ROW => ROW, COLUMN => COLUMN, HSYNC => HSYNC, VSYNC => VSYNC);


R <= 	"1111"  when to_integer(COLUMN) <  200 and to_integer(COLUMN) >= 0   and (to_integer(ROW) >=0 and to_integer(ROW) < 600) else
		"1111"  when to_integer(COLUMN) >= 400 and to_integer(COLUMN) < 600 and (to_integer(ROW) >=0 and to_integer(ROW) < 600) else
		"0000" when BLANKING = '0' else
		"0000"; 

G <= 	"1111"  when to_integer(COLUMN) <  400 and to_integer(COLUMN) >= 0   and (to_integer(ROW) >=0 and to_integer(ROW) < 600) else
		"0000" when BLANKING = '0' else
		"0000"; 

B <=  "1111"  when to_integer(COLUMN) <  100 and to_integer(COLUMN) >= 0  and (to_integer(ROW) >=0 and to_integer(ROW) < 600) else
		"1111"  when to_integer(COLUMN) >= 200 and to_integer(COLUMN) < 300 and (to_integer(ROW) >=0 and to_integer(ROW) < 600) else
		"1111"  when to_integer(COLUMN) >= 400 and to_integer(COLUMN) < 500 and (to_integer(ROW) >=0 and to_integer(ROW) < 600) else
		"1111"  when to_integer(COLUMN) >= 600 and to_integer(COLUMN) < 700 and (to_integer(ROW) >=0 and to_integer(ROW) < 600) else
		"0000" when BLANKING = '0' else
		"0000";



end arch;