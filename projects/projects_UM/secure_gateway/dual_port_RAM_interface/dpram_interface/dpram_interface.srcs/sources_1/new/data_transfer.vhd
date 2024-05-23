----------------------------------------------------------------------------------
-- Company: IMP Automation & Control Systems
-- Engineer: Uros Minoski, uros.minoski@automatika.imp.bg.ac.rs 
-- 
-- Create Date: 04/23/2024 01:49:38 PM
-- Design Name: 
-- Module Name: bidirectional_data_assignment - Behavioral
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

entity data_transfer is
	generic(
		C_DATA_SIZE 	: integer := 16			-- Data bus size
	);
	port(
		data_isa	: inout std_logic_vector(C_DATA_SIZE - 1 downto 0); 		-- Data bus.
		data_ram	: inout std_logic_vector(C_DATA_SIZE - 1 downto 0); 		-- Data bus.
		
		rw			: in std_logic;		-- R/W signal
		rst			: in std_logic;		-- Reset signal
		addr_busy	: in std_logic;		-- Busy signal is addressed
		busy 		: in std_logic 		-- Busy signal, active low
	);
end data_transfer;

architecture Behavioral of data_transfer is
	
	signal data_bus : std_logic_vector(C_DATA_SIZE - 1 downto 0);

begin

	-- 
	P1 : process(rst, rw, addr_busy, busy)
	begin
		if(rw = '1') then
			data_isa <= data_ram; 
			data_ram <= (others => 'Z');
		else
			data_ram <= data_isa;
			data_isa <= (others => 'Z');
		end if;
	end process;

	--data_isa <= data_bus when (rw = '1') else (others => 'Z');
	--data_ram <= data_bus when (rw = '0') else (others => 'Z');
	
	


	-- Process for bidirectional signal assignment.
	-- P1 : process(rst, rw, addr_busy, busy, data_isa)
		-- variable data_tmp : std_logic_vector(C_DATA_SIZE - 1 downto 0);
	-- begin
		-- If reset is active, high impedance on data bus.
		-- if(rst = '1') then
			-- data_tmp := (others => 'Z');
		-- Else route data based on RW and addr_busy signals.
		-- else
			-- If read cycle, DPRAM drives the bus.
			-- if(rw = '1') then
				-- If addressing busy line, read busy.
				-- if(addr_busy = '1') then
					-- data_tmp 	:= (others => '0');
					-- data_tmp(0)	:= busy;
				-- Else, high impedance by interface. DPRAM will drive the bus.
				-- else
					-- data_tmp := (others => 'Z');
				-- end if;
			-- If write cycle, ISA drives the bus.
			-- else
				-- data_tmp := data_isa;
			-- end if;
		-- end if;
		-- Assign variable to the port.
		-- data_ram <= data_tmp;
	-- end process;

end Behavioral;
