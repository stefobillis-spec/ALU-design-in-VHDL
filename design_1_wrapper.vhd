library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_wrapper is
  port (
    KBD_data_0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    R0_0 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    R1_0 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    R2_0 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    R3_0 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    button_0 : in STD_LOGIC;
    clk_in1_0 : in STD_LOGIC
  );
end design_1_wrapper;

architecture STRUCTURE of design_1_wrapper is
  component design_1 is
  port (
    clk_in1_0 : in STD_LOGIC;
    button_0 : in STD_LOGIC;
    KBD_data_0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    R2_0 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    R1_0 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    R0_0 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    R3_0 : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  end component design_1;
begin
design_1_i: component design_1
     port map (
      KBD_data_0(7 downto 0) => KBD_data_0(7 downto 0),
      R0_0(15 downto 0) => R0_0(15 downto 0),
      R1_0(15 downto 0) => R1_0(15 downto 0),
      R2_0(15 downto 0) => R2_0(15 downto 0),
      R3_0(15 downto 0) => R3_0(15 downto 0),
      button_0 => button_0,
      clk_in1_0 => clk_in1_0
    );
end STRUCTURE;
