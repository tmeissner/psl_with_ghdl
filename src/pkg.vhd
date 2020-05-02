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

  component hex_sequencer is
    generic (
      seq : string
    );
    port (
      clk  : in  std_logic;
      data : out std_logic_vector(3 downto 0)
    );
  end component hex_sequencer;

  function to_bit (a : in character) return std_logic;
  function to_hex (a : in character) return std_logic_vector;


end package pkg;


package body pkg is


  function to_bit (a : in character) return std_logic is
    variable ret : std_logic;
  begin
    case a is
      when '0' | '_' => ret := '0';
      when '1' | '-' => ret := '1';
      when others    => ret := 'X';
    end case;
    return ret;
  end function to_bit;

  function to_hex (a : in character) return std_logic_vector is
    variable ret : std_logic_vector(3 downto 0);
  begin
    case a is
      when '0' | '_' => ret := x"0";
      when '1'       => ret := x"1";
      when '2'       => ret := x"2";
      when '3'       => ret := x"3";
      when '4'       => ret := x"4";
      when '5'       => ret := x"5";
      when '6'       => ret := x"6";
      when '7'       => ret := x"7";
      when '8'       => ret := x"8";
      when '9'       => ret := x"9";
      when 'a' | 'A' => ret := x"A";
      when 'b' | 'B' => ret := x"B";
      when 'c' | 'C' => ret := x"C";
      when 'd' | 'D' => ret := x"D";
      when 'e' | 'E' => ret := x"E";
      when 'f' | 'F' | '-' => ret := x"F";
      when others => ret := x"X";
    end case;
    return ret;
  end function to_hex;


end package body pkg;
