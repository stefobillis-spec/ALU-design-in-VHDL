library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Memory_sim is
generic( size : integer := 14;
         bits : integer := 16);
end Memory_sim;

architecture Behavioral of Memory_sim is

component Memory 
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
end component;

signal reset_tb : std_logic := '1';
signal clk_tb : std_logic := '1';
signal input_tb : std_logic_vector(bits-1 downto 0);
signal addr_tb : std_logic_vector(size downto 0);
signal load_tb : std_logic;
signal output_tb : std_logic_vector(bits-1 downto 0);
signal KBD_data_tb : std_logic_vector(7 downto 0);
signal R0_tb : std_logic_vector(bits-1 downto 0); 
signal R1_tb : std_logic_vector(bits-1 downto 0);
signal R2_tb : std_logic_vector(bits-1 downto 0);
signal R3_tb : std_logic_vector(bits-1 downto 0);


begin

UUT: Memory port map(reset => reset_tb,
                     clk => clk_tb,
                     input => input_tb,
                     addr => addr_tb,
                     load => load_tb,
                     output => output_tb,
                     KBD_data => KBD_data_tb,
                     R0 => R0_tb,
                     R1 => R1_tb,
                     R2 => R2_tb,
                     R3 => R3_tb);

clk_tb <= not(clk_tb) after 5 ns;

process
begin
wait for 50 ns;
reset_tb <= '0';
load_tb <= '0';
addr_tb <= "000000000000000"; -- at address 0
--input_tb <= "0000000000000001"; -- load 1
wait for 7.5 ns;
load_tb <= '1';
--addr_tb <= "000000000001010"; -- at address 10
input_tb <= "0000000000000001"; -- load 1
wait for 10 ns;
addr_tb <= "000000000001010"; -- at address 10
input_tb <= "0000000000000001"; -- load 1
wait for 10 ns;
addr_tb <= "000001000000000"; -- at address 512
input_tb <= "0000000000010000"; -- load 16
wait;
end process;

end Behavioral;
