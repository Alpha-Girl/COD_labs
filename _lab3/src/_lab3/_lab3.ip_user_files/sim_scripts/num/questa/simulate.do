onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib num_opt

do {wave.do}

view wave
view structure
view signals

do {num.udo}

run -all

quit -force
