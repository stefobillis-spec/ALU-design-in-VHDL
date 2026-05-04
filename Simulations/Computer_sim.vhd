library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity Computer_sim is
--  Port ( );
end Computer_sim;

architecture Behavioral of Computer_sim is

component Computer is
port (
    KBD_data_0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    R0_0 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    R1_0 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    R2_0 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    R3_0 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    button_0 : in STD_LOGIC;
    clk_in1_0 : in STD_LOGIC);
end component;

signal KBD_data_0_tb : std_logic_vector(7 downto 0) := (others => '0');
signal R0_0_tb : STD_LOGIC_VECTOR ( 15 downto 0 );
signal R1_0_tb : STD_LOGIC_VECTOR ( 15 downto 0 );
signal R2_0_tb : STD_LOGIC_VECTOR ( 15 downto 0 );
signal R3_0_tb : STD_LOGIC_VECTOR ( 15 downto 0 );
signal button_0_tb : std_logic := '1';
signal clk_in1_0_tb : std_logic := '0';

begin

UUT: Computer port map(KBD_data_0 => KBD_data_0_tb,
                               R0_0 => R0_0_tb,
                               R1_0 => R1_0_tb,
                               R2_0 => R2_0_tb,
                               R3_0 => R3_0_tb,
                               button_0 => button_0_tb,
                               clk_in1_0 => clk_in1_0_tb);
                               
clk_in1_0_tb <= not(clk_in1_0_tb) after 4ns;

process
begin
button_0_tb <= '1';
wait for 10 us;
button_0_tb <= '0';
wait for 1 us;
KBD_data_0_tb <= "00110011"; -- press "3"
wait for 1 us;
KBD_data_0_tb <= "00000000"; -- release key
wait for 1.5 us;
KBD_data_0_tb <= "00111001"; -- press "9"
wait for 1 us;
KBD_data_0_tb <= "00000000"; -- release key
wait for 1.5 us;
KBD_data_0_tb <= "10000000"; -- press "Enter" - 1st input is 93
wait for 1 us;
KBD_data_0_tb <= "00000000"; -- release key

wait for 2 us;
KBD_data_0_tb <= "00110101"; -- press "5"
wait for 1 us;
KBD_data_0_tb <= "00000000"; -- release key
wait for 1.5 us;
KBD_data_0_tb <= "00110100"; -- press "4"
wait for 1 us;
KBD_data_0_tb <= "00000000"; -- release key
wait for 1.5 us;
KBD_data_0_tb <= "00101101"; -- press "-" - 2nd input is -45
wait for 1 us;
KBD_data_0_tb <= "00000000"; -- release key


wait;
end process;

end Behavioral;
