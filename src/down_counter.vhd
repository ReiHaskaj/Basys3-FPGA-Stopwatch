----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.03.2026 17:52:13
-- Design Name: 
-- Module Name: down_counter - Behavioral
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

entity down_counter is
    Port ( clk : in STD_LOGIC;
           res : in STD_LOGIC;
           out_val : out STD_LOGIC_VECTOR (4 downto 0);
           ready : out STD_LOGIC);
end down_counter;

architecture Behavioral of down_counter is

--This counter decrements from 29.
--It represents the 30 time units (29 -> 0) following the restart of the system.
--When the count value 0 is reached, the ready signals goes to logic HIGH ('1').
--It will be used to light up the LED.
--It uses the ticks from the clock divvider as the clock input.

signal cnt : STD_LOGIC_VECTOR(4 downto 0);

begin

proc1 : process(clk)
begin

    if(rising_edge(clk)) then
        if(res = '1') then
            cnt <= "11101";
            ready <= '0';
        else
            if(cnt = "00000") then
                cnt <= "11101";
                ready <= '1';
            else
                cnt <= std_logic_vector(unsigned(cnt) - 1);
                ready <= '0';
            end if;
        end if;
    end if;

end process proc1;


--Assigning out_val.
out_val <= cnt;

end Behavioral;