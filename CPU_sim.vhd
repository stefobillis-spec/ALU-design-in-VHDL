library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity CPU_sim is
generic(bits: integer := 16);
end CPU_sim;

architecture Behavioral of CPU_sim is

component CPU is
Port(reset : in std_logic;
      clk : in std_logic;
      inM : in std_logic_vector(bits-1 downto 0);
      instr : in std_logic_vector (bits-1 downto 0);
      outM : out std_logic_vector(bits-1 downto 0);
      writeM : out std_logic;
      addrM : out std_logic_vector (bits-2 downto 0);
      prg_cntr : out std_logic_vector(bits-2 downto 0));
end component;

signal reset_tb : std_logic := '0';
signal clk_tb : std_logic := '1';
signal inM_tb : std_logic_vector(bits-1 downto 0) := (others => '0');
signal instr_tb : std_logic_vector (bits-1 downto 0) := (others => '0');
signal outM_tb : std_logic_vector(bits-1 downto 0) := (others => '0');
signal writeM_tb : std_logic := '0';
signal addrM_tb : std_logic_vector (bits-2 downto 0) := (others => '0');
signal prg_cntr_tb : std_logic_vector(bits-2 downto 0) := (others => '0');

begin

UUT: CPU port map( reset => reset_tb,
                   clk => clk_tb,
                   inM => inM_tb,
                   instr => instr_tb,
                   outM => outM_tb,
                   writeM => writeM_tb,
                   addrM => addrM_tb,
                   prg_cntr => prg_cntr_tb);
                   
clk_tb <= not(clk_tb) after 5 ns;


process
begin
reset_tb <= '1';
wait for 45 ns;
reset_tb <= '0';
--wait for 5 ns; 
--wait for 2 ns;
instr_tb <= "0000000000000010"; -- @R2
wait for 10 ns;
instr_tb <= "1110110000010000"; -- D=A
wait for 10 ns;
inM_tb <= "0000000000000011";   -- (M=3)
instr_tb <= "1111110111100000"; -- A=M+1
wait for 10 ns;
instr_tb <= "1110110011010000"; -- D=-A
wait for 10 ns;
instr_tb <= "1110001100000011"; -- D;JGE
wait for 10 ns;
instr_tb <= "1110001100000100"; -- D;JLT
wait for 10 ns;
instr_tb <= "1110110001001000"; -- M=!A
wait for 10 ns;
instr_tb <= "1110011111001000"; -- M=D+1
wait for 10 ns;
instr_tb <= "0000000000000101"; -- @R5
wait for 10 ns;
instr_tb <= "1111110011010000"; -- D=-M

wait;
end process;

end Behavioral;
