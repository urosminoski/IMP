----------------------------------------------------------------------------------
-- Company: IMP Automation & Control Systems
-- Engineer: Uros Minoski, uros.minoski@automatika.imp.bg.ac.rs
-- 
-- Create Date: 04/23/2024 02:46:33 PM
-- Design Name: 
-- Module Name: address_decoder_tb - Behavioral
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

entity address_decoder_tb is
--  Port ( );
end address_decoder_tb;

architecture bench of address_decoder_tb is

	component address_decoder
		generic(
			C_IN_ADDR_SIZE   	: integer := 24;                        -- Address size of input address bus.
        C_OUT_ADDR_SIZE  	: integer := 16;                        -- Address size of output address bus.
		
        C_BASE_ADDR     	: unsigned(23 downto 0) := x"000000"; 	-- Base address.
		C_PAGE1_START		: unsigned(15 downto 0)	:= x"0000";		-- Start address of page 1.
		C_PAGE1_END 		: unsigned(15 downto 0)	:= x"FFFF";		-- End address of page 1.
		C_PAGE2_START		: unsigned(15 downto 0)	:= x"0000";		-- Start address of page 2.
		C_PAGE2_END 		: unsigned(15 downto 0)	:= x"0007"		-- End address of page 2.
		);
		port(
			addr_in    	: in std_logic_vector(C_IN_ADDR_SIZE - 1 downto 0);
			addr_out    : out std_logic_vector(C_OUT_ADDR_SIZE - 1 downto 0);
			rst 		: in std_logic;
			iord_n      : in std_logic;
			iowr_n      : in std_logic;
			memrd_n     : in std_logic;
			memwr_n     : in std_logic;
			addr_page1	: out std_logic;
			addr_page2	: out std_logic
		);
	end component;
  
	constant C_IN_ADDR_SIZE 	: integer := 24;
	constant C_OUT_ADDR_SIZE 	: integer := 16;
  
	constant C_BASE_ADDR 		: unsigned(C_IN_ADDR_SIZE - 1 downto 0) := x"0F0000";
	constant C_PAGE1_START 		: unsigned(C_OUT_ADDR_SIZE - 1 downto 0) := x"0000";
	constant C_PAGE1_END 		: unsigned(C_OUT_ADDR_SIZE - 1 downto 0) := x"FFFF";
	constant C_PAGE2_START 		: unsigned(C_OUT_ADDR_SIZE - 1 downto 0) := x"0000";
	constant C_PAGE2_END 		: unsigned(C_OUT_ADDR_SIZE - 1 downto 0) := x"0007";

	signal addr_in		: std_logic_vector(C_IN_ADDR_SIZE - 1 downto 0) := (others => 'Z');
	signal addr_out		: std_logic_vector(C_OUT_ADDR_SIZE - 1 downto 0);
	
	signal rst			: std_logic := '1';
	signal iord_n		: std_logic := '1';
	signal iowr_n		: std_logic := '1';
	signal memrd_n		: std_logic := '1';
	signal memwr_n		: std_logic := '1';
	
	signal addr_page1	: std_logic;
	signal addr_page2	: std_logic;

begin

	-- Insert values for generic parameters !!
	uut: address_decoder 
	generic map(
		C_IN_ADDR_SIZE  => C_IN_ADDR_SIZE,
		C_OUT_ADDR_SIZE => C_OUT_ADDR_SIZE,
		C_BASE_ADDR     => C_BASE_ADDR,
		C_PAGE1_START   => C_PAGE1_START,
		C_PAGE1_END     => C_PAGE1_END,
		C_PAGE2_START   => C_PAGE2_START,
		C_PAGE2_END     => C_PAGE2_END
	)
	port map( 
		addr_in         => addr_in,
		addr_out        => addr_out,
		rst             => rst,
		iord_n          => iord_n,
		iowr_n          => iowr_n,
		memrd_n         => memrd_n,
		memwr_n         => memwr_n,
		addr_page1      => addr_page1,
		addr_page2      => addr_page2
	);

	stimulus: process
	begin
		
		rst <= '1';
		wait for 1ns;
		rst <= '0';
		wait for 1ns;
		
		-- Memory Read
		addr_in <= x"0F0005";
		memrd_n <= '0';
		wait for 1ns;
		memrd_n <= '1';
		wait for 1ns;
		
		-- Memory Write
		addr_in <= x"0FDCE5";
		memwr_n <= '0';
		wait for 1ns;
		memwr_n <= '1';
		wait for 1ns;
		
		-- False Memory Read
		addr_in <= x"000AA5";
		memrd_n <= '0';
		wait for 1ns;
		memrd_n <= '1';
		wait for 1ns;
		
		-- False Memory Write
		addr_in <= x"1F0405";
		memwr_n <= '0';
		wait for 1ns;
		memwr_n <= '1';
		wait for 1ns;
		
		-- I/O Read Semaphore
		addr_in <= x"0F0005";
		iord_n <= '0';
		wait for 1ns;
		iord_n <= '1';
		wait for 1ns;
		
		-- I/O Read Busy
		addr_in <= x"0F0008";
		iord_n <= '0';
		wait for 1ns;
		iord_n <= '1';
		wait for 1ns;
		
		-- I/O Write to the Semaphore
		addr_in <= x"0F0007";
		iowr_n <= '0';
		wait for 1ns;
		iowr_n <= '1';
		wait for 1ns;
		
		-- False I/O Read
		addr_in <= x"0F0009";
		iord_n <= '0';
		wait for 1ns;
		iord_n <= '1';
		wait for 1ns;
		
		-- False I/O Write
		addr_in <= x"0F0008";
		iowr_n <= '0';
		wait for 1ns;
		iowr_n <= '1';
		wait for 1ns;
		
		-- False I/O write to busy
		addr_in <= x"1F0405";
		iowr_n <= '0';
		wait for 1ns;
		iowr_n <= '1';
		wait for 1ns;
		
		wait;
	end process;

end bench;
