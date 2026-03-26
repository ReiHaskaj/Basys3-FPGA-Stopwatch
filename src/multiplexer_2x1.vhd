----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.03.2026 12:58:39
-- Design Name: 
-- Module Name: multiplexer_2x1 - Behavioral
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

entity multiplexer_2x1 is
   Port (sel : in STD_LOGIC;
         in1 : in STD_LOGIC_VECTOR(6 downto 0);
         in2 : in STD_LOGIC_VECTOR(6 downto 0);
         dp : out STD_LOGIC;
         Anode : out STD_LOGIC_VECTOR(3 downto 0);
         output : out STD_LOGIC_VECTOR(6 downto 0) );
end multiplexer_2x1;

architecture Behavioral of multiplexer_2x1 is

--This multiplexer module decides which of the digits in the 7-segment display will be turned
--as well as the numbers it will show (seconds or 1/10 of seconds).
--Digit 4 : 1/10 seconds <=> Anode is "1110" and in1 is right_segment.
--Digit 3 : seconds <=> Anode is "1101" and in2 is left_segment.

begin

proc1 : process(sel, in1, in2)
begin

case (sel) is

    when '0' => Anode <= "1110";
                dp <= '1';
                output <= in1; 
                
    when '1' => Anode <= "1101";
                dp <= '0';
                output <= in2;
                
    when others => Anode <= "0000";
                   dp <= 'X';
                   output <= "XXXXXXX";
                   
end case;

end process proc1;


end Behavioral;
