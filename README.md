# psl_with_ghdl

A collection of examples of using PSL for functional and formal verification of VHDL with GHDL (and SymbiYosys).


The next two lists will grow during furter development

## PSL features supported by GHDL:

* assert directive
* cover directive
* assume directive (synthesis)
* restrict directive (synthesis)
* always operator
* never operator
* implication operator
* next operator
* next[i] operator
* next_event() operator

## PSL features currently unsupported by GHDL:

* next_a[i:j] operator
* next_e[i:j] operator
