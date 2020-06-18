#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
# 

echo "This script was generated under a different operating system."
echo "Please update the PATH and LD_LIBRARY_PATH variables below, before executing this script"
exit

if [ -z "$PATH" ]; then
  PATH=D:/XIlinx/SDK/2019.1/bin;D:/XIlinx/Vivado/2019.1/ids_lite/ISE/bin/nt64;D:/XIlinx/Vivado/2019.1/ids_lite/ISE/lib/nt64:D:/XIlinx/Vivado/2019.1/bin
else
  PATH=D:/XIlinx/SDK/2019.1/bin;D:/XIlinx/Vivado/2019.1/ids_lite/ISE/bin/nt64;D:/XIlinx/Vivado/2019.1/ids_lite/ISE/lib/nt64:D:/XIlinx/Vivado/2019.1/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=
else
  LD_LIBRARY_PATH=:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='C:/Users/Asus/Documents/GitHub/COD_labs/_lab5/src/_lab5/_lab5.runs/INS_MEM_1_synth_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

EAStep vivado -log INS_MEM_1.vds -m64 -product Vivado -mode batch -messageDb vivado.pb -notrace -source INS_MEM_1.tcl
