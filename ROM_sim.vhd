library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ROM_sim is
Generic(bits : integer := 16;
            size : integer := 14);
end ROM_sim;

architecture Behavioral of ROM_sim is

component ROM is
Port ( reset : in STD_LOGIC;
           address : in STD_LOGIC_VECTOR (bits-1 downto 0);
           data : out STD_LOGIC_VECTOR (bits-1 downto 0));
end component;

signal reset_tb : std_logic := '1';
signal address_tb : std_logic_vector(bits-1 downto 0);
signal data_tb : std_logic_vector(bits-1 downto 0);

begin

UUT: ROM port map(reset => reset_tb, address => address_tb, data => data_tb);


process
begin
wait for 25 ns;
reset_tb <= '0';
address_tb <= (others => '0');
wait for 10ns;
address_tb <= "0000000000000010";
wait for 10ns;
address_tb <= "0000000000000001";
wait for 10ns;
reset_tb <= '1';
wait;
end process;

end Behavioral;
