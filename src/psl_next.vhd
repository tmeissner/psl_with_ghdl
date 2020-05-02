library ieee;
  use ieee.std_logic_1164.all;

use work.pkg.all;


entity psl_next is
  port (
    clk : in std_logic
  );
end entity psl_next;


architecture psl of psl_next is

  signal a, b : std_logic;
  signal c, d : std_logic;

begin


  SEQ_A : sequencer generic map ("_-__--__-__") port map (clk, a);
  SEQ_B : sequencer generic map ("_--__--__--") port map (clk, b);

  SEQ_C : sequencer generic map ("_-__--__-__") port map (clk, c);
  SEQ_D : sequencer generic map ("_--__-___--") port map (clk, d);


  -- All is sensitive to rising edge of clk
  default clock is rising_edge(clk);

  -- This assertion holds
  NEXT_0_a : assert always (a -> next b);

  -- This assertion doesn't hold at cycle 6
  NEXT_1_a : assert always (c -> next d);


end architecture psl;
