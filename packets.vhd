library ieee;
use ieee.std_logic_1164.all;

package datatypes is

type connection is record
    letter: std_logic_vector(4 downto 0);
    connection: std_logic_vector(4 downto 0);
end record connection;

constant a   	: std_logic_vector(4 downto 0) :=           "00000";
constant b   	: std_logic_vector(4 downto 0) :=           "00001";
constant c   	: std_logic_vector(4 downto 0) :=           "00010"; 
constant d   	: std_logic_vector(4 downto 0) :=            "00011";
constant e   	: std_logic_vector(4 downto 0) :=            "00100"; 
constant f   	: std_logic_vector(4 downto 0) :=            "00101"; 
constant g   	: std_logic_vector(4 downto 0) :=            "00110";
constant h   	: std_logic_vector(4 downto 0) :=            "00111"; 
constant i   	: std_logic_vector(4 downto 0) :=            "01000"; 
constant j   	: std_logic_vector(4 downto 0) :=            "01001"; 
constant k   	: std_logic_vector(4 downto 0) :=            "01010"; 
constant l  	: std_logic_vector(4 downto 0) :=           "01011"; 
constant m   	: std_logic_vector(4 downto 0) :=            "01100"; 
constant n   	: std_logic_vector(4 downto 0) :=            "01101"; 
constant o   	: std_logic_vector(4 downto 0) :=            "01110"; 
constant p   	: std_logic_vector(4 downto 0) :=            "01111"; 
constant q   	: std_logic_vector(4 downto 0) :=            "10000"; 
constant r   	: std_logic_vector(4 downto 0) :=            "10001"; 
constant s   	: std_logic_vector(4 downto 0) :=            "10010"; 
constant t   	: std_logic_vector(4 downto 0) :=            "10011"; 
constant u   	: std_logic_vector(4 downto 0) :=            "10100"; 
constant v   	: std_logic_vector(4 downto 0) :=            "10101"; 
constant w   	: std_logic_vector(4 downto 0) :=           "10110"; 
constant x   	: std_logic_vector(4 downto 0) :=            "10111";
constant y   	: std_logic_vector(4 downto 0) :=            "11000"; 
constant z   	: std_logic_vector(4 downto 0) :=           "11001"; 

type mappa is array(natural range<>) of connection;
type configurazioneRotore is array(natural range<>) of std_logic_vector(4 downto 0);

constant alfabeto: configurazioneRotore(25 downto 0) := (
    0 => a,
    1 => b,
    2 => c,
    3 => d,
    4 => e,
    5 => f,
    6 => g,
    7 => h,
    8 => i,
    9 => j,
    10 => k,
    11 => l,
    12 => m,
    13 => n,
    14 => o,
    15 => p,
    16 => q,
    17 => r,
    18 => s,
    19 => t,
    20 => u,
    21 => v,
    22 => w,
    23 => x,
    24 => y,
    25 => z
);

constant mappaAssociazioneRotore_1: mappa(25 downto 0) := (
    0 => (letter => a,connection => u), -- lette al posto della lettere a al posto della u
    1 => (letter =>b,connection =>w),
    2 => (letter =>c,connection =>y),
    3 => (letter =>d,connection =>g),
    4 => (letter =>e,connection =>a),
    5 => (letter =>f,connection =>d),
    6 => (letter =>g,connection =>f),
    7 => (letter =>h,connection =>p),
    8 => (letter =>i,connection =>v),
    9 => (letter =>j,connection =>z),
    10 => (letter =>k,connection =>b),
    11 => (letter =>l,connection =>e),
    12 => (letter =>m,connection =>c),
    13 => (letter =>n,connection =>k),
    14 => (letter =>o,connection =>m),
    15 => (letter =>p,connection =>t),
    16 => (letter =>q,connection =>h),
    17 => (letter =>r,connection =>x),
    18 => (letter =>s,connection =>s),
    19 => (letter =>t,connection =>l),
    20 => (letter =>u,connection =>r),
    21 => (letter =>v,connection =>i),
    22 => (letter =>w,connection =>n),
    23 => (letter =>x,connection =>q),
    24 => (letter =>y,connection =>o),
    25 =>(letter =>z,connection =>j)
);

constant mappa_rotore: configurazioneRotore(25 downto 0) := (
    0 => e,
    1 => k,
    2 => m,
    3 => f,
    4 => l,
    5 => g,
    6 => d,
    7 => q,
    8 => v,
    9 => z,
    10 => n,
    11 => t,
    12 => o,
    13 => w,
    14 => y,
    15 => h,
    16 => x,
    17 => u,
    18 => s,
    19 => p,
    20 => a,
    21 => i,
    22 => b,
    23 => r,
    24 => c,
    25 => j
);
constant mappa_reflector: mappa(25 downto 0) := (
    0 => (letter => a,connection => y),
    1 => (letter =>b,connection =>r),
    2 => (letter =>c,connection =>u),
    3 => (letter =>d,connection =>h),
    4 => (letter =>e,connection =>q),
    5 => (letter =>f,connection =>s),
    6 => (letter =>g,connection =>l),
    7 => (letter =>h,connection =>d),
    8 => (letter =>i,connection =>p),
    9 => (letter =>j,connection =>x),
    10 => (letter =>k,connection =>n),
    11 => (letter =>l,connection =>g),
    12 => (letter =>m,connection =>o),
    13 => (letter =>n,connection =>k),
    14 => (letter =>o,connection =>m),
    15 => (letter =>p,connection =>i),
    16 => (letter =>q,connection =>e),
    17 => (letter =>r,connection =>b),
    18 => (letter =>s,connection =>f),
    19 => (letter =>t,connection =>z),
    20 => (letter =>u,connection =>c),
    21 => (letter =>v,connection =>w),
    22 => (letter =>w,connection =>v),
    23 => (letter =>x,connection =>j),
    24 => (letter =>y,connection =>a),
    25 =>(letter =>z,connection =>t)
);


end datatypes; 