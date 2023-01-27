----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.01.2023 14:16:42
-- Design Name: 
-- Module Name: rete_controllo_enigma - Behavioral
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

entity rete_controllo_enigma is
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
end rete_controllo_enigma;

architecture Behavioral of rete_controllo_enigma is
type stato is (setup,rotateRotor,init,rotate,requestCodeToRotor,getCode,requestCodeReflector,saveRefCode,requestCodeToRotor_side2,saveRotorCode_side2,endGen);
signal stato_corrente : stato := setup;
signal stato_prossimo : stato;
signal rotate_sign_tmp,finaleCodeGenerated_tmp,request_code_rotor_tmp,readed_from_rotor_tmp,src_tmp,sideOfRotor_tmp: std_logic := '0';
signal en_mem_data_in_tmp,en_mem_rotor_tmp,en_mem_refl_tmp: std_logic := '0';

begin
stato_uscita: process(stato_corrente,setup_s,rotate_s,hasNewCode,codeGenerated,readed)
begin
case stato_corrente is
   when setup => 
    rotate_sign_tmp <= '0';
    finaleCodeGenerated_tmp <= '0';
    request_code_rotor_tmp <= '0';
    readed_from_rotor_tmp <= '0';
    src_tmp <= '0';
    en_mem_data_in_tmp <= '0';
    en_mem_rotor_tmp <= '0';
    en_mem_refl_tmp <= '0';
    sideOfRotor_tmp <= '0';
    if(setup_s = '0') then
        stato_prossimo <= init;
    else 
        if(rotate_s = '1') then 
            stato_prossimo <= rotateRotor;
        else 
            stato_prossimo <= setup;
        end if;
    end if; 
    when rotateRotor => 
         rotate_sign_tmp <= '1';
         stato_prossimo <= setup;
    when init => 
        src_tmp <= '0';
        sideOfRotor_tmp <= '0';
        en_mem_data_in_tmp <= '1';
        if(hasNewCode = '1') then 
           stato_prossimo <= rotate; 
        else 
            stato_prossimo <= init;
        end if;
    when rotate => 
        en_mem_data_in_tmp <= '0';
        rotate_sign_tmp <= '1';
        stato_prossimo <= requestCodeToRotor;
   when requestCodeToRotor => 
        src_tmp <= '0';
        en_mem_rotor_tmp <= '1';
        request_code_rotor_tmp <= '1';
        rotate_sign_tmp <= '0';
        sideOfRotor_tmp <= '0';
        if(codeGenerated = '1') then 
            stato_prossimo <= getCode;
        else 
            stato_prossimo <= requestCodeToRotor;
        end if;
  when getCode => 
        request_code_rotor_tmp <= '0';
        readed_from_rotor_tmp <= '1';
        stato_prossimo <= requestCodeReflector;
  when requestCodeReflector => 
        src_tmp <= '1';
        en_mem_rotor_tmp <= '0';
        en_mem_refl_tmp <= '1';
        readed_from_rotor_tmp <= '0';
        stato_prossimo <= saveRefCode;
  when saveRefCode => 
        sideOfRotor_tmp <= '1';
        stato_prossimo <= requestCodeToRotor_side2;
  when requestCodeToRotor_side2 => 
        src_tmp <= '1';
        en_mem_rotor_tmp <= '1';
        en_mem_refl_tmp <= '0';
        sideOfRotor_tmp <= '1';
        request_code_rotor_tmp <= '1';
        if(codeGenerated = '1') then 
            stato_prossimo <= saveRotorCode_side2;
        else 
            stato_prossimo <= requestCodeToRotor_side2;
        end if;
  when saveRotorCode_side2 => 
        src_tmp <= '1';
        en_mem_rotor_tmp <= '1';
        request_code_rotor_tmp <= '0';
        readed_from_rotor_tmp <= '1';
        stato_prossimo <= endGen;
  when endGen => 
        readed_from_rotor_tmp <= '0';
        finaleCodeGenerated_tmp <= '1';
        if(readed = '1') then 
          stato_prossimo <= init;
        else 
           stato_prossimo <= endGen;
        end if;
end case;

end process;
 
mem: process (clock)
begin
	if( rising_edge(clock)) then
		if( reset = '1') then
	       stato_corrente <= setup;
	       rotate_sign <= '0';  
	       finaleCodeGenerated <= '0';
	       sideOfRotor <= '0';
	       request_code_rotor <= '0';
	       readed_from_rotor <= '0';
	       en_mem_data_in <= '0';
	       en_mem_rotor <= '0';
	       en_mem_refl <= '0';
	       src <= '0';
	    else
	       src <= src_tmp;
	       stato_corrente <= stato_prossimo;
	       rotate_sign <= rotate_sign_tmp;  
	       request_code_rotor <= request_code_rotor_tmp;
	       readed_from_rotor <= readed_from_rotor_tmp;
	       sideOfRotor <= sideOfRotor_tmp;
	       en_mem_data_in <= en_mem_data_in_tmp;
	       en_mem_rotor <= en_mem_rotor_tmp;
	       en_mem_refl <= en_mem_refl_tmp;
	       finaleCodeGenerated <= finaleCodeGenerated_tmp;
	    end if;
   end if;
end process;
end Behavioral;
