library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity PC_sim is
    Generic(bits : integer := 16);
end PC_sim;

architecture Behavioral of PC_sim is

component PC is
Port ( input : in STD_LOGIC_VECTOR (bits-1 downto 0);
           clk : in STD_LOGIC;
           load : in STD_LOGIC;
           inc : in STD_LOGIC;
           reset : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (bits-1 downto 0));
end component;

signal input_tb : STD_LOGIC_VECTOR (bits-1 downto 0) := (others => '0');
signal clk_tb : std_logic := '0';
signal load_tb : std_logic := '0';
signal inc_tb : std_logic := '0';
signal reset_tb :std_logic := '0';
signal output_tb : STD_LOGIC_VECTOR (bits-1 downto 0);

begin

UUT: PC port map(input => input_tb,
                clk => clk_tb,
                load => load_tb,
                inc => inc_tb,
                reset => reset_tb,
                output => output_tb);
                
clk_tb <= not(clk_tb) after 5 ns;

process
begin
wait for 20 ns;
input_tb <= "1000001010000101";
inc_tb <= '1';
wait for 20ns;
load_tb <= '1';
wait for 10ns;
load_tb <= '0';
wait for 20ns;
reset_tb <= '1';
wait for 20ns;
input_tb <= "0011000000111001";
inc_tb <= '0';
wait for 10ns;
load_tb <= '1';
wait for 10ns;
reset_tb <= '0';
wait for 10ns;
inc_tb <= '1';
wait for 10ns;
load_tb <= '0';
wait for 50ns;
reset_tb <= '1';

wait;
end process;
end Behavioral;
