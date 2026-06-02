#!/bin/bash
# export-gpios.sh — Exporta i configura tots els GPIOs del shield IO
# Siemens 6ES7647-0KA01-0AA2 en IoT2050
# Inclou el control de direcció del PCAL9535 (I2C 0x21)

echo "=== Exportant GPIOs del shield IO ==="

# Entrades digitals (DI0-DI4)
for gpio in 437 438 439 441 345; do
    [ ! -d /sys/class/gpio/gpio${gpio} ] && echo ${gpio} > /sys/class/gpio/export 2>/dev/null && echo "✅ gpio${gpio} (DI)"
    echo in > /sys/class/gpio/gpio${gpio}/direction 2>/dev/null
done

# Sortides digitals (DQ0-DQ1)
for gpio in 355 360; do
    [ ! -d /sys/class/gpio/gpio${gpio} ] && echo ${gpio} > /sys/class/gpio/export 2>/dev/null && echo "✅ gpio${gpio} (DQ)"
    echo out > /sys/class/gpio/gpio${gpio}/direction 2>/dev/null
done

# Direcció del PCAL9535 (IMPRESCINDIBLE per a les DQ!)
# IO7-direction = gpio487 (DQ0), IO8-direction = gpio488 (DQ1)
for gpio in 487 488; do
    [ ! -d /sys/class/gpio/gpio${gpio} ] && echo ${gpio} > /sys/class/gpio/export 2>/dev/null && echo "✅ gpio${gpio} (PCAL9535 direction)"
    echo 1 > /sys/class/gpio/gpio${gpio}/value 2>/dev/null  # hi = output
done

# Comprovar estat
echo ""
echo "=== Estat de les sortides ==="
echo "DQ0 (gpio355): $(cat /sys/class/gpio/gpio355/value 2>/dev/null)"
echo "DQ1 (gpio360): $(cat /sys/class/gpio/gpio360/value 2>/dev/null)"
echo ""
echo "=== Estat de les entrades ==="
for i in 0 1 2 3 4; do
    gpio=$([ $i -eq 4 ] && echo 345 || echo $((437+i)))
    echo "DI${i} (gpio${gpio}): $(cat /sys/class/gpio/gpio${gpio}/value 2>/dev/null)"
done
echo ""
echo "=== Estat del PCAL9535 (direcció) ==="
echo "IO7-direction (gpio487) = $(cat /sys/class/gpio/gpio487/value 2>/dev/null) (1=output) DQ0"
echo "IO8-direction (gpio488) = $(cat /sys/class/gpio/gpio488/value 2>/dev/null) (1=output) DQ1"
