library ieee;
  use ieee.std_logic_1164.all;


entity sequencer is
  generic (
    seq : string
  );
  port (
    clk  : in  std_logic;
    data : out std_logic
  );
end entity sequencer;


architecture rtl of sequencer is

  signal cycle : natural := 0;
  signal ch    : character;

begin


  process (clk) is
  begin
    if rising_edge(clk) then
      if (cycle < seq'length) then
        cycle <= cycle + 1;
      end if;
    end if;
  end process;

  ch <= seq(cycle+1);

  data <= '0' when ch = '0' or ch = '_' else
          '1' when ch = '1' or ch = '-' else
          'X';


end architecture rtl;