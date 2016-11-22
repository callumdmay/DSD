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
-- Generated on "11/04/2016 11:36:23"
                                                            
-- Vhdl Test Bench template for design  :  g25_VGA_test_pattern
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY g25_VGA_test_pattern_vhd_tst IS
END g25_VGA_test_pattern_vhd_tst;
ARCHITECTURE g25_VGA_test_pattern_arch OF g25_VGA_test_pattern_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL B : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL clock : STD_LOGIC := '0';
SIGNAL G : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL HSYNC : STD_LOGIC;
SIGNAL R : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL reset : STD_LOGIC;
SIGNAL VSYNC : STD_LOGIC;
COMPONENT g25_VGA_test_pattern
	PORT (
	B : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	clock : IN STD_LOGIC;
	G : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	HSYNC : OUT STD_LOGIC;
	R : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	reset : IN STD_LOGIC;
	VSYNC : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : g25_VGA_test_pattern
	PORT MAP (
-- list connections between master ports and signals
	B => B,
	clock => clock,
	G => G,
	HSYNC => HSYNC,
	R => R,
	reset => reset,
	VSYNC => VSYNC
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
      clock <= not clock;																	
		WAIT for 10 ns;      
END PROCESS always;                                          
END g25_VGA_test_pattern_arch;
