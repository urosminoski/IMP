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

entity secure_gateway is
	port(
		clk : in std_logic;
		
		-- Port A
		addrA_isa	: in std_logic_vector(C_ISA_ADDR_SIZE - 1 downto 0); 	-- ISA address bus
		dataA_isa	: inout std_logic_vector(C_DATA_SIZE - 1 downto 0);		-- ISA data bus
		
		aleA		: in std_logic;		-- ALE (Address Latch Enable) signal
		iordA_n		: in std_logic;		-- I/O read, active low
		iowrA_n		: in std_logic;		-- I/O write, active low
		memrdA_n	: in std_logic;		-- Memory read, active low
		memwrA_n	: in std_logic;		-- Memory write, active low
		rstA 		: in std_logic;		-- Reset signal
		
		iocs16A_n	: out std_logic;
		memcs16A_n	: out std_logic;
		intA		: out std_logic;	-- Interrupt signal
		
		-- Port B
		addrB_isa	: in std_logic_vector(C_ISA_ADDR_SIZE - 1 downto 0); 	-- ISA address bus
		dataB_isa	: inout std_logic_vector(C_DATA_SIZE - 1 downto 0);		-- ISA data bus
		
		aleB		: in std_logic;		-- ALE (Address Latch Enable) signal
		iordB_n		: in std_logic;		-- I/O read, active low
		iowrB_n		: in std_logic;		-- I/O write, active low
		memrdB_n	: in std_logic;		-- Memory read, active low
		memwrB_n	: in std_logic;		-- Memory write, active low
		rstB 		: in std_logic;		-- Reset signal
		
		iocs16B_n	: out std_logic;
		memcs16B_n	: out std_logic;
		intB		: out std_logic		-- Interrupt signal
	);
end secure_gateway;

architecture Behavioral of secure_gateway is

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
	
	component addr_decoder is
		port(
			addr_isa	: in std_logic_vector(C_ISA_ADDR_SIZE - 1 downto 0);	-- ISA address bus
			addr_ram	: out std_logic_vector(C_RAM_ADDR_SIZE - 1 downto 0); 	-- Dual-Port RAM address bus
			
			rst		: in std_logic;		-- Reset signal
			iord_n	: in std_logic; 	-- I/O read, active low
			iowr_n	: in std_logic; 	-- I/O write, active low
			memrd_n	: in std_logic; 	-- Memory read, active low
			memwr_n	: in std_logic; 	-- Memory write, active low

			intA	: out std_logic;
			intB	: out std_logic;
			memce	: out std_logic;		-- Memory chip enable, active high if RAM is addressed
			ioce	: out std_logic			-- I/O chip enable, active high if RAM's semaphores are addressed
		);
	end component addr_decoder;

	component semaphore_controler is
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
	end component semaphore_controler;
	
	component dp_ram is
		port (
			douta: out std_logic_vector(15 downto 0);
			doutb: out std_logic_vector(15 downto 0);
			clka: in std_logic;
			ocea: in std_logic;
			cea: in std_logic;
			reseta: in std_logic;
			wrea: in std_logic;
			clkb: in std_logic;
			oceb: in std_logic;
			ceb: in std_logic;
			resetb: in std_logic;
			wreb: in std_logic;
			ada: in std_logic_vector(13 downto 0);
			dina: in std_logic_vector(15 downto 0);
			adb: in std_logic_vector(13 downto 0);
			dinb: in std_logic_vector(15 downto 0)
		);
	end component dp_ram;
	
	-- Signals
	-- Latched ISA bus address
	signal addrA_latched	: std_logic_vector(C_ISA_ADDR_SIZE - 1 downto 0);	-- Latched ISA address, port A
	signal addrB_latched	: std_logic_vector(C_ISA_ADDR_SIZE - 1 downto 0);	-- Latched ISA address, port B
	
	-- RAM bus address
	signal addrA_ram		: std_logic_vector(C_RAM_ADDR_SIZE - 1 downto 0);	-- RAM address bus, port A
	signal addrB_ram		: std_logic_vector(C_RAM_ADDR_SIZE - 1 downto 0);	-- RAM address bus, port B
	
	-- Interrupt Signals
	signal intA_r 	: std_logic;	-- Port A reads from A interrupt location
	signal intA_w 	: std_logic;	-- Port B writes to A interrupt location
	signal intB_r 	: std_logic;	-- Port B reads from B interrupt location
	signal intB_w 	: std_logic;	-- Port A writes to B interrupt location
	
	-- Control Signals
	signal memceA	: std_logic;	-- RAM is addressed, port A
	signal ioceA	: std_logic;	-- Semaphores are addressed, port A\
	signal wrA		: std_logic;	-- W/R signal, port A
	signal memceB	: std_logic;	-- RAM is addressed, port B
	signal ioceB	: std_logic;	-- Semaphores are addressed, port B
	signal wrB		: std_logic;	-- W/R signal, port B
	
	-- Data bus
	signal dataA_r	: std_logic_vector(C_DATA_SIZE - 1 downto 0);
	signal dataAT_r	: std_logic_vector(C_DATA_SIZE - 1 downto 0);
	signal dataA_w	: std_logic_vector(C_DATA_SIZE - 1 downto 0);
	signal dataB_r	: std_logic_vector(C_DATA_SIZE - 1 downto 0);
	signal dataBT_r	: std_logic_vector(C_DATA_SIZE - 1 downto 0);
	signal dataB_w	: std_logic_vector(C_DATA_SIZE - 1 downto 0);
	
	signal semA_data 	: std_logic_vector(C_DATA_SIZE - 1 downto 0);
	signal semB_data 	: std_logic_vector(C_DATA_SIZE - 1 downto 0);
	signal semA_d 		: std_logic;
	signal semB_d 		: std_logic;
	
	signal tmpA : std_logic;
	signal tmpB : std_logic;

