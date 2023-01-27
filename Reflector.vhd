----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.01.2023 22:31:16
-- Design Name: 
-- Module Name: Reflector - Behavioral
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
use ieee.numeric_std.all;
use work.datatypes.all;

entity Reflector is
Port (
    clock: in std_logic;
    reset: in std_logic;
    data_in: in std_logic_vector(4 downto 0);
    getLetter: in std_logic;
    data_out: out std_logic_vector(4 downto 0)
 );
end Reflector;

architecture Structural of Reflector is
component shifting_memory
generic (
    mappatura: mappa := mappa_reflector
);
Port (
    data_in: in std_logic_vector(4 downto 0);
    clock: in std_logic;
    reset: in std_logic;
    shift: in std_logic;
    data_out: out std_logic_vector(4 downto 0)
 );
end component;

signal letterOut: std_logic_vector(4 downto 0);
begin
memory: shifting_memory
generic map(
    mappa_reflector
)
port map(
    data_in => data_in,
    clock => clock,
    reset => reset,
    shift => '0',
    data_out => letterOut
);
data_out <= letterOut when getLetter = '1' else 
            (others => '1');
end Structural;
