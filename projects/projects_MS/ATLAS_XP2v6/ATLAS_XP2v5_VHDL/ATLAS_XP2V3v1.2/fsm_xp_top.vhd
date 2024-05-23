----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:22:25 08/28/2008 
-- Design Name: 
-- Module Name:    fsm_xp_top - Behavioral 
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
--promene: mart 2013. - ispravljen ucf file sto se tice adresa 19 i 20
-- 10.07.2013 - dodata mogucnost paljenja i gasenja KVR diode kada je uredjaj slave
--01.02.2017. - izmenjena logika master/slave da bi u slucaju paljenja red. modula master radio bez smetnji
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
 
entity fsm_xp_top is   
    Port (  
			  address_isa : in  STD_LOGIC_VECTOR (23 downto 0);
			  --adr_latched :  inout STD_LOGIC_VECTOR (23 downto 0);		--test
           data_isa : inout  STD_LOGIC_VECTOR (15 downto 0);
           clk : in  STD_LOGIC;
           iowr : in  STD_LOGIC;
           iord : in  STD_LOGIC; 
           ale : in  STD_LOGIC;
			  aen : in  STD_LOGIC;
			  cw6 : in  STD_LOGIC;											--adresa PTA
			  cw7 : in  STD_LOGIC;											--kljuc W/C
			  base_addr_jp : in  STD_LOGIC_VECTOR (1 downto 0);
--			  ms_in : in  STD_LOGIC;
--			  xp_present_in : in  STD_LOGIC;
--			  wdt_out : inout  STD_LOGIC;
			  cs : inout STD_LOGIC;											--test
           address_max : inout  STD_LOGIC_VECTOR (7 downto 0);
           data_max : inout  STD_LOGIC_VECTOR (15 downto 0);
			  xp_address : in  STD_LOGIC_VECTOR (7 downto 0);	--xp_present_in | ms_in | a5..a0
			  master_enable : inout STD_LOGIC:='1';					
			  iocs16 : out  STD_LOGIC;
			  mrst : out  STD_LOGIC;
           reset : in  STD_LOGIC;			--ovo bi trebalo da bude sa CPU-a reset_drv
			  pwr_good_tps : in  STD_LOGIC;
           bale : inout STD_LOGIC;
			  bwr : inout  STD_LOGIC;
			  brd : inout  STD_LOGIC;
			  write_wdt_en : inout STD_LOGIC;	--test	
			  rst_taster : in STD_LOGIC;
			  test2 : inout STD_LOGIC;
			  data_out_enable : inout STD_LOGIC;
			  --load_data : inout STD_LOGIC;
			  load_buffer : inout STD_LOGIC;
--			  load_address : inout STD_LOGIC;
			  led_kvr : inout STD_LOGIC;
			  led_rad : inout STD_LOGIC;
			  led_lpt : out STD_LOGIC:='1';
			  led_wdt : out STD_LOGIC;
			  led_master_enable : out STD_LOGIC;
			  led_pwr_good_tps : out STD_LOGIC;
			  reset_CPU : inout STD_LOGIC;
			  direction_245 : out STD_LOGIC;
			  wdt_trg : out STD_LOGIC;
			  wdt_out_stari : in STD_LOGIC; --kada se koristi 123-ka za WDT
			  wdt_sig_stari : in STD_LOGIC; --kada se koristi 123-ka za WDT
			  smemr : in STD_LOGIC;
			  smemw : in STD_LOGIC;
           nvram_ce : out  STD_LOGIC;
           nvram_we : out  STD_LOGIC;
           nvram_oe : out  STD_LOGIC;
           nvram_cs : out  STD_LOGIC;
			  nvram_address: out  STD_LOGIC_VECTOR (20 downto 0);		
           nvram_data : inout  STD_LOGIC_VECTOR (7 downto 0);
--			  nvram_irq : in  STD_LOGIC;									
           nvram_rst : in  STD_LOGIC;
			  iq_i_syn : in  STD_LOGIC;
			  iq_o_syn : out STD_LOGIC;
--			  nvram_irq_cpu : out STD_LOGIC;
			  power_supply_24V: in STD_LOGIC;	
			  rst_dof_dsbl : in STD_LOGIC
			  );
end fsm_xp_top; 
 
