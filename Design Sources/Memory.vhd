library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Memory is
    Generic( size : integer := 14;
             bits : integer := 16);
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           mem_in : in STD_LOGIC_VECTOR (15 downto 0);
           addr : in STD_LOGIC_VECTOR (14 downto 0);
           load : in STD_LOGIC;
           mem_out : out STD_LOGIC_VECTOR (15 downto 0);
           KBD_data : in STD_LOGIC_VECTOR (7 downto 0);
           R0 : out STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
           R1 : out STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
           R2 : out STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
           R3 : out STD_LOGIC_VECTOR (15 downto 0) := (others => '0'));
end Memory;

architecture Behavioral of Memory is

type RAM is array(2**size downto 0) of signed(bits-1 downto 0);
signal RAM_block : RAM := (others => "0000000000000000");
signal KBD : std_logic_vector(bits-1 downto 0) := (others => '0');


begin


output_data: process(RAM_block(4))
begin
if RAM_block(4) = "0000000000000001" then
    R0 <= std_logic_vector(RAM_block(0));
    R1 <= std_logic_vector(RAM_block(1));
    R2 <= std_logic_vector(RAM_block(2));
    R3 <= std_logic_vector(RAM_block(3));
else
    R0 <= (others => '0');
    R1 <= (others => '0');
    R2 <= (others => '0');
    R3 <= (others => '0');
end if;
end process;



process(clk, reset)
begin
    if reset = '1' then
        RAM_block <= (others => (others => '0'));
    elsif falling_edge(clk) then
        if load = '1' and addr(14) = '0' then
            RAM_block(to_integer(unsigned(addr))) <= signed(mem_in);
        end if;
    end if;
end process;


process(RAM_block,addr)
begin
if (addr(13) and addr(14)) = '0' then
            mem_out <= std_logic_vector(RAM_block(to_integer(unsigned(addr))));
        else
            mem_out <= "00000000" & KBD_data;
        end if;
end process;

    
end Behavioral;
