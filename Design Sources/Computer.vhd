library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Computer is
    Port ( clk_in1_0 : in STD_LOGIC;
           button_0 : in STD_LOGIC;
           KBD_data_0 : in STD_LOGIC_VECTOR (7 downto 0);
           R0_0 : out STD_LOGIC_VECTOR (15 downto 0);
           R1_0 : out STD_LOGIC_VECTOR (15 downto 0);
           R2_0 : out STD_LOGIC_VECTOR (15 downto 0);
           R3_0 : out STD_LOGIC_VECTOR (15 downto 0));
end Computer;

architecture Behavioral of Computer is


------------------ CPU component Declaration -------------------
component CPU is
Generic (bits : integer := 16);
Port (reset : in std_logic;
      clk : in std_logic;
      inM : in std_logic_vector(bits-1 downto 0);
      instr : in std_logic_vector (bits-1 downto 0);
      outM : out std_logic_vector(bits-1 downto 0);
      writeM : out std_logic;
      addrM : out std_logic_vector (bits-2 downto 0);
      prg_cntr : out std_logic_vector(bits-1 downto 0));
end component;


------------------ROM component Declaration -------------------
component ROM is
    Generic(bits : integer := 16;
            size : integer := 14);
    Port ( reset : in STD_LOGIC;
           address : in STD_LOGIC_VECTOR (bits-1 downto 0);
           data : out STD_LOGIC_VECTOR (bits-1 downto 0));
end component;


------------------ Memory component Declaration -------------------
component Memory is
    Generic( size : integer := 8;
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
end component;



-------------- Intermediate Signals -----------------
signal ROM2CPU : std_logic_vector(15 downto 0);
signal PC_out : std_logic_vector(15 downto 0);
signal Mem2CPU : std_logic_vector(15 downto 0);
signal CPU2Mem : std_logic_vector(15 downto 0);
signal Mem_address : std_logic_vector(14 downto 0);
signal write : std_logic;


begin



----------------- Connections between components  ------------------

CPU1: CPU port map(reset => button_0, clk => clk_in1_0, inM => Mem2CPU, instr => ROM2CPU,
                   outM => CPU2Mem, writeM => write, addrM => Mem_address, prg_cntr => PC_out);
                   
ROM1: ROM port map(reset => button_0, address => PC_out, data => ROM2CPU);

Memory1: Memory port map(reset => button_0, clk => clk_in1_0, mem_in => CPU2Mem, addr => Mem_address,
                         load => write, KBD_data => KBD_data_0, mem_out => Mem2CPU,
                         R0 => R0_0, R1 => R1_0, R2 => R2_0, R3 => R3_0);



end Behavioral;
