onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib inst_opt

do {wave.do}

view wave
view structure
view signals

do {inst.udo}

run -all

quit -force
