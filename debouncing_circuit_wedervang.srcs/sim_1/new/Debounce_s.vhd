
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.11.2020 17:54:18
-- Design Name: 
-- Module Name: Debounce_s - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
library UNISIM;
use UNISIM.VComponents.all;

entity Debouncing_Circuit_tb is
--  Port ( );
end Debouncing_Circuit_tb;


architecture Behavioral of Debouncing_Circuit_tb is


component Debouncing_Circuit is
    Port ( rst 	  				: in STD_LOGIC;
           en 	  				: in STD_LOGIC;
           clk 	  				: in STD_LOGIC;
           sw  					: in STD_LOGIC;
           db_tick, db_level 	: out STD_LOGIC);
								-- db_tick, high on transition from 0 to 1
end component Debouncing_Circuit;

constant clk_period                 :  time := 10 ns;
signal rst_tb 	  		    		:  STD_LOGIC := '0';
signal en_tb  	  		 		    :  STD_LOGIC := '1';
signal clk_tb  	  		    		:  STD_LOGIC := '0';
signal sw_tb   			     		:  STD_LOGIC := '0';


signal db_tick_tb                   :  STD_LOGIC;
signal db_level_tb  	            :  STD_LOGIC;


begin

UUT: Debouncing_Circuit
port map(rst => rst_tb,en => en_tb,clk => clk_tb,sw => sw_tb,db_tick => db_tick_tb,db_level => db_level_tb);



process	
begin
wait for 100 ns;
wait for 20 ns;
loop 
	clk_tb  <= '0';
	wait for 5ns;
	clk_tb  <= '1';
	wait for 5ns;
	end loop;
end process; 

process
begin
wait for 100 ns;
wait for 20 ns;
loop
    sw_tb  <= '0';
    wait for 1000ms; -- giver stable power of
    sw_tb  <= '1';
    wait for 1 ms;
    sw_tb  <= '0'; -- Neeeds to go back to 0
    
    wait for 2 ms;
    sw_tb  <= '1';
    wait for 38 ms;
    sw_tb  <= '0'; --Needs to fo go back to 0
    
     wait for 2 ms;
    sw_tb  <= '1';
    wait for 10 ms;
    sw_tb  <= '0';
    wait for 2 ms;
    sw_tb  <= '1';
    wait for 1000 ms;
end loop;
end process;


end Behavioral;



















