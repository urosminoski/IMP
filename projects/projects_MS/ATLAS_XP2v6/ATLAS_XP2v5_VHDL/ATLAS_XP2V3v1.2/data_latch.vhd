----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:15:59 09/09/2008 
-- Design Name: 
-- Module Name:    data_latch - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity data_latch is
    Port ( data_isa : in  STD_LOGIC_VECTOR (15 downto 0);
           load_data_isa : in  STD_LOGIC;
           data_isa_latched : out  STD_LOGIC_VECTOR (15 downto 0));
end data_latch;

architecture Behavioral of data_latch is


begin
	
	process (data_isa,load_data_isa)
	begin
	
	if rising_edge (load_data_isa) then
		data_isa_latched <= data_isa;
	end if;
	
	end process;

end Behavioral;

