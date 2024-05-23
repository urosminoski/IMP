----------------------------------------------------------------------------------
-- Company: IMP Automation & Control Systems
-- Engineer: Uros Minoski, uros.minoski@automatika.imp.bg.ac.rs
-- 
-- Create Date: 05/08/2024 09:23:35 AM
-- Design Name: 
-- Module Name: semaphore_controler - Behavioral
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

entity semaphore_controler is
	port(
		-- Port A 	
		addrA 	: in std_logic_vector(C_RAM_ADDR_SIZE - 1 downto 0);	-- RAM address bus on port A
		
		ioceA	: in std_logic;		-- I/O chip enable, smephores are addressed
		iowrA_n	: in std_logic; 	-- I/O write, active low
		
		dinA	: in std_logic;		-- Data in
		doutA	: out std_logic;	-- Data out
		
		-- Port B 
		addrB 	: in std_logic_vector(C_RAM_ADDR_SIZE - 1 downto 0);	-- RAM address bus on port B
		
		ioceB	: in std_logic;		-- I/O chip enable, smephores are addressed
		iowrB_n	: in std_logic; 	-- I/O write, active low
		
		dinB	: in std_logic;		-- Data in
		doutB	: out std_logic		-- Data out
	);
end entity semaphore_controler;

architecture Behavioral of semaphore_controler is
	
	-- Semaphore component
	component semaphore is
		port(
			-- Port A 	
			ioceA	: in std_logic;		-- I/O chip enable, smephores are addressed
			iowrA_n	: in std_logic; 	-- I/O write, active low
			
			dinA	: in std_logic;		-- Data in
			doutA	: out std_logic;	-- Data out
			
			-- Port B 
			ioceB	: in std_logic;		-- I/O chip enable, smephores are addressed
			iowrB_n	: in std_logic; 	-- I/O write, active low
			
			dinB	: in std_logic;		-- Data in
			doutB	: out std_logic		-- Data out
		);
	end component semaphore;

	signal ioceA_tmp	: std_logic_vector(C_NUM_SEM - 1 downto 0);
	signal ioceB_tmp	: std_logic_vector(C_NUM_SEM - 1 downto 0);
	signal doutA_tmp	: std_logic_vector(C_NUM_SEM - 1 downto 0);
	signal doutB_tmp	: std_logic_vector(C_NUM_SEM - 1 downto 0);

begin

	-- Process for generating ioceA_tmp
	gen_ioceA : for i in 0 to C_NUM_SEM - 1 generate
		process(ioceA, addrA)
		begin
			if unsigned(addrA) = C_SEM_ADDRS(i) then
				if ioceA = '1' then
					ioceA_tmp(i) <= '1';
				else
					ioceA_tmp(i) <= '0';
				end if;
			else
				ioceA_tmp(i) <= '0';
			end if;
		end process;
	end generate;
	
	-- Process for generating ioceB_tmp
	gen_ioceB : for i in 0 to C_NUM_SEM - 1 generate
		process(ioceB, addrB)
		begin
			if unsigned(addrB) = C_SEM_ADDRS(i) then
				if ioceB = '1' then
					ioceB_tmp(i) <= '1';
				else
					ioceB_tmp(i) <= '0';
				end if;
			else
				ioceB_tmp(i) <= '0';
			end if;
		end process;
	end generate;
	
	-- Process for generationg doutA
	process(addrA, doutA_tmp)
		variable ddA : std_logic := 'Z';
	begin
		for i in 0 to C_NUM_SEM - 1 loop
			if unsigned(addrA) = C_SEM_ADDRS(i) then
				ddA := doutA_tmp(i);
				exit;
			end if;
		end loop;
		doutA <= ddA;
	end process;
	
	-- Process for generationg doutB
	process(addrB, doutB_tmp)
		variable ddB : std_logic := 'Z';
	begin
		for i in 0 to C_NUM_SEM - 1 loop
			if unsigned(addrB) = C_SEM_ADDRS(i) then
				ddB := doutB_tmp(i);
				exit;
			end if;
		end loop;
		doutB <= ddB;
	end process;
	
	-- Generate semaphores
    gen_semaphores : for i in 0 to C_NUM_SEM - 1 generate
        S : semaphore
        port map(
            ioceA   => ioceA_tmp(i),
            iowrA_n => iowrA_n,
            dinA    => dinA,
            doutA   => doutA_tmp(i),
            ioceB   => ioceB_tmp(i),
            iowrB_n => iowrB_n,
            dinB    => dinB,
            doutB   => doutB_tmp(i)
        );
    end generate;

end;