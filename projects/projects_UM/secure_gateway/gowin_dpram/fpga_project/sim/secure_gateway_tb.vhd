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

entity secure_gateway_tb is
end entity secure_gateway_tb;

architecture bench of secure_gateway_tb is

	component secure_gateway
		port(
			clk : in std_logic;
			addrA_isa	: in std_logic_vector(C_ISA_ADDR_SIZE - 1 downto 0);
			dataA_isa	: inout std_logic_vector(C_DATA_SIZE - 1 downto 0);
			aleA		: in std_logic;
			iordA_n		: in std_logic;
			iowrA_n		: in std_logic;
			memrdA_n	: in std_logic;
			memwrA_n	: in std_logic;
			rstA 		: in std_logic;
			iocs16A_n	: out std_logic;
			memcs16A_n	: out std_logic;
			intA		: out std_logic;
			addrB_isa	: in std_logic_vector(C_ISA_ADDR_SIZE - 1 downto 0);
			dataB_isa	: inout std_logic_vector(C_DATA_SIZE - 1 downto 0);
			aleB		: in std_logic;
			iordB_n		: in std_logic;
			iowrB_n		: in std_logic;
			memrdB_n	: in std_logic;
			memwrB_n	: in std_logic;
			rstB 		: in std_logic;
			iocs16B_n	: out std_logic;
			memcs16B_n	: out std_logic;
			intB		: out std_logic
		);
	end component;
	
	constant C_CLK_PERIOD			: time := 1 ns;
	
	signal clk			: std_logic := '1';
	signal addrA_isa	: std_logic_vector(C_ISA_ADDR_SIZE - 1 downto 0) := (others => 'Z');
	signal dataA_isa	: std_logic_vector(C_DATA_SIZE - 1 downto 0) := (others => 'Z');
	signal aleA			: std_logic := '0';
	signal iordA_n		: std_logic := '1';
	signal iowrA_n		: std_logic := '1';
	signal memrdA_n		: std_logic := '1';
	signal memwrA_n		: std_logic := '1';
	signal rstA			: std_logic := '1';
	signal iocs16A_n	: std_logic;
	signal memcs16A_n	: std_logic;
	signal intA			: std_logic;
	signal addrB_isa	: std_logic_vector(C_ISA_ADDR_SIZE - 1 downto 0) := (others => 'Z');
	signal dataB_isa	: std_logic_vector(C_DATA_SIZE - 1 downto 0) := (others => 'Z');
	signal aleB			: std_logic := '0';
	signal iordB_n		: std_logic := '1';
	signal iowrB_n		: std_logic := '1';
	signal memrdB_n		: std_logic := '1';
	signal memwrB_n		: std_logic := '1';
	signal rstB			: std_logic := '1';
	signal iocs16B_n	: std_logic;
	signal memcs16B_n	: std_logic;
	signal intB			: std_logic ;

