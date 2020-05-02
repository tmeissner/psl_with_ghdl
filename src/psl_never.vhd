library ieee;
  use ieee.std_logic_1164.all;

use work.pkg.all;


entity psl_never is
  port (
    clk : in std_logic
  );
end entity psl_never;


architecture psl of psl_never is

  signal a, b : std_logic;

begin


  --                              0123
  SEQ_A : sequencer generic map ("____") port map (clk, a);
  SEQ_B : sequencer generic map ("__-_") port map (clk, b);


  -- All is sensitive to rising edge of clk
  default clock is rising_edge(clk);

  -- This assertion holds
  NEVER_0_a : assert never a;

  -- Equivalent assert with always and negation
  -- This assertion holds
  ALWAYS_a : assert always not a;

  -- This assertion doesn't hold at cycle 2
  NEVER_1_a : assert never b;


end architecture psl;
