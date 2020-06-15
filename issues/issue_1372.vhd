vunit issue_vunit (issue(psl)) {

  -- All is sensitive to rising edge of clk
  default clock is rising_edge(clk);

  -- GHDL crash if condition evaluates to true
  test_g : if true generate

    -- This assertion holds
    CHECK_0_a : assert always (a -> b);

  end generate test_g;

}


library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity issue is
  port (
    clk : in std_logic
  );
end entity issue;


architecture psl of issue is

  component sequencer is
    generic (
      seq : string
    );
    port (
      clk  : in  std_logic;
      data : out std_logic
    );
  end component sequencer;

  signal a, b : std_logic := '1';

begin


end architecture psl;
