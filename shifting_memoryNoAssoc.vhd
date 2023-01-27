----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.01.2023 16:24:41
-- Design Name: 
-- Module Name: shifting_memoryNoAssoc - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use work.datatypes.all;

entity shifting_memoryNoAssoc is
generic (
    mappatura: configurazioneRotore := mappa_rotore
);
Port (
    data_in: in std_logic_vector(4 downto 0);
    clock: in std_logic;
    reset: in std_logic;
    shift: in std_logic;
    data_out: out std_logic_vector(4 downto 0)
 );
end shifting_memoryNoAssoc;

architecture Behavioral of shifting_memoryNoAssoc is
signal memoria: configurazioneRotore(25 downto 0) := mappatura;
begin
mem: process(clock)
begin
    if(rising_edge(clock)) then 
        if(reset = '1') then 
            memoria <= mappatura;
        elsif(shift = '1') then
            memoria(0) <= memoria(25); 
            for i in 1 to 25 loop
                memoria(i) <= memoria(i - 1);
            end loop;
        end if;
    end if; 
end process;
data_out <= memoria(to_integer(unsigned(data_in)) mod 26);

end Behavioral;
