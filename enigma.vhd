----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.01.2023 23:02:41
-- Design Name: 
-- Module Name: enigma - Structural
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

entity enigma is
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
end enigma;

architecture Structural of enigma is
component rotore
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
end component;

component Reflector
Port (
    clock: in std_logic;
    reset: in std_logic;
    data_in: in std_logic_vector(4 downto 0);
    getLetter: in std_logic;
    data_out: out std_logic_vector(4 downto 0)
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

component rete_controllo_enigma
Port (
    clock: in std_logic;
    reset: in std_logic;
    setup_s: in std_logic;
    rotate_s: in std_logic;
    hasNewCode: in std_logic;
    codeGenerated: in std_logic;
    readed: in std_logic;
    rotate_sign: out std_logic;
    finaleCodeGenerated: out std_logic;
    request_code_rotor: out std_logic;
    readed_from_rotor: out std_logic;
    en_mem_data_in: out std_logic;
    en_mem_rotor: out std_logic;
    en_mem_refl: out std_logic;
    src: out std_logic; -- 0 data, 1 reflector
    sideOfRotor: out std_logic --Dice al sistema rotore quale lato guardare
 );
end component;

component modular_normalize
Port ( 
    data_in: in std_logic_vector(4 downto 0);
    data_out: out std_logic_vector(4 downto 0)
);
end component;

signal side_of_rotor,rotor_generate,rotor_generated,rotor_rotate,memorize,rotor_read: std_logic := '0';
signal reg_out,out_of_rotor,out_of_reflector,forReg: std_logic_vector(4 downto 0);

signal memorize_data_in,memorizeRotor_data,memorizeReflector_data: std_logic := '0';
signal data_in_reg_out,reg_rotor_out,reg_reflector_out,forRotor: std_logic_vector(4 downto 0);
signal src: std_logic := '0';
signal normalizedLetter: std_logic_vector(4 downto 0);
begin 

forRotor <= data_in_reg_out when src = '0' else 
            reg_reflector_out when src = '1' else 
            (others => '0');

normalizer: modular_normalize
port map(
    data_in => reg_rotor_out,
    data_out => normalizedLetter
);
rotore_sys: rotore
port map(
    side => side_of_rotor,
    clock => clock,
    reset => reset,
    rotate => rotor_rotate,
    readed => rotor_read,
    data_in => forRotor,
    request_code => rotor_generate,
    generated => rotor_generated,
    data_out => out_of_rotor
);

ref: Reflector
port map(
    clock => clock,
    reset => reset,
    data_in => reg_rotor_out,
    getLetter => '1',
    data_out => out_of_reflector
);

codeReflectorReg: bit5_reg
port map(
    clock => clock,
    reset => reset,
    enable => memorizeReflector_data,
    d_in => out_of_reflector,
    d_out => reg_reflector_out
);

codeRotorReg: bit5_reg
port map(
    clock => clock,
    reset => reset,
    enable => memorizeRotor_data,
    d_in => out_of_rotor,
    d_out => reg_rotor_out
);

data_in_reg: bit5_reg
port map(
    clock => clock,
    reset => reset,
    enable => memorize_data_in,
    d_in => data_in,
    d_out => data_in_reg_out
);

controllo: rete_controllo_enigma
port map(
    clock => clock,
    reset => reset,
    setup_s => setup,
    rotate_s => rotate,
    hasNewCode => hasNewCode,
    codeGenerated => rotor_generated,
    readed => readed,
    rotate_sign => rotor_rotate,
    finaleCodeGenerated => code_generated,
    request_code_rotor => rotor_generate,
    readed_from_rotor => rotor_read,
    en_mem_data_in => memorize_data_in,
    en_mem_rotor => memorizeRotor_data,
    en_mem_refl => memorizeReflector_data,
    src => src,
    sideOfRotor => side_of_rotor
);
data_out <= normalizedLetter;

end Structural;
