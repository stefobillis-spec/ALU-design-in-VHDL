library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;


entity ALU is
	generic(size : integer := 4);
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
end ALU;


architecture Behavioral of ALU is 
begin

process(reset)

variable x_var : signed(size-1 downto 0);
variable y_var : signed(size-1 downto 0);
variable output_var : signed(size-1 downto 0);
begin
if reset = '0' then
x_var := x;
y_var := y;
	if zero_x = '1' then
		x_var := (others => '0');
	end if;
	if negate_x = '1' then
		x_var := not(x_var);
	end if;
	if zero_y = '1' then
		y_var := (others => '0');
	end if;
	if negate_y = '1' then
		y_var := not(y_var);
	end if;
	if func = '1' then
		output_var := x_var + y_var;
	else
		output_var := x_var and y_var;
	end if;
	if negate_out = '1' then
		output_var := not(output_var);
	end if;
	
output <= output_var;
negative <= output_var(size-1);

if output_var = "0000" then
	zero <= '1';
end if;
end if;
end process;
