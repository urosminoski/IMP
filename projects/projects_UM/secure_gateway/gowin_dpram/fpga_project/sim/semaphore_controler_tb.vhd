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
use work.secure_gateway_pkg.all;

entity semaphore_controler_tb is
end semaphore_controler_tb;

architecture bench of semaphore_controler_tb is

	component semaphore_controler
		generic(
			C_RAM_ADDR_SIZE		: natural := 12;
			C_NUM_SEM			: natural := 4
		);
		port(
			addrA 	: in std_logic_vector(C_RAM_ADDR_SIZE - 1 downto 0);
			ioceA	: in std_logic;
			iowrA_n	: in std_logic;
			dinA	: in std_logic;
			doutA	: out std_logic;
			addrB 	: in std_logic_vector(C_RAM_ADDR_SIZE - 1 downto 0);
			ioceB	: in std_logic;
			iowrB_n	: in std_logic;
			dinB	: in std_logic;
			doutB	: out std_logic
		);
	end component;
	
	signal addrA	: std_logic_vector(C_RAM_ADDR_SIZE - 1 downto 0) := (others => '0');
	signal ioceA	: std_logic := '0';
	signal iowrA_n	: std_logic := '1';
	signal dinA		: std_logic := '0';
	signal doutA	: std_logic;
	signal addrB	: std_logic_vector(C_RAM_ADDR_SIZE - 1 downto 0) := (others => '0');
	signal ioceB	: std_logic := '0';
	signal iowrB_n	: std_logic := '1';
	signal dinB		: std_logic := '0';
	signal doutB	: std_logic;

begin

	uut: semaphore_controler 
	generic map( 
		C_RAM_ADDR_SIZE => C_RAM_ADDR_SIZE,
		C_NUM_SEM       => C_NUM_SEM
	)
	port map(
		addrA           => addrA,
		ioceA           => ioceA,
		iowrA_n         => iowrA_n,
		dinA            => dinA,
		doutA           => doutA,
		addrB           => addrB,
		ioceB           => ioceB,
		iowrB_n         => iowrB_n,
		dinB            => dinB,
		doutB           => doutB 
	);

	stimulus: process
	begin
		wait for 1 ns;
		
		addrA 	<= std_logic_vector(to_unsigned(0, C_RAM_ADDR_SIZE));
		dinA	<= '1';
		addrB 	<= std_logic_vector(to_unsigned(0, C_RAM_ADDR_SIZE));
		dinB	<= '1';
		
		ioceA 	<= '1';
		ioceB 	<= '1';
		iowrA_n	<= '0';
		iowrB_n <= '0';
		wait for 1 ns;
		ioceA 	<= '0';
		ioceB 	<= '0';
		iowrA_n	<= '1';
		iowrB_n <= '1';
		wait for 1 ns;
		
		addrA 	<= std_logic_vector(to_unsigned(0, C_RAM_ADDR_SIZE));
		dinA	<= '0';
		ioceA 	<= '1';
		iowrA_n	<= '0';
		wait for 1 ns;
		ioceA 	<= '0';
		iowrA_n	<= '1';
		wait for 1 ns;
		
		addrB 	<= std_logic_vector(to_unsigned(0, C_RAM_ADDR_SIZE));
		dinB	<= '0';
		ioceB 	<= '1';
		iowrB_n	<= '0';
		wait for 1 ns;
		ioceB 	<= '0';
		iowrB_n <= '1';
		wait for 1 ns;
		
		addrA 	<= std_logic_vector(to_unsigned(0, C_RAM_ADDR_SIZE));
		dinA	<= '1';
		ioceA 	<= '1';
		iowrA_n	<= '0';
		wait for 1 ns;
		ioceA 	<= '0';
		iowrA_n	<= '1';
		wait for 1 ns;
		
		addrB 	<= std_logic_vector(to_unsigned(0, C_RAM_ADDR_SIZE));
		dinB	<= '1';
		ioceB 	<= '1';
		iowrB_n	<= '0';
		wait for 1 ns;
		ioceB 	<= '0';
		iowrB_n <= '1';
		wait for 1 ns;
		
		-----
		
		addrA 	<= std_logic_vector(to_unsigned(1, C_RAM_ADDR_SIZE));
		dinA	<= '1';
		addrB 	<= std_logic_vector(to_unsigned(1, C_RAM_ADDR_SIZE));
		dinB	<= '1';
		
		ioceA 	<= '1';
		ioceB 	<= '1';
		iowrA_n	<= '0';
		iowrB_n <= '0';
		wait for 1 ns;
		ioceA 	<= '0';
		ioceB 	<= '0';
		iowrA_n	<= '1';
		iowrB_n <= '1';
		wait for 1 ns;
		
		addrA 	<= std_logic_vector(to_unsigned(1, C_RAM_ADDR_SIZE));
		dinA	<= '0';
		ioceA 	<= '1';
		iowrA_n	<= '0';
		wait for 1 ns;
		ioceA 	<= '0';
		iowrA_n	<= '1';
		wait for 1 ns;
		
		addrB 	<= std_logic_vector(to_unsigned(1, C_RAM_ADDR_SIZE));
		dinB	<= '0';
		ioceB 	<= '1';
		iowrB_n	<= '0';
		wait for 1 ns;
		ioceB 	<= '0';
		iowrB_n <= '1';
		wait for 1 ns;
		
		addrA 	<= std_logic_vector(to_unsigned(1, C_RAM_ADDR_SIZE));
		dinA	<= '1';
		ioceA 	<= '1';
		iowrA_n	<= '0';
		wait for 1 ns;
		ioceA 	<= '0';
		iowrA_n	<= '1';
		wait for 1 ns;
		
		addrB 	<= std_logic_vector(to_unsigned(1, C_RAM_ADDR_SIZE));
		dinB	<= '1';
		ioceB 	<= '1';
		iowrB_n	<= '0';
		wait for 1 ns;
		ioceB 	<= '0';
		iowrB_n <= '1';
		wait for 1 ns;
		
		wait;
	end process;

end architecture bench;
