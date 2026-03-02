library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;


entity RAM is
    Generic( size : integer := 3;
             bits : integer := 16);
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           input : in STD_LOGIC_VECTOR (bits-1 downto 0);
           load : in STD_LOGIC;
           address : in STD_LOGIC_VECTOR (size-1 downto 0);
           output : out STD_LOGIC_VECTOR (bits-1 downto 0));
end RAM;

architecture Behavioral of RAM is
type MEMORY is array(2**size-1 downto 0) of signed(bits-1 downto 0);

signal RAM_block : MEMORY := (others => "0000000000000000");
signal addr : integer range 0 to 2**3-1;
signal a : unsigned(size-1 downto 0);



begin

addr <= to_integer(unsigned(address));



process(clk, reset)
begin
if reset = '1' then
output <= (others => '0');
elsif rising_edge(clk) then
    if load = '1' then
        RAM_block(addr) <= signed(input);
    end if;

elsif falling_edge(clk) then
    output <= std_logic_vector(RAM_block(addr));
end if;
end process;

end Behavioral;