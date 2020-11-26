----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.11.2020 12:45:43
-- Design Name: 
-- Module Name: Edge_Detector_Tb - Behavioral
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

entity Edge_Detector_Tb is
--  Port ( );
end Edge_Detector_Tb;

architecture Behavioral of Edge_Detector_Tb is

component Edge_Detector is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;          
            d : in STD_LOGIC;
           q : out STD_LOGIC);
end component Edge_Detector;


constant clk_period                 :  time := 10 ns;
signal rst 	  		    		:  STD_LOGIC;
signal en	  		 		    :  STD_LOGIC;
signal clk  	  		    		:  STD_LOGIC;
signal q, d : STD_logic;


begin

UUT: Edge_Detector
port map(en => en, rst => rst, clk => clk, q => q, d => d);

process	

begin
loop  -------10 ns CLK pulse
	clk  <= '1';
	wait for clk_period/2;
	clk  <= '0';
	wait for clk_period/2;
	end loop;
end process; 

process
begin

en <= '1';
rst <= '0';
wait for 20 ns; -- test begin at 20 ns

wait for 5 ns; -- ZERO -> TICK -> ZERO
d <= '1';
wait for 5 ns;
d <= '0';

d <= '1'; ----RST
wait for 5 ns;
d <= '0';
wait for 2 ns;
rst <= '1';
wait for 1 ns;
rst <= '0';

wait for 10 ns;

d <= '1'; --------- ZERO -> TICK -> ONE -> ZERO
wait for 20 ns;
d <= '0';

end process;



end Behavioral;























