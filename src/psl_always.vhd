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


  SEQ : sequencer generic map ("_-_-_") port map (clk, a);


  -- All is sensitive to rising edge of clk
  default clock is rising_edge(clk);

  -- Signal a has to be low at cycle 0 only
  WITHOUT_ALWAYS_a : assert a;

  -- Signal a has to be low forever
  WITH_ALWAYS_a : assert always a;


end architecture psl;
