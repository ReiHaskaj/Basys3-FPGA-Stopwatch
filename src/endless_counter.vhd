----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.03.2026 15:24:03
-- Design Name: 
-- Module Name: endless_counter - Behavioral
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

entity endless_counter is
    Port ( clk : in STD_LOGIC;
           res : in STD_LOGIC;
           cnt : out STD_LOGIC_VECTOR(31 downto 0));
end endless_counter;

architecture Behavioral of endless_counter is

--This counter serves to provide an input for the LED which starts the stop timer.
--It is an endless counter, that provides an output once the restart button on the board is pressed.

signal counter_val : STD_LOGIC_VECTOR(31 downto 0);

begin

--Endless counter for res = 0.
proc1 : process(clk)
begin

    if(rising_edge(clk)) then
        if(res = '1') then
            counter_val <= (others => '0');
        else
            counter_val <= std_logic_vector(unsigned(counter_val) + 1);
        end if;
    end if;

end process proc1;


--Assigning the counter_val to the output cnt.
cnt <= counter_val;

end Behavioral;