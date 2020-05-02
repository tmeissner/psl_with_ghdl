library ieee;
  use ieee.std_logic_1164.all;

use work.pkg.all;


entity psl_always is
  port (
    clk : in std_logic
  );
end entity psl_always;


architecture psl of psl_always is

  signal a : std_logic;

begin


  --                            012345
  SEQ : sequencer generic map ("--____") port map (clk, a);


  -- All is sensitive to rising edge of clk
  default clock is rising_edge(clk);

  -- This assertion holds
  WITHOUT_ALWAYS_a : assert a;

  -- This assertion doesn't hold at cycle 2
  WITH_ALWAYS_a : assert always a;


end architecture psl;
