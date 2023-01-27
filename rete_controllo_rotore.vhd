----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.01.2023 18:23:01
-- Design Name: 
-- Module Name: rete_controllo_rotore - Behavioral
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

entity rete_controllo_rotore is
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
end rete_controllo_rotore;

architecture Behavioral of rete_controllo_rotore is
type stato is (idle, acquireCode,AssocLetter,getCode,PerformAdd_noAssoc,PerformAdd_Assoc,SaveCode,endGen);
signal stato_corrente : stato := idle;
signal stato_prossimo : stato;
signal letterGenerated_tmp,en_mem_adder_result_tmp,en_mem_dataIn_result_tmp,association_tmp: std_logic := '0';
begin

stato_uscita: process(stato_corrente,side,request_letter,readed)
begin
case stato_corrente is
    when idle => 
        letterGenerated_tmp <= '0';
        en_mem_adder_result_tmp <= '0';
        en_mem_dataIn_result_tmp <= '0';
        association_tmp <= '0';
        if(request_letter = '1') then 
            stato_prossimo <= acquireCode;
        else 
            stato_prossimo <= idle;
        end if;
    when acquireCode => 
        en_mem_dataIn_result_tmp <= '1';
        if(side = '1') then 
            stato_prossimo <= AssocLetter;
        else 
            stato_prossimo <= getCode;
        end if;
   when getCode =>  --Stato NOAssoc
        en_mem_dataIn_result_tmp <= '0';
        stato_prossimo <= PerformAdd_noAssoc;
   when AssocLetter => --Stato Assoc
        en_mem_dataIn_result_tmp <= '0';
        association_tmp <= '1';
        en_mem_adder_result_tmp <= '1';
        stato_prossimo <= PerformAdd_Assoc;
   when PerformAdd_Assoc => 
        association_tmp <= '1';
        stato_prossimo <= SaveCode;
        en_mem_adder_result_tmp <= '1';
   when PerformAdd_noAssoc => 
        stato_prossimo <= SaveCode;
        en_mem_adder_result_tmp <= '1';
   when SaveCode =>
        letterGenerated_tmp <= '1';
        stato_prossimo <= endGen;
   when endGen => 
        en_mem_adder_result_tmp <= '0';
        --association_tmp <= '0';
        if(readed = '1') then 
            stato_prossimo <= idle;
        else 
            stato_prossimo <= endGen;
        end if;
end case;
end process;
mem: process (clock)
begin
	if( rising_edge(clock)) then
		if( reset = '1') then
	       stato_corrente <= idle;
	       letterGenerated <= '0';
	       en_mem_adder_result <= '0';
	       en_mem_dataIn_result <= '0';
	       association <= '0';
	    else
	       stato_corrente <= stato_prossimo;
	       en_mem_dataIn_result <= en_mem_dataIn_result_tmp;
	       letterGenerated <= letterGenerated_tmp;
	       association <= association_tmp;
	       en_mem_adder_result <= en_mem_adder_result_tmp;
	    end if;
   end if;
end process;
end Behavioral;
