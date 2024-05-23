----------------------------------------------------------------------------------
-- Company: IMP Automation & Control Systems
-- Engineer: Uros Minoski, uros.minoski@automatika.imp.bg.ac.rs 
-- 
-- Create Date: 04/24/2024 11:00:17 AM
-- Design Name: 
-- Module Name: data_transfer_tb - Behavioral
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity data_transfer_tb is
end data_transfer_tb;

architecture bench of data_transfer_tb is

	component data_transfer
		generic(
			C_DATA_SIZE 	: integer := 16
		);
		port(
			data_isa	: inout std_logic_vector(C_DATA_SIZE - 1 downto 0); 		-- Data bus.
			data_ram	: inout std_logic_vector(C_DATA_SIZE - 1 downto 0); 		-- Data bus.
			rw			: in std_logic;
			rst			: in std_logic;
			addr_busy	: in std_logic;
			busy 		: in std_logic
		);
	end component;

	constant C_DATA_SIZE	: integer := 16;
	
	signal data_isa		: std_logic_vector(C_DATA_SIZE - 1 downto 0) := (others => 'Z');
	signal data_ram		: std_logic_vector(C_DATA_SIZE - 1 downto 0) := (others => 'Z');
	signal rw			: std_logic	:= '1';
	signal rst			: std_logic	:= '1';
	signal addr_busy	: std_logic	:= '0';
	signal busy			: std_logic	:= '1';

begin

	-- Insert values for generic parameters !!
	uut: data_transfer 
	generic map(
		C_DATA_SIZE => C_DATA_SIZE
	)
	port map( 
		data_isa    => data_isa,
		data_ram    => data_ram,
		rw          => rw,
		rst         => rst,
		addr_busy   => addr_busy,
		busy        => busy 
	);

	stimulus: process
	begin
		
		rst <= '1';
		wait for 1ns;
		rst <= '0';
		wait for 1ns;
		
		rw <= '0';
		wait for 1ns;
		data_isa <= x"0001";
		wait for 2ns;
		
		rw <= '1';
		wait for 1ns;
		data_ram <= x"0002";

		wait;
	end process;


end bench;
