library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.secure_gateway_pkg.all;

entity addr_decoder is
    port (
        addr_isa    : in std_logic_vector(C_ISA_ADDR_SIZE - 1 downto 0);   -- ISA address bus
        addr_ram    : out std_logic_vector(C_RAM_ADDR_SIZE - 1 downto 0);  -- Dual-Port RAM address bus
        
        rst         : in std_logic;        -- Reset signal
        iord_n      : in std_logic;        -- I/O read, active low
        iowr_n      : in std_logic;        -- I/O write, active low
        memrd_n     : in std_logic;        -- Memory read, active low
        memwr_n     : in std_logic;        -- Memory write, active low

        intA        : out std_logic;
        intB        : out std_logic;    
        memce       : out std_logic;       -- Memory chip enable, active high if RAM is addressed
        ioce        : out std_logic        -- I/O chip enable, active high if RAM's semaphores are addressed
    );
end addr_decoder;

architecture Behavioral of addr_decoder is

begin

    -- Process to generate RAM address bus
    addr_ram <= addr_isa(C_RAM_ADDR_SIZE - 1 downto 0);
    
    -- Process that decodes ISA address. Checks if RAM or RAM's semaphores are addressed.
    P1 : process(rst, iord_n, iowr_n, memrd_n, memwr_n, addr_isa)
		variable tmp  	: unsigned(C_RAM_ADDR_SIZE - 1 downto 0);
        variable tmp1 	: unsigned(C_ISA_ADDR_SIZE - 1 downto C_RAM_ADDR_SIZE);
        variable tmp2 	: unsigned(C_ISA_ADDR_SIZE - 1 downto C_RAM_ADDR_SIZE);
    begin
		tmp 	:= unsigned(addr_isa(C_RAM_ADDR_SIZE - 1 downto 0));
		tmp1 	:= unsigned(addr_isa(C_ISA_ADDR_SIZE - 1 downto C_RAM_ADDR_SIZE));
		tmp2 	:= C_BASE_ADDR(C_ISA_ADDR_SIZE - 1 downto C_RAM_ADDR_SIZE);
		
        if (rst = '1') or (tmp1 /= tmp2) then
            -- Reset state
            memce <= '0';
            ioce <= '0';
            intA <= '0';
            intB <= '0';
        else
            -- Check memory or I/O operation based on the address range
            if memrd_n = '0' or memwr_n = '0' then
                if tmp >= unsigned(C_RAM_START) and tmp <= unsigned(C_RAM_END) then
                    memce <= '1';
                    ioce <= '0';
                    intA <= '0';
                    intB <= '0';
                elsif tmp = unsigned(C_INT_A) then
                    memce <= '0';
                    ioce <= '0';
                    intA <= '1';
                    intB <= '0';
                elsif tmp = unsigned(C_INT_B) then
                    memce <= '0';
                    ioce <= '0';
                    intA <= '0';
                    intB <= '1';
                else
                    -- Default state if address doesn't match any range
                    memce <= '0';
                    ioce <= '0';
                    intA <= '0';
                    intB <= '0';
                end if;
            elsif iord_n = '0' or iowr_n = '0' then
                intA <= '0';
                intB <= '0';
                if tmp >= unsigned(C_SEM_START) and tmp <= unsigned(C_SEM_END) then
                    memce <= '0';
                    ioce <= '1';
                else
                    -- Default state if address doesn't match any range
                    memce <= '0';
                    ioce <= '0';
                end if;
            else
                -- Default state for other conditions
                memce <= '0';
                ioce <= '0';
                intA <= '0';
                intB <= '0';
            end if;
        end if;
    end process;

end Behavioral;
