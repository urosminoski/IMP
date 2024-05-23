----------------------------------------------------------------------------------
-- Company: IMP Automation & Control Systems
-- Engineer: Uros Minoski, uros.minoski@automatika.imp.bg.ac.rs 
-- 
-- Create Date: 04/23/2024 03:08:21 PM
-- Design Name: 
-- Module Name: address_latch_tb - Behavioral
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

entity address_latch_tb is
end address_latch_tb;

architecture Behavioral of address_latch_tb is

	component address_latch is
		generic(
			C_ADDR_SIZE : integer := 24
		);
		port(
			addr_in			: in std_logic_vector(C_ADDR_SIZE - 1 downto 0);	-- Input address (from ISA bus)
			latch_enable	: in std_logic;										-- Enable address latching.
			addr_latched	: out std_logic_vector(C_ADDR_SIZE - 1 downto 0)	-- Latched input address bus.
		);
	end component address_latch;
	
	constant C_ADDR_SIZE : integer := 24;
	
	signal addr_in 		: std_logic_vector(C_ADDR_SIZE - 1 downto 0) := (others => 'Z');
	signal addr_latched : std_logic_vector(C_ADDR_SIZE - 1 downto 0);
	signal latch_enable	: std_logic := '0';

begin

	I1 : address_latch
	generic map(
		C_ADDR_SIZE => C_ADDR_SIZE
	)
	port map(
		addr_in 		=> addr_in,
		latch_enable 	=> latch_enable,
		addr_latched	=> addr_latched
	);
	
	stimulus : process
	begin
		
		addr_in <= x"0F0001";
		wait for 2ns;
		latch_enable <= '1';
		wait for 1ns;
		latch_enable <= '0';
		wait for 1ns;
		addr_in <= x"0F0FFF";
		wait for 5ns;
		
		latch_enable <= '1';
		wait for 1ns;
		latch_enable <= '0';
		wait for 1ns;
		addr_in <= x"000001";
		wait for 5ns;
		
		wait;
	end process;

end Behavioral;
