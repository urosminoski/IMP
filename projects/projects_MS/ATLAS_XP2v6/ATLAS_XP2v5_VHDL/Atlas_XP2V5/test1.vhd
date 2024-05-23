--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:05:05 10/16/2012
-- Design Name:   
-- Module Name:   F:/MILOS/Projects/ATLAS_XP2V3v1.2/ATLAS_XP2V3v1.2/test1.vhd
-- Project Name:  ATLAS_XP2V3v1.2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: fsm_xp_top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test1 IS
END test1;
 
ARCHITECTURE behavior OF test1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fsm_xp_top
    PORT(
         address_isa : IN  std_logic_vector(23 downto 0);
         data_isa : INOUT  std_logic_vector(15 downto 0);
         clk : IN  std_logic;
         iowr : IN  std_logic;
         iord : IN  std_logic;
         ale : IN  std_logic;
         aen : IN  std_logic;
         cw6 : IN  std_logic;
         cw7 : IN  std_logic;
         base_addr_jp : IN  std_logic_vector(1 downto 0);
         cs : INOUT  std_logic;
         address_max : INOUT  std_logic_vector(7 downto 0);
         data_max : INOUT  std_logic_vector(15 downto 0);
         xp_address : IN  std_logic_vector(7 downto 0);
         master_enable : INOUT  std_logic;
         iocs16 : OUT  std_logic;
         mrst : OUT  std_logic;
         reset : IN  std_logic;
         pwr_good_tps : IN  std_logic;
         bale : INOUT  std_logic;
         bwr : INOUT  std_logic;
         brd : INOUT  std_logic;
         write_wdt_en : INOUT  std_logic;
         rst_taster : in  std_logic;
         test2 : INOUT  std_logic;
         data_out_enable : INOUT  std_logic;
         load_buffer : INOUT  std_logic;
--         load_address : INOUT  std_logic;
         led_kvr : INOUT  std_logic;
         led_rad : INOUT  std_logic;
         led_lpt : OUT  std_logic;
         led_wdt : OUT  std_logic;
         led_master_enable : OUT  std_logic;
         led_pwr_good_tps : OUT  std_logic;
         reset_CPU : INOUT  std_logic;
         direction_245 : OUT  std_logic;
         wdt_trg : OUT  std_logic;
         wdt_out_stari : IN  std_logic;
         wdt_sig_stari : IN  std_logic;
         smemr : IN  std_logic;
         smemw : IN  std_logic;
         nvram_ce : OUT  std_logic;
         nvram_we : OUT  std_logic;
         nvram_oe : OUT  std_logic;
         nvram_cs : OUT  std_logic;
         nvram_address : OUT  std_logic_vector(20 downto 0);
         nvram_data : INOUT  std_logic_vector(7 downto 0);
         nvram_rst : IN  std_logic;
         iq_i_syn : IN  std_logic;
         iq_o_syn : OUT  std_logic;
         power_supply_24V: in STD_LOGIC;
			rst_dof_dsbl : IN  std_logic
        );
    END COMPONENT;
    

 SIGNAL address_isa : std_logic_vector (23 DownTo 0) := "000000000000000000000000";
    SIGNAL data_isa : std_logic_vector (15 DownTo 0) := "ZZZZZZZZZZZZZZZZ";
    SIGNAL clk : std_logic := '0';
    SIGNAL iowr : std_logic := '0';
    SIGNAL iord : std_logic := '0';
    SIGNAL ale : std_logic := '0';
    SIGNAL aen : std_logic := '0';
    SIGNAL cw6 : std_logic := '0';
    SIGNAL cw7 : std_logic := '0';
    SIGNAL base_addr_jp : std_logic_vector (1 DownTo 0) := "11";
    SIGNAL cs : std_logic := 'Z';
    SIGNAL address_max : std_logic_vector (7 DownTo 0) := "ZZZZZZZZ";
    SIGNAL data_max : std_logic_vector (15 DownTo 0) := "ZZZZZZZZZZZZZZZZ";
    SIGNAL xp_address : std_logic_vector (7 DownTo 0) := "00000000";
    SIGNAL master_enable : std_logic := 'Z';
    SIGNAL iocs16 : std_logic := '0';
    SIGNAL mrst : std_logic := '0';
    SIGNAL reset : std_logic := '0';
    SIGNAL pwr_good_tps : std_logic := '0';
    SIGNAL bale : std_logic := 'Z';
    SIGNAL bwr : std_logic := 'Z';
    SIGNAL brd : std_logic := 'Z';
    SIGNAL write_wdt_en : std_logic := 'Z';
    SIGNAL rst_taster : std_logic;-- := '0';
    SIGNAL test2 : std_logic := 'Z';
    SIGNAL data_out_enable : std_logic := 'Z';
    SIGNAL load_buffer : std_logic := 'Z';
