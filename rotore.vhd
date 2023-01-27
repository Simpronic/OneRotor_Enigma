----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.01.2023 23:33:24
-- Design Name: 
-- Module Name: rotore - Behavioral
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
use ieee.math_real.all;
use work.datatypes.all;

entity rotore is
Port (
    side: in std_logic; --Segnale che mi indica quale parte devo restituire
    clock: in std_logic;
    reset: in std_logic;
    rotate: in std_logic;
    readed: in std_logic; --Il livello inferiore avvisa il rotore che ha letto e può andare avanti
    data_in: in std_logic_vector(4 downto 0);
    request_code: in std_logic;
    generated: out std_logic;
    data_out: out std_logic_vector(4 downto 0)
 );
end rotore;

architecture Behavioral of rotore is

component bit5_reg 
Port ( 
    clock: in std_logic;
    reset: in std_logic;
    enable: in std_logic;
    d_in: in std_logic_vector(5 downto 1);
    d_out: out std_logic_vector(5 downto 1)
);
end component;

component rete_controllo_rotore
Port ( 
 clock: in std_logic;
 side: in std_logic;
 reset: in std_logic;
 request_letter: in std_logic;
 letterGenerated: out std_logic;
 en_mem_dataIn_result: out std_logic;
 association: out std_logic; 
 readed: in std_logic;
 en_mem_adder_result: out std_logic
);
end component;

component counter_mod_N
generic(count: positive := 10);
Port ( 
    enable:in std_logic;
    clock: in std_logic;
    reset: in std_logic;
    counter: out std_logic_vector(integer(ceil(log2(real(count))))-1 downto 0)
);
end component;

component shifting_memoryNoAssoc
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
end component;

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
component adder
Port ( 
    result: out std_logic_vector(5 downto 1);
    op1: in std_logic_vector(5 downto 1);
    op2: in std_logic_vector(5 downto 1)
);
end component;

signal out_from_side_1,out_from_side_2,collegamento,out_mux,shifts,out_from_in_reg,forAdder: std_logic_vector(4 downto 0);
signal effective_link: std_logic_vector(4 downto 0);
signal getCode,getCodeIn,association_sig: std_logic := '0';
signal operando2_adder: std_logic_vector(4 downto 0);
begin

            
r_c: rete_controllo_rotore
port map(
 clock => clock,
  side => side,
 reset => reset,
 request_letter => request_code,
 letterGenerated => generated,
 en_mem_dataIn_result => getCodeIn,
 association => association_sig,
 readed => readed,
 en_mem_adder_result => getCode
);

forAdder <= out_mux when association_sig = '0' else 
            collegamento when association_sig = '1' else 
            (others => '0');
            
side1: shifting_memoryNoAssoc
generic map(mappa_rotore)
port map(
    data_in => out_from_in_reg,
    clock => clock,
    reset => reset,
    shift => rotate,
    data_out => out_from_side_1
);

side2: shifting_memoryNoAssoc
generic map(alfabeto)
port map(
    data_in => out_from_in_reg,
    clock => clock,
    reset => reset,
    shift => rotate,
    data_out => out_from_side_2
);

out_mux <= out_from_side_1 when side = '0' else 
           out_from_side_2 when side = '1' else 
           (others => '0');
           
associationTable: shifting_memory
generic map(mappaAssociazioneRotore_1)
port map(
    data_in => out_mux,
    clock => clock,
    reset => reset,
    shift => '0',
    data_out => collegamento
);

add: adder
port map(
    result => effective_link,
    op1 => forAdder,
    op2 => shifts
);

operando2_adder <= shifts when side = '0' else 
                   (others => '0');
code: bit5_reg
Port map( 
    clock => clock, 
    reset => reset,
    enable => getCode,
    d_in => effective_link,
    d_out => data_out
);
incoming_code: bit5_reg
port map(
    clock => clock, 
    reset => reset,
    enable => getCodeIn,
    d_in => data_in,
    d_out => out_from_in_reg
);

rotationCounter: counter_mod_N
generic map(26)
port map(
    enable =>rotate, 
    clock => clock,
    reset => reset,
    counter => shifts
);

end Behavioral;
