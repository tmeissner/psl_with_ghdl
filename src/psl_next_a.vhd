library ieee;
  use ieee.std_logic_1164.all;

use work.pkg.all;


entity psl_next_a is
  port (
    clk : in std_logic
  );
end entity psl_next_a;


architecture psl of psl_next_a is

  signal a, b : std_logic;
  signal c, d : std_logic;
  signal e, f : std_logic;

begin


  --                              01234567890
  SEQ_A : sequencer generic map ("__-_-______") port map (clk, a);
  SEQ_B : sequencer generic map ("_____-_-___") port map (clk, b);

  --                              01234567890
  SEQ_C : sequencer generic map ("__-_-______") port map (clk, c);
  SEQ_D : sequencer generic map ("_____-_____") port map (clk, d);

  --                              01234567890
  SEQ_E : sequencer generic map ("__-_-______") port map (clk, e);
  SEQ_F : sequencer generic map ("_____-----_") port map (clk, f);


  -- All is sensitive to rising edge of clk
  default clock is rising_edge(clk);

  -- This assertion doesn't hold at cycle 6
  NEXT_0_a : assert always (a -> next_a[3 to 5] (b));

  -- This assertion doesn't hold at cycle 6
  NEXT_1_a : assert always (c -> next_a[3 to 5] (d));

  -- This assertion holds
  NEXT_2_a : assert always (e -> next_a[3 to 5] (f));


end architecture psl;