architecture Behavioral of fsm_xp_top is
	
	
	signal reg_wr : STD_LOGIC;
	signal temp : STD_LOGIC;
	signal reg_rd : STD_LOGIC;
	signal bwr1 : STD_LOGIC;
	signal brd1 : STD_LOGIC;
	signal bale1 : STD_LOGIC;
	signal master_enable_previous_value : STD_LOGIC;
	signal master_enable_sig : STD_LOGIC;
	signal master_enable1 : STD_LOGIC;
	signal master_enable2 : STD_LOGIC:='1';
	signal data_max_reg : STD_LOGIC_VECTOR (15 downto 0);
	signal address_max_fsm : STD_LOGIC_VECTOR (7 downto 0);
	signal data_max_reg_in : STD_LOGIC_VECTOR (15 downto 0);
	signal data_isa_latched : STD_LOGIC_VECTOR (15 downto 0);
	signal read_300h : STD_LOGIC;
	signal read_303h : STD_LOGIC;
	signal read_304h : STD_LOGIC;
	signal read_304h_1 : STD_LOGIC;
	signal read_305h : STD_LOGIC;
	signal read_306h : STD_LOGIC;
	signal read_307h : STD_LOGIC;
	signal wdt_trigger : STD_LOGIC; 
	signal test_sig : STD_LOGIC;
	signal test_sig1 : STD_LOGIC;
	signal adr_latched : STD_LOGIC_VECTOR (23 downto 0);
	signal read_data_at_adr : STD_LOGIC_VECTOR (3 downto 0);
	signal ms_in : STD_LOGIC;
	signal xp_present_in : STD_LOGIC;
	constant const_303h : STD_LOGIC_VECTOR (15 downto 0) := x"FFC0";
	constant const_307h : STD_LOGIC_VECTOR (15 downto 0) := x"FF98";
	constant mmv_200ms : STD_LOGIC_VECTOR (1 downto 0) := "00";
	constant mmv_500ms : STD_LOGIC_VECTOR (1 downto 0) := "01";
	signal reg_306h : STD_LOGIC_VECTOR (15 downto 0);
	signal xp_address_reg : STD_LOGIC_VECTOR (15 downto 0);
	signal led_kvr_sig : STD_LOGIC;
	signal led_rad_sig : STD_LOGIC;
	signal write_lpt_en : STD_LOGIC;
	
	signal wdt_timeout : STD_LOGIC;
	signal wdt_first : STD_LOGIC;
	signal wdt_first_neg : STD_LOGIC;
	signal wdt_enable : STD_LOGIC;
	signal mmv2_enable : STD_LOGIC;
	
	signal base_address_nvram_registers : STD_LOGIC_VECTOR (23 downto 0);
	signal base_address_rtc_registers : STD_LOGIC_VECTOR (23 downto 0);
--	signal data_cpu2nvram : STD_LOGIC_VECTOR (7 downto 0);
	signal data_nvram2cpu : STD_LOGIC_VECTOR (7 downto 0);
	signal nvram_ce_sig : STD_LOGIC;
	signal nvram_we_sig : STD_LOGIC;
	signal nvram_oe_sig : STD_LOGIC;
	signal nvram_cs_sig : STD_LOGIC;
	signal id1_register_sel : STD_LOGIC;   --base+0
	signal id2_register_sel : STD_LOGIC;	--base+1
	signal led_register_sel : STD_LOGIC;	--base+3
	signal page_register_sel : STD_LOGIC;	--base+4
	signal mode_register_sel : STD_LOGIC;	--base+5
	signal jumper_register_sel : STD_LOGIC;--base+6
