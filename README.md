# RNM_compuerta_inversor

# DPI_SENO

### Modelo En C de una función seno Y su testbench en systemverilog.

En este caso, no se diseño el RTL de la función seno, sin embargo se hizo una simulación del modelo en C usando un testbench basado en systemVerilog.

Este programa fue probado usando las herramientas de Synopsys.

```bash
setenv GIT_ROOT `git rev-parse --show-toplevel`
setenv UVM_WORK $GIT_ROOT/work/uvm
mkdir -p $UVM_WORK && cd $UVM_WORK
ln -sf $GIT_ROOT/hw/Makefile/Makefile.vcs Makefile
ln -sf $GIT_ROOT/verification/uvm/scripts/setup/setup_synopsys_eda.tcsh
source setup_synopsys_eda.tcsh