----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.03.2026 17:40:30
-- Design Name: 
-- Module Name: up_counter - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity up_counter is
  Port ( clk : IN STD_LOGIC;
         --res : IN STD_LOGIC;
         Start : IN STD_LOGIC;
         done : IN STD_LOGIC;
         out_val : OUT STD_LOGIC_VECTOR(4 downto 0));
end up_counter;

architecture Behavioral of up_counter is

--This counter increments to the value 19.
--It represents the 20 time units (0 -> 19) allowed in order to press the button on the board.
--It uses the ticks from the clock divvider as the clock input.
--Synchronus reset and synchronus enable.

--Update: After testing the top module, observed that the up_counter starts counting with the system restart signal (Button_Right)
--Actually, the up_counter should start counting once the Start signal is set to HIGH ('1') in the FSM.
--The actual reset of this counter is the Start signal.

signal cnt : STD_LOGIC_VECTOR(4 downto 0);

begin

proc1 : process(clk)
begin

    if(rising_edge(clk)) then
        if(Start = '0') then --was res previously and it was being evaluated at the value '1'.
            cnt <= (others => '0');
        else
            --do i even need the done or button mid at all? --if (done = '0') then --was checking Start = '1' and Button_Mid = '0' previously --update 2: got rid of the Button_Mid in this module.
                if(cnt = "10011") then
                    cnt <= (others => '0');
                else
                    cnt <= std_logic_vector(unsigned(cnt) + 1);
                end if;
            --end if;
        end if;
    end if;

end process proc1;

--Assigning the out_val output.
out_val <= cnt;

end Behavioral;