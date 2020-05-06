-makelib ies_lib/xil_defaultlib -sv \
  "D:/XIlinx/Vivado/2019.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/XIlinx/Vivado/2019.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/blk_mem_gen_v8_4_3 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../_lab2.srcs/sources_1/ip/blk_mem_gen_2/sim/blk_mem_gen_2.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

