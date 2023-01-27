----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2023 14:06:35
-- Design Name: 
-- Module Name: adder - Behavioral
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

entity adder is
Port ( 
    result: out std_logic_vector(5 downto 1);
    op1: in std_logic_vector(5 downto 1);
    op2: in std_logic_vector(5 downto 1)
);
end adder;

architecture Behavioral of adder is
    begin
    result <= (op1 + op2);
end Behavioral;
