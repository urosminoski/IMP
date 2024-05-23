----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:44:14 09/29/2008 
-- Design Name: 
-- Module Name:    mmv - Behavioral 
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

entity mmv is
    Port ( trigger : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  wdt_enable : in STD_LOGIC;
			  quasi_length_type : in STD_LOGIC_VECTOR (1 downto 0);
--			  counter : out STD_LOGIC_VECTOR (23 downto 0);
--			  trigger_rising_edge : inout STD_LOGIC;
--			  trigger_falling_edge : inout STD_LOGIC;
--			  timeout_sig : inout STD_LOGIC;
--			  test : inout STD_LOGIC;
			  q : out  STD_LOGIC
			  );
end mmv;

architecture Behavioral of mmv is
type statetype is (
						 idle,
						 wait_timeout,retrigg,
						 timeout
						 );

--	signal counter_tmp : STD_LOGIC_VECTOR (3 downto 0);
	signal nextstate,curstate : statetype;
	signal counter_preset : STD_LOGIC;
	
	signal count_enable : STD_LOGIC;
	signal q_comb : STD_LOGIC;
	signal counter_comb : STD_LOGIC_VECTOR(23 downto 0);
	signal trigger_reg : STD_LOGIC;
	signal trigger_prev : STD_LOGIC;
	
	signal counter : STD_LOGIC_VECTOR (23 downto 0); 
	signal trigger_rising_edge : STD_LOGIC;
	signal trigger_falling_edge : STD_LOGIC;
	signal timeout_sig : STD_LOGIC;
	signal test : STD_LOGIC;

	signal quasi_length :  STD_LOGIC_VECTOR(23 downto 0);
	constant quasi_stable_length1 : STD_LOGIC_VECTOR(23 downto 0) := x"000014";--:= x"000014"; --:= x"3D0900";	--4 000 000 x 50ns = 200ms
	constant quasi_stable_length2 : STD_LOGIC_VECTOR(23 downto 0) := x"000028";--:= x"000028"; --:= x"989680"; --10 000 000 x 50ns = 500ms
	constant quasi_stable_length3 : STD_LOGIC_VECTOR(23 downto 0) := x"00000A"; --:= x"00000A"; --:= x"061A80"; --400 000 x 50ns = 20ms
	
begin
	
	process (clk,quasi_length_type) 
	begin
		if rising_edge (clk) then
			if (quasi_length_type = x"0") then 
					quasi_length <= quasi_stable_length1;
			elsif (quasi_length_type = x"1") then 
					quasi_length <= quasi_stable_length2;
			elsif (quasi_length_type = x"2") then 
					quasi_length <= quasi_stable_length3;		
			else
				quasi_length <= quasi_stable_length1;
			end if;
		end if;
	end process; 
	 
	P1 : process(clk,trigger)
	begin
		if rising_edge (clk) then
			trigger_prev <= trigger_reg;
			trigger_reg <= trigger;
		end if;
	end process;
	
	P2 : process (clk,trigger_prev,trigger_reg)
	begin
		if rising_edge (clk) then
			if (trigger_prev = '0' and trigger_reg = '0') then
							trigger_rising_edge <= '0';
							trigger_falling_edge <= '0';
			elsif (trigger_prev = '0' and trigger_reg = '1') then
							trigger_rising_edge <= '1';
							trigger_falling_edge <= '0';
			elsif (trigger_prev = '1' and trigger_reg = '0') then
							trigger_rising_edge <= '0';
							trigger_falling_edge <= '1';
			elsif (trigger_prev = '1' and trigger_reg = '1') then
							trigger_rising_edge <= '0';
							trigger_falling_edge <= '0';					
			else
							trigger_rising_edge <= '0';
							trigger_falling_edge <= '0'; 
			end if;	 
		end if;	
	end process;

	
	
	seqpart: process (clk,wdt_enable)
				begin
					if (wdt_enable = '0') then  
						--test <= '0';
						curstate <= idle;
					elsif (rising_edge (clk)) then 
						--test <= '1';
						curstate <= nextstate;	
					end if;	
				end process;

	combpart: process (curstate, trigger_rising_edge,timeout_sig)			--dodati signale
				 
				 variable test_tmp : STD_LOGIC;
				 begin
				 
				 case curstate is  
					
					when idle =>
									q_comb <= '0';
