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

    Generic (Time_Unit : in INTEGER := 1);

    Port ( clk : IN STD_LOGIC; --clock signal of the system.
           Button_Mid : IN STD_LOGIC; --push middle button to get the reaction time.
           Button_Right : IN STD_LOGIC; --reset, push right button.
           LED_Start : OUT STD_LOGIC; --LED signaling the start.
           Anode : OUT STD_LOGIC_VECTOR(3 downto 0); --display on the monitor.
           dp : OUT STD_LOGIC; --the decimal point between the two digits.
           --Left_Segment : OUT STD_LOGIC_VECTOR(6 downto 0); --display on the 7-segment display.
           --Right_Segment : OUT STD_LOGIC_VECTOR(6 downto 0);
           Segment : OUT STD_LOGIC_VECTOR(6 downto 0)); --display on the 7-segment display.
end top_stop_timer;

architecture Structural of top_stop_timer is

--In this top module of the stop timer, all the formerly designed modules will be instatiated.

component clk_divider is

    GENERIC (Time_Unit : in INTEGER);

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
           Start : out STD_LOGIC;
           done : out STD_LOGIC);
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

component capture_register is
    Port ( clk : in STD_LOGIC;
           res : in STD_LOGIC;
           en : in STD_LOGIC;
           d : in STD_LOGIC_VECTOR (4 downto 0);
           q : out STD_LOGIC_VECTOR (4 downto 0));
end component;

component mux2x1 is
    Port ( sel : in STD_LOGIC;
           in1 : in STD_LOGIC_VECTOR (4 downto 0);
           in2 : in STD_LOGIC_VECTOR (4 downto 0);
           output : out STD_LOGIC_VECTOR (4 downto 0));
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

component multiplexer_select is
    Port ( clk : in STD_LOGIC;
           res : in STD_LOGIC;
           val : out STD_LOGIC);
end component;

component multiplexer_2x1 is
   Port (sel : in STD_LOGIC;
         in1 : in STD_LOGIC_VECTOR(6 downto 0);
         in2 : in STD_LOGIC_VECTOR(6 downto 0);
         dp : out STD_LOGIC;
         Anode : out STD_LOGIC_VECTOR(3 downto 0);
         output : out STD_LOGIC_VECTOR(6 downto 0) );
end component;


signal tick : STD_LOGIC; --the output of the clock divider module.

signal ready : STD_LOGIC; --the output of the down_counter module.

signal Start : STD_LOGIC; --the output of the control / FSM module. --will be connected to LED_Start.
signal done : STD_LOGIC; --the output of the control / FSM module. --will be used to choose between the registered values.
                          

signal value : STD_LOGIC_VECTOR(4 downto 0); --the output of the up_counter module.

signal value_out : STD_LOGIC_VECTOR(4 downto 0); --the output of the 5 bit register.

signal capt_value_out : STD_LOGIC_VECTOR(4 downto 0); --the output of the capture register.

signal muxed_value_out : STD_LOGIC_VECTOR(4 downto 0); --the output of the 2x1 mux between the registers.

signal left : STD_LOGIC_VECTOR(1 downto 0); --the calculated left number.
signal right : STD_LOGIC_VECTOR(3 downto 0); --the calculated right number.

signal seg_left : STD_LOGIC_VECTOR(6 downto 0); --the left output of the display logic.
signal seg_right : STD_LOGIC_VECTOR(6 downto 0); --the right output of the display logic.

signal sel_tick : STD_LOGIC; --the output of the clock divider module for multiplexer.

signal val : STD_LOGIC; --the output of the multiplexer_select module.

begin

--Instatiations
--change the clk on the right for the d_counter and u_counter to tick.
divider_one :   clk_divider         GENERIC MAP (9999999) PORT MAP (clk => clk, res => Button_Right, tick => tick);
d_counter :     down_counter        PORT MAP (clk => tick, res => Button_Right, out_val => OPEN, ready => ready);

controller :    control             PORT MAP (clk => clk, res => Button_Right, ready => ready, Button_Mid => Button_Mid, Start => Start, done => done);
u_counter :     up_counter          PORT MAP (clk => tick, Start => Start, Button_Mid => Button_Mid, out_val => value); --second position was res => Button_Right.
fb_register :   five_bit_reg        PORT MAP (clk => clk, res => Button_Right, d => value, q => value_out);
cap_regiser :   capture_register    PORT MAP (clk => clk, res => Button_Right, en => Button_Mid, d => value, q => capt_value_out);
mux_one :       mux2x1              PORT MAP (sel => done, in1 => value_out, in2 => capt_value_out, output => muxed_value_out);

arithmetics:    display_arithmetics PORT MAP (value => muxed_value_out, point => OPEN, left => left, right => right);
display :       display_logic       PORT MAP (left => left, right => right, 
                                                --seg_left => Left_Segment, 
                                                seg_left => seg_left,
                                                seg_right => seg_right);
divider_two :   clk_divider         GENERIC MAP (99999) PORT MAP (clk => clk, res => Button_Right, tick => sel_tick);
selector :      multiplexer_select  PORT MAP (clk => sel_tick, res => Button_Right, val => val); --change clk right to sel_tick.
mux_two :       multiplexer_2x1     PORT MAP (sel => val, in1 => seg_right, in2 => seg_left, dp => dp, Anode => Anode, output => Segment);

--Only for testing:
--Hardwire the 7-segment display to use the fourth digit.
--Anode <= "1110";

--Assign the LED_Stat signal.
--Using the xor with the done signal to turn the light off once the value has been captured.
--In LED state of the FSM, Start is '1' while done is '0', resulting in this xor operation to give a '1'.
--In result state of the FSM, Start is '1' and done is '1' as well, resulting in this xor operation to give a '0';
LED_Start <= Start xor done;

end Structural;