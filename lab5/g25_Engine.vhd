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
			blocks_out : out std_logic_vector(59 downto 0)		
	);
end g25_Engine;


architecture arch of g25_Engine is

	signal ball_row: unsigned(9 downto 0) := "0111000010";
	signal ball_col: unsigned(9 downto 0) := "0110010000";
	signal col_increment, row_increment: std_logic := '0';
	signal blocks : std_logic_vector( 59 downto 0):= (others => '1');
	signal vo_update_count: std_logic_vector(24 downto 0);
	signal vo_update : std_logic;
	signal update_max_value : integer := 1000000;	

Begin
	
	ball_out_row <= ball_row;
	ball_out_col <= ball_col;
	blocks_out <= blocks; 

--***********Game update clock *********--
	update_counter : lpm_counter 
	generic map(LPM_WIDTH => 25)
	port map (clock =>clock, sclr => vo_update, aclr => reset, q =>vo_update_count);						
	vo_update <= '1' when vo_update_count = std_logic_vector(to_unsigned(update_max_value, 25)) else
					 '0';	
	--*************************************--
	
	update_ball : process(vo_update, reset)
		variable ball_x: unsigned(9 downto 0) := ball_col;
		variable ball_y: unsigned(9 downto 0) := ball_row;
	Begin
		if (reset = '1') then
			ball_col <= "0110010000";
			ball_row <= "0111000010";
		elsif(rising_edge(vo_update)) then
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
		
		end if;
		
		ball_col <= ball_x;
		ball_row <= ball_y;
			
	end process update_ball;

end arch;