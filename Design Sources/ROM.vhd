library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ROM is
    Generic(bits : integer := 16;
            size : integer := 14);
    Port ( reset : in STD_LOGIC;
           address : in STD_LOGIC_VECTOR (bits-1 downto 0);
           data : out STD_LOGIC_VECTOR (bits-1 downto 0));
end ROM;

architecture Behavioral of ROM is
begin

process(reset, address)
begin
if reset = '1' then
    data <= (others => '0');
else
case to_integer(unsigned(address)) is
when 0 => data <= "0000000000000100"; -- @R4
when 1 => data <= "1110111111001000"; -- M=1
when 2 => data <= "0000000000000000"; -- @END (R0)
when 3 => data <= "1110101010000111"; -- 0;JMP
when others => data <= "0000000000000000";
end case;
end if;
end process;


end Behavioral;