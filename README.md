# Basys3 FPGA Stopwatch

This project implements a stopwatch on the Basys3 FPGA board using VHDL. The design uses the onboard 100 MHz clock and displays the time on the 7-segment display.

The stopwatch can be started, stopped and reset using the board buttons.

The middle button is used to calculate the user's reaction time, while the right button starts the stopwatch.

---

## Features

- Control logic.
- Time display on 7-segment display.  
- Clock divider to generate slower timing signals.  
- Modular design (counter, registers, multiplexers).

---

## How it works

The system takes the 100 MHz clock from the board and divides it down to a lower frequency.This slower clock is used to increment the counter.

The counter value is converted to 7-segment signals and shown on the display.

Buttons are used as inputs to control the state of the stopwatch.

---

## Project structure

- Top module.  
- Clock divider to generate a slower clock. 
- A downwards counter to generate the start signal for the stopwatch.
- An upwards counter that counts time.
- Register to save the value of the upwards counter.  
- Register to save the captured time value.
- Multiplexers.
- Modules to handle the 7-segment display.
- Testbenches.
- Constraints (I/O) based on the master.xdc file : https://github.com/Digilent/digilent-xdc/blob/master/Basys-3-Master.xdc.

---

## Requirements

- Basys3 FPGA board (Artix-7).
- Micro USB connection cable.  
- Vivado Design Suite.  

---

## Notes

The design focuses on simple structure and readability.