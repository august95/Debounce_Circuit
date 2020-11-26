----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.11.2020 13:22:11
-- Design Name: 
-- Module Name: queue_system - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity queue_system is
    Port ( clk 					: in STD_LOGIC;
           rst 					: in STD_LOGIC;
		   sw 					: in STD_LOGIC;
		   an   				: out STD_LOGIC_VECTOR (3 downto 0);
           seg 				: out STD_LOGIC_VECTOR (7 downto 0));
end queue_system;

architecture Behavioral of queue_system is

component Debouncing_Circuit is
    Port ( rst 	  				: in STD_LOGIC;
           en 	  				: in STD_LOGIC;
           clk 	  				: in STD_LOGIC;
           sw  					: in STD_LOGIC;
           db_tick, db_level 	: out STD_LOGIC);
								-- db_tick, high on transition from 0 to 1
end component Debouncing_Circuit;


component Edge_Detector is
    Port ( clk  				: in STD_LOGIC;
           en   				: in STD_LOGIC;
           rst					: in STD_LOGIC;
           d    				: in STD_LOGIC;
           q    				: out STD_LOGIC);
end component Edge_Detector;


component mod_m_counter is
    generic(
			N					: integer := 16;
			M 					: integer := 4); 
    
    Port ( rst      			: in STD_LOGIC;
           en       			: in STD_LOGIC;
           clk      			: in STD_LOGIC;
           q        			: out STD_LOGIC_VECTOR (M-1 downto 0);
           max_tick 			: out std_logic);
end component mod_m_counter;


component hex_to_sseg is
    Port ( hex  				: in STD_LOGIC_VECTOR (3 downto 0);
           seg  				: out STD_LOGIC_VECTOR (7 downto 0);
           an   				: out STD_LOGIC_VECTOR (3 downto 0));
end component hex_to_sseg;


signal db_level 				: STD_LOGIC;
signal q 						: STD_LOGIC;
signal count                    : STD_LOGIc_VECTOR(3 downto 0);

begin

Debounce : Debouncing_Circuit
port map (rst => rst, en => '1', clk => clk, sw => sw, db_tick => open, db_level => db_level);

Edge : Edge_Detector
port map  (clk => clk, en => '1', rst => rst, d => db_level, q => q);

Counter : mod_m_counter 
generic map ( N => 10, M => 4)
--port map (rst => rst, en => '1', clk => db_level, q => count, max_tick => open);
port map (rst => rst, en => '1', clk => q, q => count, max_tick => open);

Seg_Display : hex_to_sseg
port map(hex => count, seg => seg, an => an);

end Behavioral;




















