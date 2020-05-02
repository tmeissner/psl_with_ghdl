library ieee;
  use ieee.std_logic_1164.all;


package pkg is


  component sequencer is
    generic (
      seq : string
    );
    port (
      clk  : in  std_logic;
      data : out std_logic
    );
  end component sequencer;


end package pkg;