--    SIGNAL load_address : std_logic := 'Z';
    SIGNAL led_kvr : std_logic := 'Z';
    SIGNAL led_rad : std_logic := 'Z';
    SIGNAL led_lpt : std_logic := '0';
    SIGNAL led_wdt : std_logic := '0';
    SIGNAL led_master_enable : std_logic := '0';
    SIGNAL led_pwr_good_tps : std_logic := '0';
    SIGNAL reset_CPU : std_logic := 'Z';
    SIGNAL direction_245 : std_logic := '0';
    SIGNAL wdt_trg : std_logic := '0';
    SIGNAL wdt_out_stari : std_logic := '0';
    SIGNAL wdt_sig_stari : std_logic := '0';
    SIGNAL smemr : std_logic := '1';
    SIGNAL smemw : std_logic := '1';
    SIGNAL nvram_ce : std_logic := '0';
    SIGNAL nvram_we : std_logic := '0';
    SIGNAL nvram_oe : std_logic := '0';
    SIGNAL nvram_cs : std_logic := '0';
    SIGNAL nvram_address : std_logic_vector (20 DownTo 0) := "000000000000000000000";
    SIGNAL nvram_data : std_logic_vector (7 DownTo 0) := "ZZZZZZZZ";
--    SIGNAL nvram_irq : std_logic := '0';
    SIGNAL nvram_rst : std_logic := '1';
    SIGNAL iq_i_syn : std_logic := '0';
    SIGNAL iq_o_syn : std_logic := '0';
