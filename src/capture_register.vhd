----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.03.2026 13:53:55
-- Design Name: 
-- Module Name: capture_register - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity capture_register is
    Port ( clk : in STD_LOGIC;
           res : in STD_LOGIC;
           en : in STD_LOGIC;
           d : in STD_LOGIC_VECTOR (4 downto 0);
           q : out STD_LOGIC_VECTOR (4 downto 0));
end capture_register;

architecture Behavioral of capture_register is

--This register serves to capture the timer value upon pressing the middle button on the Basys3 board.
--It is reset through the same reset signal as all of the other modules (Button_Right).
--Button_Mid acts as an enable signal here.
--If Button_Mid is pressed, then the value will be assigned to the output.

begin

proc1 : process(clk)
begin

    if(rising_edge(clk)) then
        if (res = '0') then
            if (en = '1') then
                q <= d;
            end if;
        end if;
    end if;

end process proc1;


end Behavioral;
