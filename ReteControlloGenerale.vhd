----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.01.2023 23:47:01
-- Design Name: 
-- Module Name: ReteControlloGenerale - Behavioral
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

entity ReteControlloGenerale is
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
end ReteControlloGenerale;

architecture Behavioral of ReteControlloGenerale is
type stato is (setup, read_data_keyboard,rotate_state,cypher,getCode);
signal stato_corrente : stato := setup;
signal stato_prossimo : stato;

signal setup_sig_tmp: std_logic := '1';
signal rotateRot_tmp,newCode_tmp,en_mem_tmp,readed_sig_tmp: std_logic := '0';

begin
stato_uscita: process(stato_corrente,rotate,generated,start,hasNewCode)
begin
case stato_corrente is
    when setup => 
      en_mem_tmp <= '0';
      setup_sig_tmp <= '1';
      rotateRot_tmp <= '0';
      newCode_tmp <= '0';
      readed_sig_tmp <= '0';
      if(start = '1') then 
        stato_prossimo <= read_data_keyboard;
      else 
        if(rotate = '1') then 
            stato_prossimo <= rotate_state;
        else 
            stato_prossimo <= setup;
        end if;
      end if;
    when  read_data_keyboard => 
        readed_sig_tmp <= '0';
        en_mem_tmp <= '0';
        setup_sig_tmp <= '0';
        if(hasNewCode = '1') then 
            stato_prossimo <= cypher;
        else 
            stato_prossimo <= read_data_keyboard;
        end if;
   when rotate_state => 
       rotateRot_tmp <= '1';
       stato_prossimo <= setup;
   when cypher =>
       newCode_tmp <= '1';
       if(generated = '1') then 
            stato_prossimo <= getCode;
       else 
            stato_prossimo <= cypher;
       end if;
  when getCode => 
        en_mem_tmp <= '1';
        readed_sig_tmp <= '1';
        stato_prossimo <= read_data_keyboard;
end case; 
end process;

mem: process (clock)
begin
	if( rising_edge(clock)) then
		if( reset = '1') then
	       stato_corrente <= setup;
           setup_sig <= '1';
           rotateRot <= '0';
           newCode <= '0';
           en_mem <= '0';
           readed_sig <= '0';
	    else
	       stato_corrente <= stato_prossimo;
           setup_sig <= setup_sig_tmp;
           rotateRot <= rotateRot_tmp;
           newCode <= newCode_tmp;
           en_mem <= en_mem_tmp;
           readed_sig <= readed_sig_tmp;
	    end if;
   end if;
end process;
end Behavioral;
