----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2026 11:20:52
-- Design Name: 
-- Module Name: display_arithmetics - Behavioral
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

entity display_arithmetics is
    Port ( value : in STD_LOGIC_VECTOR (4 downto 0);
           point : out STD_LOGIC;
           left : out STD_LOGIC_VECTOR (1 downto 0);
           right : out STD_LOGIC_VECTOR (3 downto 0));
end display_arithmetics;

architecture Behavioral of display_arithmetics is

--The left number on the display represents the number of seconds it took to get the user's reaction.
--The left number on the display comes from the mathematical divison ( / ) of the value from the up_counter with the number 10.
--The right number on the display represents the number of 0.1 seconds it took to get the user's reaction.
--The right number on the display comes from the mathematical rest division ( % ) of the value from the up_counter with the number 10.
--The output point represents the point / comma for a floating number.

signal leftt : std_logic_vector(4 downto 0);
signal rightt : std_logic_vector(4 downto 0);

begin

leftt <= std_logic_vector(unsigned(value) / 10);
rightt <= std_logic_vector(unsigned(value) mod 10);

--Alternatively, instead of using the mod, one could calcuate the rightt signal as follows:
--rightt = value - leftt * 10.
--In this case a process would be needed, since the leftt needs to be calculated first and then the rightt would depend on that.

--Handling the point signal.
proc1 : process(rightt, leftt)
begin
if (rightt /= "00000" or leftt /= "00000") then
    point <= '1';
else
    point <= '0';
end if;    
end process proc1;

--Assigning the outputs:
--Only 2 bits needed to represent the left number since limit of 20 time units is set -> left is either 0, 1, or 2.
--Four bits needed to represent the right number, since it can be any number between 0 and 9. If it is 9, 4 bits are needed (1001).
left <= leftt(1 downto 0);
right <= rightt(3 downto 0);

end Behavioral;