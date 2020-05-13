onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ins_a_opt

do {wave.do}

view wave
view structure
view signals

do {ins_a.udo}

run -all

quit -force
