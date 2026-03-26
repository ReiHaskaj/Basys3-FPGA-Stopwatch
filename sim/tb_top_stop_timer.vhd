----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2026 16:18:41
-- Design Name: 
-- Module Name: tb_top_stop_timer - Behavioral
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

entity tb_top_stop_timer is
end tb_top_stop_timer;

architecture Behavioral of tb_top_stop_timer is

--The purposeof this module is to test the timer.

component top_stop_timer is
    
    Generic (Time_Unit : in INTEGER);

    Port ( clk : IN STD_LOGIC; --clock signal of the system.
           Button_Mid : IN STD_LOGIC; --push middle button to get the reaction time.
           Button_Right : IN STD_LOGIC; --reset, push right button.
           LED_Start : OUT STD_LOGIC; --LED signaling the start.
           Anode : OUT STD_LOGIC_VECTOR(3 downto 0); --display on the monitor.
           Segment : OUT STD_LOGIC_VECTOR(6 downto 0));
           --Left_Segment : OUT STD_LOGIC_VECTOR(6 downto 0); --display on the 7-segment display.
           --Right_Segment : OUT STD_LOGIC_VECTOR(6 downto 0)); --display on the 7-segment display.
end component;

--Inputs
constant TU : INTEGER := 9999999;
signal clk : STD_LOGIC :='0';
signal Button_Mid : STD_LOGIC :='0';
signal Button_Right : STD_LOGIC :='1';

--Outputs
signal LED_Start : STD_LOGIC;
signal Anode : STD_LOGIC_VECTOR(3 downto 0);
signal Segment : STD_LOGIC_VECTOR(6 downto 0);
--signal Left_Segment : STD_LOGIC_VECTOR(6 downto 0);
--signal Right_Segment : STD_LOGIC_VECTOR(6 downto 0);


begin

dut : top_stop_timer GENERIC MAP (TU)   PORT MAP (clk => clk, 
                                                  Button_Mid => Button_Mid, 
                                                  Button_Right => Button_Right, 
                                                  LED_Start => LED_Start, 
                                                  Anode => Anode, 
                                                  Segment => Segment);
                                                  --Left_Segment => Left_Segment, 
                                                  --Right_Segment => Right_Segment);
                               
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

--Reset
Button_Right <= '0' after 20 ns;

--Button Pressed
--Button_Mid <= '1' after 500 ns;  --300ns was not enough
                                 --5000 ms

-- Pulse generation
    pulse_process : process
    begin
        -- Initial low
        --Button_Mid <= '0';
        wait for 500 ns;

        -- Generate a high pulse of 10 ns
        Button_Mid <= '1';
        wait for 10 ns;
        Button_Mid <= '0';
        
     end process pulse_process;

end Behavioral;
