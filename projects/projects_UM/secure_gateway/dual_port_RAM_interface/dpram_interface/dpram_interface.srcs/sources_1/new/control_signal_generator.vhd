----------------------------------------------------------------------------------
-- Company: IMP Automation & Control Systems
-- Engineer: Uros Minoski, uros.minoski@automatika.imp.bg.ac.rs
-- 
-- Create Date: 04/23/2024 12:46:40 PM
-- Design Name: 
-- Module Name: control_signal_gen - Behavioral
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

entity control_signal_generator is
	port(
		addr_lsb	: in std_logic;		-- LSB of input latched address
		iord_n		: in std_logic;		-- I/O read signal. Active low
		iowr_n		: in std_logic;		-- I/O write signal. Active low
		memrd_n		: in std_logic;		-- Memory read signal. Active low
		memwr_n		: in std_logic;		-- Memory write signal. Active low
		sbhe_n		: in std_logic;		-- SBHE signal. Indicate valid data on upper data bus. Active low
		rst			: in std_logic;		-- Reset signal
		
		addr_mail	: in std_logic;		-- RAM's mailbox is addressed
		addr_sem	: in std_logic;		-- RAM's semaphores are addressed
		
		rw			: out std_logic;	-- R/W signal
		oe_n		: out std_logic;	-- Output enable. Active low
		ce0_n		: out std_logic;	-- Chip enable 0. Active low
		ce1 		: out std_logic;	-- Chip enable 1
		sem_n		: out std_logic; 	-- Semaphore enable
		ub_n		: out std_logic;	-- Upper byte select. Active low
		lb_n		: out std_logic;	-- Lower byte select. Active low	
		iocs16_n	: out std_logic;	-- Conformation of 16-bit I/O device
		memcs16_n	: out std_logic		-- Conformation of 16-bit Memory device
	);
end control_signal_generator;

architecture Behavioral of control_signal_generator is

	signal rw_tmp : std_logic;

begin

	-- Process that generates R/W signal.
	P1 : process(iord_n, iowr_n, memrd_n, memwr_n)
	begin
		if(iord_n = '0' or memrd_n = '0') then
			rw_tmp <= '1';
		elsif(iowr_n = '0' or memwr_n = '0') then
			rw_tmp <= '0';
		else
			rw_tmp <= '1';
		end if;
	end process;
	
	rw <= rw_tmp;
	
	-- Process that generates OE (Output Enable) signal.
	P2 : process(rst, rw_tmp, addr_mail, addr_sem)
		variable oe_tmp : std_logic;	-- Active low
	begin
		-- If reset is active, disable output.
		if(rst = '1') then
			oe_tmp := '1';
		else
			-- If RAM is addressed.
			if(addr_mail = '1' or addr_sem = '1') then
				-- If read cycle, enable OE.
				if(rw_tmp = '1') then
					oe_tmp := '0'; 
				else
					oe_tmp := '1';
				end if;
			else
				oe_tmp := '1';
			end if;
		end if;
		-- Assign variable to the port.
		oe_n <= oe_tmp;
	end process;
	
	-- Process that generates UB (Upper Byte) and LB (Lower Byte) signals
	P3 : process(sbhe_n, addr_lsb)
		variable ub_tmp : std_logic;	-- Active low
		variable lb_tmp : std_logic;	-- Active low
	begin
		-- If SBHE is active, 16-bit data transfer is active.
		if(sbhe_n = '0') then
			ub_tmp := '0';
			lb_tmp := '0';	
		-- Else, 8-bit data transfer is active.
		else
			-- If an even addr location is addressed, activate LB.
			if(addr_lsb = '0') then
				ub_tmp := '1';
				lb_tmp := '0';
			-- Else, activate UB.
			else 	
				ub_tmp := '0';
				lb_tmp := '1';
			end if;
		end if;
		-- Assign variables to the ports.
		ub_n <= ub_tmp;
		lb_n <= lb_tmp;
	end process;
	
	-- Process for generation of IOCS16 and MEMCS16 signals
	P4 : process(iord_n, iowr_n, memrd_n, memwr_n)
		variable iocs16_tmp 	: std_logic;	-- Avtive low.
		variable memcs16_tmp 	: std_logic;
	begin
		-- If memory access, activate MEMCS16.
		if(memrd_n = '0' or memwr_n = '0') then
			memcs16_tmp := '0';
			iocs16_tmp	:= '1';
		-- If I/O access, activate IOCS16.
		elsif(iord_n = '0' or iowr_n = '0') then
			memcs16_tmp := '1';
			iocs16_tmp	:= '0';
		-- ELse, high impedance.
		else 
			memcs16_tmp := 'Z';
			iocs16_tmp	:= 'Z';
		end if;
		-- Assign variables to the ports.
		memcs16_n <= memcs16_tmp;
		iocs16_n <= iocs16_tmp;
	end process;
	
	-- Process that generates chip select signals CE0 and C1, and semaphore enable SEM signals.
	P5 : process(rst, addr_mail, addr_sem)
		variable ce0_tmp	: std_logic;	-- Active Low
		variable ce1_tmp	: std_logic;	-- Active High
		variable sem_tmp	: std_logic;	-- Active Low
	begin
		-- If reset is active, reset all control signals.
		if(rst = '1') then
				ce0_tmp := '1';
				ce1_tmp := '0';
				sem_tmp := '1';
		else
			-- If mailbox is addressed, activate CE0 and CE1.
			if(addr_mail = '1') then
				ce0_tmp := '0';
				ce1_tmp := '1';
				sem_tmp := '1';
			
			-- If semaphores are addressed, activate SEM.
			elsif(addr_sem = '1') then
				ce0_tmp := '1';
				ce1_tmp := '0';
				sem_tmp := '0';
			
			-- Else, reset all control signals.
			else
				ce0_tmp := '1';
				ce1_tmp := '0';
				sem_tmp := '1';
			end if;
		end if;
		-- Assign variables to the ports.
		ce0_n 	<= ce0_tmp;
		ce1		<= ce1_tmp;
		sem_n	<= sem_tmp;
	end process;
	
end Behavioral;
