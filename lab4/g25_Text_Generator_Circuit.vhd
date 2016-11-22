-- entity name: g25_Text_Generator_Circuit
-- Copyright (C) 2016 Callum May, Graeme Balint
-- Version 1.0
-- Author: Callum May, Graeme Balint
-- Date: November 11, 2016

library ieee; -- allows use of the std_logic_vector type
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity g25_Text_Generator_Circuit is
	port(text_col: in std_logic_vector(5 downto 0); -- pixel column location on 18x50 grid 
		  text_row: in std_logic_vector(4 downto 0);  -- pixel row location on 18x50 grid
		  score: in std_logic_vector(15 downto 0);
		  level, life: in std_logic_vector (2 downto 0);
		  ASCII_code: out std_logic_vector(6 downto 0);
		  RGB: out std_logic_vector (11 downto 0));
	end g25_Text_Generator_Circuit;

architecture implementaion of g25_Text_Generator_Circuit is

	signal BCD_score: std_logic_vector(19 downto 0);
	
	function to_bcd ( bin : std_logic_vector((15) downto 0) ) return std_logic_vector is
		variable i : integer := 0;
		variable j : integer := 1;
		variable bcd : std_logic_vector((19) downto 0) := (others => '0');
		variable bint : std_logic_vector((15) downto 0) := bin;
		
		begin
			for i in 0 to 15 loop -- repeat 16 times (once for each input bit).
			
				bcd((19) downto 1) := bcd((18) downto 0); --shift the bcd bits.
				bcd(0) := bint(15);
				
				bint((15) downto 1) := bint((14) downto 0); -- shift the input bits.
				bint(0) := '0';
				
				loop1: for j in 1 to 5 loop -- for each BCD digit add 3 if it is greater than 4.
					if(i < 15 and bcd(((4*j)-1) downto ((4*j)-4)) > "0100") then
						bcd(((4*j)-1) downto ((4*j)-4)) :=
						std_logic_vector(unsigned(bcd(((4*j)-1) downto ((4*j)-4))) + "0011");
					end if;
				end loop loop1; -- no ADD3 is done on the last loop iteration (just shifting)
				
			end loop;
		return bcd; -- this produces the value that is returned by the function
	end to_bcd;

Begin

	ASCII_code <= "1010011" when to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col))= 0 else
					  "1000011" when to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col))= 1 else
					  "1001111" when to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col))= 2 else
					  "1010010" when to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col))= 3 else
					  "1000101" when to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col))= 4 else
					  "0111010" when to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col))= 5 else
					  "011" & BCD_score(19 downto 16) when to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col))= 6 else
					  "011" & BCD_score(15 downto 12) when to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col))= 7 else
					  "011" & BCD_score(11 downto 8)  when to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col))= 8 else
					  "011" & BCD_score(7  downto 4)  when to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col))= 9 else
					  "011" & BCD_score(3  downto 0)  when to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col))= 10 else
					  "1001100" when to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col))= 12 else
					  "1000101" when to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col))= 13 else
					  "1010110" when to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col))= 14 else
					  "1000101" when to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col))= 15 else
					  "1001100" when to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col))= 16 else
					  "0111010" when to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col))= 17 else
					  "0110"&level when to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col))= 18 else
					  "0000011" when to_integer(unsigned(life)) > 0 and to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col))= 20 else
					  "0000011" when to_integer(unsigned(life)) > 1 and to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col))= 21 else
					  "0000011" when to_integer(unsigned(life)) > 2 and to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col))= 22 else
					  "0000011" when to_integer(unsigned(life)) > 3 and to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col))= 23 else
					  "0000011" when to_integer(unsigned(life)) > 4 and to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col))= 24 else
					  "0000011" when to_integer(unsigned(life)) > 5 and to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col))= 25 else
					  "0000011" when to_integer(unsigned(life)) > 6 and to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col))= 26 else
					  "0100000";

	
	BCD_score <= to_bcd(score);			

	RGB <= "111100000000" when to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col))< 6 else
			 "111111111111" when to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col)) >=6 and to_integer(unsigned(text_col)) < 11 else
			 "111111110000" when to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col)) > 11 and to_integer(unsigned(text_col)) < 18 else
			 "111111111111" when to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col)) =18 else
			 "111100001111" when to_integer(unsigned(text_row ))= 17 and to_integer(unsigned(text_col)) > 19 and to_integer(unsigned(text_col)) < 27 else
			 "000000000000";
	

end implementaion;
	

