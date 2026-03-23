----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.03.2026 14:18:31
-- Design Name: 
-- Module Name: tb_clk_divider - Behavioral
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

entity tb_clk_divider is
end tb_clk_divider;

architecture Behavioral of tb_clk_divider is

component clk_divider is
    Port ( clk : in STD_LOGIC;
           res : in STD_LOGIC;
           tick : out STD_LOGIC);
end component;

signal clk : STD_LOGIC := '0';
signal res : STD_LOGIC := '1';
signal tick : STD_LOGIC;

begin

dut : clk_divider PORT MAP (clk => clk, res => res, tick => tick);

--Clock generation
--10 ns is the clock period of the Basys3 board.
--0.5 of the clock period is equal to 5 ns.
proc1 : process
begin
    while true loop
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end loop;
end process proc1;

--Activate the reset to start counting.
res <= '0' after 15 ns;

end Behavioral;