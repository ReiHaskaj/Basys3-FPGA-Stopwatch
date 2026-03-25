----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.03.2026 11:59:32
-- Design Name: 
-- Module Name: top_stop_timer - Structural
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

entity top_stop_timer is
    Port ( clk : IN STD_LOGIC; --clock signal of the system.
           Button_Mid : IN STD_LOGIC; --push middle button to get the reaction time.
           Button_Right : IN STD_LOGIC; --reset, push right button.
           LED_Start : OUT STD_LOGIC; --LED signaling the start.
           Anode : OUT STD_LOGIC_VECTOR(3 downto 0); --display on the monitor.
           --Left_Segment : OUT STD_LOGIC_VECTOR(6 downto 0); --display on the 7-segment display.
           Right_Segment : OUT STD_LOGIC_VECTOR(6 downto 0)); --display on the 7-segment display.
end top_stop_timer;

architecture Structural of top_stop_timer is

--In this top module of the stop timer, all the formerly designed modules will be instatiated.

component clk_divider is
    Port ( clk : in STD_LOGIC;
           res : in STD_LOGIC;
           tick : out STD_LOGIC);
end component;

component down_counter is
    Port ( clk : in STD_LOGIC;
           res : in STD_LOGIC;
           out_val : out STD_LOGIC_VECTOR (4 downto 0);
           ready : out STD_LOGIC);
end component;

component control is
    Port ( clk : in STD_LOGIC;
           res : in STD_LOGIC;
           ready : in STD_LOGIC;
           Button_Mid : in STD_LOGIC;
           Start : out STD_LOGIC);
end component;

component up_counter is
  Port ( clk : IN STD_LOGIC;
         --res : IN STD_LOGIC;
         Start : IN STD_LOGIC;
         Button_Mid : IN STD_LOGIC;
         out_val : OUT STD_LOGIC_VECTOR(4 downto 0));
end component;

component five_bit_reg is
  Port (clk : in STD_LOGIC;
        res : in STD_LOGIC;
        d : in STD_LOGIC_VECTOR(4 downto 0);
        q : out STD_LOGIC_VECTOR(4 downto 0));
end component;

component display_arithmetics is
    Port ( value : in STD_LOGIC_VECTOR (4 downto 0);
           point : out STD_LOGIC;
           left : out STD_LOGIC_VECTOR (1 downto 0);
           right : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component display_logic is
    Port ( left : in STD_LOGIC_VECTOR (1 downto 0);
           right : in STD_LOGIC_VECTOR (3 downto 0);
           --false_input : in STD_LOGIC; --in order to display F if button pressed before LED was turned on.
           seg_left : out STD_logic_vector (6 downto 0);
           seg_right : out STD_LOGIC_VECTOR (6 downto 0));
end component;


signal tick : STD_LOGIC; --the output of the clock divider module.

signal ready : STD_LOGIC; --the output of the down_counter module.

signal Start : STD_LOGIC; --the output of the control / FSM module.
                          --will be connected to LED_Start.

signal value : STD_LOGIC_VECTOR(4 downto 0); --the output of the up_counter module.

signal value_out : STD_LOGIC_VECTOR(4 downto 0); --the output of the 5 bit register.

signal left : STD_LOGIC_VECTOR(1 downto 0); --the calculated left number.
signal right : STD_LOGIC_VECTOR(3 downto 0); --the calculated right number.

begin

--Instatiations
--change the clk on the right for the d_counter and u_counter to tick.
divider :       clk_divider         PORT MAP (clk => clk, res => Button_Right, tick => tick);
d_counter :     down_counter        PORT MAP (clk => tick, res => Button_Right, out_val => OPEN, ready => ready);
controller :    control             PORT MAP (clk => clk, res => Button_Right, ready => ready, Button_Mid => Button_Mid, Start => Start);
u_counter :     up_counter          PORT MAP (clk => tick, Start => Start, Button_Mid => Button_Mid, out_val => value); --second position was res => Button_Right.
fb_register :   five_bit_reg        PORT MAP (clk => clk, res => Button_Right, d => value, q => value_out);
arithmetics:    display_arithmetics PORT MAP (value => value_out, point => OPEN, left => left, right => right);
display :       display_logic       PORT MAP (left => left, right => right, 
                                                --seg_left => Left_Segment, 
                                                seg_right => Right_Segment);

--Hardwire the 7-segment display to use the first and second digits.
Anode <= "1100";

--Assign the LED_Stat signal.
LED_Start <= Start;

end Structural;