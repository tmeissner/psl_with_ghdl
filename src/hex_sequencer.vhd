-- Simple sequencer to generate waveforms for 4 bit std_logic_vector signals
-- Inspired by SymbioticEDA's sva-demos seq module
-- https://github.com/SymbioticEDA/sva-demos/blob/master/seq.sv

library ieee;
  use ieee.std_logic_1164.all;

use work.pkg.all;


entity hex_sequencer is
  generic (
    seq : string
  );
  port (
    clk  : in  std_logic;
    data : out std_logic_vector(3 downto 0)
  );
end entity hex_sequencer;


architecture rtl of hex_sequencer is

  signal cycle : natural := 0;
  signal ch    : character;

begin


  process (clk) is
  begin
    if rising_edge(clk) then
      if (cycle < seq'length) then
        cycle <= cycle + 1;
      end if;
    end if;
  end process;

  ch <= seq(cycle+1);

  data <= to_hex(ch);


end architecture rtl;
