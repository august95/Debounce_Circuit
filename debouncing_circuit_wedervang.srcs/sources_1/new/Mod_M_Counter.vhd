----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.10.2020 13:26:11
-- Design Name: 
-- Module Name: mod_m_counter - Behavioral
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

entity mod_m_counter is
    generic(
    N : integer := 16;
    M : integer := 4);

    Port ( rst      : in STD_LOGIC;
           en       : in STD_LOGIC;
           clk      : in STD_LOGIC;
           q        : out STD_LOGIC_VECTOR (M-1 downto 0);
           max_tick : out std_logic);
end mod_m_counter;

architecture Behavioral of mod_m_counter is
signal current_state, next_state : unsigned(M -1 downto 0);

begin
	process(rst, clk)
	begin
		if(rst = '1') then 
			current_state <= (others => '0');
		elsif (rising_edge(clk)) then --(clk'event and clk = '1')
			if(en = '1' ) then
				current_state <= next_state;
			end if;
		end if;
	end process;

--next state logic

------input : r_reg
------output : r_next
  next_state <= (others => '0') when current_state = N-1 else
			  current_state +1;

 -------r_reg and external input signal 
	 q <= std_logic_vector(current_state);
	 max_tick <= '1' when current_state = N-1 else
				'0';

end Behavioral;
