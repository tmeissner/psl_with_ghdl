library ieee;
  use ieee.std_logic_1164.all;

use work.pkg.all;


entity psl_sere_non_consecutive_repeat_repetition is
  port (
    clk : in std_logic
  );
end entity psl_sere_non_consecutive_repeat_repetition;


architecture psl of psl_sere_non_consecutive_repeat_repetition is

  signal req, busy, done : std_logic;

  -- All is sensitive to rising edge of clk
  default clock is rising_edge(clk);

begin


  --                                 0123456789
  SEQ_REQ  : sequencer generic map ("_-________") port map (clk, req);
  SEQ_BUSY : sequencer generic map ("__-_-_-___") port map (clk, busy);
  SEQ_DONE : sequencer generic map ("________-_") port map (clk, done);


  -- Non consecutive repetition of 3 cycles with possible padding
  -- busy has to hold on 3 cycles between req & done
  -- This assertion holds
  SERE_0_a : assert always {req} |=> {busy[=3]; done};

  -- Non consecutive repetition of 2 to 4 cycles with possible padding
  -- busy has to hold on 2 to 4 cycles between req & done
  -- This assertion holds
  SERE_1_a : assert always {req} |=> {busy[=2 to 4]; done};

  -- Non consecutive repetition of 5 cycles with possible padding
  -- busy has to hold on 5 cycles between req & done
  -- This assertion holds -> possible PITFALL!
  -- RHS is underspecified, nothing prevents done to hold between or together
  -- with holding busy. For intentioned behaviour, the behaviour of done
  -- has to be described more specificly (see SERE_3_a)
  SERE_2_a : assert always {req} |=> {busy[=5]; done};

  -- Non consecutive repetition of 3 cycles with possible padding
  -- busy has to hold on exactly 3 cycles between req & and the first done
  -- This is a more exact version of the assertions before using
  -- the length-matching and SERE operator &&
  -- This assertion holds
  SERE_3_a : assert always {req} |=> {{{busy[=3]} && {not done[+]}}; done};

  -- Non consecutive repetition of 4 cycles with possible padding
  -- busy has to hold on exactly 4 cycles between req & and the first done
  -- This assertion doesn't hold at cycle 8
  SERE_4_a : assert always {req} |=> {{{busy[=4]} && {not done[+]}}; done};

  -- Stop simulation after longest running sequencer is finished
  -- Simulation only code by using pragmas
  -- synthesis translate_off
  stop_sim(clk, 10);
  -- synthesis translate_on


end architecture psl;
