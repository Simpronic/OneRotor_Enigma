----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.11.2022 20:15:30
-- Design Name: 
-- Module Name: counter_mod_24 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use ieee.math_real.all;

entity counter_mod_N is
generic(count: positive := 10);
Port ( 
    enable:in std_logic;
    clock: in std_logic;
    reset: in std_logic;
    counter: out std_logic_vector(integer(ceil(log2(real(count))))-1 downto 0)
);
end counter_mod_N;

architecture Behavioral of counter_mod_N is
signal counter_signal: std_logic_vector(integer(ceil(log2(real(count))))-1 downto 0) := (others => '0');
begin
counter <= counter_signal;
counting:process(clock)
    begin
        if(rising_edge(clock)) then
            if(reset = '1') then
                counter_signal <= (others => '0');
            elsif (enable = '1') then
                if(TO_INTEGER(unsigned(counter_signal)) >= count - 1)then
                    counter_signal <= (others => '0');
                else 
                    counter_signal <= counter_signal + "1";
                end if;
            end if;
        end if;
    end process;
end Behavioral;