--    SIGNAL nvram_irq_cpu : std_logic := '0';
    signal power_supply_24V : std_logic := '0';
	 SIGNAL rst_dof_dsbl : std_logic := '0';

    constant PERIOD : time := 50 ns;
    constant DUTY_CYCLE : real := 0.5;
    constant OFFSET : time := 100 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: fsm_xp_top PORT MAP(
		address_isa => address_isa,
		data_isa => data_isa,
		clk => clk,
		iowr => iowr,
		iord => iord,
		ale => ale,
		aen => aen,
		cw6 => cw6,
		cw7 => cw7,
		base_addr_jp => base_addr_jp,
		cs => cs,
		address_max => address_max,
		data_max => data_max,
		xp_address => xp_address,
		master_enable => master_enable,
		iocs16 => iocs16,
		mrst => mrst,
		reset => reset,
		pwr_good_tps => pwr_good_tps,
		bale => bale,
		bwr => bwr,
		brd => brd,
		write_wdt_en => write_wdt_en,
		rst_taster => rst_taster,
		test2 => test2,
		data_out_enable => data_out_enable,
		load_buffer => load_buffer,
--		load_address => load_address,
		led_kvr => led_kvr,
		led_rad => led_rad,
		led_lpt => led_lpt,
		led_wdt => led_wdt,
		led_master_enable => led_master_enable,
		led_pwr_good_tps => led_pwr_good_tps,
		reset_CPU => reset_CPU,
		direction_245 => direction_245,
		wdt_trg => wdt_trg,
		wdt_out_stari => wdt_out_stari,
		wdt_sig_stari => wdt_sig_stari,
		smemr => smemr,
		smemw => smemw,
		nvram_ce => nvram_ce,
		nvram_we => nvram_we,
		nvram_oe => nvram_oe,
		nvram_cs => nvram_cs,
		nvram_address => nvram_address,
		nvram_data => nvram_data,
--		nvram_irq => nvram_irq,
		nvram_rst => nvram_rst,
		iq_i_syn => iq_i_syn,
		iq_o_syn => iq_o_syn,
--		nvram_irq_cpu => nvram_irq_cpu,
		power_supply_24V=>power_supply_24V,
		rst_dof_dsbl => rst_dof_dsbl
	);

 PROCESS    -- clock process for clk
        BEGIN
            WAIT for OFFSET;
            CLOCK_LOOP : LOOP
                clk <= '0';
                WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
                clk <= '1';
                WAIT FOR (PERIOD * DUTY_CYCLE);
            END LOOP CLOCK_LOOP;
        END PROCESS;

	tb : PROCESS
            BEGIN
                -- -------------  Current Time:  100ns
                WAIT FOR 100 ns;
                iord <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  110ns
                WAIT FOR 10 ns;
                iowr <= '1';
                cw6 <= '1';
					 cw7 <= '1';
                address_isa <= "000000000000000001000000";
                -- -------------------------------------
                -- -------------  Current Time:  210ns
                WAIT FOR 100 ns;
                xp_address <= "01000000";
                -- -------------------------------------
                -- -------------  Current Time:  810ns
                WAIT FOR 600 ns;
                xp_address <= x"42";
                -- -------------------------------------
                -- -------------  Current Time:  1060ns
                WAIT FOR 250 ns;
                ale <= '1';
                address_isa <= "000000000000001100000100";
                -- -------------------------------------
                -- -------------  Current Time:  1110ns
                WAIT FOR 50 ns;
                ale <= '0';
              
 				    WAIT FOR 50 ns;
                iord <= '0';

                WAIT FOR 550 ns;
                iord <= '1';

					 WAIT FOR 100 ns;
                ale <= '1';
					 address_isa <= x"000303";
                
                WAIT FOR 50 ns;
                ale <= '0';
					 
 				    WAIT FOR 50 ns;
                iord <= '0';

                WAIT FOR 550 ns;
                iord <= '1';

                WAIT FOR 100 ns;
                ale <= '1';
					 address_isa <= x"000307";
                
                WAIT FOR 50 ns;
                ale <= '0';
					 
 				    WAIT FOR 50 ns;
                iord <= '0';

                WAIT FOR 550 ns;
                iord <= '1';                


                WAIT FOR 100 ns;
                ale <= '1';
					 address_isa <= x"000304";
                
                WAIT FOR 50 ns;
                ale <= '0';
					 
 				    WAIT FOR 50 ns;
                iord <= '0';

                WAIT FOR 550 ns;
                iord <= '1';                

					 
					 WAIT FOR 100 ns;
                ale <= '1';
					 address_isa <= x"000301";
                
                WAIT FOR 50 ns;
                ale <= '0';
					 data_isa <= x"0050";
					 
 				    WAIT FOR 50 ns;
                iowr <= '0';

                WAIT FOR 550 ns;
                iowr <= '1';     
					 
					 WAIT FOR 100 ns;
                ale <= '1';
					 address_isa <= x"000300";
                
                WAIT FOR 50 ns;
                ale <= '0';
					 data_isa <= x"AA55";
					 
 				    WAIT FOR 50 ns;
                iowr <= '0';

                WAIT FOR 550 ns;
                iowr <= '1';   
					 
					 WAIT FOR 700 ns;
                ale <= '1';
					 address_isa <= x"000301";
                
                WAIT FOR 50 ns;
                ale <= '0';
					 data_isa <= x"005F";
					 
 				    WAIT FOR 50 ns;
                iowr <= '0';

                WAIT FOR 550 ns;
                iowr <= '1';       
					 
					 WAIT FOR 700 ns;
                ale <= '1';
					 address_isa <= x"000308";
                data_isa <= (others => 'Z');
					 
                WAIT FOR 50 ns;
                ale <= '0';
					 					 
 				    WAIT FOR 50 ns;
                iord <= '0';
                data_max <= x"1234";
                
                WAIT FOR 550 ns;
                iord <= '1'; 
					 data_max <= (others => 'Z');
					 
					 --
					 WAIT FOR 700 ns;
                ale <= '1';
					 address_isa <= x"000300";
                data_isa <= (others => 'Z');
					 
                WAIT FOR 50 ns;
                ale <= '0';
					 					 
 				    WAIT FOR 50 ns;
                iord <= '0';
                
                WAIT FOR 550 ns;
                iord <= '1'; 
					 
					 WAIT FOR 700 ns;
                ale <= '1';
					 address_isa <= x"000140";
               
                WAIT FOR 50 ns;
                ale <= '0';
					 					 
 				    WAIT FOR 50 ns;
                iord <= '0';
                
                WAIT FOR 550 ns;
                iord <= '1';
					 
					 WAIT FOR 700 ns;
                ale <= '1';
					 address_isa <= x"000141";
               
                WAIT FOR 50 ns;
                ale <= '0';
					 					 
 				    WAIT FOR 50 ns;
                iord <= '0';
                
                WAIT FOR 550 ns;
                iord <= '1';
					 
					 WAIT FOR 700 ns;
                ale <= '1';
					 address_isa <= x"000143";
               
                WAIT FOR 50 ns;
                ale <= '0';
					 					 
 				    WAIT FOR 50 ns;
                iord <= '0';
              
					 
                WAIT FOR 550 ns;
                iord <= '1';
					 
					 WAIT FOR 700 ns;
                ale <= '1';
					 address_isa <= x"000144";
               					 
                WAIT FOR 50 ns;
                ale <= '0';
					 data_isa <= x"003F"; ---page
					 					 
 				    WAIT FOR 50 ns;
                iowr <= '0';
              
					 
                WAIT FOR 550 ns;
                iowr <= '1';
					 
					 WAIT FOR 100 ns;
					 data_isa <= (others => 'Z');
					 
					 WAIT FOR 600 ns;
                ale <= '1';
					 address_isa <= x"000144";
               
                WAIT FOR 50 ns;
                ale <= '0';		
                							
 				    WAIT FOR 50 ns;
                iord <= '0';
              
					 
                WAIT FOR 550 ns;
                iord <= '1';
					 
					 --
					 WAIT FOR 700 ns;
                ale <= '1';
					 address_isa <= x"000145";
               
                WAIT FOR 50 ns;
                ale <= '0';
					 data_isa <= x"0046";
					 					 
 				    WAIT FOR 50 ns;
                iowr <= '0';
              
					 
                WAIT FOR 550 ns;
                iowr <= '1';
					 
					 WAIT FOR 100 ns;
					 data_isa <= (others => 'Z');
					 
					 WAIT FOR 600 ns;
                ale <= '1';
					 address_isa <= x"000145";
               
                WAIT FOR 50 ns;
                ale <= '0';
					 					 
 				    WAIT FOR 50 ns;
                iord <= '0';
              
					 
                WAIT FOR 550 ns;
                iord <= '1';
