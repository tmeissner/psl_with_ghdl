library ieee;
  use ieee.std_logic_1164.all;

use work.pkg.all;


entity psl_never is
  port (
    clk : in std_logic
  );
end entity psl_never;


architecture psl of psl_never is

  signal a : std_logic;

begin


  SEQ : sequencer generic map ("_-_-_") port map (clk, a);


  -- All is sensitive to rising edge of clk
  default clock is rising_edge(clk);

  -- Signal a has to be low forever
  NEVER_a : assert never a;

  -- Equivalent assert with always and negation
  ALWAYS_a : assert always not a;


end architecture psl;
