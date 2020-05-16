include tests.mk


.PHONY: all clean

all: ${psl_tests}


%: %.vhd work/%.sby
	ghdl --synth --std=08 $@.vhd -e issue > work/$@_synth.vhd
	-sby --yosys "yosys -m ghdl" -f -d work/$@ work/$@.sby bmc

work/%.sby: template.sby
	mkdir -p work
	sed 's/__ISSUE__/$(basename $(notdir $@))/g' $< > $@


clean:
	rm -rf work
