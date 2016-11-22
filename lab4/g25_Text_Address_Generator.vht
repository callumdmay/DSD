-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "11/13/2016 16:13:20"
                                                            
-- Vhdl Test Bench template for design  :  g25_Text_Address_Generator
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;
                               

ENTITY g25_Text_Address_Generator_vhd_tst IS
END g25_Text_Address_Generator_vhd_tst;
ARCHITECTURE g25_Text_Address_Generator_arch OF g25_Text_Address_Generator_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL COLUMN : UNSIGNED(9 DOWNTO 0);
SIGNAL font_col : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL font_row : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL ROW : UNSIGNED(9 DOWNTO 0);
SIGNAL text_col : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL text_row : STD_LOGIC_VECTOR(4 DOWNTO 0);
COMPONENT g25_Text_Address_Generator
	PORT (
	COLUMN : IN UNSIGNED(9 DOWNTO 0);
	font_col : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	font_row : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	ROW : IN UNSIGNED(9 DOWNTO 0);
	text_col : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
	text_row : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : g25_Text_Address_Generator
	PORT MAP (
-- list connections between master ports and signals
	COLUMN => COLUMN,
	font_col => font_col,
	font_row => font_row,
	ROW => ROW,
	text_col => text_col,
	text_row => text_row
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once                      
WAIT;                                                       
END PROCESS init;                                           
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
       for i in 0 to 599 loop -- repeat 16 times (once for each input bit).
			for j in 0 to 799 loop

				ROW <= to_unsigned(i,10);
				COLUMN <= to_unsigned(j,10);
				
				WAIT for 10 NS; 
		 end loop;
		end loop; 
                                                                                   
END PROCESS always;                                          
END g25_Text_Address_Generator_arch;
