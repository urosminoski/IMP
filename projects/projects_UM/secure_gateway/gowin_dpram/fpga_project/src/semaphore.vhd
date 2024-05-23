----------------------------------------------------------------------------------
-- Company: IMP Automation & Control Systems
-- Engineer: Uros Minoski, uros.minoski@automatika.imp.bg.ac.rs
-- 
-- Create Date: 05/07/2024 03:04:42 PM
-- Design Name: 
-- Module Name: semaphore - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity semaphore is
	port(
		-- Port A 	
		ioceA	: in std_logic;		-- I/O chip enable, smephores are addressed
		iowrA_n	: in std_logic; 	-- I/O write, active low
		
		dinA	: in std_logic;		-- Data in
		doutA	: out std_logic;	-- Data out
		
		-- Port B 
		ioceB	: in std_logic;		-- I/O chip enable, smephores are addressed
		iowrB_n	: in std_logic; 	-- I/O write, active low
		
		dinB	: in std_logic;		-- Data in
		doutB	: out std_logic		-- Data out
	);
end entity semaphore;

architecture Behavioral of semaphore is

	signal writeA 	: std_logic;	-- Write signal on port A
	signal writeB	: std_logic;	-- Write signal on port B
	
	signal dA 	: std_logic; 	-- Latched input data on port A
	signal dB 	: std_logic;	-- Latched input data on port B
	
	signal doutA_tmp 	: std_logic;	-- Output of semaphore on port A
	signal doutB_tmp 	: std_logic;	-- Output of semaphore on port B
	

begin

	-- Process to determine write signals
	writeA <= '1' when (ioceA = '1' and iowrA_n = '0') else '0';
	writeB <= '1' when (ioceB = '1' and iowrB_n = '0') else '0';
	
	-- Latch input data when write is enabled
    process(dinA, writeA, dinB, writeB)
    begin
        if writeA = '1' then
            dA <= not dinA;
        end if;
        
        if writeB = '1' then
            dB <= not dinB;
        end if;
    end process;
	
	-- Semaphore output logic
    process(dA, dB, doutA_tmp, doutB_tmp)
    begin
        doutA_tmp <= not (dA and doutB_tmp);
        doutB_tmp <= not (dB and doutA_tmp);
    end process;
	
	-- Assign temporary outputs to actual outputs
    doutA <= doutA_tmp;
    doutB <= doutB_tmp;

end Behavioral;
