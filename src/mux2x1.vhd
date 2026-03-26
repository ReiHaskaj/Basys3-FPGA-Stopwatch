----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.03.2026 14:16:42
-- Design Name: 
-- Module Name: mux2x1 - Behavioral
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

entity mux2x1 is
    Port ( sel : in STD_LOGIC;
           in1 : in STD_LOGIC_VECTOR (4 downto 0);
           in2 : in STD_LOGIC_VECTOR (4 downto 0);
           output : out STD_LOGIC_VECTOR (4 downto 0));
end mux2x1;

architecture Behavioral of mux2x1 is

--This multiplexer will choose which weather the output of the 
--capture register or the running register will be propagated further.

begin

proc1 : process(sel, in1, in2)
begin

    case (sel) is 
        
        when '0' => output <= in1;
        when '1' => output <= in2;
        when others => output <= "XXXXX";
        
    end case;

end process proc1;


end Behavioral;
