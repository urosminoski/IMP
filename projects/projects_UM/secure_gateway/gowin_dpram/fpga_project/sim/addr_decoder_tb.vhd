----------------------------------------------------------------------------------
-- Company: IMP Automation & Control Systems
-- Engineer: Uros Minoski, uros.minoski@automatika.imp.bg.ac.rs
-- 
-- Create Date: 05/08/2024 12:29:29 PM
-- Design Name: 
-- Module Name: addr_decoder_tb - Behavioral
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

entity addr_decoder_tb is
end entity addr_decoder_tb;

architecture bench of addr_decoder_tb is

	component addr_decoder
		port(
			addr_isa	: in std_logic_vector(C_ISA_ADDR_SIZE - 1 downto 0);
			addr_ram	: out std_logic_vector(C_RAM_ADDR_SIZE - 1 downto 0);
			rst			: in std_logic;
			iord_n		: in std_logic;
			iowr_n		: in std_logic;
			memrd_n		: in std_logic;
			memwr_n		: in std_logic;
			intA		: out std_logic;
			intB		: out std_logic;	
			memce		: out std_logic;
			ioce		: out std_logic
		);
	end component;

	signal addr_isa	: std_logic_vector(C_ISA_ADDR_SIZE - 1 downto 0) := (others => 'Z');
	signal addr_ram	: std_logic_vector(C_RAM_ADDR_SIZE - 1 downto 0);
	signal rst		: std_logic	:= '1';
	signal iord_n	: std_logic	:= '1';
	signal iowr_n	: std_logic	:= '1';
	signal memrd_n	: std_logic	:= '1';
	signal memwr_n	: std_logic	:= '1';
	signal intA		: std_logic;
	signal intB		: std_logic;
	signal memce	: std_logic;
	signal ioce		: std_logic ;

begin

	-- Insert values for generic parameters !!
	uut: addr_decoder 
	port map( 
		addr_isa        => addr_isa,
		addr_ram        => addr_ram,
		rst             => rst,
		iord_n          => iord_n,
		iowr_n          => iowr_n,
		memrd_n         => memrd_n,
		memwr_n         => memwr_n,
		intA            => intA,
		intB            => intB,
		memce           => memce,
		ioce            => ioce 
	);

	stimulus: process
	begin
	
		rst <= '1';
		wait for 1 ns;
		rst <= '0';
		wait for 1 ns;
		
		-- Memory
		addr_isa 	<= std_logic_vector(to_unsigned(to_integer(C_RAM_END + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		memrd_n 	<= '0';
		wait for 1 ns;
		memrd_n 	<= '1';
		wait for 1 ns;
		
		addr_isa 	<= std_logic_vector(to_unsigned(to_integer(unsigned'(x"10A104")), C_ISA_ADDR_SIZE));
		memrd_n 	<= '0';
		wait for 1 ns;
		memrd_n 	<= '1';
		wait for 1 ns;
		
		addr_isa 	<= std_logic_vector(to_unsigned(to_integer(unsigned'(x"0A0FFD")), C_ISA_ADDR_SIZE));
		memwr_n 	<= '0';
		wait for 1 ns;
		memwr_n 	<= '1';
		wait for 1 ns;
		
		addr_isa 	<= std_logic_vector(to_unsigned(to_integer(unsigned'(x"11AF0D")), C_ISA_ADDR_SIZE));
		memwr_n 	<= '0';
		wait for 1 ns;
		memwr_n 	<= '1';
		wait for 1 ns;
		
		-- I/O 
		addr_isa 	<= std_logic_vector(to_unsigned(to_integer(unsigned'(x"0A0004")), C_ISA_ADDR_SIZE));
		iord_n 	<= '0';
		wait for 1 ns;
		iord_n 	<= '1';
		wait for 1 ns;
		
		addr_isa 	<= std_logic_vector(to_unsigned(to_integer(unsigned'(x"10A1A4")), C_ISA_ADDR_SIZE));
		iord_n 	<= '0';
		wait for 1 ns;
		iord_n 	<= '1';
		wait for 1 ns;
		
		addr_isa 	<= std_logic_vector(to_unsigned(to_integer(unsigned'(x"0A0007")), C_ISA_ADDR_SIZE));
		iowr_n 	<= '0';
		wait for 1 ns;
		iowr_n 	<= '1';
		wait for 1 ns;
		
		addr_isa 	<= std_logic_vector(to_unsigned(to_integer(unsigned'(x"11AF07")), C_ISA_ADDR_SIZE));
		iowr_n 	<= '0';
		wait for 1 ns;
		iowr_n 	<= '1';
		wait for 1 ns;
		
		-- Interrupt
		addr_isa 	<= std_logic_vector(to_unsigned(to_integer(C_INT_B + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		memwr_n 	<= '0';
		wait for 1 ns;
		memwr_n 	<= '1';
		wait for 1 ns;
		
		addr_isa 	<= std_logic_vector(to_unsigned(to_integer(C_INT_A + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		memwr_n 	<= '0';
		wait for 1 ns;
		memwr_n 	<= '1';
		wait for 1 ns;
		
		addr_isa 	<= std_logic_vector(to_unsigned(to_integer(C_INT_B + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		memrd_n 	<= '0';
		wait for 1 ns;
		memrd_n 	<= '1';
		wait for 1 ns;
		
		addr_isa 	<= std_logic_vector(to_unsigned(to_integer(C_INT_A + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		memrd_n 	<= '0';
		wait for 1 ns;
		memrd_n 	<= '1';
		wait for 1 ns;
	
		wait;
	end process;


end;