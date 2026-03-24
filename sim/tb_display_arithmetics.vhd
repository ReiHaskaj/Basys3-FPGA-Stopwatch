----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2026 11:55:54
-- Design Name: 
-- Module Name: tb_display_arithmetics - Behavioral
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

entity tb_display_arithmetics is
end tb_display_arithmetics;

architecture Behavioral of tb_display_arithmetics is

--This testbench serves to check the functionality of the display_arithmetics module.

component display_arithmetics is
    Port ( value : in STD_LOGIC_VECTOR (4 downto 0);
           point : out STD_LOGIC;
           left : out STD_LOGIC_VECTOR (1 downto 0);
           right : out STD_LOGIC_VECTOR (3 downto 0));
end component;

--Input
signal value : std_logic_vector(4 downto 0) := (others => '0');

--Outputs
signal point : std_logic;
signal left : std_logic_vector(1 downto 0);
signal right : std_logic_vector(3 downto 0);

begin

dut : display_arithmetics PORT MAP (value => value, point => point , left => left, right => right);

--Change the signal value.
value <= "01111" after 40 ns;

end Behavioral;