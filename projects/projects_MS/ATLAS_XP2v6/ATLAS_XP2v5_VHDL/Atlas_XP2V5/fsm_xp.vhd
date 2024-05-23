----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:32:09 08/12/2008 
-- Design Name: 
-- Module Name:    fsm_xp - Behavioral 
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

entity fsm_xp is
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
			  );
end fsm_xp;

architecture Behavioral of fsm_xp is
type statetype is (
						 wait_idle,
						 idle,
						 wr_300h,wr_300h_1,wr_300h_2,wr_300h_3,wr_300h_4,wr_300h_5,wr_300h_6,wr_300h_7,wr_300h_8,
						 wr_300h_9,wr_300h_10,wr_300h_11,wr_300h_12,wr_300h_13,wr_300h_14,wr_300h_15,wr_300h_16,
						 wr_300h_17,wr_300h_18,wr_300h_19,
						 rd_308h,rd_308h_1,rd_308h_2,rd_308h_3,rd_308h_4,rd_308h_5,rd_308h_6,rd_308h_7,rd_308h_8,
						 rd_308h_9,rd_308h_rd,
						 rd_300h,
						 rd_309h,
						 rd_303h,rd_304h,rd_306h,rd_307h,rd_30fh,
						 wr_301h, wr_301h_1,wr_301h_2,wr_305h,wr_305h_1,wr_305h_2,wr_306h,wr_306h_1,wr_306h_2
						 );

	signal nextstate,curstate : statetype;
	signal write_wdt_en_pre : STD_LOGIC;
	signal write_lpt_en_pre : STD_LOGIC;
	signal brd_pre : STD_LOGIC;
	signal bwr_pre : STD_LOGIC;
	signal bale_pre : STD_LOGIC;
	signal data_out_enable_pre : STD_LOGIC;
	signal load_buffer_pre : STD_LOGIC;
	signal load_address_pre : STD_LOGIC;
	signal load_data_pre : STD_LOGIC;
	signal wdt_trg_pre : STD_LOGIC;
--	signal led_kvr_clk : STD_LOGIC;
begin
	
	seqpart: process (clk,rst)
				begin
					if (rst = '1') then 
						--test <= '0';
						curstate <= idle;
					elsif (rising_edge (clk)) then 
						--test <= '1';
						curstate <= nextstate;	
					end if;	
				end process;
				
	combpart: process (curstate, reg_wr, reg_rd,address_max, address_latched_low)			--dodati signale
				 
				 variable test_tmp : STD_LOGIC;
				 begin
				 
				 case curstate is  
					
					when wait_idle =>
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
								--	test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '1';
									bale_pre <= '1';
									data_out_enable_pre <= '1';
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									if ((reg_rd = '0') and (reg_wr = '0') ) then
										--	test <= '1';
											nextstate <= idle;
											
									else
										--	test <= '0';
											nextstate <= wait_idle;
											 
									end if;
								
					
					when idle => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									--test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '1';
									bale_pre <= '1';
									data_out_enable_pre <= '1';
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									if ((reg_wr = '1') and (address_latched_low = x"00")) then 
															nextstate <= wr_300h;
									elsif ((reg_wr = '1') and (address_latched_low = x"01")) then 
															nextstate <= wr_301h;
									elsif ((reg_wr = '1') and (address_latched_low = x"05")) then 
															nextstate <= wr_305h;
									elsif ((reg_wr = '1') and (address_latched_low = x"06")) then 
															nextstate <= wr_306h;							
									elsif (reg_rd = '1' and address_latched_low = x"08") then
															nextstate <= rd_308h;
									elsif (reg_rd = '1' and address_latched_low = x"00") then
															nextstate <= rd_300h;						
									elsif (reg_rd = '1' and address_latched_low = x"03") then
															nextstate <= rd_303h;
									elsif (reg_rd = '1' and address_latched_low = x"04") then
															nextstate <= rd_304h;	
									elsif (reg_rd = '1' and address_latched_low = x"06") then
															nextstate <= rd_306h;									
									elsif (reg_rd = '1' and address_latched_low = x"07") then
															nextstate <= rd_307h;	
									elsif (reg_rd = '1' and address_latched_low = x"09") then
															nextstate <= rd_309h;									
									else
												nextstate <= idle;
	
								end if; 
									
