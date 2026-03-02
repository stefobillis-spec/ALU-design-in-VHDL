library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity simulation is
    Generic( size : integer := 3;
             bits : integer := 16);
end simulation;

architecture Behavioral of simulation is

component RAM is
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           input : in STD_LOGIC_VECTOR (bits-1 downto 0);
           load : in STD_LOGIC;
           address : in STD_LOGIC_VECTOR (size-1 downto 0);
           output : out STD_LOGIC_VECTOR (bits-1 downto 0));
end component;

signal reset_tb : STD_LOGIC;
signal clk_tb : STD_LOGIC := '0';
signal input_tb : STD_LOGIC_VECTOR (bits-1 downto 0);
signal load_tb : STD_LOGIC;
signal address_tb : STD_LOGIC_VECTOR (size-1 downto 0);
signal output_tb : STD_LOGIC_VECTOR (bits-1 downto 0);

begin

UUT: RAM port map(reset => reset_tb,
                  clk => clk_tb,
                  input => input_tb,
                  load => load_tb,
                  address => address_tb,
                  output => output_tb);
                  
clk_tb <= not(clk_tb) after 5 ns;

process
begin
reset_tb <= '1';
wait for 24ns;
reset_tb <= '0';
load_tb <= '1';
address_tb <= "000";
input_tb <= "0000000000000001";


wait for 10 ns;
load_tb <= '0';
input_tb <= "0000000000000000";
wait for 10 ns;
load_tb <= '1';
address_tb <= "010";
input_tb <= "0000000000001010";
wait for 10 ns;
load_tb <= '0';
wait for 10 ns;
address_tb <= "000";

wait;
end process;
                  
end Behavioral;