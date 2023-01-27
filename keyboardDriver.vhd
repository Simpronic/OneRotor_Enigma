----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.01.2023 10:08:36
-- Design Name: 
-- Module Name: keyboardDriver - Structural
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity keyboardDriver is
Port ( 
    clock: in std_logic;
    reset: in std_logic;
    ps2_clk: in std_logic;
    ps2_data: in std_logic;
    key_code: out std_logic_vector(4 downto 0);
    hasNewCode: out std_logic
);
end keyboardDriver;

architecture Structural of keyboardDriver is
component decoder_7_bit
Port ( 
    data_in: in std_logic_vector(7 downto 0);
    data_out: out std_logic_vector(4 downto 0)
);
end component;

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
signal keyboardCode: std_logic_vector(7 downto 0);
begin

ps2Driver: ps2_keyboard
port map(
  clk => clock,
  ps2_clk => ps2_clk,
  ps2_data => ps2_data,
  ps2_code_new => hasNewCode,
  ps2_code => keyboardCode
);

decoder: decoder_7_bit
port map(
    data_in => keyboardCode,
    data_out => key_code
);

end Structural;