------------------------------wr_300h----------------------------------								
								
					when wr_300h => 
								--	test_tmp := '0';
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
																		
									brd_pre <= '1';
									bwr_pre <= '1';
									bale_pre <= '1';
							   	data_out_enable_pre <= '1';
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									if (address_max = x"00" or address_max = x"0F") then
											nextstate <= wait_idle;
											
									else
											nextstate <= wr_300h_1;
									
									end if;			
					
					when wr_300h_1 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
								--	test_tmp := '1';
									brd_pre <= '1';
									bwr_pre <= '1';
									bale_pre <= '1';
									data_out_enable_pre <= '1';
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wr_300h_2;
					
					when wr_300h_2 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
								--	test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '1';
									bale_pre <= '1';
									data_out_enable_pre <= '1';
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '1';
									wdt_trg_pre <= '1';
								   nextstate <= wr_300h_3;
					
					when wr_300h_3 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
								--	test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '1';
									bale_pre <= '1';
									data_out_enable_pre <= '1';
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wr_300h_4;
									
					when wr_300h_4 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
								--	test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '1';
									bale_pre <= '1';
									data_out_enable_pre <= '1';
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wr_300h_5;				
					
					when wr_300h_5 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
								--	test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '1';
									bale_pre <= '0';
									data_out_enable_pre <= '0';	--ovde skace na 1
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wr_300h_6;	
									
					when wr_300h_6 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
								--	test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '0';					--ovde pada na nulu
									bale_pre <= '0';
								   data_out_enable_pre <= '0';
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wr_300h_7;		
					
					when wr_300h_7 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
								--	test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '0';
									bale_pre <= '0';
								   data_out_enable_pre <= '0';
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wr_300h_8;		
										
					when wr_300h_8 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									--test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '0';
									bale_pre <= '0';
									data_out_enable_pre <= '0';
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wr_300h_9;				
									
					
					when wr_300h_9 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
								--	test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '0';
									bale_pre <= '0';
									data_out_enable_pre <= '0';
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wr_300h_10;	
					
					when wr_300h_10 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
								--	test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '0';
									bale_pre <= '0';
									data_out_enable_pre <= '0';
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wr_300h_11;
									
					when wr_300h_11 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
								--	test_tmp := '1';
									brd_pre <= '1';
									bwr_pre <= '0';
									bale_pre <= '0';
									data_out_enable_pre <= '0';
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wr_300h_12;				
									
					when wr_300h_12 => 
									write_wdt_en_pre<= '0';
									write_lpt_en_pre <= '0';
								--	test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '0';
									bale_pre <= '0';
									data_out_enable_pre <= '0';
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wr_300h_13;
					
					when wr_300h_13 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
								--	test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '0';
									bale_pre <= '0';
									data_out_enable_pre <= '0';
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wr_300h_14;
									
					when wr_300h_14 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									--test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '0';
									bale_pre <= '0';
									data_out_enable_pre <= '0';
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wr_300h_15;
					
					when wr_300h_15 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									--test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '0';
									bale_pre <= '0';
									data_out_enable_pre <= '0';
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wr_300h_16;
										
					when wr_300h_16 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									--test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '0';
									bale_pre <= '0';
									data_out_enable_pre <= '0';
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wr_300h_17;
					
					when wr_300h_17 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									--test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '0';
									bale_pre <= '0';
									data_out_enable_pre <= '0';
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate<= wr_300h_18;
										
					when wr_300h_18 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									--test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '0';
									bale_pre <= '0';
									data_out_enable_pre <= '0';
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wr_300h_19;

					when wr_300h_19 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									--test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '0';
									bale_pre <= '0';
									data_out_enable_pre <= '0';	
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= idle;						

