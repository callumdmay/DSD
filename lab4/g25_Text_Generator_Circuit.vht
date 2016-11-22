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
-- Generated on "11/14/2016 14:07:33"
                                                            
-- Vhdl Test Bench template for design  :  g25_Text_Generator_Circuit
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;
Use ieee.numeric_std.all;                                

ENTITY g25_Text_Generator_Circuit_vhd_tst IS
END g25_Text_Generator_Circuit_vhd_tst;
ARCHITECTURE g25_Text_Generator_Circuit_arch OF g25_Text_Generator_Circuit_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL ASCII_code : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL level : STD_LOGIC_VECTOR(2 DOWNTO 0) := "011";
SIGNAL life : STD_LOGIC_VECTOR(2 DOWNTO 0) := "111";
SIGNAL RGB : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL score : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0011000000111001";
SIGNAL text_col : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL text_row : STD_LOGIC_VECTOR(4 DOWNTO 0);
COMPONENT g25_Text_Generator_Circuit
	PORT (
	ASCII_code : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	level : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	life : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	RGB : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	score : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	text_col : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
	text_row : IN STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : g25_Text_Generator_Circuit
	PORT MAP (
-- list connections between master ports and signals
	ASCII_code => ASCII_code,
	level => level,
	life => life,
	RGB => RGB,
	score => score,
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
        for i in 0 to 19 loop -- repeat 16 times (once for each input bit).
			for j in 0 to 51 loop
				text_col <= std_logic_vector(to_unsigned(j,6));
				text_row <= std_logic_vector(to_unsigned(i,5));
				
				WAIT for 10 NS; 
			end loop;
		  end loop; 
                                                       
END PROCESS always;                                          
END g25_Text_Generator_Circuit_arch;
