#!/bin/bash
# setup-gpios.sh — Per afegir a /etc/rc.local (arrencada automàtica)
# Siemens 6ES7647-0KA01-0AA2 en IoT2050
# Inclou control de direcció del PCAL9535

# Exportar GPIOs de dades (DI)
for gpio in 437 438 439 441 345; do
    [ ! -d /sys/class/gpio/gpio${gpio} ] && echo ${gpio} > /sys/class/gpio/export
done

# Exportar GPIOs de dades (DQ)
for gpio in 355 360; do
    [ ! -d /sys/class/gpio/gpio${gpio} ] && echo ${gpio} > /sys/class/gpio/export
done

# Exportar GPIOs de direcció del PCAL9535
for gpio in 487 488; do
    [ ! -d /sys/class/gpio/gpio${gpio} ] && echo ${gpio} > /sys/class/gpio/export
done

# Configurar entrades
echo in > /sys/class/gpio/gpio437/direction; echo in > /sys/class/gpio/gpio438/direction
echo in > /sys/class/gpio/gpio439/direction; echo in > /sys/class/gpio/gpio441/direction
echo in > /sys/class/gpio/gpio345/direction

# Configurar direcció al PCAL9535 (HARDWARE) — IMPRESCINDIBLE!
echo 1 > /sys/class/gpio/gpio487/value   # IO7-direction = output (DQ0)
echo 1 > /sys/class/gpio/gpio488/value   # IO8-direction = output (DQ1)

# Configurar sortides natives i inicialitzar a OFF
echo out > /sys/class/gpio/gpio355/direction
echo out > /sys/class/gpio/gpio360/direction
echo 0 > /sys/class/gpio/gpio355/value
echo 0 > /sys/class/gpio/gpio360/value

exit 0
