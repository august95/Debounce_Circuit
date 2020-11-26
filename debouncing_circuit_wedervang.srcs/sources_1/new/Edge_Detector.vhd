----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.11.2020 12:55:02
-- Design Name: 
-- Module Name: Edge_Detector - Behavioral
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

entity Edge_Detector is
    Port ( clk  : in STD_LOGIC;
           en   : in STD_LOGIC;
           rst  : in STD_LOGIC;
           d    : in STD_LOGIC;
           q    : out STD_LOGIC);
end Edge_Detector;

architecture Behavioral of Edge_Detector is

type states is (ZERO, EDGE, ONE);
signal state_reg, state_next : states;

begin
process(rst, clk, en, state_reg, state_next)
begin

if (rst = '1') then
	state_reg <= ZERO;
elsif(rising_edge(clk)) then
	if (en = '1') then
		state_reg <= state_next;		
	end if;
end if;

end process;


process(state_reg, state_reg, d) 
begin
state_next <= state_reg;
--q <= (others =>'0');
q <= '0';

case state_reg is

when ZERO =>
	if(d = '1') then 
		state_next <= EDGE;	
		
	end if;

when EDGE =>
	q <= '1';
	if(d = '0') then
		state_next <= ZERO;
	else	
		state_next <= ONE;
	end if;


when ONE =>
	q <= '1';
	if(d = '0') then
		state_next <= ZERO;
	end if;
	
	end case;

end process;

end Behavioral;
