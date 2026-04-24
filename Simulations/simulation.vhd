library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;


entity simulation is
generic(size : integer := 16);
end simulation;

architecture Behavioral of simulation is

component ALU
    Generic( size : integer := 16);
	port(reset : in std_logic;
	     x : in std_logic_vector(size-1 downto 0);
	     y : in std_logic_vector(size-1 downto 0);
	     control_bits : in std_logic_vector(5 downto 0);
	     output : out std_logic_vector(size-1 downto 0);
	     zero : out std_logic;
	     negative : out std_logic);
end component;

signal reset_tb : std_logic;
signal x_tb : std_logic_vector(size-1 downto 0);
signal y_tb : std_logic_vector(size-1 downto 0);
signal control_bits_tb : std_logic_vector(5 downto 0);
signal output_tb : std_logic_vector(size-1 downto 0);
signal zero_tb : std_logic;
signal negative_tb : std_logic;

begin

UUT: ALU port map(reset => reset_tb,
                 x => x_tb,
                 y => y_tb,
                 control_bits => control_bits_tb,
                 output => output_tb,
                 zero => zero_tb,
                 negative => negative_tb);

test: process
begin 
reset_tb <= '1';
x_tb <= "0000000000001100"; -- x = 12
y_tb <= "0000000000000001"; -- y = 1
control_bits_tb <= "110001"; -- ALU <= !y
wait for 30 ns;
reset_tb <= '0';
wait for 10 ns;
y_tb <= "0000000000011010"; -- Y = 26
wait for 10 ns;
control_bits_tb <= "011111"; -- ALU <= x+1
wait for 10 ns;
x_tb <= "0000000000000101"; -- X = 5
wait for 10 ns;
control_bits_tb <= "010011"; -- ALU <= x-y
wait for 10 ns;
control_bits_tb <= "101010"; -- ALU <= 0
wait for 30 ns;
wait;
end process;
end Behavioral;
