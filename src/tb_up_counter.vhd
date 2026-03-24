----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2026 11:03:05
-- Design Name: 
-- Module Name: tb_up_counter - Behavioral
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

entity tb_up_counter is
end tb_up_counter;

architecture Behavioral of tb_up_counter is

--This testbench serves to check the functionality of the up_counter module.

component up_counter is
  Port ( clk : IN STD_LOGIC;
         --res : IN STD_LOGIC;
         Start : IN STD_LOGIC;
         Button_Mid : IN STD_LOGIC;
         out_val : OUT STD_LOGIC_VECTOR(4 downto 0));
end component;

--Inputs
signal clk : STD_LOGIC := '0';
--signal res : STD_LOGIC := '1';
signal Start : STD_LOGIC := '0';
signal Button_Mid : STD_LOGIC := '0';

--Output
signal out_val : STD_LOGIC_VECTOR(4 downto 0);

begin

dut : up_counter PORT MAP (clk => clk, 
                           --res => res, 
                           Start => Start, 
                           Button_Mid => Button_Mid, 
                           out_val => out_val);

--Generate clock signal
proc1 : process
begin
    while true loop
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end loop;
end process proc1;

--Handling the restart signal
--res <= '0' after 20 ns;
Start <= '1' after 500 ns;

--Handling the Start and Button_Mid signals
proc2 : process
begin
--        wait for 50 ns;
--        Start <= '1';
--        wait for 100 ns;
--        Start <= '0';
        
        wait for 80 ns;
        Button_Mid <= '1';
        wait for 100 ns;
        Button_Mid <= '0';

end process proc2;

end Behavioral;
