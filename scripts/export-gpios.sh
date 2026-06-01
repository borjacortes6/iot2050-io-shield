#!/bin/bash
# export-gpios.sh — Exporta i configura tots els GPIOs del shield IO
# Siemens 6ES7647-0KA01-0AA2 en IoT2050

for gpio in 437 438 439 441 345; do
    [ ! -d /sys/class/gpio/gpio${gpio} ] && echo ${gpio} > /sys/class/gpio/export 2>/dev/null && echo "✅ gpio${gpio}"
    echo in > /sys/class/gpio/gpio${gpio}/direction 2>/dev/null
done
for gpio in 355 360; do
    [ ! -d /sys/class/gpio/gpio${gpio} ] && echo ${gpio} > /sys/class/gpio/export 2>/dev/null && echo "✅ gpio${gpio}"
    echo out > /sys/class/gpio/gpio${gpio}/direction 2>/dev/null
done
echo ""
echo "DQ0: $(cat /sys/class/gpio/gpio355/value 2>/dev/null)"
echo "DQ1: $(cat /sys/class/gpio/gpio360/value 2>/dev/null)"
for i in 0 1 2 3 4; do
    gpio=$([ $i -eq 4 ] && echo 345 || echo $((437+i)))
    echo "DI${i}: $(cat /sys/class/gpio/gpio${gpio}/value 2>/dev/null)"
done
