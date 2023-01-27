----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.01.2023 12:21:19
-- Design Name: 
-- Module Name: keyboardCommunication - Structural
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

entity keyboardCommunication is
Port ( 
 led_out: out std_logic_vector(7 downto 0);
 anodes_out: out std_logic_vector(7 downto 0);
 ps2_clk: in std_logic;
 ps2_data: in std_logic;
 clock: in std_logic
);
end keyboardCommunication;

architecture Structural of keyboardCommunication is
component ps2_keyboard
GENERIC(
    clk_freq              : INTEGER := 100_000_000; --system clock frequency in Hz
    debounce_counter_size : INTEGER := 8);         --set such that (2^size)/clk_freq = 5us (size = 8 for 50MHz)
  PORT(
    clk          : IN  STD_LOGIC;                     --system clock
    ps2_clk      : IN  STD_LOGIC;                     --clock signal from PS/2 keyboard
    ps2_data     : IN  STD_LOGIC;                     --data signal from PS/2 keyboard
    ps2_code_new : OUT STD_LOGIC;                     --flag that new PS/2 code is available on ps2_code bus
    ps2_code     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)); --code received from PS/2
end component;

component cathodes_manager
    Port ( value : in  STD_LOGIC_VECTOR (4 downto 0); 
           dot : in  STD_LOGIC; 
           cathodes_dot : out  STD_LOGIC_VECTOR (7 downto 0)); 
end component;

component decoder_7_bit
Port ( 
    data_in: in std_logic_vector(7 downto 0);
    data_out: out std_logic_vector(4 downto 0)
);
end component;


signal newCode: std_logic;
signal ps2Code: std_logic_vector(7 downto 0);
signal out_from_coder: std_logic_vector(4 downto 0);
begin
ps2_driver: ps2_keyboard
port map(
    clk => clock,
    ps2_clk => ps2_clk,
    ps2_data => ps2_data,
    ps2_code_new => newCode,
    ps2_code => ps2Code
);
catMan: cathodes_manager
port map(
    value => out_from_coder,
    dot => '0',
    cathodes_dot => led_out
);
decoder: decoder_7_bit
port map(
    data_in => ps2Code,
    data_out => out_from_coder
);
anodes_out <= not("00000001");
end Structural;
