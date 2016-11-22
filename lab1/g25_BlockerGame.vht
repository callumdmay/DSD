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
-- Generated on "09/26/2016 14:24:02"
                                                            
-- Vhdl Test Bench template for design  :  g25_BlockerGame
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;                                

ENTITY g25_BlockerGame_vhd_tst IS
END g25_BlockerGame_vhd_tst;
ARCHITECTURE g25_BlockerGame_arch OF g25_BlockerGame_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL block_col : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL code : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL error : STD_LOGIC;
COMPONENT g25_BlockerGame
	PORT (
	block_col : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	code : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	error : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : g25_BlockerGame
	PORT MAP (
-- list connections between master ports and signals
	block_col => block_col,
	code => code,
	error => error
	);                                      
generate_test : PROCESS                                              
                        
BEGIN                                                         
	FOR i IN 0 to 64 LOOP
	i <= i *2;
		block_col <= std_logic_vector(to_unsigned(i,16));
		WAIT FOR 10 ns;
	END LOOP;
	WAIT;                                                        
END PROCESS generate_test;                                          
END g25_BlockerGame_arch;
