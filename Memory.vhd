library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Memory is
    Generic( size : integer := 14;
             bits : integer := 16);
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           input : in STD_LOGIC_VECTOR (15 downto 0);
           addr : in STD_LOGIC_VECTOR (14 downto 0);
           load : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (15 downto 0);
           KBD_data : in STD_LOGIC_VECTOR (7 downto 0);
           R0 : out STD_LOGIC_VECTOR (15 downto 0);
           R1 : out STD_LOGIC_VECTOR (15 downto 0);
           R2 : out STD_LOGIC_VECTOR (15 downto 0);
           R3 : out STD_LOGIC_VECTOR (15 downto 0));
end Memory;

architecture Behavioral of Memory is

type RAM is array(2**size downto 0) of signed(bits-1 downto 0);
signal RAM_block : RAM := (others => "0000000000000000");
signal KBD : std_logic_vector(bits-1 downto 0) := (others => '0');
-- Make R4 a signal and assign it to RAM_block(4) ???

signal loadRAM : std_logic := '0';
signal a : integer range 0 to 2**size := 0;

begin


KBD <= "00000000" & KBD_data;
--loadRAM <= not(addr(13)) and load;
--a <= to_integer(unsigned(addr));


output_data: process(RAM_block)
begin
if RAM_block(4) = "0000000000000001" then
    R0 <= std_logic_vector(RAM_block(0));
    R1 <= std_logic_vector(RAM_block(1));
    R2 <= std_logic_vector(RAM_block(2));
    R3 <= std_logic_vector(RAM_block(3));
end if;
end process;


--RAMorKBD: process(clk,reset)
--begin
--if reset = '1' then
--    output <= (others => '0');
--    RAM_block <= (others => "0000000000000000");
--else
--if rising_edge(clk) then
--    if addr(13) = '0' then 
--          output <= std_logic_vector(RAM_block(a));
--    else
--        output <= "00000000" & KBD_data;
--    end if;
--end if;
--end if; 
--end process;



   
--Write: process(clk)
--begin
--if falling_edge(clk) then
--    if loadRAM = '1' then
--          RAM_block(a) <= signed(input);
--   end if;
--end if;
--end process;


process(clk, reset)
begin
    if reset = '1' then
        RAM_block <= (others => (others => '0'));
--        output <= (others => '0');

    elsif rising_edge(clk) then
        -- WRITE (synchronous)
        if load = '1' and addr(13) = '0' then
            RAM_block(to_integer(unsigned(addr))) <= signed(input);
        end if;

        -- READ (synchronous)
--        if addr(13) = '0' then
--            output <= std_logic_vector(RAM_block(to_integer(unsigned(addr))));
--        else
--            output <= KBD;
--        end if;
    end if;
end process;

process(RAM_block)
begin
if addr(13) = '0' then
            output <= std_logic_vector(RAM_block(to_integer(unsigned(addr))));
        else
            output <= KBD;
        end if;
end process;

    
end Behavioral;
