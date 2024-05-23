----------------------------------------------------------------------------------
-- Company: IMP Automation & Control Systems
-- Engineer: Uros Minoski, uros.minoski@automatika.imp.bg.ac.rs
-- 
-- Create Date: 05/07/2024 01:25:59 PM
-- Design Name: 
-- Module Name: addr_latch - Behavioral
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

entity address_latch is
	generic(
		C_ADDR_SIZE : integer := 24
	);
	port(
		addr_in			: in std_logic_vector(C_ADDR_SIZE - 1 downto 0);	-- Input address (from ISA bus)
		latch_enable	: in std_logic;										-- Enable address latching.
		addr_latched	: out std_logic_vector(C_ADDR_SIZE - 1 downto 0)	-- Latched input address bus.
	);
end entity address_latch;

architecture Behavioral of address_latch is

begin

	-- Process that performs latching.
	P1 : process(latch_enable)
	begin
		-- latch on rising edge of enable signal.
		if falling_edge(latch_enable) then
			addr_latched <= addr_in;
		end if;
	end process;

end Behavioral;
