----------------------------------------------------------------------------------
-- Company: IMP Automation & Control Systems
-- Engineer: Uros Minoski, uros.minoski@automatika.imp.bg.ac.rs
-- 
-- Create Date: 04/24/2024 11:18:43 AM
-- Design Name: 
-- Module Name: dpram_interface_single_tb - Behavioral
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

entity dpram_interface_single_tb is
end dpram_interface_single_tb;

architecture bench of dpram_interface_single_tb is

	component dpram_interface_single
		generic(
			C_ISA_ADDR_SIZE   	: integer := 24;
			C_RAM_ADDR_SIZE     : integer := 16;
			C_BASE_ADDR     	: unsigned(23 downto 0) := x"000000";
			C_MAILBOX_START		: unsigned(15 downto 0)	:= x"0000";
			C_MAILBOX_END 		: unsigned(15 downto 0)	:= x"FFFF";
			C_SEM_START			: unsigned(15 downto 0)	:= x"0000";
			C_SEM_END 			: unsigned(15 downto 0)	:= x"0007"
		);
		port(
			ADDR_ISA    : in std_logic_vector(C_ISA_ADDR_SIZE - 1 downto 0);
			ADDR_RAM    : out std_logic_vector(C_RAM_ADDR_SIZE - 1 downto 0);
			IORD_n      : in std_logic;
			IOWR_n      : in std_logic;
			MEMRD_n     : in std_logic;
			MEMWR_n     : in std_logic;
			SBHE_n      : in std_logic;
			ALE         : in std_logic;
			RESET       : in std_logic;
			IOCS16_n    : out std_logic;
			MEMCS16_n   : out std_logic;
			RW          : out std_logic;
			UB_n        : out std_logic;
			LB_n        : out std_logic;
			SEM_n       : out std_logic;
			CE0_n       : out std_logic;
			CE1         : out std_logic;
			OE_n		: out std_logic;
			BUSY_n      : in std_logic;
			INT_RAM     : in std_logic;
			INT_ISA     : out std_logic;
			INT_BUSY	: out std_logic
		);
	end component;
	
	constant C_ISA_ADDR_SIZE 	: integer := 24;
	constant C_RAM_ADDR_SIZE   	: integer := 16;
	constant C_DATA_SIZE		: integer := 16;
	constant C_BASE_ADDR    	: unsigned(23 downto 0) := x"0F0000";
	constant C_MAILBOX_START	: unsigned(15 downto 0)	:= x"0000";
	constant C_MAILBOX_END 		: unsigned(15 downto 0)	:= x"FFFF";
	constant C_SEM_START		: unsigned(15 downto 0)	:= x"0000";
	constant C_SEM_END 			: unsigned(15 downto 0)	:= x"0007";

	signal ADDR_ISA		: std_logic_vector(C_ISA_ADDR_SIZE - 1 downto 0) := (others => 'Z');
	signal ADDR_RAM		: std_logic_vector(C_RAM_ADDR_SIZE - 1 downto 0);
	signal IORD_n		: std_logic := '1';
	signal IOWR_n		: std_logic := '1';
	signal MEMRD_n		: std_logic := '1';
	signal MEMWR_n		: std_logic := '1';
	signal SBHE_n		: std_logic := '0';
	signal ALE			: std_logic := '0';
	signal RESET		: std_logic := '1';
	signal IOCS16_n		: std_logic;
	signal MEMCS16_n	: std_logic;
	signal RW			: std_logic;
	signal UB_n			: std_logic;
	signal LB_n			: std_logic;
	signal SEM_n		: std_logic;
	signal CE0_n		: std_logic;
	signal CE1			: std_logic;
	signal OE_n			: std_logic;
	signal BUSY_n		: std_logic := '1';
	signal INT_RAM		: std_logic := '1';
	signal INT_ISA		: std_logic;
	signal INT_BUSY		: std_logic;

