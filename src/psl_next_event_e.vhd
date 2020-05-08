library ieee;
  use ieee.std_logic_1164.all;

use work.pkg.all;


entity psl_next_event_e is
  port (
    clk : in std_logic
  );
end entity psl_next_event_e;


architecture psl of psl_next_event_e is

  signal a, b, c : std_logic;

begin


  --                              012345678901234
  SEQ_A : sequencer generic map ("_-______-______") port map (clk, a);
  SEQ_B : sequencer generic map ("___-__-___-__-_") port map (clk, b);
  SEQ_C : sequencer generic map ("______-___-____") port map (clk, c);



  -- All is sensitive to rising edge of clk
  default clock is rising_edge(clk);

  -- This assertion holds
  NEXT_EVENT_a : assert always (a -> next_event_e(b)[1 to 2](c));


  -- psl.sem_property: cannot handle N_NEXT_EVENT_E
  --
  -- ******************** GHDL Bug occurred ***************************
  -- Please report this bug on https://github.com/ghdl/ghdl/issues
  -- GHDL release: 1.0-dev (tarball) [Dunoon edition]
  -- Compiled with GNAT Version: 8.3.0
  -- Target: x86_64-linux-gnu
  -- /build/src/
  -- Command line:
  -- ghdl --synth --std=08 pkg.vhd sequencer.vhd psl_next_event_e.vhd -e psl_next_event_e
  -- Exception TYPES.INTERNAL_ERROR raised
  -- Exception information:
  -- raised TYPES.INTERNAL_ERROR : psl-errors.adb:39
  -- Call stack traceback locations:
  -- 0x55607472bb3a 0x55607484fbb7 0x55607484f8f1 0x55607484f69f 0x55607484f765 0x556074850557 0x556074856fd7 0x5560748570de 0x556074857235 0x55607488f17d 0x556074895e72 0x55607484d9c2 0x55607484e814 0x55607484e9bc 0x5560748f61c6 0x556074934ab9 0x556074935361 0x55607484536f 0x55607493ecaf 0x5560746f7fa3 0x7f2cefe1f099 0x5560746f6df8 0xfffffffffffffffe
  -- ******************************************************************


end architecture psl;
