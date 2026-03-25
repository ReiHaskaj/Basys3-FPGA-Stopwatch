----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2026 15:11:52
-- Design Name: 
-- Module Name: display_logic - Behavioral
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

entity display_logic is
    Port ( left : in STD_LOGIC_VECTOR (1 downto 0);
           right : in STD_LOGIC_VECTOR (3 downto 0);
           --false_input : in STD_LOGIC; --in order to display F if button pressed before LED was turned on.
           seg_left : out STD_logic_vector (6 downto 0);
           seg_right : out STD_LOGIC_VECTOR (6 downto 0));
end display_logic;

architecture Behavioral of display_logic is

--Depending on the left and right numbers, some logic is needed to present these in the 7-segment-display.
--Update : Segment is ON on 0 -> flip the bits for both processes.

begin

proc1 : process(left)
begin

case (left) is
    when "00" =>    seg_left <= "0000001"; --display 0
    when "01" =>    seg_left <= "1001111"; --display 1
    when "10" =>    seg_left <= "0010010"; --display 2 1101101
    when others =>  seg_left <= "0111000"; --display F 1000111
end case;

end process proc1;

proc2 : process(right)
begin

case (right) is
    when "0000" =>    seg_right <= "0000001"; --display 0
    when "0001" =>    seg_right <= "1001111"; --display 1
    when "0010" =>    seg_right <= "0010010"; --display 2
    when "0011" =>    seg_right <= "0000110"; --display 3 1111001
    when "0100" =>    seg_right <= "1001100"; --display 4 0110011
    when "0101" =>    seg_right <= "0100100"; --display 5 1011011
    when "0110" =>    seg_right <= "0100000"; --display 6 1011111
    when "0111" =>    seg_right <= "0001111"; --display 7 1110000
    when "1000" =>    seg_right <= "0000000"; --display 8 1111111
    when "1001" =>    seg_right <= "0001100"; --display 9 1110011
    when others =>    seg_right <= "0111000"; --display F
end case;

end process proc2;


end Behavioral;