begin

-- Port A addres latch
	I1_A : address_latch
	generic map(
		C_ADDR_SIZE => C_ISA_ADDR_SIZE
	)
	port map(
		addr_in			=> addrA_isa,	
		latch_enable	=> aleA,
		addr_latched	=> addrA_latched
	);
	
	-- Port B addres latch
	I1_B : address_latch
	generic map(
		C_ADDR_SIZE => C_ISA_ADDR_SIZE
	)
	port map(
		addr_in			=> addrB_isa,	
		latch_enable	=> aleB,
		addr_latched	=> addrB_latched
	);
	
	-- Port A address decoder
	I2_A : addr_decoder
	port map(
		addr_isa	=> addrA_latched,
		addr_ram	=> addrA_ram,
		rst			=> rstA,
		iord_n		=> iordA_n,
		iowr_n		=> iowrA_n,
		memrd_n		=> memrdA_n,
		memwr_n		=> memwrA_n,
		intA		=> intA_r,
		intB		=> intA_w,
		memce		=> memceA,
		ioce		=> ioceA
	);
	
	-- Port B address decoder
	I2_B : addr_decoder
	port map(
		addr_isa	=> addrB_latched,
		addr_ram	=> addrB_ram,
		rst			=> rstB,
		iord_n		=> iordB_n,
		iowr_n		=> iowrB_n,
		memrd_n		=> memrdB_n,
		memwr_n		=> memwrB_n,
		intA		=> intB_w,
		intB		=> intB_r,
		memce		=> memceB,
		ioce		=> ioceB
	);
	
	-- Process that generates interrupt signals
	P1 : process(intA_r, intA_w, intB_r, intB_w)
		variable intA_tmp : std_logic;
		variable intB_tmp : std_logic;
	begin
		if(intA_r = '1') then
			intA_tmp := '0';
		elsif(intA_w = '1') then
			intB_tmp := '1';
		elsif(rstA = '1') then
			intA_tmp := '0';
		else
			intA_tmp := intA_tmp or '0';
		end if;
		
		if(intB_r = '1') then
			intB_tmp := '0';
		elsif(intB_w = '1') then
			intA_tmp := '1';
		elsif(rstB = '1') then
			intB_tmp := '0';
		else
			intB_tmp := intB_tmp or '0';
		end if;
		
		intA <= intA_tmp;
		intB <= intB_tmp;
		
	end process;
	
	iocs16A_n <= not ((not iordA_n or not iowrA_n) and ioceA);
	iocs16B_n <= not ((not iordB_n or not iowrB_n) and ioceB);

	memcs16A_n <= not ((not memrdA_n or not memwrA_n) and (memceA or intA_r or intA_w));
	memcs16B_n <= not ((not memrdB_n or not memwrB_n) and (memceB or intB_r or intB_w));
	
	-- Process to generate W/R signal
	P2 : process(iordA_n, iowrA_n, memrdA_n, memwrA_n, iordB_n, iowrB_n, memrdB_n, memwrB_n)
	begin
		-- Port A
		if(iordA_n = '0' or memrdA_n = '0') then
			wrA <= '0';
		elsif(iowrA_n = '0' or memwrA_n = '0') then
			wrA <= '1';
		else
			wrA <= '1';
		end if;
		
		-- Port B
		if(iordB_n = '0' or memrdB_n = '0') then
			wrB <= '0';
		elsif(iowrB_n = '0' or memwrB_n = '0') then
			wrB <= '1';
		else
			wrB <= '1';
		end if;
	end process;
	
	-- Semaphore controler
	-- Read semaphore token is in LSB !!
	I3 : semaphore_controler 
	port map(
		-- Port A 	
		addrA 	=> addrA_ram,
		ioceA	=> ioceA,
		iowrA_n	=> iowrA_n,
		dinA	=> dataA_w(0),
		doutA	=> semA_d, --dataA_r(0),
		-- Port B 
		addrB 	=> addrB_ram,
		ioceB	=> ioceB,
		iowrB_n	=> iowrB_n,
		dinB	=> dataB_w(0),
		doutB	=> semB_d --dataB_r(0)
	);
	
	tmpA <= memceA or intA_r or intA_w;
	tmpB <= memceB or intB_r or intB_w;
	
	-- Dual-Port RAM
	I4 : dp_ram
	port map(
		douta	=> dataAT_r,
		doutb	=> dataBT_r,
		clka	=> clk,
		ocea	=> tmpA,
		cea		=> tmpA,
		reseta	=> rstA,
		wrea	=> wrA,
		clkb	=> clk,
		oceb	=> tmpB,
		ceb		=> tmpB,
		resetb	=> rstB,
		wreb	=> wrB,
		ada		=> addrA_ram,
		dina	=> dataA_w,
		adb		=> addrB_ram,
		dinb	=> dataB_w
	);
	
	dataA_w <= dataA_isa when (wrA = '1') else dataA_w;
	dataB_w <= dataB_isa when (wrB = '1') else dataB_w;
	
	P : process(semA_d, semB_d)
		variable dA_tmp : std_logic_vector(C_DATA_SIZE - 1 downto 0);
		variable dB_tmp : std_logic_vector(C_DATA_SIZE - 1 downto 0);
	begin
		dA_tmp 		:= (others => '0');
		dA_tmp(0)	:= semA_d;
		semA_data 	<= dA_tmp;
		
		dB_tmp 		:= (others => '0');
		dB_tmp(0)	:= semB_d;
		semB_data 	<= dB_tmp;
	end process;
	
	dataA_isa <= dataA_r when (wrA = '0') else (others => 'Z');
	dataB_isa <= dataB_r when (wrB = '0') else (others => 'Z');
	
	PAB : process(semA_data, dataAT_r, memceA, ioceA, intA_r, intA_w, semB_data, dataBT_r, memceB, ioceB, intB_r, intB_w)
		variable dataA_tmp : std_logic_vector(C_DATA_SIZE - 1 downto 0);
		variable dataB_tmp : std_logic_vector(C_DATA_SIZE - 1 downto 0);
	begin
		if(ioceA = '1') then
			dataA_tmp := semA_data;
		elsif(memceA = '1' or intA_r = '1' or intA_w = '1') then
			dataA_tmp := dataAT_r;	
		else 
			dataA_tmp := (others => 'Z');
		end if;
		
		if(ioceB = '1') then
			dataB_tmp := semB_data;
		elsif(memceB = '1' or intB_r = '1' or intB_w = '1') then
			dataB_tmp := dataBT_r;	
		else 
			dataB_tmp := (others => 'Z');
		end if;
		
		dataA_r <= dataA_tmp;
		dataB_r <= dataB_tmp;
		
	end process;
	
end;