library ieee;
  use ieee.std_logic_1164.all;

use work.pkg.all;


entity psl_abort is
  port (
    clk : in std_logic
  );
end entity psl_abort;


architecture psl of psl_abort is

  signal a, b, c, d : std_logic;

begin

  d <= '0', '1' after 1100 ps, '0' after 1400 ps;

  --                              0123456789
  SEQ_A : sequencer generic map ("-___-_____") port map (clk, a);
  SEQ_B : sequencer generic map ("_______-__") port map (clk, b);
  SEQ_C : sequencer generic map ("-_________") port map (clk, c);
  --  D :                         _|________

  -- All is sensitive to rising edge of clk
  default clock is rising_edge(clk);

  -- This assertion doesn't hold at cycle 4
  WITHOUT_ABORT_a : assert (always a -> next (b before a));

  -- This assertion holds
  WITH_ABORT_0_a : assert (always a -> next (b before a)) abort c;

  -- In simulation this assertion should also hold, but it does not
  -- GHDL seems to implement abort as sync_abort instead of async_abort
  -- See 1850-2010 6.2.1.5.1 abort, async_abort, and sync_abort
  -- In formal this assertion fails as d is 0 all the time
  WITH_ABORT_1_a : assert (always a -> next (b before a)) abort d;

  -- Stop simulation after longest running sequencer is finished
  -- Simulation only code by using pragmas
  -- synthesis translate_off
  stop_sim(clk, 12);
  -- synthesis translate_on


end architecture psl;
