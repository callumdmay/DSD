-- entity name: g25_VGA
-- Copyright (C) 2016 Callum May, Graeme Balint
-- Version 1.0
-- Author: Callum May, Graeme Balint
-- Date: October 27, 2016


library ieee; -- allows use of the std_logic_vector type
library lpm;
use lpm.lpm_components.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity g25_VGA is
	port ( clock : in std_logic; -- 50MHz
		rst : in std_logic; -- reset
		BLANKING : out std_logic; -- blank display when zero
		ROW : out unsigned(9 downto 0); -- line 0 to 599
		COLUMN : out unsigned(9 downto 0); -- column 0 to 799
		HSYNC : out std_logic; -- horizontal sync signal
		VSYNC : out std_logic); -- vertical sync signal
end g25_VGA;


architecture arch of g25_VGA is

signal horizontalCount : std_logic_vector(10 downto 0); 
signal verticalCount : std_logic_vector(9 downto 0);
signal horizontalClear, verticalClear : std_logic;

begin


-- create horizontal counter
horizontalCounter : lpm_counter 
	generic map(LPM_WIDTH => 11)
	port map (clock =>clock, sclr=> horizontalClear, aclr => rst, q =>horizontalCount);						
with horizontalCount select
	horizontalClear <= '1' when "10000001111",
	'0' when others;
	
--create vertical counter
verticalCounter : lpm_counter
	generic map (LPM_WIDTH => 10)
	port map (clock => clock, sclr => verticalClear, q => verticalCount, aclr => rst, cnt_en =>horizontalClear);
with verticalCount select
	verticalClear <= horizontalClear when "1010011001",
	'0' when others;

ROW <= to_unsigned(599, 10) when (to_integer(unsigned(verticalCount)) < 43) or (to_integer(unsigned(verticalCount)) > 642) else
		to_unsigned(to_integer(unsigned(verticalCount)) -43, 10);

COLUMN <= to_unsigned(799, 10) when (to_integer(unsigned(horizontalCount)) < 176) or (to_integer(unsigned(horizontalCount)) > 975) else
		to_unsigned(to_integer(unsigned(horizontalCount)) -176, 10);

BLANKING <= '0' when ((to_integer(unsigned(verticalCount)) < 43) or (to_integer(unsigned(verticalCount)) > 642)) or ((to_integer(unsigned(horizontalCount)) < 176) or (to_integer(unsigned(horizontalCount)) > 975)) else
		 '1';

HSYNC <= '0' when to_integer(unsigned(horizontalCount)) < 120 and to_integer(unsigned(horizontalCount)) >=0 else
			'1';
			
VSYNC <= '0' when to_integer(unsigned(verticalCount)) < 6 and to_integer(unsigned(verticalCount)) >=0 else
			'1';

end arch;