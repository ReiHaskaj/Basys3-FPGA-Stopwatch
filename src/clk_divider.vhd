----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.03.2026 12:26:33
-- Design Name: 
-- Module Name: clk_divider - Behavioral
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
--Update 1 : This divider can be used to generate the ticks every 0.1 seconds.
--This is used by both of the up_counter and down_counter modules.

--Update 2 : In order to reuse this same module for generating ticks every s, ms, us, ns, or 
--any other time units, we need a generic.
--The decisive number of cycles is presented in line __. Depending on the desired sampling speed,
--this number can change. -> use generic for this module.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clk_divider is

    Generic (Time_Unit : in INTEGER);
    
    Port ( clk : in STD_LOGIC;
           res : in STD_LOGIC;
           tick : out STD_LOGIC);
end clk_divider;

architecture Behavioral of clk_divider is

--The Basys3 board has a 100Mhz clk signal.
--If we want to calculate reaction time on the scale of 1/10 seconds, we need a clock divider to tick every 1/10 seconds.
--The clock period can be calculated to 1 / 100 Mhz = 10^(-8) seconds.
--So 1 second is equivalent to 10^8 clock periods and 2 seconds to 2 * 10^8 clock periods respectively.
--The chosen maximum reaction time for this project is 2 seconds, meaning 20 ticks is a maximum.
--We need to count up to 2 * 10^8 and produce 20 ticks.
--In order to count up to 2 * 10^8 we need 28 bits (calculated in MATLAB).

signal counter_val : STD_LOGIC_VECTOR(27 downto 0);

begin

--To count from 0s to 0.1s.
proc1 : process(clk)
begin
        if(rising_edge(clk)) then
        
            if(res = '1') then
                counter_val <= (others => '0');
                tick <= '0';
                else
                    if(unsigned(counter_val) = (Time_Unit - 1)) then --was previosly 9999999 for a tick every 0.1 s.
                        counter_val <= (others => '0');
                        tick <= '1';
                    else
                        counter_val <= std_logic_vector(unsigned(counter_val) + 1);
                        tick <= '0';
                    end if;
            end if;
        end if;

end process proc1;

end Behavioral;