--					 nvram_rst <= '0';
					 
--					 wait for 100 ns;
--					 reset <= '1';
					 
					 wait for 100 ns;
					 ale <= '1';
					 address_isa <= x"000146";
					 
					 WAIT FOR 50 ns;
                ale <= '0';
					 
					 WAIT FOR 50 ns;
                iord <= '0';
              
					 
                WAIT FOR 550 ns;
                iord <= '1';
					 
					 WAIT FOR 700 ns;
                ale <= '1';
					 address_isa <= x"0D0000";
               
                WAIT FOR 50 ns;
                ale <= '0';
					 data_isa <= x"0055";
					 					 
 				    WAIT FOR 50 ns;
                smemw <= '0';
              
					 
                WAIT FOR 550 ns;
                smemw <= '1';
                
					 WAIT FOR 100 ns;
					 data_isa <= (others => 'Z');

                WAIT FOR 100 ns;
                ale <= '1';
					 address_isa <= x"0D7FFF";
               
                WAIT FOR 50 ns;
                ale <= '0';
					 
					 					 
 				    WAIT FOR 50 ns;
                smemr <= '0';
              
					 WAIT FOR 100 ns;
					 nvram_data <= x"A5";
					 
                WAIT FOR 450 ns;
                smemr <= '1';
                 
                WAIT FOR 20 ns;					  
                nvram_data <= (others => 'Z');				 
					 
					 wait for 100 ns;
					 nvram_rst <= '0';
					 
					 wait for 20 ns;
					 reset <= '1';
					 
					 wait for 50 ns;
					 xp_address <= x"01";
					 
					 wait for 50 ns;
					 reset <= '0';

					 wait for 1000 ns;
					 ale <= '1';
					 address_isa <= x"00030F";
                
                WAIT FOR 50 ns;
                ale <= '0';
					 
 				    WAIT FOR 50 ns;
                iord <= '0';

                WAIT FOR 550 ns;
                iord <= '1';
					 
--                WAIT FOR 8440 ns;
                WAIT;

            END PROCESS;

END;
