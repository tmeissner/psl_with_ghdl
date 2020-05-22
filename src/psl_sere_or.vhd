library ieee;
  use ieee.std_logic_1164.all;

use work.pkg.all;


entity psl_sere_or is
  port (
    clk : in std_logic
  );
end entity psl_sere_or;


architecture psl of psl_sere_or is

  signal req2, req4, busy, valid, done : std_logic;

begin


  --                                  0123456789012345678
  SEQ_REQ2  : sequencer generic map ("_-_________________") port map (clk, req2);
  SEQ_REQ4  : sequencer generic map ("________-__________") port map (clk, req4);
  SEQ_BUSY  : sequencer generic map ("__----___--------__") port map (clk, busy);
  SEQ_VALID : sequencer generic map ("___-_-____-_-_-_-__") port map (clk, valid);
  SEQ_DONE  : sequencer generic map ("______-__________-_") port map (clk, done);


  -- All is sensitive to rising edge of clk
  default clock is rising_edge(clk);

  -- This assertion holds
  SERE_0_a : assert always {req2 ; {valid[->2]} && {busy and not done}[+]} |=> {not busy and done};

  -- This assertion holds
  SERE_1_a : assert always {req4 ; {valid[->4]} && {busy and not done}[+]} |=> {not busy and done};

  -- SERE or operato
  -- Combination of both assertions above
  -- This assertion holds
  SERE_2_a : assert always {{req2 ; {valid[->2]} && {busy and not done}[+]} |
                            {req4 ; {valid[->4]} && {busy and not done}[+]}} |=>
                            {not busy and done};


end architecture psl;
