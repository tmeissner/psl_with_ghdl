include tests.mk

VHD_STD := 08

.PHONY: all clean

.SECONDARY:


all: ${psl_tests}

%: ../src/%.vhd ../src/pkg.vhd ../src/sequencer.vhd ../src/hex_sequencer.vhd work/%/testbench.vhd
	ghdl -a --std=$(VHD_STD) --workdir=work/$@ ../src/pkg.vhd ../src/sequencer.vhd ../src/hex_sequencer.vhd
	ghdl -a --std=$(VHD_STD) --workdir=work/$@ ../src/$@.vhd
	ghdl -a --std=$(VHD_STD) --workdir=work/$@ work/$@/testbench.vhd
	ghdl -e --std=$(VHD_STD) --workdir=work/$@ -o work/$@/tb_$@ tb_$@
	cd work/$@; ghdl -r --std=$(VHD_STD) tb_$@ --wave=$@.ghw --psl-report=$@_psl_coverage.json --stop-time=50ns

work/%/testbench.vhd: template.vhd
	mkdir -p work; mkdir -p $(dir $@)
	sed 's/__DUT__/$(subst /,,$(subst work,,$(dir $@)))/g' $< > $@

clean:
	rm -rf work
