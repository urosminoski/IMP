----------------------------------------------------------------------------------
-- Company: IMP Automation & Control Systems
-- Engineer: Uros Minoski, uros.minoski@automatika.imp.bg.ac.rs
-- 
-- Create Date: 04/23/2024 12:17:29 PM
-- Design Name: 
-- Module Name: dpram_interface_single - Behavioral
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

entity dpram_interface_single is
    generic(
        C_ISA_ADDR_SIZE   	: integer := 24;                        -- Address size of input address bus (from ISA bus).
        C_RAM_ADDR_SIZE     : integer := 16;                        -- Address size of output address bus (to DPRAM module).
		
        C_BASE_ADDR     	: unsigned(23 downto 0) := x"000000";   -- Base address.
		C_MAILBOX_START		: unsigned(15 downto 0)	:= x"0000";		-- Start address of RAMS's mailbox.
		C_MAILBOX_END 		: unsigned(15 downto 0)	:= x"FFFF";		-- End address of RAM's mailbox.
		C_SEM_START			: unsigned(15 downto 0)	:= x"0000";		-- Start address of RAM's semaphores.
		C_SEM_END 			: unsigned(15 downto 0)	:= x"0007"		-- End address of RAM's semaphores.
    );
    port(
        ADDR_ISA    : in std_logic_vector(C_ISA_ADDR_SIZE - 1 downto 0); 	-- Input address bus, form ISA bus.
        ADDR_RAM    : out std_logic_vector(C_RAM_ADDR_SIZE - 1 downto 0); 	-- Input address bus, to DPRAM module.
        
        IORD_n      : in std_logic;     -- Input/Output Read.
        IOWR_n      : in std_logic;     -- Input/Output Write.
        MEMRD_n     : in std_logic;     -- Memory Read.
        MEMWR_n     : in std_logic;     -- Memory Write.        
        SBHE_n      : in std_logic;     -- SBHE signal. Indicate valid data on upper data bus. Active low.
        ALE         : in std_logic;     -- ALE (Address latch Enable) line. indicates bus cycle start.
        RESET       : in std_logic;     -- Reset signal.
        
        IOCS16_n    : out std_logic;    -- Conformation of 16-bit I/O device.
        MEMCS16_n   : out std_logic;    -- Conformation of 16-bit Memory device.     
        RW          : out std_logic;    -- Read/Write signal.
        UB_n        : out std_logic;    -- Upper byte select. Active low.
        LB_n        : out std_logic;    -- Lower byte select. Active low.
        SEM_n       : out std_logic;    -- Semaphore enable. Active low.
        CE0_n       : out std_logic;    -- Chip enable 0. Active low.
        CE1         : out std_logic;    -- Chip enable 1.
		OE_n		: out std_logic;	-- output enable. Active low.
        
        BUSY_n      : in std_logic;     -- Busy line. From DPRAM module.
        
        INT_RAM     : in std_logic;     -- Input interrupt line. From DPRAM module.
        INT_ISA     : out std_logic; 	-- Output interrupt line. To ISA bus.
		INT_BUSY	: out std_logic		-- Busy line is connected to interrupt line on ISA bus.
    );
end dpram_interface_single;

architecture Behavioral of dpram_interface_single is

	component address_latch is
		generic(
			C_ADDR_SIZE : integer := 24
		);
		port(
			addr_in			: in std_logic_vector(C_ADDR_SIZE - 1 downto 0);	-- Input address (from ISA bus)
			latch_enable	: in std_logic;										-- Enable address latching.
			addr_latched	: out std_logic_vector(C_ADDR_SIZE - 1 downto 0)	-- Latched input address bus.
		);
	end component address_latch;
	
	component address_decoder is
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
			addr_in    : in std_logic_vector(C_IN_ADDR_SIZE - 1 downto 0);      -- Input address.
			addr_out    : out std_logic_vector(C_OUT_ADDR_SIZE - 1 downto 0);    -- Output address.
			
			rst 		: in std_logic;		-- Reset signal.
			iord_n      : in std_logic;     -- I/O Read. Active low.
			iowr_n      : in std_logic;     -- I/O Write. Active low.
			memrd_n     : in std_logic;     -- Memory Read. Active low.
			memwr_n     : in std_logic;     -- Memory Write. Active low.
							 
			addr_page1	: out std_logic;	-- Page 1 is addressed.
			addr_page2	: out std_logic		-- Page 2 is addressed.		
		);
	end component address_decoder;
	
	component control_signal_generator is
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
	end component control_signal_generator;
	
	signal addr_latched : std_logic_vector(C_ISA_ADDR_SIZE - 1 downto 0);
	signal addr_ram_tmp	: std_logic_vector(C_RAM_ADDR_SIZE - 1 downto 0);
	
	signal addr_mail	: std_logic;
	signal addr_sem		: std_logic;
	signal addr_busy	: std_logic;
	
	signal rw_tmp : std_logic;

begin

	latch : address_latch
	generic map(
		C_ADDR_SIZE => C_ISA_ADDR_SIZE
	)
	port map(
		addr_in			=> ADDR_ISA,
		latch_enable	=> ALE,
		addr_latched	=> addr_latched
	);
	
	decoder : address_decoder
	generic map(
		C_IN_ADDR_SIZE   	=> C_ISA_ADDR_SIZE,
		C_OUT_ADDR_SIZE  	=> C_RAM_ADDR_SIZE,
		
		C_BASE_ADDR     	=> C_BASE_ADDR,
		C_PAGE1_START		=> C_MAILBOX_START,
		C_PAGE1_END 		=> C_MAILBOX_END,
		C_PAGE2_START		=> C_SEM_START,
		C_PAGE2_END 		=> C_SEM_END
	)
	port map(
		addr_in    	=> addr_latched,
		addr_out    => addr_ram_tmp,
		
		rst 		=> RESET,
		iord_n      => IORD_n,
		iowr_n      => IOWR_n,
		memrd_n     => MEMRD_n,
		memwr_n     => MEMWR_n,
						 
		addr_page1	=> addr_mail,
		addr_page2	=> addr_sem
	);
	
	ADDR_RAM <= addr_ram_tmp;
	
	control_gen : control_signal_generator
	port map(
		addr_lsb	=> addr_ram_tmp(0),
		iord_n		=> IORD_n,
		iowr_n		=> IOWR_n,
		memrd_n		=> MEMRD_n,
		memwr_n		=> MEMWR_n,
		sbhe_n		=> SBHE_n,
		rst			=> RESET,
		
		addr_mail	=> addr_mail,
		addr_sem	=> addr_sem,
		
		rw			=> rw_tmp,	
		oe_n		=> OE_n,
		ce0_n		=> CE0_n,
		ce1 		=> CE1, 
		sem_n		=> SEM_n,
		ub_n		=> UB_n,
		lb_n		=> LB_n,
		iocs16_n	=> IOCS16_n,
		memcs16_n	=> MEMCS16_n
	);
		
	RW 			<= rw_tmp;
	INT_ISA 	<= not INT_RAM;
	INT_BUSY	<= not BUSY_n;
	
end Behavioral;
