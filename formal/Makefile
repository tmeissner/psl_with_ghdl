include tests.mk


.PHONY: all clean

all: ${psl_tests}


%: ../src/%.vhd ../src/pkg.vhd ../src/sequencer.vhd ../src/hex_sequencer.vhd %.sby
	mkdir -p work
	-sby --yosys "yosys -m ghdl" -f -d work/$@ $@.sby bmc


clean:
	rm -rf work
