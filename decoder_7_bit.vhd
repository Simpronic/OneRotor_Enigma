----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.01.2023 13:02:16
-- Design Name: 
-- Module Name: decoder_7_bit - Behavioral
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

entity decoder_7_bit is
Port ( 
    data_in: in std_logic_vector(7 downto 0);
    data_out: out std_logic_vector(4 downto 0)
);
end decoder_7_bit;

architecture Behavioral of decoder_7_bit is

begin 
data_out <= "00000" when data_in = "00011100" else 
            "00001" when data_in = "00110010" else
            "00010" when data_in = "00100001" else
            "00011" when data_in = "00100011" else
            "00100" when data_in = "00100100" else
            "00101" when data_in = "00101011" else
            "00110" when data_in = "00110100" else
            "00111" when data_in = "00110011" else
            "01000" when data_in = "01000011" else
            "01001" when data_in = "00111011" else
            "01010" when data_in = "01000010" else
            "01011" when data_in = "01001011" else
            "01100" when data_in = "00111010" else
            "01101" when data_in = "00110001" else
            "01110" when data_in = "01000100" else
            "01111" when data_in = "01001101" else
            "10000" when data_in = "00010101" else
            "10001" when data_in = "00101101" else
            "10010" when data_in = "00011011" else
            "10011" when data_in = "00101100" else
            "10100" when data_in = "00111100" else
            "10101" when data_in = "00101010" else
            "10110" when data_in = "00011101" else
            "10111" when data_in = "00100010" else
            "11000" when data_in = "00110101" else
            "11001" when data_in = "00011010" else
            (others => '1');

end Behavioral;
