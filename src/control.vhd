----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2026 09:48:00
-- Design Name: 
-- Module Name: control - Behavioral
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

entity control is
    Port ( clk : in STD_LOGIC;
           res : in STD_LOGIC;
           ready : in STD_LOGIC;
           Button_Mid : in STD_LOGIC;
           Start : out STD_LOGIC;
           --false_input : out STD_LOGIC;
           done : out STD_LOGIC); --new signal, will be used in the up_counter module as an enable.
end control;

architecture Behavioral of control is

--This module represents the FSM used to control the stop timer.
--There are 4 states in total:
--1) Idle: The initial state.
--2) Waiting: Once restart button is pressed, we wait for the LED to go on.
--3) LED is on: The timer goes on and the user needs to react by pressing the middle button as soon as possible.
--4) Result: The button was pressed and the reaction time result is displayed.


type states is (idle, waiting, LED, result);
signal current_state, next_state : states;

begin


--StateMem
StateMem : process(clk)
begin

    if(rising_edge(clk)) then
        if(res = '1') then
            current_state <= idle;
        else
            current_state <= next_state;
        end if;
    end if;

end process StateMem;


--NextStateLogic
NextStateLogic : process(current_state, ready, Button_Mid)
begin

case (current_state) is

    when idle => next_state <= waiting;
    
    --Update : The state transitions from the waiting state should not depend
    --         on the Button_Mid
    --Before:
    
--    when waiting => if (ready = '0' and Button_Mid = '0') then
--                        next_state <= waiting;
--                    elsif (ready = '1' and Button_Mid = '0') then
--                        next_state <= LED;
--                    else
--                        next_state <= waiting; --was result
--                    end if;

    when waiting => if (ready = '0') then
                            next_state <= waiting;
                        else
                            next_state <= LED;
                        end if;
                        
    when LED => if (Button_Mid = '0') then
                    next_state <= LED;
                else 
                    next_state <= result;
                end if;
    
    --Update: There is no reason to keep staying at result state for the moment.
    --Before:      
--    when result => if (Button_Mid = '0') then
--                       next_state <= idle;
--                   else
--                       next_state <= result;
--                   end if;

    --Update : Try to get stuck at result.
    when result => next_state <= result; --was idle.
     
end case;

end process NextStateLogic;


--OutputLogic
--Update : Since the counting on the up_counter module depends on the Start signal and the current_state is updated 
--         with the next_state on the rising_edge of the clock, then we can actually set the Start to be '1' when the 
--         next_state is LED. However, this small delay will be ignored for now.
OutputLogic : process(current_state)
begin

case (current_state) is 
    
    when idle =>    Start <= '0'; done <= '0';
    when waiting => Start <= '0'; done <= '0';
    when LED =>     Start <= '1'; done <= '0';
    when result =>  Start <= '1'; done <= '1';  --Start was '0' earlier.
    
end case;

end process OutputLogic;

end Behavioral;