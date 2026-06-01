#!/bin/bash
# setup-gpios.sh — Per afegir a /etc/rc.local (arrencada automàtica)
for gpio in 437 438 439 441 345 355 360; do
    [ ! -d /sys/class/gpio/gpio${gpio} ] && echo ${gpio} > /sys/class/gpio/export
done
echo in > /sys/class/gpio/gpio437/direction; echo in > /sys/class/gpio/gpio438/direction
echo in > /sys/class/gpio/gpio439/direction; echo in > /sys/class/gpio/gpio441/direction
echo in > /sys/class/gpio/gpio345/direction
echo out > /sys/class/gpio/gpio355/direction; echo out > /sys/class/gpio/gpio360/direction
echo 0 > /sys/class/gpio/gpio355/value; echo 0 > /sys/class/gpio/gpio360/value
exit 0
