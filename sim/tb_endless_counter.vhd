----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.03.2026 15:32:53
-- Design Name: 
-- Module Name: tb_endless_counter - Behavioral
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

entity tb_endless_counter is
end tb_endless_counter;

architecture Behavioral of tb_endless_counter is

component endless_counter is
    Port ( clk : in STD_LOGIC;
           res : in STD_LOGIC;
           cnt : out STD_LOGIC_VECTOR(31 downto 0));
end component;

signal clk : STD_LOGIC := '0';
signal res : STD_LOGIC := '1';
signal cnt : STD_LOGIC_VECTOR(31 downto 0);

begin

dut : endless_counter PORT MAP (clk => clk, res => res, cnt => cnt);

--Clock generation
--10 ns is the clock period of the Basys3 board.
proc1 : process
begin
    while true loop
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
     end loop;
end process proc1;
        
--activate the reset to start counting.
res <= '0' after 15 ns;

end Behavioral;