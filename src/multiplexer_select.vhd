----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.03.2026 10:08:54
-- Design Name: 
-- Module Name: multiplexer_select - Behavioral
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

entity multiplexer_select is
    Port ( clk : in STD_LOGIC;
           res : in STD_LOGIC;
           val : out STD_LOGIC);
end multiplexer_select;

architecture Behavioral of multiplexer_select is

--This module provides the signal to trigger which one of the anodes will be on.

signal tmp : STD_LOGIC;

begin

proc1 : process(clk)
begin

if(rising_edge(clk)) then
    if(res = '1') then
        tmp <= '0';
    else
        if (tmp = '1') then
            tmp <= '0';
        else
            tmp <= tmp or '1';
        end if;
    end if;
end if;

end process proc1;

--Assigning the output:
val <= tmp;


end Behavioral;
