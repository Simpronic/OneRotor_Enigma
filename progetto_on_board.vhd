library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity progetto_on_board is
Port (
    reset: in std_logic;
    clock: in std_logic;
    start: in std_logic;
    load: in std_logic;
    newEncode: in std_logic;
    ps2_clk: in std_logic;
    ps2_data: in std_logic;
    rotate_sig: in std_logic;
    led_out: out std_logic_vector(7 downto 0);
    anodes_out : out std_logic_vector (7 downto 0)
 );
end progetto_on_board;

architecture Structural of progetto_on_board is

component display
Port ( 
    data_in: in std_logic_vector(4 downto 0);
    clock: in std_logic;
    reset: in std_logic;
    led_out: out std_logic_vector(7 downto 0);
    anodes_out: out std_logic_vector(7 downto 0)
);
end component;

component ButtonDebouncer
    generic (                       
        CLK_period: integer := 10;  -- periodo del clock in nanosec
        btn_noise_time: integer := 10000000 --durata dell'oscillazione in nanosec
        );
    Port ( RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           BTN : in STD_LOGIC; 
           CLEARED_BTN : out STD_LOGIC);
end component;

component keyboardDriver
Port ( 
    clock: in std_logic;
    reset: in std_logic;
    ps2_clk: in std_logic;
    ps2_data: in std_logic;
    key_code: out std_logic_vector(4 downto 0);
    hasNewCode: out std_logic
);
end component;

component progetto
Port ( 
    start: in std_logic;
    clock: in std_logic;
    rotate_sig: in std_logic;
    reset: in std_logic;
    hasNewCode: in std_logic;
    data_in: in std_logic_vector(4 downto 0);
    data_out: out std_logic_vector(4 downto 0)
);
end component;

component rete_controllo_progetto
Port ( 
    clock: in std_logic;
    reset: in std_logic;
    setup: in std_logic;
    load: in std_logic;
    newEncode: in std_logic;
    hasNewLetter: out std_logic;
    src: out std_logic
);
end component;

signal cleared_start,cleared_rotate,clearedLoad,cleared_newEncode: stD_logic;
signal hasNewCode: std_logic := '0';
signal keyCode,out_code,enigmaCode: std_logic_vector(4 downto 0);
signal src: std_logic := '0';
signal notStart: std_logic;
signal divided_clock: std_logic;
begin

disp: display
port map(
    data_in =>out_code,
    clock => clock,
    reset => reset,
    led_out => led_out,
    anodes_out => anodes_out
);


keyboardDr: keyboardDriver
port map(
  clock => clock,
  reset => reset,
  ps2_clk => ps2_clk,
  ps2_data => ps2_data,
  key_code => keyCode
);



deb_start: ButtonDebouncer
generic map(10,1000000)
port map(
    RST => reset,
    CLK => clock,
    BTN => start,
    CLEARED_BTN => cleared_start 
);

deb_rotate: ButtonDebouncer
generic map(10,1000000)
port map(
    RST => reset,
    CLK => clock,
    BTN => rotate_sig,
    CLEARED_BTN => cleared_rotate 
);
db_load:ButtonDebouncer 
generic map(10,1000000)
port map(
    RST => reset,
    CLK => clock,
    BTN => load,
    CLEARED_BTN => clearedLoad 
);
db_newEncode: ButtonDebouncer
generic map(10,1000000)
port map(
    RST => reset,
    CLK => clock,
    BTN => newEncode,
    CLEARED_BTN => cleared_newEncode 
);
notStart <= not start;
rete: rete_controllo_progetto
port map(
    clock => clock,
    reset => reset,
    setup => notStart,
    load => clearedLoad,
    newEncode => cleared_newEncode,
    hasNewLetter => hasNewCode,
    src => src
);

macchina: progetto
port map(
    start => cleared_start,
    clock => clock,
    rotate_sig => cleared_rotate,
    reset => reset,
    hasNewCode => hasNewCode,
    data_in => keyCode,
    data_out => enigmaCode
);


out_code <= enigmaCode when src = '1' else 
            keyCode when src = '0' else 
            (others => '0');


end Structural;
