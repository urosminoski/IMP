----------------------------------------------------------------------------------
-- Company: IMP Automation & Control Systems
-- Engineer: Uros Minoski, uros.minoski@automatika.imp.bg.ac.rs
-- 
-- Create Date: 04/23/2024 03:21:32 PM
-- Design Name: 
-- Module Name: control_signal_generator_tb - Behavioral
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

entity control_signal_generator_tb is
end control_signal_generator_tb;

architecture bench of control_signal_generator_tb is

	component control_signal_generator
		port(
			addr_lsb	: in std_logic;
			iord_n		: in std_logic;
			iowr_n		: in std_logic;
			memrd_n		: in std_logic;
			memwr_n		: in std_logic;
			sbhe_n		: in std_logic;
			rst			: in std_logic;
			addr_mail	: in std_logic;
			addr_sem	: in std_logic;
			rw			: out std_logic;
			oe_n		: out std_logic;
			ce0_n		: out std_logic;
			ce1 		: out std_logic;
			sem_n		: out std_logic;
			ub_n		: out std_logic;
			lb_n		: out std_logic;
			iocs16_n	: out std_logic;
			memcs16_n	: out std_logic
		);
	end component;

	signal addr_lsb		: std_logic	:= '0';
	signal iord_n		: std_logic	:= '1';
	signal iowr_n		: std_logic	:= '1';
	signal memrd_n		: std_logic	:= '1';
	signal memwr_n		: std_logic	:= '1';
	signal sbhe_n		: std_logic	:= '0';
	signal rst			: std_logic	:= '0';
	signal addr_mail	: std_logic	:= '0';
	signal addr_sem		: std_logic	:= '0';
	
	signal rw			: std_logic;
	signal oe_n			: std_logic;
	signal ce0_n		: std_logic;
	signal ce1			: std_logic;
	signal sem_n		: std_logic;
	signal ub_n			: std_logic;
	signal lb_n			: std_logic;
	signal iocs16_n		: std_logic;
	signal memcs16_n	: std_logic ;

begin

	uut: control_signal_generator 
	port map( 
		addr_lsb  => addr_lsb,
		iord_n    => iord_n,
		iowr_n    => iowr_n,
		memrd_n   => memrd_n,
		memwr_n   => memwr_n,
		sbhe_n    => sbhe_n,
		rst       => rst,
		addr_mail => addr_mail,
		addr_sem  => addr_sem,
		rw        => rw,
		oe_n      => oe_n,
		ce0_n     => ce0_n,
		ce1       => ce1,
		sem_n     => sem_n,
		ub_n      => ub_n,
		lb_n      => lb_n,
		iocs16_n  => iocs16_n,
		memcs16_n => memcs16_n 
	);

	stimulus: process
	begin
		
		rst <= '1';
		wait for 2ns;
		rst <= '0';
		wait for 1ns;
		
		iord_n 		<= '0';
		addr_sem	<= '1';
		wait for 1ns;
		addr_sem	<= '0';
		iord_n		<= '1';
		wait for 1ns;
		
		iowr_n 		<= '0';
		addr_sem	<= '1';
		wait for 1ns;
		addr_sem	<= '0';
		iowr_n		<= '1';
		wait for 1ns;
		
		memwr_n 	<= '0';
		addr_mail	<= '1';
		wait for 1ns;
		addr_mail	<= '0';
		memwr_n		<= '1';
		wait for 1ns;
		
		memrd_n 	<= '0';
		addr_mail	<= '1';
		wait for 1ns;
		addr_mail	<= '0';
		memrd_n		<= '1';
		wait for 1ns;
		
		sbhe_n 		<= '1';
		addr_lsb 	<= '0';
		wait for 1ns;
		
		sbhe_n 		<= '1';
		addr_lsb 	<= '1';
		wait for 1ns;

		wait;
	end process;


end bench;
