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
-- Generated on "10/03/2016 14:41:16"
                                                            
-- Vhdl Test Bench template for design  :  g25_64_6_encoder
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;                                         

ENTITY g25_64_6_encoder_vhd_tst IS
END g25_64_6_encoder_vhd_tst;
ARCHITECTURE g25_64_6_encoder_arch OF g25_64_6_encoder_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL error : STD_LOGIC;
SIGNAL input : STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL outputCode : STD_LOGIC_VECTOR(5 DOWNTO 0);
COMPONENT g25_64_6_encoder
	PORT (
	error : OUT STD_LOGIC;
	input : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	outputCode : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : g25_64_6_encoder
	PORT MAP (
-- list connections between master ports and signals
	error => error,
	input => input,
	outputCode => outputCode
	);
                                           
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN  
		input <= (others => '0');	
		WAIT FOR 10 ns;		
	FOR i IN 0 to 63 LOOP
		input <= (i => '1', others => '0');
		WAIT FOR 10 ns;
	END LOOP;

		input <= std_logic_vector(to_unsigned(5700,64));	
		WAIT FOR 10 ns;	
	
		input <= std_logic_vector(to_unsigned(961160,64));	
		WAIT FOR 10 ns;	
	
		input <= std_logic_vector(to_unsigned(4202020,64));	
		WAIT FOR 10 ns;	
	
		input <= std_logic_vector(to_unsigned(458752,64));	
		WAIT FOR 10 ns;	
	
WAIT;                                                        
END PROCESS always;                                          
END g25_64_6_encoder_arch;