begin

	-- Insert values for generic parameters !!
	uut: secure_gateway 
	port map(
		clk             => clk,
		addrA_isa       => addrA_isa,
		dataA_isa       => dataA_isa,
		aleA            => aleA,
		iordA_n         => iordA_n,
		iowrA_n         => iowrA_n,
		memrdA_n        => memrdA_n,
		memwrA_n        => memwrA_n,
		rstA            => rstA,
		iocs16A_n       => iocs16A_n,
		memcs16A_n      => memcs16A_n,
		intA            => intA,
		addrB_isa       => addrB_isa,
		dataB_isa       => dataB_isa,
		aleB            => aleB,
		iordB_n         => iordB_n,
		iowrB_n         => iowrB_n,
		memrdB_n        => memrdB_n,
		memwrB_n        => memwrB_n,
		rstB            => rstB,
		iocs16B_n       => iocs16B_n,
		memcs16B_n      => memcs16B_n,
		intB            => intB 
	);
	
	clk <= not clk after C_CLK_PERIOD / 2;
	
	stimulus: process
	begin
		
		wait for 2.5 ns;
		rstA <= '0';
		rstB <= '0';
		wait for 1.2 ns;
		
		-- Write to RAM
		addrA_isa 	<= std_logic_vector(to_unsigned(to_integer(C_RAM_START + x"0" + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		addrB_isa 	<= std_logic_vector(to_unsigned(to_integer(C_RAM_START + x"1" + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		dataA_isa	<= x"00F0";
		dataB_isa	<= x"00F1";
		aleA 		<= '1';
		aleB		<= '1';
		wait for 0.3 ns;
		aleA		<= '0';
		aleB		<= '0';
		wait for 1.6 ns;
		memwrA_n	<= '0';
		memwrB_n	<= '0';
		wait for 2 ns;
		memwrA_n	<= '1';
		memwrB_n	<= '1';
		wait for 0.7 ns;
		
		-- Write to RAM
		addrA_isa 	<= std_logic_vector(to_unsigned(to_integer(C_RAM_END + x"0" + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		addrB_isa 	<= std_logic_vector(to_unsigned(to_integer(C_RAM_END - x"1" + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		dataA_isa	<= x"FFF0";
		dataB_isa	<= x"FFF1";
		aleA 		<= '1';
		aleB		<= '1';
		wait for 0.3 ns;
		aleA		<= '0';
		aleB		<= '0';
		wait for 1.6 ns;
		memwrA_n	<= '0';
		memwrB_n	<= '0';
		wait for 2 ns;
		memwrA_n	<= '1';
		memwrB_n	<= '1';
		wait for 0.7 ns;
		
		-- Read from RAM
		addrA_isa 	<= std_logic_vector(to_unsigned(to_integer(C_RAM_START + x"0" + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		addrB_isa 	<= std_logic_vector(to_unsigned(to_integer(C_RAM_START + x"1" + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		dataA_isa	<= (others => 'Z');
		dataB_isa	<= (others => 'Z');
		aleA 		<= '1';
		aleB		<= '1';
		wait for 0.3 ns;
		aleA		<= '0';
		aleB		<= '0';
		wait for 1.6 ns;
		memrdA_n	<= '0';
		memrdB_n	<= '0';
		wait for 2 ns;
		memrdA_n	<= '1';
		memrdB_n	<= '1';
		wait for 0.7 ns;
		
		-- Read from RAM
		addrA_isa 	<= std_logic_vector(to_unsigned(to_integer(C_RAM_END + x"0" + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		addrB_isa 	<= std_logic_vector(to_unsigned(to_integer(C_RAM_END - x"1" + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		dataA_isa	<= (others => 'Z');
		dataB_isa	<= (others => 'Z');
		aleA 		<= '1';
		aleB		<= '1';
		wait for 0.3 ns;
		aleA		<= '0';
		aleB		<= '0';
		wait for 1.6 ns;
		memrdA_n	<= '0';
		memrdB_n	<= '0';
		wait for 2 ns;
		memrdA_n	<= '1';
		memrdB_n	<= '1';
		wait for 0.7 ns;
		
		-- Write to SEM 0
		addrA_isa 	<= std_logic_vector(to_unsigned(to_integer(C_SEM_ADDRS(0) + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		addrB_isa 	<= std_logic_vector(to_unsigned(to_integer(C_SEM_ADDRS(0) + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		dataA_isa	<= x"0001";
		dataB_isa	<= x"0001";
		aleA 		<= '1';
		aleB		<= '1';
		wait for 0.3 ns;
		aleA		<= '0';
		aleB		<= '0';
		wait for 1.6 ns;
		iowrA_n	<= '0';
		iowrB_n	<= '0';
		wait for 2 ns;
		iowrA_n	<= '1';
		iowrB_n	<= '1';
		wait for 0.7 ns;
		
		-- Read from SEM 0
		addrA_isa 	<= std_logic_vector(to_unsigned(to_integer(C_SEM_ADDRS(0) + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		addrB_isa 	<= std_logic_vector(to_unsigned(to_integer(C_SEM_ADDRS(0) + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		dataA_isa	<= (others => 'Z');
		dataB_isa	<= (others => 'Z');
		aleA 		<= '1';
		aleB		<= '1';
		wait for 0.3 ns;
		aleA		<= '0';
		aleB		<= '0';
		wait for 1.6 ns;
		iordA_n		<= '0';
		iordB_n		<= '0';
		wait for 2 ns;
		iordA_n		<= '1';
		iordB_n		<= '1';
		wait for 0.7 ns;
		
		-- Port A takes SEM 0
		addrA_isa 	<= std_logic_vector(to_unsigned(to_integer(C_SEM_ADDRS(0) + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		addrB_isa 	<= (others => 'Z');
		dataA_isa	<= x"0000";
		dataB_isa	<= (others => 'Z');
		aleA 		<= '1';
		aleB		<= '0';
		wait for 0.3 ns;
		aleA		<= '0';
		aleB		<= '0';
		wait for 1.6 ns;
		iowrA_n	<= '0';
		iowrB_n	<= '1';
		wait for 2 ns;
		iowrA_n	<= '1';
		iowrB_n	<= '1';
		wait for 0.7 ns;
		
		-- Port A reads SEM 0
		addrA_isa 	<= std_logic_vector(to_unsigned(to_integer(C_SEM_ADDRS(0) + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		addrB_isa 	<= (others => 'Z');
		dataA_isa	<= (others => 'Z');
		dataB_isa	<= (others => 'Z');
		aleA 		<= '1';
		aleB		<= '0';
		wait for 0.3 ns;
		aleA		<= '0';
		aleB		<= '0';
		wait for 1.6 ns;
		iordA_n	<= '0';
		iowrB_n	<= '1';
		wait for 2 ns;
		iordA_n	<= '1';
		iowrB_n	<= '1';
		wait for 0.7 ns;
		
		-- Port B tries to take SEM 0
		addrA_isa 	<= (others => 'Z');
		addrB_isa 	<= std_logic_vector(to_unsigned(to_integer(C_SEM_ADDRS(0) + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		dataA_isa	<= (others => 'Z');
		dataB_isa	<= x"0000";
		aleA 		<= '0';
		aleB		<= '1';
		wait for 0.3 ns;
		aleA		<= '0';
		aleB		<= '0';
		wait for 1.6 ns;
		iowrA_n	<= '1';
		iowrB_n	<= '0';
		wait for 2 ns;
		iowrA_n	<= '1';
		iowrB_n	<= '1';
		wait for 0.7 ns;
		
		-- Port B reads SEM 0
		addrA_isa 	<= (others => 'Z');
		addrB_isa 	<= std_logic_vector(to_unsigned(to_integer(C_SEM_ADDRS(0) + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		dataA_isa	<= (others => 'Z');
		dataB_isa	<= (others => 'Z');
		aleA 		<= '0';
		aleB		<= '1';
		wait for 0.3 ns;
		aleA		<= '0';
		aleB		<= '0';
		wait for 1.6 ns;
		iowrA_n	<= '1';
		iordB_n	<= '0';
		wait for 2 ns;
		iowrA_n	<= '1';
		iordB_n	<= '1';
		wait for 0.7 ns;
		
		-- Port A realises SEM 0
		addrA_isa 	<= std_logic_vector(to_unsigned(to_integer(C_SEM_ADDRS(0) + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		addrB_isa 	<= (others => 'Z');
		dataA_isa	<= x"0001";
		dataB_isa	<= (others => 'Z');
		aleA 		<= '1';
		aleB		<= '0';
		wait for 0.3 ns;
		aleA		<= '0';
		aleB		<= '0';
		wait for 1.6 ns;
		iowrA_n	<= '0';
		iowrB_n	<= '1';
		wait for 2 ns;
		iowrA_n	<= '1';
		iowrB_n	<= '1';
		wait for 0.7 ns;
		
		-- Port B reads SEM 0
		addrA_isa 	<= (others => 'Z');
		addrB_isa 	<= std_logic_vector(to_unsigned(to_integer(C_SEM_ADDRS(0) + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		dataA_isa	<= (others => 'Z');
		dataB_isa	<= (others => 'Z');
		aleA 		<= '0';
		aleB		<= '1';
		wait for 0.3 ns;
		aleA		<= '0';
		aleB		<= '0';
		wait for 1.6 ns;
		iowrA_n	<= '1';
		iordB_n	<= '0';
		wait for 2 ns;
		iowrA_n	<= '1';
		iordB_n	<= '1';
		wait for 0.7 ns;
		
		-- Port A activetes INT on B side
		addrA_isa 	<= std_logic_vector(to_unsigned(to_integer(C_INT_B + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		addrB_isa 	<= (others => 'Z');
		dataA_isa	<= x"000A";
		dataB_isa	<= (others => 'Z');
		aleA 		<= '1';
		aleB		<= '0';
		wait for 0.3 ns;
		aleA		<= '0';
		aleB		<= '0';
		wait for 1.6 ns;
		memwrA_n	<= '0';
		memwrB_n	<= '1';
		wait for 2 ns;
		memwrA_n	<= '1';
		memwrB_n	<= '1';
		wait for 0.7 ns;
		
		-- Port B clears INT on B side
		addrA_isa 	<= (others => 'Z');
		addrB_isa 	<= std_logic_vector(to_unsigned(to_integer(C_INT_B + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		dataA_isa	<= (others => 'Z');
		dataB_isa	<= (others => 'Z');
		aleA 		<= '0';
		aleB		<= '1';
		wait for 0.3 ns;
		aleA		<= '0';
		aleB		<= '0';
		wait for 1.6 ns;
		memwrA_n	<= '1';
		memrdB_n	<= '0';
		wait for 2 ns;
		memwrA_n	<= '1';
		memrdB_n	<= '1';
		wait for 0.7 ns;
		
		-- Port B activetes INT on A side
		addrA_isa 	<= (others => 'Z');
		addrB_isa 	<= std_logic_vector(to_unsigned(to_integer(C_INT_A + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		dataA_isa	<= (others => 'Z');
		dataB_isa	<= x"000B";
		aleA 		<= '0';
		aleB		<= '1';
		wait for 0.3 ns;
		aleA		<= '0';
		aleB		<= '0';
		wait for 1.6 ns;
		memwrA_n	<= '1';
		memwrB_n	<= '0';
		wait for 2 ns;
		memwrA_n	<= '1';
		memwrB_n	<= '1';
		wait for 0.7 ns;
		
		-- Port A clears INT on A side
		addrA_isa 	<= std_logic_vector(to_unsigned(to_integer(C_INT_A + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		addrB_isa 	<= (others => 'Z');
		dataA_isa	<= (others => 'Z');
		dataB_isa	<= (others => 'Z');
		aleA 		<= '1';
		aleB		<= '0';
		wait for 0.3 ns;
		aleA		<= '0';
		aleB		<= '0';
		wait for 1.6 ns;
		memrdA_n	<= '0';
		memrdB_n	<= '1';
		wait for 2 ns;
		memrdA_n	<= '1';
		memrdB_n	<= '1';
		wait for 0.7 ns;
		
		
		-----------------------------
		
		
		-- Write to SEM 1
		addrA_isa 	<= std_logic_vector(to_unsigned(to_integer(C_SEM_ADDRS(1) + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		addrB_isa 	<= std_logic_vector(to_unsigned(to_integer(C_SEM_ADDRS(1) + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		dataA_isa	<= x"0001";
		dataB_isa	<= x"0001";
		aleA 		<= '1';
		aleB		<= '1';
		wait for 0.3 ns;
		aleA		<= '0';
		aleB		<= '0';
		wait for 1.6 ns;
		iowrA_n	<= '0';
		iowrB_n	<= '0';
		wait for 2 ns;
		iowrA_n	<= '1';
		iowrB_n	<= '1';
		wait for 0.7 ns;
		
		-- Read from SEM 1
		addrA_isa 	<= std_logic_vector(to_unsigned(to_integer(C_SEM_ADDRS(1) + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		addrB_isa 	<= std_logic_vector(to_unsigned(to_integer(C_SEM_ADDRS(1) + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		dataA_isa	<= (others => 'Z');
		dataB_isa	<= (others => 'Z');
		aleA 		<= '1';
		aleB		<= '1';
		wait for 0.3 ns;
		aleA		<= '0';
		aleB		<= '0';
		wait for 1.6 ns;
		iordA_n		<= '0';
		iordB_n		<= '0';
		wait for 2 ns;
		iordA_n		<= '1';
		iordB_n		<= '1';
		wait for 0.7 ns;
		
		-- Port A takes SEM 1
		addrA_isa 	<= std_logic_vector(to_unsigned(to_integer(C_SEM_ADDRS(1) + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		addrB_isa 	<= (others => 'Z');
		dataA_isa	<= x"0000";
		dataB_isa	<= (others => 'Z');
		aleA 		<= '1';
		aleB		<= '0';
		wait for 0.3 ns;
		aleA		<= '0';
		aleB		<= '0';
		wait for 1.6 ns;
		iowrA_n	<= '0';
		iowrB_n	<= '1';
		wait for 2 ns;
		iowrA_n	<= '1';
		iowrB_n	<= '1';
		wait for 0.7 ns;
		
		-- Port A reads SEM 1
		addrA_isa 	<= std_logic_vector(to_unsigned(to_integer(C_SEM_ADDRS(1) + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		addrB_isa 	<= (others => 'Z');
		dataA_isa	<= (others => 'Z');
		dataB_isa	<= (others => 'Z');
		aleA 		<= '1';
		aleB		<= '0';
		wait for 0.3 ns;
		aleA		<= '0';
		aleB		<= '0';
		wait for 1.6 ns;
		iordA_n	<= '0';
		iowrB_n	<= '1';
		wait for 2 ns;
		iordA_n	<= '1';
		iowrB_n	<= '1';
		wait for 0.7 ns;
		
		-- Port B tries to take SEM 1
		addrA_isa 	<= (others => 'Z');
		addrB_isa 	<= std_logic_vector(to_unsigned(to_integer(C_SEM_ADDRS(1) + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		dataA_isa	<= (others => 'Z');
		dataB_isa	<= x"0000";
		aleA 		<= '0';
		aleB		<= '1';
		wait for 0.3 ns;
		aleA		<= '0';
		aleB		<= '0';
		wait for 1.6 ns;
		iowrA_n	<= '1';
		iowrB_n	<= '0';
		wait for 2 ns;
		iowrA_n	<= '1';
		iowrB_n	<= '1';
		wait for 0.7 ns;
		
		-- Port B reads SEM 1
		addrA_isa 	<= (others => 'Z');
		addrB_isa 	<= std_logic_vector(to_unsigned(to_integer(C_SEM_ADDRS(1) + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		dataA_isa	<= (others => 'Z');
		dataB_isa	<= (others => 'Z');
		aleA 		<= '0';
		aleB		<= '1';
		wait for 0.3 ns;
		aleA		<= '0';
		aleB		<= '0';
		wait for 1.6 ns;
		iowrA_n	<= '1';
		iordB_n	<= '0';
		wait for 2 ns;
		iowrA_n	<= '1';
		iordB_n	<= '1';
		wait for 0.7 ns;
		
		-- Port A realises SEM 1
		addrA_isa 	<= std_logic_vector(to_unsigned(to_integer(C_SEM_ADDRS(1) + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		addrB_isa 	<= (others => 'Z');
		dataA_isa	<= x"0001";
		dataB_isa	<= (others => 'Z');
		aleA 		<= '1';
		aleB		<= '0';
		wait for 0.3 ns;
		aleA		<= '0';
		aleB		<= '0';
		wait for 1.6 ns;
		iowrA_n	<= '0';
		iowrB_n	<= '1';
		wait for 2 ns;
		iowrA_n	<= '1';
		iowrB_n	<= '1';
		wait for 0.7 ns;
		
		-- Port B reads SEM 1
		addrA_isa 	<= (others => 'Z');
		addrB_isa 	<= std_logic_vector(to_unsigned(to_integer(C_SEM_ADDRS(1) + C_BASE_ADDR), C_ISA_ADDR_SIZE));
		dataA_isa	<= (others => 'Z');
		dataB_isa	<= (others => 'Z');
		aleA 		<= '0';
		aleB		<= '1';
		wait for 0.3 ns;
		aleA		<= '0';
		aleB		<= '0';
		wait for 1.6 ns;
		iowrA_n	<= '1';
		iordB_n	<= '0';
		wait for 2 ns;
		iowrA_n	<= '1';
		iordB_n	<= '1';
		wait for 0.7 ns;
	
		wait;
	end process;


end;