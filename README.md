[![tests](https://github.com/tmeissner/psl_with_ghdl/workflows/tests/badge.svg?branch=master)](https://github.com/tmeissner/psl_with_ghdl/actions?query=workflow%3Atests)

# psl_with_ghdl

A collection of examples of using PSL for functional and formal verification of VHDL with GHDL (and SymbiYosys).

This is a project with the purpose to get a current state of PSL implementation in GHDL. It probably will find unsupported PSL features, incorrect implemented features or simple bugs like GHDL crashs.

It is also intended for experiments with PSL when learning the language. You can play around with the examples, as they are pretty simple. You can comment out failing assertions if you want to have a successful proof or simulation if you want. You can change them to see what happens. Have fun!


The next two lists will grow during further development

## PSL features supported by GHDL:

* assert directive
* cover directive
* assume directive (synthesis)
* restrict directive (synthesis)
* always operator
* never operator
* implication operator
* next operator
* next[n] operator
* next_a[i to j] operator
* next_e[i to j] operator
* next_event operator
* next_event[n] operator
* until operator
* until_ operator
* before operator (GHDL crash with a specific property, see psl_before.vhd)
* eventually! operator (simulation, synthesis produces a GHDL crash, see psl_eventually.vhd)

## PSL features not yet supported by GHDL:

* next_event_a[i to j] operator
* next_event_e[i to j] operator

## PSL features supported by GHDL but with wrong behaviour

* before_ operator (Seems that LHS & RHS of operator have to be active at same cycle, see psl_before.vhd)