--	signal rst_register_sel : STD_LOGIC;	--base+7
	
	signal read_id1_register : STD_LOGIC;
	signal read_id2_register : STD_LOGIC;
	signal read_led_register : STD_LOGIC;
	signal read_page_register : STD_LOGIC;
	signal read_mode_register : STD_LOGIC;
	signal read_jumper_register : STD_LOGIC;
	signal read_rst_register : STD_LOGIC;
	signal write_page_register : STD_LOGIC;
	signal write_mode_register : STD_LOGIC;
	
	signal page_register : STD_LOGIC_VECTOR (7 downto 0);
	signal mode_register : STD_LOGIC_VECTOR (7 downto 0);
	signal rst_register : STD_LOGIC_VECTOR (7 downto 0);
	signal test3 : STD_LOGIC;
	signal reset_sig : STD_LOGIC;
	
	signal wdt_trg_sig : STD_LOGIC;
	signal wdt_out : STD_LOGIC;
	signal reset_CPU_sig : STD_LOGIC;
	signal load_data : STD_LOGIC;
	signal force_master : STD_LOGIC;
	signal master_enable2_previous : STD_LOGIC:='1';
	signal test_nvram_sig : STD_LOGIC;
	signal load_address : STD_LOGIC;
	component fsm_xp
		Port ( clk : in  STD_LOGIC;
				  rst : in  STD_LOGIC;
				  reg_wr : in  STD_LOGIC; 
				  reg_rd : in  STD_LOGIC;
				  address_latched_low : in STD_LOGIC_VECTOR (3 downto 0);
				  address_max : in STD_LOGIC_VECTOR (7 downto 0);			  
				  brd : inout STD_LOGIC;
				  bwr : inout STD_LOGIC;
				  bale : inout STD_LOGIC;
				  write_wdt_en : inout STD_LOGIC;
				  write_lpt_en : inout STD_LOGIC;
				  data_out_enable : inout STD_LOGIC;
				  load_data : inout STD_LOGIC;
				  load_buffer : inout STD_LOGIC;
				  load_address : inout STD_LOGIC;
				  wdt_trg : inout STD_LOGIC;
				  led_kvr : inout STD_LOGIC
				  
--				  wdt_en : inout STD_LOGIC
				  );
	end component;			  
	
	component adr_latch 
   Port (
			  address_isa : in  STD_LOGIC_VECTOR (23 downto 0);
           ale : in  STD_LOGIC;
           adr_latched : out  STD_LOGIC_VECTOR (23 downto 0)
			);
	end component;
	
	component data_latch
	Port ( data_isa : in  STD_LOGIC_VECTOR (15 downto 0);
          load_data_isa : in  STD_LOGIC;
          data_isa_latched : out  STD_LOGIC_VECTOR (15 downto 0));
	end component;
	
	component mmv 
	Port (  
			  trigger : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  wdt_enable : in STD_LOGIC;
			  quasi_length_type : in STD_LOGIC_VECTOR (1 downto 0);
			  q : out  STD_LOGIC
			  );
	end component;
	
	component nvram_rtc
    Port ( 
			  clk : in STD_LOGIC;			  
			  reset : in STD_LOGIC;
			  smemr : in STD_LOGIC;
			  smemw : in STD_LOGIC;
			  iord : in STD_LOGIC;
			  iowr : in STD_LOGIC;
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
--			  nvram_irq : in  STD_LOGIC;									
           nvram_rst : in  STD_LOGIC;
			  test_nvram : out STD_LOGIC;
			  base_address_rtc_registers : in STD_LOGIC_VECTOR (23 downto 0)
			  );
end component;
	
	begin
	
	P1: process (clk,iord, cs, aen, iowr)
		
	
		begin
			if rising_edge(clk) then
					reg_rd <=  cs and not(aen) and not(iord);
					reg_wr <=  cs and not(aen) and not(iowr);
			end if;
		end process;
	
	
	

	P2 : process (adr_latched,cw6,ale)
		begin
			

				if (((adr_latched(23 downto 4) = x"00030")  and (cw6 = '1') and (ale = '0'))
					or ((adr_latched(23 downto 4) = x"00031")  and (cw6 = '0') and (ale = '0'))) then
					cs <= '1';
				else
					cs <= '0';
				end if;


		end process; 


  
 
	
	I1 : adr_latch	
			PORT MAP (
				address_isa => address_isa,
				ale => ale,
				adr_latched => adr_latched
		  );	
	
	  
	
	I2 : fsm_xp	 
			PORT MAP (
				clk => clk, 
				rst => reset_sig,
				reg_wr => reg_wr,
				reg_rd => reg_rd,
				address_latched_low => adr_latched(3 downto 0), --treba staviti address_latched (3 downto 0)
				address_max => address_max_fsm, --promenjeno sa address_max
				brd => brd1,
				bwr => bwr1,
				bale => bale1,
				write_wdt_en => write_wdt_en,
				write_lpt_en => write_lpt_en,
				data_out_enable => data_out_enable,
				load_data => load_data,
				load_buffer => load_buffer,
				load_address => load_address,
				wdt_trg => wdt_trg_sig,
				led_kvr => led_kvr_sig
				
--				wdt_en => wdt_en	
		  );
		  
		  
	I3: data_latch
			PORT MAP(
				data_isa => data_isa,
				load_data_isa => reg_wr,
				data_isa_latched => data_isa_latched
			
			);
	
--	I4 : mmv
--			PORT MAP(
--			trigger => wdt_trigger,		--ili wdt_trg_sig za konfiguraciju sa  HCT123
--			clk => clk,
--			wdt_enable => '1',
--			quasi_length_type => "01",
--			q => wdt_first
--			);	
--			
--	I5 : mmv
--			PORT MAP(
--			trigger => wdt_first_neg,
--			clk => clk,
--			wdt_enable => '1', 
--			quasi_length_type => "10",
--			q => wdt_timeout
--			);		
			
			wdt_timeout <= '1';
			
	I6 : nvram_rtc
			PORT MAP(
			clk => clk,
			reset => reset,
			smemr => smemr,
			smemw => smemw,
			iord => iord,
			iowr => iowr,
         nvram_ce => nvram_ce_sig,
         nvram_we => nvram_we_sig,
         nvram_oe => nvram_oe_sig,
         nvram_cs => nvram_cs_sig,
			aen => aen,
			address_isa_latched => address_isa,			
			data_cpu2nvram => data_isa(7 downto 0),
			data_nvram2cpu => data_isa(7 downto 0),
         mode_register => mode_register,		
			page_register => page_register,	
			nvram_address => nvram_address,		
         nvram_data => nvram_data,
--			nvram_irq => nvram_irq,									
         nvram_rst => nvram_rst,
			test_nvram => test_nvram_sig,
			base_address_rtc_registers => base_address_rtc_registers
			);
			
			nvram_we <= nvram_we_sig;
			nvram_oe <= nvram_oe_sig;
			nvram_cs <= nvram_cs_sig;
			nvram_ce <= nvram_ce_sig;
