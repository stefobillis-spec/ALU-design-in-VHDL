library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

------------------- Entity Declaration -------------------
entity CPU is
Generic (bits : integer := 16);
Port (reset : in std_logic;
      clk : in std_logic;
      inM : in std_logic_vector(bits-1 downto 0);
      instr : in std_logic_vector (bits-1 downto 0);
      outM : out std_logic_vector(bits-1 downto 0);
      writeM : out std_logic;
      addrM : out std_logic_vector (bits-2 downto 0);
      prg_cntr : out std_logic_vector(bits-2 downto 0));
end CPU;

architecture Behavioral of CPU is

--------------------- ALU declaration -------------------
component ALU is
	generic(size : integer := 16);
	port(reset : in std_logic; 
	     x : in std_logic_vector(size-1 downto 0);
	     y : in std_logic_vector(size-1 downto 0);
	     control_bits : in std_logic_vector(5 downto 0);
	     output : out std_logic_vector(size-1 downto 0);
	     zero : out std_logic;
	     negative : out std_logic);
    end component;

---------------------- PC declaration ----------------------  
component PC is
    Generic(bits : integer := 16);
    Port ( input : in STD_LOGIC_VECTOR (bits-1 downto 0);
           clk : in STD_LOGIC;
           load : in STD_LOGIC;
           inc : in STD_LOGIC;
           reset : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (bits-1 downto 0));
end component;

------------------ Intermediate signals -------------------
signal A_reg : std_logic_vector(bits-1 downto 0);
signal D_reg : std_logic_vector(bits-1 downto 0);
signal alu_y_in : std_logic_vector(bits-1 downto 0);
signal ALUout : std_logic_vector(bits-1 downto 0);
signal zr : std_logic := '0';
signal neg : std_logic := '0';
signal pos : std_logic := '0';
signal PC_out : std_logic_vector(bits-2 downto 0);

----------------- Control signals ------------------------
signal alu_control : std_logic_vector(5 downto 0); -- ????
signal loadA : std_logic := '0';
signal loadD : std_logic := '0';
signal loadPC : std_logic := '0';
signal jump : std_logic := '0';
signal OP : std_logic; 


begin

----------------- Control signals logic -------------------
OP <= instr(15);
alu_control <= instr(11 downto 6);
pos <= not(neg or zr);
loadA <= (not(OP) or instr(5));
loadD <= OP and instr(4);
jump <= (instr(2) and neg) or (instr(1) and zr) or (instr(0) and pos);
loadPC <= jump and OP;

---------------- I/O signals logic -----------------------
outM <= ALUout;
writeM <= OP and instr(3);
addrM <= A_reg(bits-2 downto 0);
prg_cntr <= PC_out(bits-2 downto 0);


---------------- ALU component instantiation -------------
ALU1: ALU port map(reset => reset, x => D_reg, y => ALU_y_in,
	     control_bits => alu_control, output => ALUout, zero => zr, negative => neg);
	     
----------------- PC component instantiation -------------
PC1: PC port map(input => A_reg, clk => clk, load => loadPC,
                 inc => '1', reset => reset, output => PC_out);


--------------- A register process --------------------
A_reg_proc: process(clk)
begin
if rising_edge(clk) then
if loadA = '1' then
    if OP = '1' then
        A_reg <= ALUout;
    else
        A_reg <= instr;
    end if;
end if;
end if;
end process;

--------------- D register process -------------------
D_reg_proc: process(clk)
begin
if rising_edge(clk) then
if loadD = '1' then
    D_reg <= ALUout;
end if;
end if;
end process;



end Behavioral;
