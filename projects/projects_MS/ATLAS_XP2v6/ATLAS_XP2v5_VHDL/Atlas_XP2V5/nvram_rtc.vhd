----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:13:34 10/24/2008 
-- Design Name: 
-- Module Name:    nvram_rtc - Behavioral 
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
----------------------------------SREDITI ADRESE(da liukljuciti LA23..20)!!!!!!!!!!!!!!!!!!!---------------------
entity nvram_rtc is
    Port ( 
			  clk : in STD_LOGIC;
			  reset : in STD_LOGIC;
			  smemr : in STD_LOGIC;
			  smemw : in STD_LOGIC;
			  iord : in STD_LOGIC;
			  iowr : in STD_LOGIC;
--			  base_addr_jp : in  STD_LOGIC_VECTOR (1 downto 0);
           nvram_ce : out  STD_LOGIC;
           nvram_we : out  STD_LOGIC;
           nvram_oe : out  STD_LOGIC;
           nvram_cs : out  STD_LOGIC;
			  aen : in STD_LOGIC;
			  address_isa_latched : in  STD_LOGIC_VECTOR (23 downto 0);			--adr_isa_latched(1 downto 0)
			  data_cpu2nvram: in STD_LOGIC_VECTOR (7 downto 0);
			  data_nvram2cpu : out STD_LOGIC_VECTOR (7 downto 0);
           mode_register : in STD_LOGIC_VECTOR (7 downto 0);		--|linear|paged|test_mode|rsvd|decode|mem_sel..1|
			  page_register : in STD_LOGIC_VECTOR (7 downto 0);		--|rsvd|rsvd|page_select5..0|
			  nvram_address: out  STD_LOGIC_VECTOR (20 downto 0);		--jumper_reg : |rsvd|rsvd|jp5|jp4|rsvd|jp2|jp1|rsvd|
           nvram_data : inout  STD_LOGIC_VECTOR (7 downto 0);
--			  base_address_io : out STD_LOGIC_VECTOR (11 downto 0);
--			  base_address_ram : out STD_LOGIC_VECTOR (23 downto 0);
--			  nvram_irq : in  STD_LOGIC;									-- vezati na IRQ ulaz CPU-a
           nvram_rst : in  STD_LOGIC;
			  test_nvram : out STD_LOGIC;
			  base_address_rtc_registers : in STD_LOGIC_VECTOR (23 downto 0)
			  );
end nvram_rtc;

architecture Behavioral of nvram_rtc is

	signal base_address_ram_sig : STD_LOGIC_VECTOR (23 downto 0);
	signal nvram_ce_sig : STD_LOGIC;
	signal nvram_we_sig : STD_LOGIC;
	signal nvram_oe_sig : STD_LOGIC;
	signal nvram_cs_sig : STD_LOGIC;
--	signal counter_en : STD_LOGIC;
--	signal counter : STD_LOGIC_VECTOR (1 downto 0);
--	signal nvram_data_buffer : STD_LOGIC_VECTOR (7 downto 0);
	signal nvram_data_out_gate : STD_LOGIC;
	signal nvram_data_out_gate_delay : STD_LOGIC;
	signal nvram_data_out_gate_en : STD_LOGIC;
	
begin
	
	
	
--	set_base_address_io : process (base_addr_jp)
--	begin
--		
--			case base_addr_jp is
--				when "11" => base_address_io <= x"140";
--				when "10" => base_address_io <= x"148";
--				when "01" => base_address_io <= x"160";
--				when "00" => base_address_io <= x"168";
--				when others => base_address_io <= x"140";
--			end case;
--	
--	end process;
	
	set_base_address_ram : process (mode_register)
	begin
		if (mode_register(7 downto 3) = "01000") then
			case mode_register(2 downto 0) is
				when "000" => base_address_ram_sig <= x"0A0000";
				when "001" => base_address_ram_sig <= x"0A8000";
				when "010" => base_address_ram_sig<= x"0B0000";
				when "011" => base_address_ram_sig <= x"0B8000";
				when "100" => base_address_ram_sig <= x"0C0000";
				when "101" => base_address_ram_sig <= x"0C8000";
				when "110" => base_address_ram_sig <= x"0D0000";
				when "111" => base_address_ram_sig <= x"0D8000";
				when others => base_address_ram_sig <= x"0D0000";
			end case;
			
		else	
			base_address_ram_sig <= x"FFFFFF";			--dok stanica ne upise podatak u mode_register(inicijalno je on 0x00)
		end if;													--ne dozvoljava pristup nvram-u
	end process;
	
	
	
	
--------------------------------------------------------
-- generisanje kontrolnih signala
--------------------------------------------------------
	
	set_ctrl_signals_NVRAM_rtc : process (nvram_ce_sig,nvram_cs_sig,smemw,smemr,iord,iowr)		--proveriti osciloskopom
	begin
		
		if (nvram_cs_sig = '0' and nvram_ce_sig = '1') then					--RTC selected
			nvram_we_sig <= iowr;
			nvram_oe_sig <= iord;												
		elsif (nvram_cs_sig = '1' and nvram_ce_sig = '0') then				--NVRAM selected	
			nvram_we_sig <= smemw;
			nvram_oe_sig <= smemr;
		else
			nvram_we_sig <= '1';
			nvram_oe_sig <= '1';
		end if;	
			--ako je selektovan RTC	
