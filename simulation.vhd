library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;


entity simulation is
generic(size : integer := 4);
end simulation;

architecture Behavioral of simulation is

component ALU
	port(reset : in std_logic;
	     x : in signed(size-1 downto 0);
	     y : in signed(size-1 downto 0);
	     negate_x : in std_logic;
	     zero_x : in std_logic;
	     negate_y : in std_logic;
	     zero_y : in std_logic;
         func : in std_logic;
	     negate_out : in std_logic;
	     output : out signed(size-1 downto 0);
	     zero : out std_logic;
	     negative : out std_logic);
end component;

signal reset_tb : std_logic;
signal x_tb : signed (size-1 downto 0);
signal y_tb : signed(size-1 downto 0);
signal negate_x_tb : std_logic;
signal zero_x_tb : std_logic;
signal negate_y_tb : std_logic;
signal zero_y_tb : std_logic;
signal func_tb : std_logic;
signal negate_out_tb : std_logic;
signal output_tb : signed(size-1 downto 0);
signal zero_tb : std_logic;
signal negative_tb : std_logic;

begin

UUT: ALU port map(reset => reset_tb,
                 x => x_tb,
                 y => y_tb,
                 negate_x => negate_x_tb,
                 zero_x => zero_x_tb,
                 negate_y => negate_y_tb,
                 zero_y => zero_y_tb,
                 func => func_tb,
                 negate_out => negate_out_tb,
                 output => output_tb,
                 zero => zero_tb,
                 negative => negative_tb);

test: process
begin 
reset_tb <= '1';
x_tb <= "1100";
y_tb <= "0001";
negate_x_tb <= '1';
zero_x_tb <= '0';
negate_y_tb <= '0';
zero_y_tb <= '0';
func_tb <= '1';
negate_out_tb <= '1';
wait for 30 ns;
reset_tb <= '0';
wait for 30 ns;
wait;
end process;
end Behavioral;