--									counter_comb <= x"0";
									if (trigger_rising_edge = '1') then
										--	test <= '1';
											--q_comb <= '1';
											count_enable <= '1';
											nextstate <= wait_timeout;
									else
										--	test <= '0';
											nextstate <= idle;
									end if;
					
					when wait_timeout =>
									q_comb <= '1';
									
									----------------------------
									
									if (timeout_sig = '1') then
										nextstate <= timeout;
									elsif (timeout_sig = '0') then
										nextstate <= wait_timeout;
									end if;
									
									----------------------------

									count_enable <= '1';
			
									if (trigger_rising_edge = '1') then
											counter_preset <= '1';
									else
											counter_preset <= '0';
									end if;		
									
--									counter_comb <= counter_comb + "0001";			--poc
--				
--									if (counter_comb = quasi_length) then 
----										--	test <= '1';
--											nextstate <= timeout;
--									
--									elsif (trigger_rising_edge = '1') then
----										
----											nextstate <= retrigg;
--											
----										
----									else	
--											nextstate <= wait_timeout;
--									end if;													--kraj 
----					
--					when retrigg =>
--									q_comb <= '1';
--									counter_comb <= x"0";
--									nextstate <= wait_timeout;
					
					when timeout =>
									q_comb <= '0';
--									counter_comb <= x"0";
									count_enable <= '0';
									nextstate <= idle;
									
						
					
					
					
					when others => 
									--test <= '0';
									nextstate <= idle;		
					
				 end case;
				 end process;
	
--	dioda: process(clk,q_comb)
--	begin
--		if rising_edge(clk) then
--			if (q_comb = '0') then
--				q <= '0';
--			else
--				q <= 'Z';
--			end if;	
--		end if;
--	end process;
	
	output_reg: process(clk,counter_comb,wdt_enable)
		begin
			if rising_edge (clk) then
				if (wdt_enable = '1') then
					q <= q_comb;
					counter <= counter_comb;
				else
					q <= '0';
					counter <= x"000000";
				end if;	
--				counter_tmp <= counter_comb;
			end if;
		
		end process;
	
	
	counter_proc : process (clk,count_enable,counter_preset)
	begin
		if rising_edge (clk) then
			if (count_enable = '1') then
				if (counter_preset = '1') then
					counter_comb <= x"000000";
				else	
					counter_comb <= counter_comb + x"1"; 
				end if;	
			
			else
				counter_comb <= x"000000";
			end if;
		end if;
	end process;
	
	process (clk)
	begin	
		if rising_edge (clk) then
			if (counter_comb >= quasi_length) then

--				count_enable <= '0';
				timeout_sig <= '1';
			else
				timeout_sig <= '0';
			end if;	
		end if;
	end process;
	test <= count_enable;
--P1 : process (trigger)
--	begin
--			if falling_edge (trigger) then
----				q <= '1';
--				count_enable <= '1';
----			else
----				count_enable <= '0';
--			end if;
--	end process;
--	
----P1a : process (clk)
----	begin
----		if rising_edge (clk) then
----		
----		end if;
--	
----	end process;
--
--P2 : process (clk,count_enable)
--	begin
--			if not(count_enable = '1') then
--				counter_tmp <= x"0";
--		   elsif rising_edge (clk) then
--				counter_tmp <= counter_tmp + 1;
--			end if;	
--		
--		
--	end process;
--
--	counter <= counter_tmp;
--
--P3 : process (counter_tmp,quasi_length,count_enable)
--	begin
--		if (counter_tmp = x"A" and count_enable = '1') then
----			counter_tmp <= x"0";
--			count_enable <= '0';
----			q <= '0';
--		elsif  (counter_tmp = x"0" and count_enable = '0') then
--			count_enable <= '0';
--		else
--			count_enable <= '1';
--		end if;
--	end process;


	
					
	
end Behavioral;

