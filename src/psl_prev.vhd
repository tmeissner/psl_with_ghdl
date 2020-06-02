library ieee;
  use ieee.std_logic_1164.all;

use work.pkg.all;


entity psl_prev is
  port (
    clk : in std_logic
  );
end entity psl_prev;


architecture psl of psl_prev is

  signal valid : std_logic;
  signal a     : std_logic;
  signal d     : std_logic_vector(3 downto 0);

begin


  --                                  01234567890123
  SEQ_VALID : sequencer generic map ("____-_-_-_-_-_") port map (clk, valid);
  SEQ_A     : sequencer generic map ("-__--__--__--_") port map (clk, a);
  SEQ_D : hex_sequencer generic map ("00011223344556") port map (clk, d);


  -- All is sensitive to rising edge of clk
  default clock is rising_edge(clk);

  -- This assertion holds
  PREV_0_a : assert always (valid -> a = prev(a));

  -- This assertion should hold
  -- prev() with vector parameter isn't supported yet
  -- Workaround: VHDL glue logic and simple compare
  --  PREV_1_a : assert always (valid -> d = prev(d));

  -- Workaround with VHDL glue logic generating the
  -- previous value of d and simple comparing the two values
  d_reg : block is
    signal d_prev : std_logic_vector(d'range);
  begin
    process (clk) is
    begin
      if rising_edge(clk) then
        d_prev <= d;
      end if;
    end process;
    PREV_2_a : assert always (valid -> d = d_prev);
  end block d_reg;

  -- Using prev() with additional parameter i, should return
  -- the value of the expression in the i-th previous cycle
  -- prev(a) = prev(a, 1)
  -- This assertion holds
  PREV_3_a : assert always (valid -> a = prev(a, 1));

  -- Using prev() with additional parameter i, should return
  -- the value of the expression in the i-th previous cycle
  -- This assertion holds
  PREV_4_a : assert always (valid -> a = prev(a, 4));

  -- Stop simulation after longest running sequencer is finished
  -- Simulation only code by using pragmas
  -- synthesis translate_off
  stop_sim(clk, 14);
  -- synthesis translate_on


end architecture psl;
