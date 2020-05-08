library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

use work.pkg.all;


entity psl_next_event_a is
  port (
    clk : in std_logic
  );
end entity psl_next_event_a;


architecture psl of psl_next_event_a is

  signal a, c : std_logic;
  signal b    : std_logic_vector(3 downto 0);

begin


  --                                  012345678901234567890
  SEQ_A : sequencer generic map     ("_-______________-____") port map (clk, a);
  SEQ_B : hex_sequencer generic map ("443334477444433355555") port map (clk, b);
  SEQ_C : sequencer generic map     ("_____-___---_____----") port map (clk, c);



  -- All is sensitive to rising edge of clk
  default clock is rising_edge(clk);

  -- Check for one possible value of b
  -- This assertion holds
  NEXT_EVENT_a : assert always ((a and b = x"4") -> next_event_a(c)[1 to 4](b = x"4"));

  -- Check for all possible values of b
  -- Workaround for missing PSL forall in {i to j} statement
  -- This assertion holds
  check_b : for i in 0 to 0 generate
    signal i_slv : std_logic_vector(b'range);
  begin
    i_slv <= std_logic_vector(to_unsigned(i, 4));
    --Without name it works
    assert always ((a and b = i_slv) -> next_event_a(c)[1 to 4](b = i_slv));
    -- This errors because of similar names for all asserts
    -- ERROR: Assert `count_id(cell->name) == 0' failed in kernel/rtlil.cc:1613.
    -- NEXT_EVENT_a : assert always ((a and b = i_slv) -> next_event_a(c)[1](b = i_slv));
  end generate check_b;


  -- psl.sem_property: cannot handle N_NEXT_EVENT_A
  --
  -- ******************** GHDL Bug occurred ***************************
  -- Please report this bug on https://github.com/ghdl/ghdl/issues
  -- GHDL release: 1.0-dev (tarball) [Dunoon edition]
  -- Compiled with GNAT Version: 8.3.0
  -- Target: x86_64-linux-gnu
  -- /build/src/
  -- Command line:
  -- ghdl --synth --std=08 pkg.vhd sequencer.vhd hex_sequencer.vhd psl_next_event_a.vhd -e psl_next_event_a
  -- Exception TYPES.INTERNAL_ERROR raised
  -- Exception information:
  -- raised TYPES.INTERNAL_ERROR : psl-errors.adb:39
  -- Call stack traceback locations:
  -- 0x556095397b3a 0x5560954bbbb7 0x5560954bb8f1 0x5560954bb69f 0x5560954bb765 0x5560954bc557 0x5560954c2fd7 0x5560954c30de 0x5560954c3235 0x5560954fb17d 0x556095501e72 0x5560954b99c2 0x5560954ba814 0x5560954ba9bc 0x5560955621c6 0x5560955a0ab9 0x5560955a1361 0x5560954b136f 0x5560955aacaf 0x556095363fa3 0x7f72faa58099 0x556095362df8 0xfffffffffffffffe
  -- ******************************************************************


end architecture psl;
