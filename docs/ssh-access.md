# Accés SSH al IoT2050

## Connexió

```bash
ssh root@192.168.200.1
```

## Credencials

| Usuari | Contrasenya |
|--------|-------------|
| `root` | `123456` |

## Comprovació dels GPIOs

Un cop connectat:

```bash
# Veure tots els gpiochips
gpiodetect

# Veure estat de tots els GPIOs
gpioinfo

# Veure estat detallat complert
cat /sys/kernel/debug/gpio

# Comprovar DQ0
cat /sys/class/gpio/gpio355/value

# Activar DQ0
echo 1 > /sys/class/gpio/gpio355/value

# Desactivar DQ0
echo 0 > /sys/class/gpio/gpio355/value
```

## Gestió de Node-RED

```bash
# Veure estat
systemctl status node-red

# Reiniciar
systemctl restart node-red

# Veure logs
journalctl -u node-red --no-pager -n 50
```

## I2C

```bash
# Escanejar bus I2C
i2cdetect -y -r 1
```
