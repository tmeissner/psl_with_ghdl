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

begin


  --                              012345678
  SEQ_A : sequencer generic map ("_-_______") port map (clk, a);
  SEQ_B : sequencer generic map ("__----___") port map (clk, b);
  SEQ_C : sequencer generic map ("______-__") port map (clk, c);


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


end architecture psl;
