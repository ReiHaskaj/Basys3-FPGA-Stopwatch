----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2026 10:14:21
-- Design Name: 
-- Module Name: tb_control - Behavioral
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

entity tb_control is
end tb_control;

architecture Behavioral of tb_control is

--This testbench serves to check the functionality of the control module.

component control is
    Port ( clk : in STD_LOGIC;
           res : in STD_LOGIC;
           ready : in STD_LOGIC;
           Button_Mid : in STD_LOGIC;
           Start : out STD_LOGIC);
end component;

--Inputs
signal clk : STD_LOGIC := '0';
signal res : STD_LOGIC := '1';
signal ready : STD_LOGIC := '0';
signal Button_Mid : STD_LOGIC := '0';

--Output
signal Start : STD_LOGIC;


begin


dut : control PORT MAP (clk => clk, res => res, ready => ready, Button_Mid => Button_Mid, Start => Start);

--Clock generator
proc1 : process
begin

    while true loop
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end loop;

end process proc1;


--Restart, ready and Button_Mid signals handling
res <= '0' after 15 ns;

proc2 : process
begin
    wait for 50 ns;
    ready <= '1';
    wait for 20 ns;
    ready <= '0';
    
    wait for 200 ns;
    Button_Mid <= '1';
    wait for 50 ns;
    Button_Mid <= '0';
    
end process proc2;

end Behavioral;