------------------------------wr_300h----------------------------------------
											
									
------------------------------wr_301h----------------------------------------
									
					when wr_301h => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									--test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '1';
									bale_pre <= '1';
									data_out_enable_pre <= '1';	
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wr_301h_1;
						
					when wr_301h_1 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									--test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '1';
									bale_pre <= '1';
									data_out_enable_pre <= '1';	
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wr_301h_2;	

					when wr_301h_2 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									--test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '1';
									bale_pre <= '1';
									data_out_enable_pre <= '1';	
									load_buffer_pre <= '0';
									load_address_pre <= '1';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wait_idle;					
									
------------------------------wr_301h----------------------------------------

------------------------------wr_305h-----------------------------------------
					when wr_305h => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									--test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '1';
									bale_pre <= '1';
									data_out_enable_pre <= '1';	
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wr_305h_1;	
	
					when wr_305h_1 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									--test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '1';
									bale_pre <= '1';
									data_out_enable_pre <= '1';	
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wr_305h_2;	
									
					when wr_305h_2 => 
									write_wdt_en_pre <= '1';
									write_lpt_en_pre <= '0';
									--test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '1';
									bale_pre <= '1';
									data_out_enable_pre <= '1';	
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wait_idle;					

------------------------------wr_305h-----------------------------------------

------------------------------wr_306h-----------------------------------------
					when wr_306h => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									--test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '1';
									bale_pre <= '1';
									data_out_enable_pre <= '1';	
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wr_306h_1;	
	
					when wr_306h_1 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									--test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '1';
									bale_pre <= '1';
									data_out_enable_pre <= '1';	
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wr_306h_2;	
									
					when wr_306h_2 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '1';
									--test_tmp := '0';
									brd_pre <= '1';
									bwr_pre <= '1';
									bale_pre <= '1';
									data_out_enable_pre <= '1';	
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wait_idle;					

------------------------------wr_306h-----------------------------------------


------------------------------rd_308h----------------------------------------
					when rd_308h => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									brd_pre <= '1';
									bwr_pre <= '1';
									bale_pre <= '0';
									data_out_enable_pre <= '1';	
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= rd_308h_1;	
									
					when rd_308h_1 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									brd_pre <= '0';
									bwr_pre <= '1';
									bale_pre <= '0';
									data_out_enable_pre <= '1';	
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= rd_308h_2;	
					
					when rd_308h_2 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									brd_pre <= '0';
									bwr_pre <= '1';
									bale_pre <= '0';
									data_out_enable_pre <= '1';	
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= rd_308h_3;	
					
					when rd_308h_3 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									brd_pre <= '0';
									bwr_pre <= '1';
									bale_pre <= '0';
									data_out_enable_pre <= '1';	
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= rd_308h_4;
					
					when rd_308h_4 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									brd_pre <= '0';
									bwr_pre <= '1';
									bale_pre <= '0';
									data_out_enable_pre <= '1';	
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= rd_308h_5;
					
					when rd_308h_5 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									brd_pre <= '0';
									bwr_pre <= '1';
									bale_pre <= '0';
									data_out_enable_pre <= '1';	
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= rd_308h_6;
					
					when rd_308h_6 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									brd_pre <= '0';
									bwr_pre <= '1';
									bale_pre <= '0';
									data_out_enable_pre <= '1';	
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= rd_308h_7;
					
					when rd_308h_7 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									brd_pre <= '0';
									bwr_pre <= '1';
									bale_pre <= '0';
									data_out_enable_pre <= '1';	
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= rd_308h_8;
					
					when rd_308h_8 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									brd_pre <= '0';
									bwr_pre <= '1';
									bale_pre <= '0';
									data_out_enable_pre <= '1';	
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= rd_308h_9;
					
					when rd_308h_9 => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									brd_pre <= '0';
									bwr_pre <= '1';
									bale_pre <= '0';
									data_out_enable_pre <= '1';	
									load_buffer_pre <= '1';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= rd_308h_rd;
					
					
					when rd_308h_rd => 
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									brd_pre <= '1';
									bwr_pre <= '1';
									bale_pre <= '1';
									data_out_enable_pre <= '1';	
									load_buffer_pre <= '1';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wait_idle;

