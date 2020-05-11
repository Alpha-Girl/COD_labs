onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ins_opt

do {wave.do}

view wave
view structure
view signals

do {ins.udo}

run -all

quit -force
