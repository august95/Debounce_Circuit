
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Debounce_Circuit_Tb is
--  Port ( );
end Debounce_Circuit_Tb;

architecture Behavioral of Debounce_Circuit_Tb is


component Debouncing_Circuit is
    Port ( rst 	  				: in STD_LOGIC;
           en 	  				: in STD_LOGIC;
           clk 	  				: in STD_LOGIC;
           sw  					: in STD_LOGIC;
           db_tick, db_level 	: out STD_LOGIC);
								-- db_tick, high on transition from 0 to 1
end component Debouncing_Circuit;

constant clk_period                 :  time := 10 ns;
signal rst_tb 	  		    		:  STD_LOGIC;
signal en_tb  	  		 		    :  STD_LOGIC;
signal clk_tb  	  		    		:  STD_LOGIC;
signal sw_tb   			     		:  STD_LOGIC;


signal db_tick_tb                   :  STD_LOGIC;
signal db_level_tb  	            :  STD_LOGIC;


begin

UUT: Debouncing_Circuit
port map(rst => rst_tb,en => en_tb,clk => clk_tb,sw => sw_tb,db_tick => db_tick_tb,db_level => db_level_tb);



process	

begin
loop 
	clk_tb  <= '1';
	wait for clk_period/2;
	clk_tb  <= '0';
	wait for clk_period/2;
	end loop;
end process; 
 
process

begin
wait for 20 ns;
rst_tb <= '1';
en_tb <= '0';
sw_tb <= '0';
wait for 20 ns;
en_tb <= '1';
rst_tb <= '0'; 
sw_tb <= '0';
wait for 20 ns; ----INITILIZATION FINISHED

sw_tb <= '1'; ------ ON AND OFF
wait for 80 ms;
sw_tb <= '0';
wait for 80 ms;
    
sw_tb <= '1'; ------DOUBNCE TO ON
wait for 1 ms;
sw_tb <= '0';
wait for 2 ms;   
sw_tb <= '1';
wait for 1 ms;
sw_tb <= '0';
wait for 2 ms; 
sw_tb <= '1';
wait for 1 ms;
sw_tb <= '0';
wait for 2 ms; 

sw_tb <= '1'; -----DEBOUNCE to OFF
wait for 80 ms;
sw_tb <= '0';
wait for 2 ms;   
sw_tb <= '1';
wait for 1 ms;
sw_tb <= '0';
wait for 2 ms; 
sw_tb <= '1';
wait for 1 ms;
sw_tb <= '0';
wait for 2 ms; 

sw_tb <= '0';
wait for 40 ms; 

sw_tb <= '1';
wait for 45 ms;
rst_tb <= '1';

wait for 1 ms;
rst_tb <= '0';
wait for 2 ms;
en_tb <= '0';
wait for 50 ms;



end process;



end Behavioral;






