------------------------------rd_308h--------------------------					

------------------------------rd_300h----------------------------

					when rd_300h =>	
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									brd_pre <= '1';
									bwr_pre <= '1';
									bale_pre <= '1';
									data_out_enable_pre <= '1';	
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wait_idle;
									

------------------------------rd_300h----------------------------

------------------------------rd_303h----------------------------

					when rd_303h =>	
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									brd_pre <= '1';
									bwr_pre <= '1';
									bale_pre <= '1';
									data_out_enable_pre <= '1';	
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wait_idle;
									

------------------------------rd_303h----------------------------

------------------------------rd_304h----------------------------

					when rd_304h =>	
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									brd_pre <= '1';
									bwr_pre <= '1';
									bale_pre <= '1';
									data_out_enable_pre <= '1';	
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wait_idle;
									

------------------------------rd_304h----------------------------

------------------------------rd_306h----------------------------

					when rd_306h =>	
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									brd_pre <= '1';
									bwr_pre <= '1';
									bale_pre <= '1';
									data_out_enable_pre <= '1';	
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wait_idle;
									

------------------------------rd_306h----------------------------

------------------------------rd_307h----------------------------
					when rd_307h =>	
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									brd_pre <= '1';
									bwr_pre <= '1';
									bale_pre <= '1';
									data_out_enable_pre <= '1';	
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '1';
									nextstate <= wait_idle;
									
									
------------------------------rd_307h----------------------------

------------------------------rd_309h----------------------------
					when rd_309h =>	
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									brd_pre <= '1';
									bwr_pre <= '1';
									bale_pre <= '1';
									data_out_enable_pre <= '1';	
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '0';
									nextstate <= wait_idle;
									
									
------------------------------rd_309h----------------------------

------------------------------rd_30fh----------------------------
					when rd_30fh =>	
									write_wdt_en_pre <= '0';
									write_lpt_en_pre <= '0';
									brd_pre <= '1';
									bwr_pre <= '1';
									bale_pre <= '1';
									data_out_enable_pre <= '1';	
									load_buffer_pre <= '0';
									load_address_pre <= '0';
									load_data_pre <= '0';
									wdt_trg_pre <= '0';
									nextstate <= wait_idle;
									
									
------------------------------rd_30fh----------------------------

					
					when others => 
									--test <= '0';
									nextstate <= wait_idle;		
					
				 end case;
				 
				 	
				 
				 end process;
	
	P1: process(clk, write_wdt_en_pre, write_lpt_en_pre, brd_pre,bwr_pre,bale_pre,data_out_enable_pre,load_buffer_pre,load_address_pre,load_data_pre,wdt_trg_pre)
		begin
			if falling_edge (clk) then
				write_wdt_en <= write_wdt_en_pre;
				write_lpt_en <= write_lpt_en_pre;
				brd <= brd_pre;
				bwr <= bwr_pre;
				bale <= bale_pre;
				data_out_enable <= data_out_enable_pre;
				load_buffer <= load_buffer_pre;
				load_address <= load_address_pre;
				load_data <= load_data_pre;
				wdt_trg <= wdt_trg_pre;
			end if;
		
		end process;
	
	led_kvr_toggle : process (clk,led_kvr,curstate,address_max)				--proveriti kako ovo funkcionise
		begin
			if rising_edge(clk) then
				if ((curstate =  wr_300h) and address_max = x"0F" ) then
							led_kvr <= '1';
			--	end if;
				
				elsif ((curstate =  rd_308h) and address_max = x"0F" ) then
							led_kvr <= '0';			
				else 
					led_kvr <= led_kvr; 
				end if;
			end if;
		end process;	
		 
		
	
	
end Behavioral;

