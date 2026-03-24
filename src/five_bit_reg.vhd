----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2026 10:16:44
-- Design Name: 
-- Module Name: 6_bit_reg - Behavioral
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

entity five_bit_reg is
  Port (clk : in STD_LOGIC;
        res : in STD_LOGIC;
        d : in STD_LOGIC_VECTOR(4 downto 0);
        q : out STD_LOGIC_VECTOR(4 downto 0));
end five_bit_reg;

architecture Behavioral of five_bit_reg is

--This register will be used to save the value from the up_counter.
--The output will be directly connected to the display.

begin

proc1 : process(clk)
begin

    if(rising_edge(clk)) then
    
        if(res = '0') then
        
            q <= d;
        
        end if;
        
    end if;

end process proc1;


end Behavioral;