begin

	-- Insert values for generic parameters !!
	uut: dpram_interface_single 
	generic map( 
		C_ISA_ADDR_SIZE => C_ISA_ADDR_SIZE,
		C_RAM_ADDR_SIZE => C_RAM_ADDR_SIZE,
		C_BASE_ADDR     => C_BASE_ADDR,
		C_MAILBOX_START => C_MAILBOX_START,
		C_MAILBOX_END   => C_MAILBOX_END,
		C_SEM_START     => C_SEM_START,
		C_SEM_END       => C_SEM_END
	)
	port map( 
		ADDR_ISA        => ADDR_ISA,
		ADDR_RAM        => ADDR_RAM,
		IORD_n          => IORD_n,
		IOWR_n          => IOWR_n,
		MEMRD_n         => MEMRD_n,
		MEMWR_n         => MEMWR_n,
		SBHE_n          => SBHE_n,
		ALE             => ALE,
		RESET           => RESET,
		IOCS16_n        => IOCS16_n,
		MEMCS16_n       => MEMCS16_n,
		RW              => RW,
		UB_n            => UB_n,
		LB_n            => LB_n,
		SEM_n           => SEM_n,
		CE0_n           => CE0_n,
		CE1             => CE1,
		OE_n            => OE_n,
		BUSY_n          => BUSY_n,
		INT_RAM         => INT_RAM,
		INT_ISA         => INT_ISA,
		INT_BUSY		=> INT_BUSY
	);

	stimulus: process
	begin
		
		RESET <= '1';
		wait for 2ns;
		RESET <= '0';
		
		-- Memory Read.
		ADDR_ISA <= x"0F001A";
		wait for 0.2ns;
		ALE	<= '1';
		wait for 1ns;
		ALE <= '0';
		wait for 0.2ns;
		MEMRD_n <= '0';
		wait for 2ns;

		-- Memory Write
		MEMRD_n 	<= '1';
		ADDR_ISA 	<= x"0F1234";
		wait for 0.2ns;
		ALE <= '1';
		wait for 1ns;
		ALE <= '0';
		wait for 0.2ns;
		MEMWR_n <= '0';
		wait for 2ns;
		
		-- False Memory Read.
		SBHE_n <= '1';
		MEMWR_n		<= '1';
		ADDR_ISA 	<= x"AA021A";
		wait for 0.2ns;
		ALE	<= '1';
		wait for 1ns;
		ALE <= '0';
		wait for 0.2ns;
		MEMRD_n 	<= '0';
		wait for 2ns;

		-- False Memory Write
		SBHE_n 		<= '0';
		MEMRD_n 	<= '1';
		ADDR_ISA 	<= x"0000FC";
		wait for 0.2ns;
		ALE <= '1';
		wait for 1ns;
		ALE <= '0';
		wait for 0.2ns;
		MEMWR_n <= '0';
		wait for 2ns;
		
		-- I/O Read Semaphore
		MEMWR_n <= '1';
		ADDR_ISA 	<= x"0F0000";
		wait for 0.2ns;
		ALE <= '1';
		wait for 1 ns;
		ALE <= '0';
		wait for 0.2ns;
		IORD_n <= '0';
		wait for 2ns;
		
		-- I/O Write Semaphore
		SBHE_n <= '1';
		IORD_n <= '1';
		ADDR_ISA 	<= x"0F0007";
		wait for 0.2ns;
		ALE <= '1';
		wait for 1 ns;
		ALE <= '0';
		wait for 0.2ns;
		IOWR_n <= '0';
		wait for 2ns;
		
		-- False I/O Read Semaphore
		IOWR_n <= '1';
		SBHE_n <= '0';
		ADDR_ISA 	<= x"0F0009";
		wait for 0.2ns;
		ALE <= '1';
		wait for 1 ns;
		ALE <= '0';
		wait for 0.2ns;
		IORD_n <= '0';
		wait for 2ns;
		
		-- False I/O Write Semaphore
		IORD_n <= '1';
		ADDR_ISA 	<= x"AF0007";
		wait for 0.2ns;
		ALE <= '1';
		wait for 1 ns;
		ALE <= '0';
		wait for 0.2ns;
		IOWR_n <= '0';
		wait for 2ns;
		
		-- I/O Read Busy = '0'
		IOWR_n <= '1';
		ADDR_ISA 	<= x"0F0008";
		BUSY_n 		<= '0';
		wait for 0.2ns;
		ALE <= '1';
		wait for 1 ns;
		ALE <= '0';
		wait for 0.2ns;
		IORD_n <= '0';
		wait for 2ns;
		
		-- False I/O Write Busy
		IORD_n <= '1';
		ADDR_ISA 	<= x"0F0008";
		wait for 0.2ns;
		ALE <= '1';
		wait for 1 ns;
		ALE <= '0';
		wait for 0.2ns;
		IOWR_n <= '0';
		wait for 2ns;
		
		-- I/O Read Busy = '1'
		IOWR_n <= '1';
		ADDR_ISA 	<= x"0F0008";
		BUSY_n 		<= '1';
		wait for 0.2ns;
		ALE <= '1';
		wait for 1 ns;
		ALE <= '0';
		wait for 0.2ns;
		IORD_n <= '0';
		wait for 2ns;
		
		IORD_n <= '1';
		wait for 1ns;
		
		INT_RAM <= '0';
  
		wait;
	end process;


end bench;
