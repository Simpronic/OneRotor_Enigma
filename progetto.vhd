----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.01.2023 10:07:23
-- Design Name: 
-- Module Name: progetto - Structural
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

entity progetto is
Port ( 
    start: in std_logic;
    clock: in std_logic;
    rotate_sig: in std_logic;
    reset: in std_logic;
    hasNewCode: in std_logic;
    data_in: in std_logic_vector(4 downto 0);
    data_out: out std_logic_vector(4 downto 0)
);
end progetto;

architecture Structural of progetto is

component ReteControlloGenerale
Port ( 
    clock: in std_logic;
    reset: in std_logic;
    setup_sig: out std_logic;
    rotate: in std_logic;
    start: in std_logic; 
    hasNewCode: in std_logic;
    generated: in std_logic;
    rotateRot: out std_logic;
    en_mem: out std_logic;
    readed_sig: out std_logic;
    newCode: out std_logic --Codice per attivare enigma
);
end component;

component enigma
Port ( 
    clock: in std_logic;
    reset: in std_logic;
    setup: in std_logic;
    rotate: in std_logic;
    data_in: in std_logic_vector(4 downto 0);
    data_out: out std_logic_vector(4 downto 0);
    hasNewCode: in std_logic;
    readed: in std_logic; --Segnale che mi avvisa che ho letto l'elemento, me lo da il livallo inferiore
    code_generated: out std_logic
);
end component;

component bit5_reg
Port ( 
    clock: in std_logic;
    reset: in std_logic;
    enable: in std_logic;
    d_in: in std_logic_vector(5 downto 1);
    d_out: out std_logic_vector(5 downto 1)
);
end component;

signal setup: std_logic := '1';
signal rotate,newCode,enigmaGenerated,memorize,readed_for_enigma: std_logic := '0';
signal out_fromEnigma: std_logic_vector(4 downto 0);

begin

rete: ReteControlloGenerale
port map(
    clock => clock,
    reset => reset,
    setup_sig => setup,
    rotate => rotate_sig,
    start => start,
    hasNewCode => hasNewCode,
    generated => enigmaGenerated,
    rotateRot => rotate,
    en_mem => memorize,
    readed_sig => readed_for_enigma,
    newCode => newCode
);

macchina:enigma
port map( 
    clock => clock,
    reset => reset,
    setup => setup,
    rotate => rotate,
    data_in => data_in,
    data_out => out_fromEnigma,
    hasNewCode => newCode,
    readed => readed_for_enigma,
    code_generated => enigmaGenerated
);
registro_codice: bit5_reg
port map(
    clock => clock,
    reset => reset,
    enable => memorize,
    d_in => out_fromEnigma,
    d_out => data_out
);
end Structural;
