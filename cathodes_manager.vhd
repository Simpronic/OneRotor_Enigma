----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:29:17 22/10/2012 
-- Design Name: 
-- Module Name:    cathode_manager - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cathodes_manager is
    Port ( value : in  STD_LOGIC_VECTOR (4 downto 0); --dato da mostrare sulla cifra del display
           dot : in  STD_LOGIC; --configurazione del punto: acceso o spento
           cathodes_dot : out  STD_LOGIC_VECTOR (7 downto 0)); --indica i 7 catodi più il punto
end cathodes_manager;

architecture Behavioral of cathodes_manager is

-- i catodi sono collegati nel seguente ordine:
-- cathodes[0]=CA
-- cathodes[2]=CB
--....
-- i catodi sono 0-attivi 
constant a   	: std_logic_vector(6 downto 0) := "0001000"; 
constant b      : std_logic_vector(6 downto 0) := "0000011"; 
constant c      : std_logic_vector(6 downto 0) := "1000110"; 
constant d      : std_logic_vector(6 downto 0) := "0100001"; 
constant e      : std_logic_vector(6 downto 0) := "0000110"; 
constant f      : std_logic_vector(6 downto 0) := "0001110";
constant g      : std_logic_vector(6 downto 0) := "1000010";
constant h      : std_logic_vector(6 downto 0) := "0001001";
constant i      : std_logic_vector(6 downto 0) := "1001111";
constant j      : std_logic_vector(6 downto 0) := "1100001";
constant k      : std_logic_vector(6 downto 0) := "0001010";    
constant l      : std_logic_vector(6 downto 0) := "1000111";
constant m      : std_logic_vector(6 downto 0) := "1101010";
constant n      : std_logic_vector(6 downto 0) := "1001000";
constant o      : std_logic_vector(6 downto 0) := "1000000";
constant p      : std_logic_vector(6 downto 0) := "0001100";
constant q      : std_logic_vector(6 downto 0) := "0010100";
constant r      : std_logic_vector(6 downto 0) := "1001100";
constant s      : std_logic_vector(6 downto 0) := "0010010";
constant t      : std_logic_vector(6 downto 0) := "0000111";
constant u      : std_logic_vector(6 downto 0) := "1000001";
constant v      : std_logic_vector(6 downto 0) := "1000001";
constant w      : std_logic_vector(6 downto 0) := "1010101";
constant x      : std_logic_vector(6 downto 0) := "0001001";
constant y      : std_logic_vector(6 downto 0) := "0010001";
constant z      : std_logic_vector(6 downto 0) := "0100100";

signal cathodes : std_logic_vector(6 downto 0); --segnale temporaneo per codificare
                                                --il pattern sui 7 led in base alla cifra da mostrare (value)

begin		 
seven_segment_decoder_process: process 
  begin 
    case value is 
      when "00000" => cathodes <= a; 
      when "00001" => cathodes <= b; 
      when "00010" => cathodes <= c; 
      when "00011" => cathodes <= d; 
      when "00100" => cathodes <= e; 
      when "00101" => cathodes <= f; 
      when "00110" => cathodes <= g; 
      when "00111" => cathodes <= h; 
      when "01000" => cathodes <= i; 
      when "01001" => cathodes <= j; 
      when "01010" => cathodes <= k; 
      when "01011" => cathodes <= l; 
      when "01100" => cathodes <= m; 
      when "01101" => cathodes <= n; 
      when "01110" => cathodes <= o; 
      when "01111" => cathodes <= p;
      when "10000" => cathodes <= q;
      when "10001" => cathodes <= r;
      when "10010" => cathodes <= s;
      when "10011" => cathodes <= t;
      when "10100" => cathodes <= u;
      when "10101" => cathodes <= v;
      when "10110" => cathodes <= w;
      when "10111" => cathodes <= x;
      when "11000" => cathodes <= y;
      when "11001" => cathodes <= z;
		when others => cathodes <= (others => '0');
    end case; 
  end process seven_segment_decoder_process;
  
cathodes_dot <= (not dot)&cathodes; --segnale complessivo di 7+1 bit con catodi e punto



end Behavioral;