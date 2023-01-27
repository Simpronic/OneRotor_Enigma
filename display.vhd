----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.01.2023 10:08:13
-- Design Name: 
-- Module Name: display - Structural
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

entity display is
Port ( 
    data_in: in std_logic_vector(4 downto 0);
    clock: in std_logic;
    reset: in std_logic;
    led_out: out std_logic_vector(7 downto 0);
    anodes_out: out std_logic_vector(7 downto 0)
);
end display;

architecture Structural of display is

component cathodes_manager
    Port ( value : in  STD_LOGIC_VECTOR (4 downto 0); --dato da mostrare sulla cifra del display
           dot : in  STD_LOGIC; --configurazione del punto: acceso o spento
           cathodes_dot : out  STD_LOGIC_VECTOR (7 downto 0)); --indica i 7 catodi più il punto
end component;


begin

gestoreCatodi: cathodes_manager
port map(
    value => data_in,
    dot => '0',
    cathodes_dot => led_out
);

anodes_out <= "11111110";

end Structural;
