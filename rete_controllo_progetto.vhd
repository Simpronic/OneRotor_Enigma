----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.01.2023 19:23:33
-- Design Name: 
-- Module Name: rete_controllo_progetto - Behavioral
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


entity rete_controllo_progetto is
Port ( 
    clock: in std_logic;
    reset: in std_logic;
    setup: in std_logic;
    load: in std_logic;
    newEncode: in std_logic;
    hasNewLetter: out std_logic;
    src: out std_logic
);
end rete_controllo_progetto;

architecture Behavioral of rete_controllo_progetto is
type stato is (setup_state, waitforLoad,LoadToProgetto,sameLetter);
signal stato_corrente : stato := setup_state;
signal stato_prossimo : stato;
signal hasNewLetter_tmp,src_tmp: std_logic := '0';
begin
stato_uscita: process(stato_corrente,setup,load,newEncode)
begin
case stato_corrente is
when setup_state => 
    src_tmp <= '0';
    hasNewLetter_tmp <= '0';
    if(setup = '0') then 
        stato_prossimo <= waitforLoad;
    else 
        stato_prossimo <= setup_state;
    end if;
when waitforLoad => 
     src_tmp <= '0';
     hasNewLetter_tmp <= '0';
    if(load = '1') then 
        stato_prossimo <= LoadToProgetto;
    else 
        stato_prossimo <= waitforLoad;
    end if;
when LoadToProgetto => 
     src_tmp <= '1';
     hasNewLetter_tmp <= '1';
     stato_prossimo <= sameLetter;
when sameLetter => 
    hasNewLetter_tmp <= '0';
    if(newEncode = '1') then 
        stato_prossimo <= waitforLoad;
    else
        stato_prossimo <= sameLetter;
    end if; 
end case; 
end process;

mem: process (clock)
begin
	if( rising_edge(clock)) then
		if( reset = '1') then
	       stato_corrente <= setup_state;
	       hasNewLetter <= '0';
	       src <= '0';
	    else
	       stato_corrente <= stato_prossimo;
	       hasNewLetter <= hasNewLetter_tmp;
	       src <= src_tmp;
	    end if;
   end if;
end process;
end Behavioral;
