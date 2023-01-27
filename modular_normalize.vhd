----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.01.2023 15:57:17
-- Design Name: 
-- Module Name: modular_normalize - Behavioral
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
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity modular_normalize is
Port ( 
    data_in: in std_logic_vector(4 downto 0);
    data_out: out std_logic_vector(4 downto 0)
);
end modular_normalize;

architecture Behavioral of modular_normalize is
signal normalize_result: std_logic_vector(4 downto 0);
constant subtractor: std_logic_vector(4 downto 0) := "11010";
begin
norm: process(data_in)
begin 
if(to_integer(unsigned(data_in)) >= 26) then 
    normalize_result <= data_in - subtractor;
else 
    normalize_result <= data_in;
end if;
end process;
data_out <= normalize_result;
end Behavioral;
