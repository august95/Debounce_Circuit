----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.10.2020 15:14:34
-- Design Name: 
-- Module Name: Debouncing_Circuit - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Debouncing_Circuit is
    Port ( rst 	  				: in STD_LOGIC;
           en 	  				: in STD_LOGIC;
           clk 	  				: in STD_LOGIC;
           sw  					: in STD_LOGIC;
           db_tick, db_level 	: out STD_LOGIC);
								-- db_tick, high on transition from 0 to 1
end Debouncing_Circuit;

architecture Behavioral of Debouncing_Circuit is


---------------signal declaration-----


type debounce_states is			(zero, wait1, one, wait0);
constant N 						: integer := 21; -- 40 ms deleay. 2^20 * 2 ns = 40 ms;
signal r_reg, r_next 			: unsigned (N downto 0);
signal state_reg, state_next 	: debounce_states;
--signal db_tick_s, db_level_s    : std_logic;


---------------sequential part--------

begin

process(en, rst, clk, state_reg, state_next, r_reg, r_next)
begin
	if(rst = '1') then
		state_reg <= ZERO;
		r_reg <= (others => '0');
	elsif(rising_edge(clk)) then
		if(en = '1') then
			state_reg <= state_next;
			r_reg <= r_next;
		end if;	
	end if;
end process;


---------------next state logic-------


process(clk, state_reg, state_next, r_reg, r_next, sw)
begin
	state_next 	<= state_reg; -- unless else is specified, next state is current state
	r_next 		<= r_reg;
	db_tick 	<= '0';
	db_level 	<= '0';
	

case state_reg is 
	when zero =>
		if(sw = '1') then
		r_next <=  (others => '1'); -- reg is filled with all 1
		state_next <= wait1;
		end if;
	
	when wait1 =>
		if(sw = '1') then
			r_next <= r_reg - 1;
			if(r_next = 0) then
				state_next <= one;
				db_tick <= '1'; -- Tick on transition from 1 to 0
			end if;
		else
			state_next <= one;
		end if;
		
	when one =>
		db_level <= '1';
		if (sw = '0') then
			r_next <=  (others => '1');
			state_next <= wait0;		
		end if;	
		
	when wait0 =>
		db_level <= '1';
		if(sw = '0') then
			r_next <= r_reg -1;
			if(r_next = 0) then
				state_next <= zero;
			end if;
		end if;

	end case;
	
end process;



end behavioral;





