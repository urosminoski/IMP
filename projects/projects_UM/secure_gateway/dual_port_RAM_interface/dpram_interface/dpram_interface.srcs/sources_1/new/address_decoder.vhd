----------------------------------------------------------------------------------
-- Company: IMP Automation & Control Systems
-- Engineer: Uros Minoski, uros.minoski@automatika.imp.bg.ac.rs
-- 
-- Create Date: 04/22/2024 01:19:59 PM
-- Design Name: 
-- Module Name: address_decoder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: This module serves as an address decode, translating the address space of the Dual-Port RAM
--              to the address space of the connected devices. Dual-Port RAM has address space for mailbox,
--              that includes locations for interrupt flags, and separate addresses fir semaphore tokens.
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

entity address_decoder is
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
		addr_page2	: out std_logic 	-- Page 2 is addressed.
    );
end entity address_decoder;

architecture Behavioral of address_decoder is
	
begin

	addr_out <= addr_in(C_OUT_ADDR_SIZE - 1 downto 0);
	
	-- Process to decode input address and control signals
	P2 : process(rst, addr_in, iord_n, iowr_n, memrd_n, memwr_n)
		variable v_addr_page1 	: std_logic;
		variable v_addr_page2 	: std_logic;
		
		variable addr_tmp	: unsigned(C_OUT_ADDR_SIZE - 1 downto 0);
		variable tmp1 		: unsigned(C_IN_ADDR_SIZE - 1 downto C_OUT_ADDR_SIZE);
		variable tmp2 		: unsigned(C_IN_ADDR_SIZE - 1 downto C_OUT_ADDR_SIZE);
		
	begin
		addr_tmp := unsigned(addr_in(C_OUT_ADDR_SIZE - 1 downto 0));
		
		tmp1 := unsigned(addr_in(C_IN_ADDR_SIZE - 1 downto C_OUT_ADDR_SIZE));
		tmp2 := C_BASE_ADDR(C_IN_ADDR_SIZE - 1 downto C_OUT_ADDR_SIZE);
		
		-- If reset is active, reset all contorl signals.
		if(rst = '1') then
			v_addr_page1 := '0';
			v_addr_page2 := '0';
		else
			-- Else, if RAM is addressed.
			if(tmp1 = tmp2) then
				-- Memory Read/Write.
				if(memrd_n = '0' or memwr_n = '0') then
					-- If input address falls into page 1.
					if(addr_tmp >= C_PAGE1_START and addr_tmp <= C_PAGE1_END) then
						v_addr_page1 := '1';
						v_addr_page2 := '0';
					-- Else, DPRAM isn't addressed.
					else
						v_addr_page1 := '0';
						v_addr_page2 := '0';
					end if;
				-- I/O Read/Write. Page 2 is addressed.
				elsif(iord_n = '0' or iowr_n = '0') then
					-- If input address falls into page 2.
					if(addr_tmp >= C_PAGE2_START and addr_tmp <= C_PAGE2_END) then
						v_addr_page1 := '0';
						v_addr_page2 := '1';
					-- Else, DPRAM isn't addressed.
					else
						v_addr_page1 := '0';
						v_addr_page2 := '0';
					end if;
				else
					v_addr_page1 := '0';
					v_addr_page2 := '0';
				end if;
			end if;
		end if;
		-- Assign variables to the ports.
		addr_page1 <= v_addr_page1;
		addr_page2 <= v_addr_page2;
	end process;

end Behavioral;