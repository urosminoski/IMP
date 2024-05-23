----------------------------------------------------------------------------------
-- Company: IMP Automation & Control Systems
-- Engineer: Uros Minoski, uros.minoski@automatika.imp.bg.ac.rs
-- 
-- Create Date: 05/08/2024 12:29:29 PM
-- Design Name: 
-- Module Name: secure_gateway - Behavioral
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

package secure_gateway_pkg is

	-- Define address and data bus sizes
	constant C_DATA_SIZE			: natural := 16;	-- Data bus size 
	constant C_ISA_ADDR_SIZE		: natural := 24; 	-- ISA address bus size
	constant C_RAM_ADDR_SIZE		: natural := 14; 	-- Dual-Port RAM address bus size
	
	-- Define the type for an array of unsigned addresses
    type unsigned_array is array (natural range <>) of unsigned(C_RAM_ADDR_SIZE-1 downto 0);
	
	-- Define number of semaphores
	constant C_NUM_SEM		: natural := 8;
	
	-- Define the semaphore addresses
    constant C_SEM_ADDRS : unsigned_array(0 to C_NUM_SEM-1) := 
	(
		to_unsigned(0, C_RAM_ADDR_SIZE),
		to_unsigned(1, C_RAM_ADDR_SIZE),
		to_unsigned(2, C_RAM_ADDR_SIZE),
		to_unsigned(3, C_RAM_ADDR_SIZE),
		to_unsigned(4, C_RAM_ADDR_SIZE),
		to_unsigned(5, C_RAM_ADDR_SIZE)	,
		to_unsigned(6, C_RAM_ADDR_SIZE)	,
		to_unsigned(7, C_RAM_ADDR_SIZE)	
		-- Add more addresses here if C_NUM_SEM is increased
	);

	constant C_BASE_ADDR		: unsigned(C_ISA_ADDR_SIZE - 1 downto 0) := "000010100000000000000000";		-- Base address
	constant C_RAM_START		: unsigned(C_RAM_ADDR_SIZE - 1 downto 0) := "00000000000000";				-- RAM start address
	constant C_RAM_END 			: unsigned(C_RAM_ADDR_SIZE - 1 downto 0) := "10011111111101";				-- RAM end address
	constant C_INT_A			: unsigned(C_RAM_ADDR_SIZE - 1 downto 0) := "10011111111110";				-- Interrupt address on port A
	constant C_INT_B			: unsigned(C_RAM_ADDR_SIZE - 1 downto 0) := "10011111111111";				-- Interrupt address on port B
	constant C_SEM_START		: unsigned(C_RAM_ADDR_SIZE - 1 downto 0) := "00000000000000";				-- Semaphore start address
	constant C_SEM_END			: unsigned(C_RAM_ADDR_SIZE - 1 downto 0) := "00000000000111";				-- Semaphore start address

end package secure_gateway_pkg;