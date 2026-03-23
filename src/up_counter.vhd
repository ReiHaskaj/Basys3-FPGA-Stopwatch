----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.03.2026 17:40:30
-- Design Name: 
-- Module Name: up_counter - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity up_counter is
  Port ( clk : IN STD_LOGIC;
         res : IN STD_LOGIC;
         out_val : OUT STD_LOGIC_VECTOR(4 downto 0));
end up_counter;

architecture Behavioral of up_counter is

--This counter increments to the value 19.
--It represents the 20 time units (0 -> 19) allowed in order to press the button on the board.
--It uses the ticks from the clock divvider as the clock input.

signal cnt : STD_LOGIC_VECTOR(4 downto 0);

begin

proc1 : process(clk)
begin

    if(rising_edge(clk)) then
        if(res = '1') then
            cnt <= (others => '0');
        else 
            if(cnt = "10011") then
                cnt <= (others => '0');
            else
                cnt <= std_logic_vector(unsigned(cnt) + 1);
            end if;
        end if;
    end if;

end process proc1;

end Behavioral;