--			nvram_we_sig <= (not(nvram_cs_sig) and nvram_ce_sig and iowr) or (nvram_cs_sig and not(nvram_ce_sig) and smemw);
--		   nvram_oe_sig <= (not(nvram_cs_sig) and nvram_ce_sig and iord) or (nvram_cs_sig and not(nvram_ce_sig) and smemr);
			
--			nvram_we_sig <= nvram_cs_sig and not(nvram_ce_sig) and smemw;
--			nvram_oe_sig <= nvram_cs_sig and not(nvram_ce_sig) and smemr;
	end process;
	
-------------------------------------------------------------------------------
--NVRAM select
-------------------------------------------------------------------------------	
	NVRAM_select: process (address_isa_latched,base_address_ram_sig,aen,reset)
	begin
		if (address_isa_latched (23 downto 15) = base_address_ram_sig (23 downto 15) and aen = '0' and reset = '0') then 
																								--ovde valjda ide DMA prenos
			nvram_ce_sig <= '0';		--aktivan na 0
		else
			nvram_ce_sig <= '1';	
		end if;
		
	end process;


	
-------------------------------------------------------------------------------------
--- RTC SELECT
---------------------------------------------------------------------------
	
	rtc_select : process(address_isa_latched,aen,reset)
	begin
		if (address_isa_latched(23 downto 4) = base_address_rtc_registers(23 downto 4) and aen = '0' and reset = '0') then     --ovde ide nomalan IO transfer
			nvram_cs_sig <= '0';		--videti opseg adresa u I/O prostoru za RTC	
		else
			nvram_cs_sig <= '1';	
		end if;
	end process;
-----------------------------------------------------------------
---generisanje adrese za RTC read/write  i za NVRAM read/write
-----------------------------------------------------------------
--ako je selektovan RTC bitne su samo adrese a3..a0 (16 adresa),uzecemo 0x150..0x15F u I/O prostoru
	set_rtc_NVRAM_address : process (nvram_cs_sig, nvram_ce_sig, address_isa_latched,page_register)
	begin
		if (nvram_cs_sig = '0' and nvram_ce_sig = '1') then					
			nvram_address(19 downto 0) <= address_isa_latched(19 downto 0);												
		elsif (nvram_cs_sig = '1' and nvram_ce_sig = '0') then					
			nvram_address(20 downto 15) <= page_register (5 downto 0);
			nvram_address(14 downto 0) <= address_isa_latched (14 downto 0);
		else
			nvram_address <= (others => 'Z');
		end if;																				
	end process;

--------------------------------------------------------------
---slanje podatka procitanog iz NVRAM/RTC-a ka CPU
---------------------------------------------------------------

	process (nvram_cs_sig,nvram_ce_sig,nvram_oe_sig,nvram_data)
	begin
		if ((nvram_cs_sig = '0' or nvram_ce_sig = '0') and nvram_oe_sig = '0') then
					data_nvram2cpu <= nvram_data; 
		else
			data_nvram2cpu <= (others => 'Z');
		end if;
	end process;
	
-------------------------------------------------------------
---slanje podatka koji treba da upise CPU ka NVRAM/RTC-u
-------------------------------------------------------------

	process (clk,nvram_cs_sig,nvram_ce_sig,nvram_we_sig, data_cpu2nvram)
	begin
	  if rising_edge(clk) then
			if ((nvram_cs_sig = '0' or nvram_ce_sig = '0') and nvram_we_sig = '0') then
					nvram_data_out_gate <= '0';			
				nvram_data <= data_cpu2nvram; 
			else
				nvram_data <= (others => 'Z');
				nvram_data_out_gate <= '1';
			end if;
		end if;
	end process;

--	process (clk,nvram_data_out_gate)
--	begin
--		if rising_edge(clk) then
--			nvram_data_out_gate_delay <= nvram_data_out_gate;
--		end if;
--	end process;
--	
--	process(nvram_data_out_gate, nvram_data_out_gate_delay)
--	begin
--		nvram_data_out_gate_en <= nvram_data_out_gate and nvram_data_out_gate_delay;
--	end process;
--	
--	process(nvram_data_out_gate_en, data_cpu2nvram)
--	begin
--		if (nvram_data_out_gate_en = '0') then
--			nvram_data <= data_cpu2nvram;
--		else
--			nvram_data <= (others => 'Z');
--		end if;
--	end process;
	
	test_nvram <= nvram_data_out_gate_en;
--   process (nvram_we_sig)
--	begin
--		if rising_edge(nvram_we_sig) then
--			counter_en <= '1';
--		end if;
--	end process;
--	
--	process (clk,counter_en)
--	begin
--		if rising_edge(clk) then
--			if (counter_en = '1') then
--				counter <= counter + 1;
--			else
--			 counter <= "00";
--			end if;
--		end if;
--	end process;

--------------------------------------------
---output signals
---------------------------------------------
		
		
		nvram_we <= nvram_we_sig ;
		nvram_oe <= nvram_oe_sig;
		nvram_cs <= nvram_cs_sig;
		nvram_ce <= nvram_ce_sig;
--		base_address_ram <= base_address_ram_sig;

end Behavioral;

