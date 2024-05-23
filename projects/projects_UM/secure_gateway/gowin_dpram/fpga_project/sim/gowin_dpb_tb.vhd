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

entity Gowin_DPB_tb is
end entity Gowin_DPB_tb;

architecture bench of Gowin_DPB_tb is

	component dp_ram
		port (
			douta	: out std_logic_vector(15 downto 0);
			doutb	: out std_logic_vector(15 downto 0);
			clka	: in std_logic;
			ocea	: in std_logic;
			cea		: in std_logic;
			reseta	: in std_logic;
			wrea	: in std_logic;
			clkb	: in std_logic;
			oceb	: in std_logic;
			ceb		: in std_logic;
			resetb	: in std_logic;
			wreb	: in std_logic;
			ada		: in std_logic_vector(11 downto 0);
			dina	: in std_logic_vector(15 downto 0);
			adb		: in std_logic_vector(11 downto 0);
			dinb	: in std_logic_vector(15 downto 0)
		);
	end component;
	
	constant C_CLK_PERIOD : time := 2 ns;

	constant C_TIME_1 : time := 5 ns;
	constant C_TIME_2 : time := 5 ns;

	signal douta	: std_logic_vector(15 downto 0);
	signal doutb	: std_logic_vector(15 downto 0);
	signal clka		: std_logic := '1';
	signal ocea		: std_logic := '0';
	signal cea		: std_logic := '0';
	signal reseta	: std_logic := '1';
	signal wrea		: std_logic := '0';
	signal clkb		: std_logic := '1';
	signal oceb		: std_logic := '0';
	signal ceb		: std_logic := '0';
	signal resetb	: std_logic := '1';
	signal wreb		: std_logic := '0';
	signal ada		: std_logic_vector(11 downto 0) := (others => 'Z');
	signal dina		: std_logic_vector(15 downto 0) := (others => 'Z');
	signal adb		: std_logic_vector(11 downto 0) := (others => 'Z');
	signal dinb		: std_logic_vector(15 downto 0) := (others => 'Z');
	
	signal clk : std_logic := '1';

begin

	uut: dp_ram 
	port map(
		douta  => douta,
		doutb  => doutb,
		clka   => clka,
		ocea   => ocea,
		cea    => cea,
		reseta => reseta,
		wrea   => wrea,
		clkb   => clkb,
		oceb   => oceb,
		ceb    => ceb,
		resetb => resetb,
		wreb   => wreb,
		ada    => ada,
		dina   => dina,
		adb    => adb,
		dinb   => dinb 
	);
	
	clk <= not clk after C_CLK_PERIOD / 2;
	
	clka <= clk;
	clkb <= clk;
	
	-- P : process
	-- begin
		-- while true loop
			
			-- clka <= '1';
			-- wait for C_TIME_1;
			
			-- clka <= '0';
			-- wait for C_TIME_2;
			
		-- end loop;
		-- wait;
	-- end process;

	stimulus: process
	begin
		
		reseta <= '1';
		wait for 5 ns;
		reseta <= '0';
		
		wait until falling_edge(clka);
		cea 	<= '1';
		ocea	<= '1';
		
		wait until falling_edge(clka);
		wrea 	<= '1';
		ada 	<= x"000";
		dina 	<= x"00F0";
		wait until falling_edge(clka);
		wrea 	<= '1';
		ada 	<= x"001";
		dina 	<= x"00F1";
		wait until falling_edge(clka);
		wrea 	<= '1';
		ada 	<= x"002";
		dina 	<= x"00F2";
		wait until falling_edge(clka);
		wrea 	<= '1';
		ada 	<= x"003";
		dina 	<= x"00F3";
		
		wait until falling_edge(clka);
		wrea 	<= '0';
		ada 	<= x"000";
		dina 	<= (others => 'Z');
		wait until falling_edge(clka);
		wrea 	<= '0';
		ada 	<= x"001";
		dina 	<= (others => 'Z');
		wait until falling_edge(clka);
		wrea 	<= '0';
		ada 	<= x"002";
		dina 	<= (others => 'Z');
		wait until falling_edge(clka);
		wrea 	<= '0';
		ada 	<= x"003";
		dina 	<= (others => 'Z');
		
		wait until rising_edge(clka);
		wrea 	<= '0';
		ada 	<= x"000";
		dina 	<= (others => 'Z');
		
		
		
		wait;
	end process;
	
end;