library ieee;
  use ieee.std_logic_1164.all;

use work.pkg.all;


entity psl_sere_consecutive_repetition is
  port (
    clk : in std_logic
  );
end entity psl_sere_consecutive_repetition;


architecture psl of psl_sere_consecutive_repetition is

  signal a, b, c : std_logic;
  signal d, e, f : std_logic;
  signal g, h, i : std_logic;

begin


  --                              012345678
  SEQ_A : sequencer generic map ("_-_______") port map (clk, a);
  SEQ_B : sequencer generic map ("__----___") port map (clk, b);
  SEQ_C : sequencer generic map ("______-__") port map (clk, c);

  --                              012345
  SEQ_D : sequencer generic map ("_-____") port map (clk, d);
  SEQ_E : sequencer generic map ("______") port map (clk, e);
  SEQ_F : sequencer generic map ("__-___") port map (clk, f);

  --                              012345678
  SEQ_G : sequencer generic map ("_-_______") port map (clk, g);
  SEQ_H : sequencer generic map ("__-_-_-__") port map (clk, h);
  SEQ_I : sequencer generic map ("_______-_") port map (clk, i);


  -- All is sensitive to rising edge of clk
  default clock is rising_edge(clk);

  -- This assertion holds
  SERE_0_a : assert always {a} |=> {b; b; b; b; c};

  -- This assertion holds
  SERE_1_a : assert always {a} |=> {b[*4]; c};

  -- This assertion holds
  SERE_2_a : assert always {a} |=> {b[*3 to 5]; c};

  -- This assertion holds
  SERE_3_a : assert always {a} |=> {b[*]; c};

  -- This assertion holds
  SERE_4_a : assert always {a} |=> {b[+]; c};

  -- This assertion holds
  SERE_5_a : assert always {d} |=> {e[*]; f};

  -- This assertion doesn't hold at cycle 2
  SERE_6_a : assert always {d} |=> {e[+]; f};

  -- This assertion doesn't hold at cycle 3
  SERE_7_a : assert always {g} |=> {h[*3]; i};

  -- This assertion doesn't hold at cycle 3
  SERE_8_a : assert always {g} |=> {h[*2 to 4]; i};

  -- This assertion doesn't hold at cycle 3
  SERE_9_a : assert always {g} |=> {h[*]; i};

  -- This assertion doesn't hold at cycle 3
  SERE_10_a : assert always {g} |=> {h[+]; i};

  -- This assertion holds
  SERE_11_a : assert always {g} |=> {[*5]; i};  


end architecture psl;
