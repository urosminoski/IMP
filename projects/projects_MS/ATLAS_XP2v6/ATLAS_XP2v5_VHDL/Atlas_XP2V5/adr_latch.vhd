----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:15:55 07/28/2008 
-- Design Name: 
-- Module Name:    adr_latch - Behavioral 
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

entity adr_latch is
    Port ( address_isa : in  STD_LOGIC_VECTOR (23 downto 0);
           ale : in  STD_LOGIC;
           adr_latched : out  STD_LOGIC_VECTOR (23 downto 0));
end adr_latch;

architecture Behavioral of adr_latch is

begin
	process (address_isa,ale)
	begin
	
	if falling_edge (ale) then
		adr_latched <= address_isa;
	end if;
	
	end process;
	

end Behavioral; 

