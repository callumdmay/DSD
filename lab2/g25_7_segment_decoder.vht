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
-- Generated on "10/14/2016 11:56:20"
                                                            
-- Vhdl Test Bench template for design  :  g25_7_segment_decoder
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;  
Use ieee.numeric_std.all;                              

ENTITY g25_7_segment_decoder_vhd_tst IS
END g25_7_segment_decoder_vhd_tst;
ARCHITECTURE g25_7_segment_decoder_arch OF g25_7_segment_decoder_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL asci_code : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL segments : STD_LOGIC_VECTOR(6 DOWNTO 0);
COMPONENT g25_7_segment_decoder
	PORT (
	asci_code : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
	segments : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : g25_7_segment_decoder
	PORT MAP (
-- list connections between master ports and signals
	asci_code => asci_code,
	segments => segments
	);
                                          
always : PROCESS                                              

			
BEGIN                                                         
      FOR i IN 0 to 127 LOOP -- loop over all ASCII values 
		
			asci_code <= std_logic_vector(to_unsigned(i,7)); -- convert the loop variable i to std_logic_vector 	
			WAIT FOR 10 ns; -- suspend process for 10 nanoseconds at the start of each loop

		END LOOP;
		
WAIT;                                                        
END PROCESS always;                                          
END g25_7_segment_decoder_arch;
