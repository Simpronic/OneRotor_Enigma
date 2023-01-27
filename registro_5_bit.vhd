----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2023 16:12:43
-- Design Name: 
-- Module Name: 8_bit_reg - Behavioral
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

entity bit5_reg is
Port ( 
    clock: in std_logic;
    reset: in std_logic;
    enable: in std_logic;
    d_in: in std_logic_vector(5 downto 1);
    d_out: out std_logic_vector(5 downto 1)
);
end bit5_reg;

architecture Behavioral of bit5_reg is
signal memorizedData: std_logic_vector(5 downto 1);
begin
memo: process(clock)
variable register_status: std_logic_vector(5 downto 1);
begin
    if(rising_edge(clock)) then
        if(reset = '1') then
            register_status := (others => '0');
        elsif(enable = '1') then 
            register_status:=  d_in;
        else 
            register_status:= memorizedData;
        end if;
    end if;
    memorizedData <= register_status;
end process;
d_out <= memorizedData;
end Behavioral;