--			data_isa (7 downto 0) <= data_nvram2cpu; 	

--		read_NVRAM : process (nvram_cs_sig,nvram_ce_sig,nvram_oe_sig,data_nvram2cpu)
--		begin
--			if ((nvram_cs_sig = '0' or nvram_ce_sig = '0') and nvram_oe_sig = '0') then
--						data_isa (7 downto 0) <= data_nvram2cpu; 
--			else
--				data_isa (7 downto 0) <= (others => 'Z');
--			end if;
--		end process;

			
	P3 : process(load_data, master_enable_sig, bwr1, brd1, bale1)						--ovde treba ubaciti uslov za ms_out
	begin
		if master_enable_sig = '0' then						--bilo master_enable = '0'
			if rising_edge (load_data) then
				data_max_reg <= data_isa_latched;
			end if;
			brd <= brd1;
			bwr <= bwr1;
			bale <= bale1;
		else
--			data_max <= (others => 'Z');
			brd <= 'Z';
			bwr <= 'Z';
			bale <= 'Z';
		end if;
	end process;
	

	  
	
	master_enable_previous_value <= master_enable;
--	test1 <= base_addr_jp(0) and nvram_irq;--NVRAM_reset;-- wdt_enable;			--read_303h or read_304h or read_307h;
--	test2 <= base_addr_jp(1) and nvram_rst;--wdt_timeout and wdt_enable;
	test_sig <= not(read_307h);
	test_sig1 <= not (test_sig);
	reset_sig <= reset; --or not(nvram_rst);
	
	P4 : process(clk, ms_in,reset_sig,xp_present_in,wdt_out_stari)						--ovde treba ubaciti uslov za ms_out
	begin
		
		if rising_edge (clk) then
	--		master_enable <=  not((not(wdt_out or reset_sig) and ms_in) or (not(wdt_out or / or not(ms_in))and not(master_enable_previous_value)) or xp_present_in);
			master_enable1 <=  (not(xp_present_in) and (wdt_out_stari or not(ms_in) or reset_sig));--and (master_enable and force_master);--and not(master_enable_previous_value
			--master_enable1 <=  (not(xp_present_in) and (wdt_out_stari or not(ms_in)));-- or reset_sig));--and (master_enable and force_master);--and not(master_enable_previous_value
	--		master_enable1 <= master_enable and force_master;
		--	master_enable <= not(ms_in);
		end if;
	end process;
	
--	force_master_process : process (clk,force_master,ms_in)
--	begin
--		if rising_edge(clk) then
--				if (force_master = '0') then
--							master_enable2 <= '0';
--			--	end if;
--				
--				elsif (ms_in = '1' ) then
--							master_enable2 <= '1';			
--				else 
--					master_enable2 <= master_enable2; 
--				end if;
--			end if;
--	end process;
	
	process (clk)
	begin
		if rising_edge (clk) then
			master_enable2 <= ms_in or (master_enable2_previous and force_master);
		end if;
	end process;
	
	process (clk)
	begin
		if rising_edge (clk) then
			master_enable2_previous <= master_enable2;
		end if;
	end process;
	
	--master_enable2 <= ms_in or force_master;
	master_enable_sig <= master_enable1 and master_enable2;
	master_enable <= master_enable_sig;
--	process(master_enable_sig)
--	 begin
--		 if (master_enable_sig = '0') then
--			master_enable <= '0';
--		 else
--			master_enable <= 'Z';	 
--		 end if;
--	 end process;
	
--	ms_out.d = !((!(wdt_out # res_drv) & ms_in) # (!(wdt_out # res_drv # !ms_in )) & !ms_out.q # pta_prs_in) ;   
	
	P5 : process (master_enable_sig,data_out_enable,data_max_reg)
	begin
	 
		if (master_enable_sig = '0' and data_out_enable = '0') then		--bilo master_enable_sig = '0'
			data_max <= data_max_reg;
		else
			data_max <= (others => 'Z');
			
		end if;
		
	end process;

	P6 : process (master_enable_sig,load_address,data_isa_latched)				--ubaciti uslov za inc_addr!!!!!!
	begin 
		
		if (master_enable_sig = '0') then												--bilo master_enable = '0'
		
			if rising_edge (load_address) then
				address_max <= data_isa_latched(7 downto 0);
			end if;
		
		else
				address_max <= (others => 'Z');
		end if;	
	
	end process;

--
process (load_address)
begin
	if (load_address = '1') then 
		address_max_fsm <= data_isa_latched(7 downto 0);
	end if;
end process;
	
--

	P7 : process (load_buffer,data_max)
	begin
		--test1 <= '0';
		if rising_edge(load_buffer) then
			if (address_max = x"00" ) then
						data_max_reg_in <= x"FFFE";
			else
				data_max_reg_in <= data_max;
				--test1 <= '1';
			end if;
		end if;
	end process;
	
	P8 : process (read_300h,data_max_reg_in)		--ubaciti uslov za bd.oe -- dodato u verziji 1.2
	begin
--			if rising_edge (clk) then
				if (read_300h = '1') then
				
					data_isa <= data_max_reg_in;
--					test1 <= '1';	
				elsif (read_300h = '0') then
					data_isa <= (others => 'Z');
--					test1 <= '0';	
				end if;
--			end if;
	end process;

 
	P9 : process (reg_rd, adr_latched(3 downto 0),wdt_enable)  --dodatu u ver 1.2
	begin 
		 
--		 if ((reg_rd = '1') and (adr_latched(3 downto 0) = x"00")) then
--					read_data_at_adr <= x"0";
----					test1 <= '1';
--		 else
--			--		read_data_at_adr <= (others => 'Z');
----					test1 <= '0';
--		 end if;
--		 if rising_edge (clk) then
			 
			 if ((reg_rd = '1') and (adr_latched(3 downto 0) = x"00")) then
						read_300h <= '1';

			 else
					read_300h <= '0';
	
			 end if;
			 
			 if ((reg_rd = '1') and (adr_latched(3 downto 0) = x"03")) then
						read_303h <= '1';

			 else
					read_303h <= '0';
	
			 end if;
			
			 if ((reg_rd = '1') and (adr_latched(3 downto 0) = x"07")) then
						read_307h <= '1';
			 else
						read_307h <= '0';
		
			 end if;
			 
			 if ((reg_rd = '1') and (adr_latched(3 downto 0) = x"04")) then
						read_304h <= '1';
						read_304h_1 <= '1';
			 else
						read_304h <= '0';
						read_304h_1 <= '0';
		
			 end if;
			 
			 if ((reg_rd = '1') and (adr_latched(3 downto 0) = x"05")) then
						read_305h <= '1';
			 else
						read_305h <= '0';
		
			 end if;
			 
			 if ((reg_rd = '1') and (adr_latched(3 downto 0) = x"06")) then
						read_306h <= '1';
			 else
						read_306h <= '0';
		
			 end if;
			 
			 if ((reg_rd = '1') and (adr_latched(3 downto 0) = x"09") and wdt_enable = '1') then
						wdt_trigger <= '1';
			 else
						wdt_trigger <= '0';
		
			 end if;
			 
			 if ((reg_rd = '1') and (adr_latched(3 downto 0) = x"0F")) then
						force_master <= '0';
			 else
						force_master <= '1';
		
--			 end if;
			 
			 end if;		 
		
	end process;
--		
--	P9a : process(cs,iowr,iord,adr_latched(3 downto 0))  --u ABEL-u nije uzet u obzir aen signal
--	begin
--	if (((cs = '1') and (iowr = '0') and adr_latched(3 downto 0) = x"00") or ((cs = '1') and (iord = '0') and adr_latched(3 downto 0) = x"00")) then
--			iocs16 <= '0';
--		else
--			iocs16 <= '1';
--		end if;
--   end process;	
	
	P9a : process(cs,iowr,iord,adr_latched(3 downto 0))  --u ABEL-u nije uzet u obzir aen signal
	begin
	if (((cs = '1') and (iowr = '0')) or ((cs = '1') and (iord = '0'))) then
			if ((adr_latched(3 downto 0) = x"00") or (adr_latched(3 downto 0) = x"04")) then
				iocs16 <= '0';
			else
				iocs16 <= '1';
			end if;
	else
		iocs16 <= '1';
	end if;		
   end process;	
	
	P10 : process (read_303h)					--ubaciti uslov za bd.oe --dodat clk u ver 1.2
	begin
--		if rising_edge (clk) then
			if (read_303h = '1') then
				data_isa <= const_303h;	
			elsif (read_303h = '0') then
				data_isa <= (others => 'Z');
			end if;
--		end if;
	end process;
		

	P11 : process (read_307h)					--ubaciti uslov za bd.oe --dodat clk u ver 1.2
	begin
--	if rising_edge (clk) then
				if (read_307h = '1') then
					data_isa <= const_307h;	
				elsif (read_307h = '0') then
					data_isa <= (others => 'Z'); 
				end if;
--   end if;
	end process; 

	P12 : process (read_304h,xp_address)					--ubaciti uslov za bd.oe --dodat clk u ver 1.2
	begin
--		if rising_edge (clk) then
				if (read_304h = '1') then
					data_isa (7 downto 0) <= xp_address;
					data_isa (8) <= power_supply_24V;					
					data_isa(15 downto 9) <= (others => 'Z');
				elsif (read_304h = '0') then
					data_isa <= (others => 'Z'); 
				end if;
--		end if;
	end process; 
	
--	P122 : process (read_304h_1)					--ubaciti uslov za bd.oe
--	begin
----		if rising_edge (clk) then
--				if (read_304h_1 = '1') then
--					data_isa (7 downto 0) <= xp_address;
--					data_isa(15 downto 8) <= (others => 'Z');
--				elsif (read_304h_1 = '0') then
--					data_isa <= (others => 'Z'); 
--				end if;
----		end if;
--	end process; 
	
--	
	P12a : process (read_305h,wdt_enable)					--ubaciti uslov za bd.oe  --dodat clk u ver 1.2
	begin
--		if rising_edge (clk) then
				if (read_305h = '1') then
					data_isa(0) <= wdt_enable;
					data_isa(7 downto 1) <= "0000000";
				elsif (read_305h = '0') then
					data_isa <= (others => 'Z'); 
				end if;
--		end if;
	end process; 
	
	P12b : process (read_306h)    ----dodat clk u ver 1.2
	begin
--		if rising_edge (clk) then
			if (read_306h = '1') then
				data_isa <= reg_306h;
			elsif (read_306h = '0') then
				data_isa <= (others => 'Z');  
			end if;
--		end if;
	end process;
	
	
	
	P13 : process (clk, xp_address)
	begin
		if rising_edge (clk) then
			xp_present_in <= xp_address(7);
			ms_in <= xp_address(6);
			xp_address_reg (15 downto 8) <= X"FF";--(others => 'Z');
			xp_address_reg (7 downto 0) <= xp_address; 
		end if;
	end process;

	P14 : process (cw7,cw6)
	begin
		reg_306h (15 downto 8) <= (others => 'Z');
		reg_306h (7) <= cw7;
		reg_306h (6) <= cw6; 
		reg_306h (5) <= '0';
		reg_306h (4) <= '0';
		reg_306h (3) <= '0';
		reg_306h (2) <= '0';
		reg_306h (1) <= '1';
		reg_306h (0) <= '0';
	end process;
	
----------------LEDOVKE-------------------------------------------------	
	
	P15 : process (clk,led_kvr_sig)
	begin
		if rising_edge (clk) then
			led_kvr <= not (led_kvr_sig);   
--			led_kvr <= led_kvr_sig; 
		end if;
	end process;
	
	P16 : process (bale1,led_rad_sig)
	begin
		if falling_edge (bale1) then
			led_rad_sig <= not(led_rad_sig);
		end if;
	end process; 
	
	P17 : process (clk,led_rad_sig, master_enable_sig)
	begin 
		if rising_edge (clk) then
			led_rad <= not(led_rad_sig) or master_enable_sig;
--			led_rad <= led_rad_sig and not(master_enable_sig);
--			led_rad <= led_rad_sig or master_enable;
		end if;
	end process;

	
	led_lpt_process : process (write_lpt_en,data_isa_latched)
	begin
		if rising_edge(write_lpt_en) then
				
				led_lpt <= not(data_isa_latched(3));
				
		end if;		
	end process;
	
	led_wdt_process : process (wdt_sig_stari)
	begin		
		led_wdt <= wdt_sig_stari;
--		led_wdt <= not(wdt_sig_stari);
	end process;
	
	led_master_enable_process : process (master_enable_sig)
	begin		
		led_master_enable <= master_enable_sig;
--		led_master_enable <= not(master_enable_sig);
	end process;
--	 
	led_pwr_good_tps_process : process (pwr_good_tps)
	begin		
		led_pwr_good_tps <= pwr_good_tps;
--		led_pwr_good_tps <= not(pwr_good_tps);
	end process;
--	
--	led_pwr_good_tps_process : process (test3)
--	begin		
--		led_pwr_good_tps <= test3 and not(pwr_good_tps) ;
--	end process;
		
----------------LEDOVKE-------------------------------------------------	
	
	wdt_enable_process : process (clk,write_wdt_en,data_isa_latched)
	begin
		if rising_edge(clk) then
				if (write_wdt_en = '1' and  data_isa_latched(0) = '1') then
							wdt_enable <= '1';
			--	end if;
				
				elsif (write_wdt_en = '1' and data_isa_latched(0) = '0' ) then
							wdt_enable <= '0';			
				else 
					wdt_enable <= wdt_enable; 
				end if;
			end if;
	end process;

	
	P18 : process (wdt_first,wdt_enable)
	begin
--		if rising_edge (clk) then
--			if (wdt_enable = '1') then
				wdt_first_neg <= not(wdt_first and wdt_enable) ;
--			end if;
--		end if;
--	
	end process; 
	
	--reset_CPU_process : process (wdt_out_stari,wdt_enable,nvram_rst)  --wdt_timeout zameniti sa wdt_out_stari rst_taster
	reset_CPU_process : process (wdt_out_stari,wdt_enable,nvram_rst,rst_taster)  --wdt_timeout zameniti sa wdt_out_stari rst_taster
	begin
--		reset_CPU <= not(wdt_timeout and wdt_enable);		--ovo je rst_CPU,aktivan na 0
--		wdt_out <= (wdt_timeout and wdt_enable);
		reset_CPU_sig <= not(wdt_out_stari and wdt_enable) and nvram_rst and rst_taster;		--sa nvram_rst
--		reset_CPU_sig <= not(wdt_out_stari and wdt_enable) ;		--bez nvram_rst
		wdt_out <= (wdt_out_stari and wdt_enable); --proveriti da li ima veze sa nvram_rst
	end process;


	 process(reset_CPU_sig)
	 begin
		 if (reset_CPU_sig = '0') then
			reset_CPU <= '0';
		 else
			reset_CPU <= 'Z';	 
		 end if;
	 end process;	

 
	process (rst_dof_dsbl,reset_CPU) --dodati jumper rst_dsbl umesto base_addr_jp!!!!!!!!!!
	begin	
	 if (rst_dof_dsbl = '1') then
			mrst <= reset_CPU;
	 else
			mrst <= '1';
	 end if;
	end process;
	
	
	set_base_address_nvram_registers : process (base_addr_jp)
	begin
		
			case base_addr_jp is
				when "11" => base_address_nvram_registers <= x"000140"; 
								 base_address_rtc_registers <= x"000150";	
				when "10" => base_address_nvram_registers <= x"000148";
								 base_address_rtc_registers <= x"000150";	
				when "01" => base_address_nvram_registers <= x"000160";
								 base_address_rtc_registers <= x"000170";
				when "00" => base_address_nvram_registers <= x"000168";
								 base_address_rtc_registers <= x"000170";	
				when others => base_address_nvram_registers <= x"000140";
								   base_address_rtc_registers <= x"000150";
			end case;
	
	end process;
 

	direction_245 <= not (data_out_enable);
	wdt_trg <= wdt_trg_sig;
	
	
--sinhronizacija PPS,PPM
	--iq_o_syn <= not(iq_i_syn);
	iq_o_syn <= not(iq_i_syn) and master_enable2;
	
--sinhronizacija PPS,PPM

--upisivanje i citanje registara za NVRAM(mode_register,page_register)
set_nvram_registers_adr : process (adr_latched,ale,base_address_nvram_registers)
		begin
			
	      if (ale = '0' and adr_latched = base_address_nvram_registers)	then
--			if (ale = '0' and adr_latched(23 downto 0) = x"000140")	then
				id1_register_sel <= '1';
--			   led_master_enable <= '0';
				test3 <= '0';
			else
				id1_register_sel <= '0';
--				led_master_enable <= '1';
				test3 <= '1';
			end if;	
			
		   if (ale = '0' and adr_latched = base_address_nvram_registers + x"1")	then
--			if (ale = '0' and adr_latched(8 downto 0) = "101000001")	then
				id2_register_sel <= '1';
			else
				id2_register_sel <= '0';
			end if;	
			
			if (ale = '0' and adr_latched = base_address_nvram_registers + x"3")	then
--			if (ale = '0' and adr_latched(8 downto 0) = "101000011")	then
				led_register_sel <= '1';
			else
				led_register_sel <= '0';
			end if;	
			
			if (ale = '0' and adr_latched = base_address_nvram_registers + x"4")	then
--			if (ale = '0' and adr_latched(8 downto 0) = "101000100")	then
				page_register_sel <= '1';
			else
				page_register_sel <= '0';
			end if;
			 
			if (ale = '0' and adr_latched = base_address_nvram_registers + x"5")	then
--			if (ale = '0' and adr_latched(8 downto 0) = "101000101")	then
				mode_register_sel <= '1';
				--test1 <= '1';
			else
				mode_register_sel <= '0'; 
				--test1 <= '0';
			end if;
			
			if (ale = '0' and adr_latched = base_address_nvram_registers + x"6")	then
--			if (ale = '0' and adr_latched(8 downto 0) = "101000101")	then
				jumper_register_sel <= '1';
				--test1 <= '1';
			else
				jumper_register_sel <= '0'; 
				--test1 <= '0';
			end if;
			
--			if (ale = '0' and adr_latched = base_address_nvram_registers + x"7")	then
--				rst_register_sel <= '1';
--				--test1 <= '1';
--			else
--				rst_register_sel <= '0'; 
--				--test1 <= '0';
--			end if;
			
		end process; 
   
--	test1 <= base_addr_jp(0) and nvram_irq;--NVRAM_reset;-- wdt_enable;			--read_303h or read_304h or read_307h;
--	test2 <= base_addr_jp(1) and base_addr_jp(0) and nvram_rst and nvram_irq;--wdt_timeout and wdt_enable;
	test2 <= read_304h;--master_enable2


process (id1_register_sel,id2_register_sel,led_register_sel,page_register_sel,mode_register_sel,jumper_register_sel,iord,iowr,aen)
begin
	read_id1_register <= id1_register_sel and not(aen) and not(iord);
	read_id2_register <= id2_register_sel and not(aen) and not(iord);
	read_led_register <= led_register_sel and not(aen) and not(iord);
	read_page_register <= page_register_sel and not(aen) and not(iord);
	read_mode_register <= mode_register_sel and not(aen) and not(iord);
	read_jumper_register <= jumper_register_sel and not(aen) and not(iord);
--	read_rst_register <= rst_register_sel and not(aen) and not(iord);
	write_page_register <= page_register_sel and not(aen) and not(iowr);
	write_mode_register <= mode_register_sel and not(aen) and not(iowr);
end process;
--
write_nvram_set_page : process (data_isa,write_page_register)
begin
	if (write_page_register = '1') then 
		page_register <= data_isa(7 downto 0);
	end if;
end process;

write_nvram_set_mode : process (data_isa,write_mode_register)
begin
	if (write_mode_register = '1') then 
		mode_register <= data_isa(7 downto 0);
	end if;
end process;

read_nvram_read_ID1 : process (read_id1_register)
begin
	 
	if (read_id1_register = '1') then 
		data_isa(7 downto 0) <= x"77";
	--	test1 <= '1';
	else
	   data_isa(7 downto 0) <= (others => 'Z');
	--	test1 <= '0';
	end if;
end process;

read_nvram_read_ID2 : process (read_id2_register)
begin
	
	
	if (read_id2_register = '1') then 
		data_isa(7 downto 0) <= x"D9";
	else
	   data_isa(7 downto 0) <= (others => 'Z');
	end if;
	
end process;

read_nvram_read_led : process (read_led_register)
begin
	if (read_led_register = '1') then 
		data_isa(7 downto 0) <= x"02";			--ovde ubaciti uslov ispravnosti BBRAM-a(v2 i v3)
--      data_isa(7 downto 2) <= "000000";
--		data_isa(1) <= nvram_rst;
--		data_isa(0) <= '0';
	else
	   data_isa(7 downto 0) <= (others => 'Z');
	end if;
	
end process;

read_nvram_read_page : process (read_page_register,page_register)
begin
	if (read_page_register = '1') then 
		data_isa(7 downto 0) <= page_register;
	else
	   data_isa(7 downto 0) <= (others => 'Z');
	end if;
end process;


read_nvram_read_mode : process (read_mode_register,mode_register)
begin
	if (read_mode_register = '1') then 
		data_isa(7 downto 0) <= mode_register;
	else
	   data_isa(7 downto 0) <= (others => 'Z');
	end if;
end process;



read_jumper_reg : process (read_jumper_register,base_addr_jp)
begin
	 
	if (read_jumper_register = '1') then 
		data_isa(7 downto 3) <= "00010";
		data_isa(2) <= not(base_addr_jp(1));
		data_isa(1) <= not(base_addr_jp(0));
		data_isa(0)<= '0';
	--	test1 <= '1';
	else
	   data_isa(7 downto 0) <= (others => 'Z');
	--	test1 <= '0';
	end if;
end process;

--read_rst_reg : process (read_rst_register)
--begin
--	 
--	if (read_rst_register = '1') then 
--		data_isa(7 downto 1) <= "0000000";
--		data_isa(0)<= nvram_rst;
--	--	test1 <= '1';
--	else
--	   data_isa(7 downto 0) <= (others => 'Z');
--	--	test1 <= '0';
--	end if;
--end process;


--nvram_irq_cpu <= nvram_irq;  --Verzija sa DS1265W





--upisivanje i citanje registara za NVRAM

--	process (wdt_timeout,wdt_enable)
--	begin
--		wdt_out <= (wdt_timeout and wdt_enable);
--	end process;
--	
--	P7 : process (master_enable,address_max_reg)
--	begin
--		if (master_enable = '0') then
--			address_max <= address_max_reg;	
--		else
--			address_max <= (others => 'Z');
--		end if;
--	
--	end process;
	
--	master_enable <=  ms_in;
--	wdt_out <= xp_present_in;

--SA MASTER_ENABLE TREBA USLOVITI SVE STO IZLAZI NA MAX BUS!!!!!!!!!!!!!!!!!!!!!
 
	
	end Behavioral;

 